package safeapex.model;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import jeeb.lib.util.Alert;
import jeeb.lib.util.CancellationException;
import jeeb.lib.util.Log;
import jeeb.lib.util.ProgressDispatcher;
import jeeb.lib.util.StatusDispatcher;
import jeeb.lib.util.Translator;
import safeapex.apex.*;


import safeapex.extension.ioformat.SafeApexInventory;
import safeapex.extension.ioformat.export.SafeApexExport;
import safeapex.extension.ioformat.export.SafeApexExportProfile;
import safeapex.extension.ioformat.export.SafeApexExportProfileCatalog;
import capsis.kernel.EvolutionParameters;
import capsis.kernel.GModel;
import capsis.kernel.GScene;
import capsis.kernel.InitialParameters;
import capsis.kernel.MethodProvider;
import capsis.kernel.Project;
import capsis.kernel.Step;


/**
 * SafeApexModel is the main class for Hi-sAFe module runing with APEX cropModel 
 * 
 * @author Isabelle Lecomte - October 2018
 */

public class SafeApexModel extends GModel {

	private boolean isBatchMode;		// Set to true if model is called in batch mode
	private boolean isCalibrationMode;	// Set to true if model is called in calibration mode
	private boolean isReStart;			// Set to true if model is restarted
	private boolean isDebugMode;		// Set to true for debugging


	private Step  lastStep = null;
	
	private int simulationIndex;		// Set the index of the current simulation 


	public  SafeApexJNA jna;

	// CROP SPECIES LIST
	private SafeApexCropSettings cropSpecies;				// CROP SPECIES (species.crop)
	
	// CLIMAT ENTRIES 
	private SafeApexMacroClimat climat;
	
	// Used for export in BATCH mode
	private Map<String, String> fileNameMap;

	/**
	 * Constructor.
	 */
	public SafeApexModel() throws Exception {

		super();
		
		isBatchMode = false; 			
		isCalibrationMode = false;  
		isReStart = false;   		
		isDebugMode = false;

		// creation of general parameters set
		setSettings(new SafeApexInitialParameters());

		// creation of climat 
		climat = new SafeApexMacroClimat();
		
		//creation of crop species
		cropSpecies = new SafeApexCropSettings();
		
	}

	/**
	 * Creates a MethodProvider for the module.
	 */
	protected MethodProvider createMethodProvider() {
		return new SafeApexMethodProvider();
	}

	/**
	 * Checks if the given .pld file can be loaded, returns false if trouble.
	 * Does not change the SafeApexModel's SafeApexInitialParameters object.
	 */
	public boolean checkIfLoadable(String fileName) {

		try {
			new SafeApexInventory(fileName).load(new SafeApexModel(), new SafeApexInitialParameters());
			return true;
		} catch (Exception e) {
			return false;
		}

	}
	
	/**
	 * Loads the inventory (stand - plot - trees) from .pld ascii file 
	 * File format is described in SafeApexInventory. 
	 */
	public SafeApexStand loadInitStand(String fileName, SafeApexModel model, SafeApexInitialParameters settings) throws Exception {
		SafeApexStand initStand = (SafeApexStand) new SafeApexInventory(fileName).load(model, settings);
		return initStand;

	}

	/**
	 * Load APEX dynamic library
	 * Note: apex.dll (or libapex.so) must be in the system PATH or LD_LIRARY_PATH
	 */
	private void loadLibrary() {

		try {
			jna = new SafeApexJNA();
			if (getDebugMode()) System.out.println("APEX FORTRAN LOADED WITH SUCCESS\n");

		} catch (Throwable e) {
			Log.println(Log.ERROR, "SafeApexModel.loadLibrary ()", "Error during APEX Fortran dynamic library loading", e);
			Alert.print("Error during APEX Fortran dynamic library loading");
		}		
	}

	/**
	 * LOAD general parameter for APEX and HISAFE
	 */
	//parameters files are search in priority in simulation folder
	//then in safe/data/simSettings
	//finally in safe/data/
	private void loadGeneralParameter (SafeApexInitialParameters safeSettings) throws Exception {
	
		try {
			this.loadHISAFEParameter(safeSettings.dataPath+"/hisafe.par");
		} catch (CancellationException e1) {
			throw e1;
		} catch (Throwable e1) {	

			try {				
				this.loadHISAFEParameter(safeSettings.dataOriginalPath+"/simSettings/"+safeSettings.projectName+"/hisafe.par");
				if (getDebugMode()) System.out.println("WARNING hisafe.par read in folder "+safeSettings.dataOriginalPath+"/simSettings/"+safeSettings.projectName);
				
			} catch (CancellationException e2) {
				throw e2;
			} catch (Throwable e2) {	
				try {
					this.loadHISAFEParameter(safeSettings.dataOriginalPath+"/hisafe.par");
					if (getDebugMode()) System.out.println("WARNING hisafe.par read in folder "+safeSettings.dataOriginalPath);

				} catch (Throwable e3) {
					System.out.println("Probleme loading HISAFE general parameter file hisafe.par "+e3);
					throw e3;
				}
			}
		}
		

		
		try {
			this.loadAPEXSpecies(safeSettings.dataPath+"/species/species.crop");
		} catch (Throwable e1) {	
			try {
				this.loadAPEXSpecies(safeSettings.dataOriginalPath+"/simSettings/"+safeSettings.projectName+"/species/species.crop");
				if (getDebugMode()) System.out.println("WARNING CROPCOM.dat read in folder "+safeSettings.dataOriginalPath+"/simSettings/"+safeSettings.projectName);
				
			} catch (Throwable e2) {
				try {
					this.loadAPEXSpecies(safeSettings.dataOriginalPath+"/species/species.crop");
					if (getDebugMode()) System.out.println("WARNING CROPCOM.dat read in folder "+safeSettings.dataOriginalPath);
					
				} catch (Throwable e3) {
					System.out.println("Probleme loading species.crop file "+e3);
					throw e3;
				}
			}
		}
	}	
	
	/**
	 * HISAFE general parameter file loading from ascii file 
	 */
	private void loadHISAFEParameter (String paramFileName) throws Exception {
		new SafeApexGeneralParameterFormat(paramFileName).load(getSettings());
	}

	
	
	/**
	 * APEX crop species file loading from ascii file 
	 */
	private void loadAPEXSpecies(String paramFileName) throws Exception {
		new SafeApexCropFormat(paramFileName).load (this.cropSpecies);
	}
	
	/**
	 * Weather file loading from ascii file
	 */
	public void loadWeather(float latitude, String weatherFileName) throws Exception {
		new SafeApexMacroFormat(weatherFileName).load(getSettings(), climat, latitude);
	}

	/**
	 * These initializations are done once after the stand loading
	 */
	@Override
	public Step initializeModel(InitialParameters ip) throws Exception {


		SafeApexInitialParameters safeSettings; 
		if  ((isReStart) && (isBatchMode)) {
			// Get main references on reopened project
			safeSettings = getSettings();
		}
		else {
			
			SafeApexStand initStand;

			safeSettings = (SafeApexInitialParameters) ip;
			
			//In case initial parameter was created in script mode -il 14/09/2015
			setSettings(safeSettings);
		
			initStand = (SafeApexStand) safeSettings.getInitScene();
	
			// Stand init
			initStand.setDate(0);
			initStand.setJulianDay(0);
			initStand.setWeatherDay(0);
			initStand.setWeatherMonth(0);
			initStand.setWeatherYear(0);
			
			try {
				
				//loading HISAFE and APEX general parameters	
				loadGeneralParameter (safeSettings);
				
				// Create all objects (plot, trees, voxels) attached to the stand
				initStand.createAll(getSettings(), getPlotSettings(),  getInitialValues());
		
				// Initialise all these objects with initial values
				initStand.initialisation(getSettings(), getInitialValues(), getPlotSettings());
			}
			catch (Throwable e) {
				throw e;
			}
				
			lastStep = initStand.getStep();
		}

		// Load crop dynamic library
		loadLibrary();

		

		//Initilalise the simulation number to 0
		this.simulationIndex = 0;
		
		// Tell user inits are done
		if (getDebugMode()) StatusDispatcher.print(Translator.swap("SafeApexModel.initsAreDone"));

		return lastStep;
	}

	/**
	 * Initializations when a project is re-opened
	 */
	protected void projectJustOpened() {

		// Get main references on reopened project
		SafeApexInitialParameters safeSettings = getSettings();
		Project project = getProject();
		safeSettings.resetDataPath();
		
		// Load cropmodel dynamic library
		loadLibrary();
		
		//load Hisafe and APEX general parameters
		try {
			loadGeneralParameter (safeSettings);
		}
		catch (Throwable e) {
			return;
		}
	
		//search the last step of the re-opened project 
		lastStep = project.getRoot();
		for (Iterator t = project.getNodes().iterator(); t.hasNext();) {
			lastStep = (Step) t.next();
		}

		isReStart = true;	
	}
	

	/**
	 * Evolution for SafeApexModel. 
	 * This evolution performs classically one single rotation.
	 */
	@Override
	public Step processEvolution(Step stp, EvolutionParameters ep) throws Exception {

		SafeApexEvolutionParameters evolutionParameters = (SafeApexEvolutionParameters) ep;

		SafeApexStand initStand = (SafeApexStand) stp.getScene();

		SafeApexPlot initPlot = (SafeApexPlot) initStand.getPlot();
	
		double lastSunDeclination = 0;


		//check the number of days for this simulation
		if (evolutionParameters.simulationNbrDays[simulationIndex] > 366) { 
			Log.println("crop model simulation impossible for more than 366 day");
			throw (new Exception());
		}
		
		int yearStart = evolutionParameters.simulationYearStart;
		int dayStart = evolutionParameters.simulationDayStart;

		// adjustment of the start date and number day per rotation in case of leaps years
		// to ensure date continuity from year to year - sr - 16-01-2009
		if (this.climat.isLeapYear(yearStart) && (evolutionParameters.simulationNbrDays[simulationIndex] == 365)) {
			evolutionParameters.simulationNbrDays[simulationIndex]++;
		}
		int nbrDays = evolutionParameters.simulationNbrDays[simulationIndex];
		int dayEnd = dayStart + nbrDays - 1;
		int cpt = 0;
		
		// Initialise SafeApexBeamSet
		// Optimization of nbImpactMultiplication for small trees
		int nbImpact = SafeApexLightModel.nbImpactOptimization(initStand);

		SafeApexLightModel.initialiseBeamSet(climat, getPlotSettings(), evolutionParameters, getSettings(), nbImpact);

		// Loading climat file for this rotation
		try {

			// loading weather from ascii file if interactive mode only
			//in BATCH mode this is done in the ScripGen
			if (!getBatchMode())
				loadWeather(initStand.getYLAT(), evolutionParameters.weatherFile);

			// check that dates required for the simulation are available in this file
			SafeApexDailyClimat dayClimat = climat.getDailyWeather(yearStart, dayStart);

			climat.loadClimate (yearStart, dayStart, dayEnd);


		} catch (Exception exc) {
			String error = "Climat loading problem ";
			Log.println(Log.ERROR, "SafeApexModel.loadClimat ()", error);
			throw exc;
		}

		//Call integrated export for the root step (BATCH ONLY) 
		if (getBatchMode()) {
			Step rootStep = (Step) stp.getProject().getRoot();
			if (evolutionParameters.firstSimulation) 
				initExport(rootStep, evolutionParameters);	
		}

				
		// For each rotation, crop species have to be organise on the plot
		// repartition is done between main and inter crop
		// and with treeCropDistance and WeededAreaRadius simulation parameters
		initPlot.setTreeCropDistance (evolutionParameters.treeCropDistance[simulationIndex]);
		initPlot.setTreeCropRadius (evolutionParameters.treeCropRadius[simulationIndex]);

		//FIRST SIMULATION
		if ((simulationIndex == 0) && (!isReStart)) {	
			
			
			// Computing cell neighbourgs (for root growth)
			initPlot.computeCellsNeighbourg (evolutionParameters);
			
			//first time we have to create the crop objets
			initStand.createCrop ();
			
			//Determine the crop species regarding to plot definition
			initStand.determineCropSpecies (evolutionParameters);

				
			//first initialisation of crops in APEX
			//APEX objects are initialised with initial values
			String dir = getSettings().dataPath+"/apex/";
			initStand.initialiseCrop (jna, 
					                      evolutionParameters,
					                      getPlotSettings(),
										  getSettings(), 									   
										  dir,			 
										  simulationIndex);
			
		}
		//OTHER SIMULATIONS OR REOPEN A PROJECT
		else {					

			//reload tree species
			if (isReStart) initStand.reloadTreeSpecies(evolutionParameters, getSettings());
			
			//Determine the crop species regarding to plot definition
			initStand.determineCropSpecies (evolutionParameters);


			//Re-initialisation of crops in APEX
			//APEX objects are initialised with last day of previous simulation
			String dir = getSettings().dataPath+"/apex/";
			initStand.reinitialiseCrop (jna, 
                                            evolutionParameters,
                                            getPlotSettings(),
					                        getSettings(), 									   
					                        dir,			 
					                        simulationIndex);
			
		}
			

			
		// APEX start year loop 
		initStand.yearLoopStart(jna);
	

		if (!getBatchMode()) ProgressDispatcher.setMinMax(1, nbrDays); // progres bar
		
		SafeApexDailyClimat yesterdayClimat = null; 
		for (int julianDay = dayStart; ((julianDay <= dayEnd)  ); julianDay++) {

			if (!getBatchMode()) ProgressDispatcher.setValue(++cpt);

			evolutionParameters.currentDay = julianDay;
			
			// raz voxels reference in layers
			SafeApexStand oldStand = (SafeApexStand) stp.getScene();
			SafeApexPlot oldPlot = (SafeApexPlot) oldStand.getPlot();		
			for (Iterator c = oldPlot.getSoil().getLayers().iterator(); c.hasNext();) {
				SafeApexLayer l = (SafeApexLayer) c.next();
				if (l != null) l.razVoxel();
			}
			
			// new stand creation including tree cloning
			SafeApexStand newStand = (SafeApexStand) oldStand.getEvolutionBase();
			SafeApexPlot newPlot = (SafeApexPlot) newStand.getPlot();			
			
			// cleaning voxel cloning reference to avoid memory problems
			// in the old stand
			for (Iterator c = oldPlot.getCells().iterator(); c.hasNext();) {
				SafeApexCell cell = (SafeApexCell) c.next();
				SafeApexVoxel voxels[] = cell.getVoxels();
				for (int iz = 0; iz < voxels.length; iz++) {
					voxels[iz].cleanCloningReference();
				}
			}

			// Get Daily climat 
			int climateDay = julianDay;
			int climatYear = yearStart;

			// leap year
			int nbDayMax = 365;
			if (climat.isLeapYear(yearStart)) {
				nbDayMax = 366;
			}
			if (climateDay > nbDayMax) {
				climateDay = climateDay - nbDayMax;
				climatYear = climatYear + 1;
			}

			SafeApexDailyClimat dayClimat = climat.getDailyWeather(climatYear, climateDay);
			
			//snow calculation
			dayClimat.calculateSnow (getSettings(), yesterdayClimat);
			yesterdayClimat = dayClimat;
			
			newStand.setWeatherDay(dayClimat.getDay());
			newStand.setWeatherMonth(dayClimat.getMonth());
			newStand.setWeatherYear(dayClimat.getYear());
			newStand.setJulianDay(climateDay);
			newStand.setDate(julianDay);

			// User wait message (with updated date: sr 16-01-09)
			if (getDebugMode()) { //DEBUG MODE ONLY
				String msg = "";
				msg += "Step=" + julianDay+ " Date=" + newStand.getCaption();
				StatusDispatcher.print(msg);
			}

			boolean display = false; // false: unvisible

			//Do avoid bad test in case of winter crop
			int testDay = julianDay;
			if (julianDay > 365) testDay = julianDay-365;
			
			if (getBatchMode()) { //BATCH MODE ONLY


				
				//TREE PLANTING IL 31/01/2018
				for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
					SafeApexTree tree = (SafeApexTree) t.next();
					if (!tree.isPlanted()) {
						if (((simulationIndex+1) == evolutionParameters.treePlantingYears.get(tree.getId()-1)) && (testDay == evolutionParameters.treePlantingDays.get(tree.getId()-1))) {
							
							try {
								if (getDebugMode()) StatusDispatcher.print("Planting Tree ID=" + tree.getId());
								tree.plant();							
								// Computing tree fine and coarse roots initialisation
								tree.fineRootsInitialisation (newStand.getPlot(), getInitialValues(), getSettings(), getPlotSettings(), evolutionParameters);
								tree.coarseRootsInitialisation (newStand.getPlot(), getInitialValues(), getSettings(), getPlotSettings());	// gt - 5.10.2009 - added initialValues		
								if ((tree.getLeafArea() == 0) && (testDay > 180)) {
									tree.setPhenologicalStage(4);
								}	
							
							} catch (Exception exc1) {
								String error = "Tree planting problem problem ";
								Log.println(Log.ERROR, "SafeApexModel.loadClimat ()", error);
								throw exc1;
							}
						}
													
					}
				}
			
			
				// tree pruning GT 24/09/2010 
				for (int i = 0; i < evolutionParameters.treePruningYears.size(); i++) {
					
					if ((simulationIndex+1) == evolutionParameters.treePruningYears.get(i)) {
						
						if (testDay == evolutionParameters.treePruningDays.get(i)) {
							
							for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
								SafeApexTree tree = (SafeApexTree) t.next();
								if (tree.isPlanted()) {
									if (getDebugMode()) StatusDispatcher.print("Pruning Tree ID=" + tree.getId());
									tree.pruning(evolutionParameters.treePruningProp.get(i),
											evolutionParameters.treePruningMaxHeight.get(i),
											evolutionParameters.treeDensityReduction.get(i));
								}
							}
						}
					}
				}
				

				// root pruning 
				for (int i = 0; i < evolutionParameters.treeRootPruningYears.size(); i++) {

					if ((simulationIndex+1) == evolutionParameters.treeRootPruningYears.get(i)) {

						if (testDay == evolutionParameters.treeRootPruningDays.get(i)) {
							
							for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
								SafeApexTree tree = (SafeApexTree) t.next();
								if (tree.isPlanted()) {
									if (getDebugMode()) StatusDispatcher.print("Root Pruning Tree ID=" + tree.getId());
									tree.rootPruning(newStand, getSettings(), evolutionParameters.treeRootPruningDistance.get(i),evolutionParameters.treeRootPruningDepth.get(i) );
								}
							}
						}
					}
				}

				
				// tree pollarding (il 27.09.2017)
				if (evolutionParameters.treePollardingMethod == 1) {	//regular pollarding (years)
					for (int i = 0; i < evolutionParameters.treePollardingYears.size(); i++) {
						
						if ((simulationIndex+1) == evolutionParameters.treePollardingYears.get(i)) {
							
							if (testDay == evolutionParameters.treePollardingDays.get(i)) {
								
								for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {									
									SafeApexTree tree = (SafeApexTree) t.next();
									if (tree.isPlanted()) {
										if (getDebugMode()) StatusDispatcher.print("Pollarding Tree ID=" + tree.getId());
										tree.pollarding(newStand, evolutionParameters.treePollardingHeight.get(i), evolutionParameters.treePollardingCanopyLeft.get(i), julianDay);
									}
								}
							}
						}
					}
				}
				if (evolutionParameters.treePollardingMethod == 2) { //tree height threshold trigger
					
					if (testDay == evolutionParameters.treePollardingDays.get(0)) {
						
						for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
							SafeApexTree tree = (SafeApexTree) t.next();
							if (tree.isPlanted()) {
								if (tree.getHeight() > evolutionParameters.treePollardingThreshold) {
									if (getDebugMode()) StatusDispatcher.print("Pollarding Tree ID=" + tree.getId());
									tree.pollarding(newStand, evolutionParameters.treePollardingHeight.get(0), evolutionParameters.treePollardingCanopyLeft.get(0), julianDay);
								}
							}
						}
					}				
				}
				
				// tree thinning IL 10/04/2015 
				// move after exporting IL 10/07/2018
				
				for (int i = 0; i < evolutionParameters.treeThinningYears.size(); i++) {
					
					if ((simulationIndex+1) == evolutionParameters.treeThinningYears.get(i)) {
						
						//the day of thinning we keep the value
						if (testDay == evolutionParameters.treeThinningDays.get(i)) {
							
							for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
								SafeApexTree tree = (SafeApexTree) t.next();
								if (tree.isPlanted() && (tree.getId()==evolutionParameters.treeThinningIds.get(i))) {
									// root senescence
									tree.getFineRoots().getFirstRootNode().computeTotalRootSenescence(tree, getSettings());
									
									//Keep carbon pool values exported in the tree
									tree.setCarbonStemExported(tree.getCarbonStem());
									tree.setCarbonFoliageExported(tree.getCarbonFoliage());
									tree.setCarbonBranchesExported(tree.getCarbonBranches());
									tree.setNitrogenStemExported(tree.getNitrogenStem());
									tree.setNitrogenFoliageExported(tree.getNitrogenFoliage());
									tree.setNitrogenBranchesExported(tree.getNitrogenBranches());	
								}
							}
						
						}
						
						if (testDay == evolutionParameters.treeThinningDays.get(i)+1) {
							
							// First step : marking trees
							Vector treesToCut = new Vector();
							for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
								SafeApexTree tree = (SafeApexTree) t.next();
								if (tree.isPlanted() && (tree.getId()==evolutionParameters.treeThinningIds.get(i))) {
									if (getDebugMode()) StatusDispatcher.print("Thinning Tree ID=" + tree.getId());
									treesToCut.add(tree);
								}
							}
							
							// Second step cutting trees 
							for (Iterator ite = treesToCut.iterator(); ite.hasNext();) {
								SafeApexTree t = (SafeApexTree) ite.next();
							
								//remove the tree
								newStand.removeTree(t);					
							}							
						}						
					}
				}			
			
			}
			//INTERACTIVE MODE
			else {
				//TREE PLANTING THE FIRST DAY    IL 31/01/2018
				for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
					SafeApexTree tree = (SafeApexTree) t.next();
					if (!tree.isPlanted()) {
						tree.setPlanted(true);		
						tree.fineRootsInitialisation (newStand.getPlot(), getInitialValues(), getSettings(), getPlotSettings(), evolutionParameters);
						tree.coarseRootsInitialisation (newStand.getPlot(),  getInitialValues(), getSettings(), getPlotSettings());	// gt - 5.10.2009 - added initialValues	
						if ((tree.getLeafArea() == 0) && (testDay > 180)) {
							tree.setPhenologicalStage(4);
						}		
					}
				}				
			}

			

			
			
			// LIGHT MODEL TRIGGER COMPUTATION
			// the processLighting is computed only if :
			// - this is the first day of simulation
			// - there is leaves in the trees (as least one)
			// - for diffuse : delta between leaf area day/last execution are upper than thresholds
			// - for direct : delta between sun declination day/last execution are upper than thresholds
			boolean isDirect = false;
			boolean isDiffus = false;

			float dayDeclination = dayClimat.getSunDeclination();

			// if sun declination has changed -> direct light computation
			isDirect = (Math.abs(
					dayDeclination - lastSunDeclination) > (getSettings().declinationThreshold * Math.PI / 180));

			if (julianDay == dayStart) { // first day of simulation
				isDiffus = isDirect = true;
			}

			double heightMax = 0;
			double crownRadiusMax = 0;

			for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
				
				SafeApexTree tree = (SafeApexTree) t.next();
				
				if (tree.isPlanted()) {
					double dayLeafArea = tree.getLeafArea();
					double lastLeafArea = tree.getLastLeafArea();
	
					// if there is leaf on the tree
					if (dayLeafArea > 0) {
						if (lastLeafArea == 0) { // leaf area was null the day before
							isDiffus = isDirect = true;
						}
						// leaf area has increase more than the thresold
						else if ((Math.abs(dayLeafArea - lastLeafArea)
								/ lastLeafArea) > (getSettings().leafAreaThreshold / 100)) {
							isDiffus = isDirect = true;
						}
					} else {
						if (lastLeafArea > 0) { // leaf area was not null the day
												// before
							isDiffus = isDirect = true;
						}
					}
	
					// Recalculation of treeHeightMax and crownRadiusMax
					// for limitation of toric symetrie computation
					if (tree.getHeight() > heightMax)
						heightMax = tree.getHeight();
					if (tree.getCrownRadius() > crownRadiusMax)
						crownRadiusMax = tree.getCrownRadius();
				}
			}

			if (getSettings().cropLightMethod) {
				isDiffus = true;
				isDirect = true;
			}

			// LIGHT MODEL EXECUTION
			// only if triggers are ON
			SafeApexBeamSet beamSet = climat.getBeamSet();

			if (isDirect) {

				SafeApexLightModel.beamDirectEnergy(getSettings(), beamSet, dayClimat, getPlotSettings()); // GT 2007

				// Calculation of extinction coefficient for crops (if CropLightMethod == True) 
				if (getSettings().cropLightMethod) {

					for (Iterator i = newPlot.getCells().iterator(); i.hasNext();) {
						SafeApexCell c = (SafeApexCell) i.next();
						SafeApexCrop crop = c.getCrop();
						crop.findCropLightCoef(beamSet, getSettings(), dayClimat);
					}
				}

				// Compute relative cell neighbourhoods for competing trees
				SafeApexLightModel.computeRelativeCellNeighbourhoods(beamSet, getPlotSettings(), heightMax, crownRadiusMax,
						isDiffus);
				// Compute relative cell neighbourhood for competing crops
				float heightCropMax = 0;
				if (getSettings().cropLightMethod) {
					for (Iterator c = newStand.getPlot().getCells().iterator(); c.hasNext();) {
						SafeApexCrop crop = ((SafeApexCell) c.next()).getCrop();
						float height = crop.getHeight();
						if (height > heightCropMax)
							heightCropMax = height;
					}
				}

				SafeApexLightModel.createShadingMasks(beamSet, getSettings(), getPlotSettings(), heightCropMax);
				SafeApexLightModel.processLighting(newStand, getPlotSettings(), evolutionParameters, getSettings(), beamSet,
						isDiffus);

				// we keep the last values of this execution for testing the next thresholds
				lastSunDeclination = dayDeclination; // sun declination
				for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
					SafeApexTree tree = (SafeApexTree) t.next();
					tree.setLastLeafArea(tree.getLeafArea()); // tree leaf area
				}
			}

			// Update light results for each tree with daily climat
			for (Iterator t = newStand.getTrees().iterator(); t.hasNext();) {
				SafeApexTree tree = (SafeApexTree) t.next();
				tree.updateDailyLightResults(dayClimat, evolutionParameters, getSettings()); // GT 2007
			}

			// Update light results on each cell with daily climat
			for (Iterator c = newPlot.getCells().iterator(); c.hasNext();) {
				SafeApexCell cell = (SafeApexCell) c.next();

				cell.updateDailyLightResults(beamSet, dayClimat, getSettings());

				cell.getCrop().updateDailyInterceptedPar(dayClimat, getSettings(), beamSet);
			}



			// TREES AND CROP PROCESS GROWTH
			processGrowth(newStand, dayClimat, evolutionParameters);
		

			if (julianDay == dayEnd) {
				display = true;
				newStand.setDisplay("end of simulation");
			}

			String reason = "Daily Step";
			Step newStp = stp.getProject().processNewStep(stp, newStand, reason);
			newStp.setVisible(display);
			stp = newStp;
			
			newPlot.processTotalAnnual();
			
			// Integrated export, deals with a frequency and a list of profiles
			// BATCH MODE ONLY
			if (getBatchMode()) 
				integratedExport(stp, simulationIndex, evolutionParameters, nbDayMax);

			
			//Plot Annual RAZ
			if (newStand.getYLAT() >= 0) {	//north latitude 01/01
				if ((dayClimat.getDay() == 1) &&  (dayClimat.getMonth() == 1)) newPlot.razTotalAnnual();
			}
			else {	//south latitude 01/07
				if ((dayClimat.getDay() == 1) &&  (dayClimat.getMonth() == 7)) newPlot.razTotalAnnual();	
			}
			
			//Montly RAZ the first day of the month
			if (dayClimat.getDay() == 1) {
				for (Iterator j = newPlot.getCells().iterator(); j.hasNext();) {
					SafeApexCell cell = (SafeApexCell) j.next();
					cell.razTotalMonth();
				}
			}
			
		}//// end of daily loop 
		
		
		// APEX end year loop 
		initStand.yearLoopEnd(jna);
		
		this.simulationIndex++;

		//last simulation
		if (simulationIndex==evolutionParameters.nbSimulations) {
			initStand.simulationEnd (jna);
		}
		if (!getBatchMode()) ProgressDispatcher.stop();
		
		return stp;
	}

	
	/**
	 * Growing method for SafeApexModel newStand = the new stand (day j)
	 * 
	 * return true if the step has to be visible (budburst date, sowing or harvesting crop ...)
	 */
	public void processGrowth (SafeApexStand newStand, 
								  SafeApexDailyClimat dayClimat,
								  SafeApexEvolutionParameters evolutionParameters) {
		
		SafeApexPlot newPlot = (SafeApexPlot) newStand.getPlot();

		// maybe useless... to clean !!!
		int simulationYear = newStand.getWeatherYear(); // gt - 14.01.2009
		int simulationDay = dayClimat.getJulianDay(); // gt - 14.01.2009
		int julianDay = newStand.getJulianDay(); // gt - 14.01.2009


		// light and microclimat influence on crop
		double cellRad  = dayClimat.getGlobalRadiation (); 	// default value : light transmitted is 100%
		double cellRain = dayClimat.getRain(); 				// default value : rain transmitted is daily rain 
		double cellEtp  = dayClimat.getEtpPenman(); 		// default value : ETP is daily ETP
		
		double cellVisibleSky = 1;							// default value : visible sky is 100%
		double cellTrg = 1;									// default value : global radiation is 100%

		// return value to make the step visible in the project
		boolean visibleStep = false;

		//for EXPORT
		newStand.getPlot().setPrecipitation (dayClimat.getPrecipitation());
		
		//Search all cells with trees above and calculate lai of tree above each cell
		newStand.computeLaiAboveCells();
		
		// rain interception and stemflow
		//if there is rain or snow or snowMelted today 
		if (dayClimat.getRain()+dayClimat.getSnow()+dayClimat.getMeltedSnow() > 0)  {
			climat.rainTreatement(getSettings(), newStand, dayClimat.getRain(), dayClimat.getSnow(), dayClimat.getMeltedSnow());			
		}

		// WATER TABLE : voxel under water table depth are saturated (z >= waterTableDepth)
		// saturated voxels are set to field capacity (fine soil+stone)
		// if update, voxels will be desagregated in APEX soil
		if (((SafeApexSoil) newStand.getPlot().getSoil()).isWaterTable()) {
			double waterTableDepth = Math.abs(Math.min(-0.2, dayClimat.getWaterTableDepth()));
			if (waterTableDepth > 0) 
				newPlot.computeWaterTable(getSettings(), waterTableDepth, true);
		}


		//LEAVES MINERALISATION IN ALL PLOT SURFACE 
		//will be passed to crop each CROP in processApport before processGrowth1
		double treeCarbonLeafLitter = 0;
		double treeNitrogenLeafLitter = 0;
		if (evolutionParameters.treesLeafLitterIncorporated) {		
			treeCarbonLeafLitter   = newStand.getTreesCarbonLeafLitter()  / (newPlot.getArea() / 10000);	 // in kg ha-1
			treeNitrogenLeafLitter = newStand.getTreesNitrogenLeafLitter()  / (newPlot.getArea() / 10000); 	 // kg ha-1		
		}



		// 1) Process growth for the crop on each cell (part I) before water competition	
		for (Iterator c = newPlot.getCells().iterator(); c.hasNext();) {

			SafeApexCell cell = (SafeApexCell) c.next();

			// rain on this cell is rain transmitted by trees + stemflow by tree
			cellRain = (float) (cell.getRainTransmittedByTrees() + cell.getStemFlowByTrees());
		
			// light transmitted 
			cellRad = (float)  (cell.getRelativeGlobalRadIncident() * dayClimat.getGlobalRadiation());
			
			// etp on this cell in influenced by trees			
			double newEtp = dayClimat.getEtpPenman() * cell.getRelativeGlobalRadIncident(); // gt 23 sept 2010
			cell.setEtpCalculated(newEtp);
			cellEtp = (float) cell.getEtpCalculated();
							
			//correction arrondis
			if (cellRain >  dayClimat.getRain()) cellRain = dayClimat.getRain();
			if (cellRad  > dayClimat.getGlobalRadiation ()) cellRad = dayClimat.getGlobalRadiation ();
			

			// Call APEX for mineral Apport in soil (leaf and roots) 
			//cell.getCrop().processApport(j);
			
			// Call APEX part I
			cell.getCrop().processGrowth1 (jna, 
										  cell,
										  getSettings(), 
										  julianDay, 
										  cellRad, 
										  cellRain, 
										  cellEtp);
			

			System.out.println("SafeApexModel Line 955");
			// Compute agregation results from APEX soil layers to voxels
			// Crop root density, water content, nitrogen concentration
			cell.apexSoilToVoxelsAfterPart1 (julianDay);
			System.out.println("SafeApexModel Line 959");
			//After APEX crop root growth 
			//Recalculation of crop root topology
			cell.computeCropRootTopology (julianDay);
			System.out.println("SafeApexModel Line 963");
		}
		
		// 2) Process growth for each tree before water repartition
		for (Iterator i = newStand.getTrees().iterator(); i.hasNext();) {

			SafeApexTree tree = (SafeApexTree) i.next();

			
			if (tree.isPlanted()) {
		
				tree.processGrowth1 (newStand, 
								    getSettings(), 
								    getPlotSettings(), 
								    dayClimat, 
								    climat); 
		
				tree.setAge(tree.getAge()+1);
			}

		}

		
		// Water repartition between trees and crop in each soil voxel

		SafeApexWaterCompetitionModel.waterNitrogenRepartition(newStand, getSettings(), simulationDay);
		


		// 3) Process growth for each tree after water repartition
		for (Iterator i = newStand.getTrees().iterator(); i.hasNext();) {

			SafeApexTree tree = (SafeApexTree) i.next();
			
			if (tree.isPlanted()) {
				tree.processGrowth2 (newStand, 
								     getSettings(), 
								     getPlotSettings(), 
								     dayClimat, 
								     simulationDay);

			}
		}

		// 4) Process growth for the crop on each cell (part II) after water repartition
		for (Iterator c = newPlot.getCells().iterator(); c.hasNext();) {

			SafeApexCell cell = (SafeApexCell) c.next();

			// Water and nitrogen extraction results desagreggation 
			// from voxels to APEX soil layers
			cell.voxelsToApexSoil(getSettings());

			
			// In case of soil management, some fine roots are removed from trees. // gt-09.07.2009
			// If soil management depth is below the gravity center of a voxel,
			// the coarse root in this voxel and all depending topology are removed
			double soilManagementDepth = cell.getCrop().getSoilManagementDepth();
			if (soilManagementDepth > 0) {
				newStand.treeRootPruning (cell, soilManagementDepth,  getSettings());				
			}

			// Call APEX part II
			cell.getCrop().processGrowth2 (jna, julianDay);

			// Compute agregation results from APEX soil layers to voxels
			cell.apexSoilToVoxelsAfterPart2 ();
		}

	}
	/**
	* Destruction of APEX objects references (to clean memory) 
	*/
	public void razApex () {




		//RAZ crop APEX objetcs of the last step
		Step lastStep = this.getProject().getLastStep();
		SafeApexStand stand = (SafeApexStand) lastStep.getScene();

		for (Iterator c = stand.getPlot().getCells().iterator(); c.hasNext();) {
			SafeApexCell cell = (SafeApexCell) c.next();
			cell.getCrop().razApexObjects();
		}
		
		//garbage collector
		System.gc();
		
	}
	
	
	/**
	 * Creates objets for exporting profiles BATCH MODE ONLY
	 */
	private void initExport(Step step, SafeApexEvolutionParameters ep) throws Exception {

		if (step == null) {
			return;
		}

		if (ep.profileNames == null || ep.profileNames.isEmpty()) {
			return;
		}

		if (ep.firstSimulation) fileNameMap = null;
		
		// create the file name map with all information about exports
		if (fileNameMap == null) {
			createFileNameMap(ep.profileNames, ep);
		}

		// for each profile, export headers and initial Step
		for (String profile : ep.profileNames) {
			try {
				String exportFileName = fileNameMap.get(profile);
				SafeApexExport exp = new SafeApexExport(ep.catalogExportDir, profile);
				exp.initExport(step.getProject().getModel(), step);
				exp.save(exportFileName, false);

			} catch (Exception e) {
				Log.println(Log.ERROR, "SafeApexModel.integratedExport ()", "could not export the step " + step, e);
			}
		}
	
	}

	/**
	 * Export profiles BATCH MODE ONLY
	 */
	private void integratedExport(Step step, int simulationIndex, SafeApexEvolutionParameters ep, int nbDayMax) throws Exception {

		if (step == null) {
			return;
		}


		int date = step.getScene().getDate();

		// create the file name map with all information about exports
		if (fileNameMap == null) {
			createFileNameMap(ep.profileNames, ep);
		}
	
		// for each profile, export data annual
		for (int i = 0; i < ep.profileNames.size(); i++) {
			String profileName = ep.profileNames.get(i);
			Integer exportFrequency = ep.exportFrequencies[i][simulationIndex];

			//Test date export
			SafeApexStand stand = (SafeApexStand) step.getScene();
			int day = stand.getWeatherDay();
			int month = stand.getWeatherMonth();
			boolean export = false;
			//pour que l'export tous les 365 jours tombe tjrs le 1er janvier
			if (exportFrequency == 365)  {
				if ((day == 1) && (month ==1)) export = true;
			}	
			//pour que l'export tous les 30 jours tombe tjrs le 1er jour du mois
			else if (exportFrequency == 30)  {
				if (day == 1) export = true;
			}
			else {
				if (date % exportFrequency == 0) export = true; 
			}

			
			// if export frequency match with step date
			if ((exportFrequency > 0) && (export)) {

				try {
					String exportFileName = fileNameMap.get(profileName);
					
					SafeApexExport exp = new SafeApexExport(ep.catalogExportDir,profileName);
					exp.export(step.getProject().getModel(), step);
					exp.save(exportFileName, true);

				} catch (Exception e) {
					Log.println(Log.ERROR, "SafeApexModel.integratedExport ()", "could not export the step " + step, e);
				}
	
			}
		}
	}

	/**
	 * Create export object and BATCH MODE ONLY
	 */
	private void createFileNameMap(List<String> profileNames, SafeApexEvolutionParameters ep) throws Exception {


		String projectName = getProject().getName();
		String exportDir = ep.exportDir;


		File dir = new File(exportDir);
		if (!dir.exists()) {
			boolean success = dir.mkdirs();
			if (!success) {
				Log.println(Log.ERROR, "SafeApexModel.createFileNameMap ()",
						"Could not create " + exportDir + " directory");
			}
		}

		fileNameMap = new HashMap<String, String>();

		for (String profileName : profileNames) {
			String fileName = exportDir + "/" + projectName + '_' + profileName + ".txt";
			fileNameMap.put(profileName, fileName);

			// Check profiles
			try {

				// check the profile definition
				SafeApexExportProfileCatalog catalog = new SafeApexExportProfileCatalog(ep.catalogExportDir);
				SafeApexExportProfile profile = catalog.loadProfile(profileName);

				if (profile == null)
					throw new Exception(
							"SafeApexModel.createFileNameMap (): could not find export profile: " + profileName);

				if (profile.subjectsToExport == null || profile.subjectsToExport.isEmpty())
					throw new Exception("subjectsToExport is null or empty");

				if (profile.subjectsToExport.size() != 1)
					throw new Exception("subjectsToExport size should be 1");



			} catch (Exception e) {
				Log.println(Log.WARNING, "SafeApexModel.createFileNameMap ()",
						"Wrong profile " + profileName + ": " + e.getMessage());
				throw e;

			}
		}
	}

	/**
	 * Post intervention processing (ex: after thining).
	 */
	@Override
	public void processPostIntervention(GScene newScene, GScene prevScene) {
		SafeApexStand stand = (SafeApexStand) newScene;
		// after thinning, tree roots have to be removed
		Collection cutTrees = stand.getTrees("cut");

		Collection cutTreesIds = new ArrayList();
		for (Iterator i = cutTrees.iterator(); i.hasNext();) {
			SafeApexTree t = (SafeApexTree) i.next();
			cutTreesIds.add(t.getId());
		}
		processRazTreeRoots(stand, cutTreesIds);
	}

	/**
	 * after thinning, tree roots have to be removed RAZ of roots in each rooted voxels
	 */
	public void processRazTreeRoots(SafeApexStand stand, Collection treeIds) {

		// For each tree "cut" object
		for (Iterator i = treeIds.iterator(); i.hasNext();) {
			Integer tree = (Integer) i.next();
			int treeIndex = tree - 1;

			// RAZ of roots in each rooted voxels
			for (Iterator c = stand.getPlot().getCells().iterator(); c.hasNext();) {
				SafeApexCell cell = (SafeApexCell) c.next();
				SafeApexVoxel voxels[] = cell.getVoxels();
				for (int iz = 0; iz < voxels.length; iz++) {
					voxels[iz].setTreeRootDensity(treeIndex, 0);
				}
			}
		}
	}

	/**
	 * Accessors
	 */
	public SafeApexPlotSettings getPlotSettings() {return getSettings().plotSettings;}
	public SafeApexInitialValues getInitialValues() {return getSettings().initialValues;}
	public SafeApexMacroClimat getMacroClimat() {return climat;}
	public SafeApexCropSettings getCropSpecies() {return cropSpecies;}
	public boolean getBatchMode() {return isBatchMode;}
	public boolean getCalibrationMode() {return isCalibrationMode;}
	public boolean getReStart() {return isReStart;}	
	public boolean getDebugMode() {return isDebugMode;}	

	public int getSimulationIndex() {return simulationIndex;}
	public void setBatchMode(boolean b) {isBatchMode = b;}
	public void setCalibrationMode(boolean b) {isCalibrationMode = b;}
	public void setReStart(boolean b) {isReStart = b;}
	public void setDebugMode(boolean b) {isDebugMode = b;}
	public void setSimulationIndex(int n) {simulationIndex = n;}
	public void razFileNameMap() {fileNameMap = null;}
	public SafeApexInitialParameters getSettings() {return (SafeApexInitialParameters) settings;}


	public Step getLastStep() {return lastStep;}

	
}
