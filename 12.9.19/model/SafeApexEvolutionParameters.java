package safeapex.model;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.ArrayList;

import capsis.kernel.EvolutionParameters;
import jeeb.lib.util.PathManager;
import safeapex.pgms.SafeApexSimulationLoader;



/**
 * Simulation settings   
 * 
 * @author Isabelle Lecomte - July 2002
 */
public class SafeApexEvolutionParameters implements EvolutionParameters {

	public static final int NB_SIMULATION_MAX = 100; 	// max number of simulation
	public static final int NB_PROFIL_MAX = 20; 		// max number of export profiles

	// SIMULATION PARAMETERS
	public int nbSimulations; 			// total number of simulation
	public int simulationYearStart; 	// simulation starting year
	public int simulationMonthStart; 	// simulation starting month
	public int simulationDayStart; 		// simulation starting day (julian)
	public int currentDay;
	public boolean firstSimulation;
	
	public int[] simulationNbrDays; 	// nbr days
	public double[] treeCropDistance; 	// distance between tree lines and crop (m)
	public double[] treeCropRadius; 	// radius between tree lines and crop (m)
	
	//SIMULATION FILE NAMES
	public String simulationDir;
	public String windFile; 					// wind data file
	public String herdFile; 					// herd data file
	public String rtfFile; 						// rain storm data file
	public String stationFile;					//name of the weather station file
	public String weatherFile;					//name of the daily weather file	
	public String mainCropInterventionFile; 	// main crop ops file name
	public String interCropInterventionFile; 	// inter crop ops file name
	
	//EXPORTATION  FILE NAMES
	public String exportDir;
	public String catalogExportDir;
	public List<String> profileNames;    	// export profile names
	public int[][] exportFrequencies; 	 	// export frequencies in days for all profiles and all simulations

	// TREE PLANTING 
	public List<Integer> treePlantingYears; 	// tree planting years
	public List<Integer> treePlantingDays;  	// tree planting days

	// TREE PRUNING 
	public List<Integer> treePruningYears; 		// tree pruning years
	public List<Integer> treePruningDays; 		// tree pruning days
	public List<Double> treePruningProp; 		// tree pruning proportion
	public List<Double> treePruningMaxHeight; 	// tree pruning max height in meters
	public List<Double> treeDensityReduction; 	// tree density reduction fraction 

	// TREE THINNING 
	public List<Integer> treeThinningIds; 		// tree ids for thinning
	public List<Integer> treeThinningYears; 	// tree thinning years
	public List<Integer> treeThinningDays; 		// tree thinning days

	// TREE ROOT PRUNING 
	public List<Integer> treeRootPruningYears; 	// tree root pruning years
	public List<Integer> treeRootPruningDays; 	// tree root pruning days
	public List<Double> treeRootPruningDistance; // tree root pruning distance
	public List<Double> treeRootPruningDepth; 	// tree root pruning depth

	
	// TREE POLLARDING 
	public int treePollardingMethod;  			//1=regular 2=triggered by the side of tree
	public double treePollardingThreshold;  	//tree pollarding threshold (method=2)	
	public List<Integer> treePollardingYears; 	// tree Pollarding years
	public List<Integer> treePollardingDays; 	// tree Pollarding days
	public List<Double> treePollardingHeight; 	// tree Pollarding height in meters
	public List<Double> treePollardingCanopyLeft; // tree Pollarding canopy left in meters
	

	//CARBON AND NITROGEN LITTER INCORPORATION il-27.03.2018
	public boolean treesLeafLitterIncorporated = true; 			    // tree leaves senescent would be incorporated  in soil
	public boolean treesRootLitterIncorporated = true; 		// tree root senescent would be incorporated in soil
	public boolean treesDeepRootLitterIncorporated = true; 	// tree root senescent would be incorporated in DEEP soil
	
	//TORIC symetry parameters
	public static final int TORIC_X_POS = 1000; 				// toric symetry on x axis positive (number of tours allowed)
	public static final int TORIC_X_NEG = 1000; 				// toric symetry on y axis negative (number of tours allowed)
	public static final int TORIC_Y_POS = 1000; 				// toric symetry on x axis positive (number of tours allowed)
	public static final int TORIC_Y_NEG = 1000; 				// toric symetry on y axis negative (number of tours allowed)

	public int toricXp;
	public int toricXn;
	public int toricYp;
	public int toricYn;

	//APEXRUN.DAT PARAMETERS

	public int IPD;
	public int NGN0;
	public int IGN;
	public int IGSD;
	public int LPYR;
	public int IET;
	public int ISCN;
	public int ITYP;
	public int ISTA;
	public int IHUS;
	public int NVCN0;
	public int INFL0;
	public int MASP;
	public int IERT;
	public int LBP;
	public int NUPC;
	//LINE2
	public int MNUL;
	public int LPD;
	public int MSCP;
	public int ISLF;
	public int NAQ;
	public int IHY;
	public int ICO2;
	public int ISW;
	public int IGMX;
	public int IDIR;
	public int IMW0;
	public int IOX;
	public int IDNT;
	public int IAZM;
	public int IPAT;
	public int IHRD;
	public int IWTB;
	public int IKAT;
	public int NSTP;
	public int IPRK;
	public int ICP;
	public int NTV;
	public int ISAP;
	//LINE3
	public float RFN0;
	public float CO20;
	public float CQN0;
	public float PSTX;
	public float YWI;
	public float BTA;
	public float EXPK;
	public float QG;
	public float QCF;
	public float CHS0;
	//LINE4
	public float BWD;
	public float FCW;
	public float FPS0;
	public float GWS0;
	public float RFT0;
	public float RFP0;
	public float SAT0;
	public float FL0;
	public float FW0;
	public float ANG0;
	//LINE5
	public float UXP;
	public float DIAM;
	public float ACW;
	public float GZL0;
	public float RTN0;
	public float BXCT;
	public float BYCT;
	public float DTHY;
	public float QTH;
	public float STND;
	//LINE6
	public float DRV;
	public float PCO0;
	public float RCC0;
	public float CSLT;
	public float CPV0;
	public float CPH0;
	public float DZDN;
	public float DTG;
		
	/**
	 * Constructor.
	 */
	public SafeApexEvolutionParameters(
									SafeApexInitialParameters safeSettings,
									SafeApexInitialValues initialValues, 
									SafeApexSimulationLoader loader,
									String simulationDir, 
									String exportDir)  {

		String capsisRoot = PathManager.getInstallDir(); // e.g.: C:/capsis4
		
		this.simulationNbrDays = new int[NB_SIMULATION_MAX];
		this.treeCropDistance = new double[NB_SIMULATION_MAX];
		this.treeCropRadius = new double[NB_SIMULATION_MAX];
		this.toricXp = TORIC_X_POS; 
		this.toricXn = TORIC_X_NEG;
		this.toricYp = TORIC_Y_POS;
		this.toricYn = TORIC_Y_NEG;
		
		//BATCH MODE
		if (loader != null) {
				this.nbSimulations = loader.nbSimulations;
				this.simulationYearStart = loader.simulationYearStart;
				this.simulationMonthStart = loader.simulationMonthStart;
				this.simulationDayStart = loader.simulationDayStart;
				this.simulationDir = simulationDir; 
				this.exportDir = exportDir;
				
				//name of crop operations schedule files
				this.mainCropInterventionFile = loader.mainCropOps;
				this.interCropInterventionFile = loader.interCropOps;
				this.windFile = loader.windFile;
				this.herdFile = loader.herdFile;
				this.rtfFile = loader.rtfFile;
				this.stationFile = loader.stationFile;
				this.weatherFile = loader.weatherFile;
				
				//Export profiles are search in priority in simulation folder
				//then in safe/data/simSettings	
				//finally in safe/data/exportParameters
				
				this.catalogExportDir = simulationDir + File.separator + "exportParameters"; 
				File f = new File(this.catalogExportDir);
				if (!f.exists()) {
					this.catalogExportDir = capsisRoot + File.separator + "data" + File.separator + "safe" 
							+ File.separator + "simSettings" 
							+ File.separator + safeSettings.projectName
							+ File.separator + "exportParameters";						
					File f2 = new File(this.catalogExportDir);
					if (!f2.exists()) {						
						this.catalogExportDir = capsisRoot + File.separator + "data" 
								+ File.separator + "safe" 
								+ File.separator + "exportParameters";	
					}
				}
				
				this.profileNames = loader.profileNames;
				this.treePlantingYears = loader.treePlantingYears;
				this.treePlantingDays = loader.treePlantingDays;
				this.treePruningYears = loader.treePruningYears;
				this.treePruningProp = loader.treePruningProp;
				this.treePruningMaxHeight = loader.treePruningMaxHeight;
				this.treeDensityReduction = loader.treeDensityReduction;
				this.treePruningDays = loader.treePruningDays;
				this.treeThinningIds = loader.treeThinningIds;
				this.treeThinningYears = loader.treeThinningYears;
				this.treeThinningDays = loader.treeThinningDays;
				this.treeRootPruningYears = loader.treeRootPruningYears;
				this.treeRootPruningDays = loader.treeRootPruningDays;
				this.treeRootPruningDistance = loader.treeRootPruningDistance;
				this.treeRootPruningDepth = loader.treeRootPruningDepth;
				this.treePollardingMethod = loader.treePollardingMethod;
				this.treePollardingThreshold = loader.treePollardingThreshold;
				this.treePollardingYears = loader.treePollardingYears;
				this.treePollardingDays = loader.treePollardingDays;
				this.treePollardingHeight = loader.treePollardingHeight;
				this.treePollardingCanopyLeft = loader.treePollardingCanopyLeft;
				this.exportFrequencies = new int[NB_PROFIL_MAX][NB_SIMULATION_MAX];

				//TORIC SYMETRIE parameter set
				this.toricXp = loader.toricXp * TORIC_X_POS;
				this.toricXn = loader.toricXn * TORIC_X_NEG;
				this.toricYp = loader.toricYp * TORIC_Y_POS;
				this.toricYn = loader.toricYn * TORIC_Y_NEG;
						
				//CARBON AND NITROGEN LITTER INCORPORATION il-27.03.2018
				this.treesLeafLitterIncorporated = loader.treesLeafLitterIncorporated; 
				this.treesRootLitterIncorporated = loader.treesRootLitterIncorporated; 
				this.treesDeepRootLitterIncorporated = loader.treesDeepRootLitterIncorporated; 
 
				//APEX SECTION

				
				this.IPD = loader.IPD;
				this.NGN0 = loader.NGN0;
				this.IGN = loader.IGN;
				this.IGSD = loader.IGSD;
				this.LPYR = loader.LPYR;
				this.IET = loader.IET;
				this.ISCN = loader.ISCN;
				this.ITYP = loader.ITYP;
				this.ISTA = loader.ISTA;
				this.IHUS = loader.IHUS;
				this.NVCN0 = loader.NVCN0;
				this.INFL0 = loader.INFL0;
				this.MASP = loader.MASP;
				this.IERT = loader.IERT;
				this.LBP = loader.LBP;
				this.NUPC = loader.NUPC;
				this.MNUL = loader.MNUL;
				this.LPD = loader.LPD;
				this.MSCP = loader.MSCP;
				this.ISLF = loader.ISLF;
				this.NAQ = loader.NAQ;
				this.IHY = loader.IHY;
				this.ICO2 = loader.ICO2;
				this.ISW = loader.ISW;
				this.IGMX = loader.IGMX;
				this.IDIR = loader.IDIR;
				this.IMW0 = loader.IMW0;
				this.IOX = loader.IOX;
				this.IDNT = loader.IDNT;
				this.IAZM = loader.IAZM;
				this.IPAT = loader.IPAT;
				this.IHRD = loader.IHRD;
				this.IWTB = loader.IWTB;
				this.IKAT = loader.IKAT;
				this.NSTP = loader.NSTP;
				this.IPRK = loader.IPRK;
				this.ICP = loader.ICP;
				this.NTV = loader.NTV;
				this.ISAP = loader.ISAP;
				this.RFN0 = loader.RFN0;
				this.CO20 = loader.CO20;
				this.CQN0 = loader.CQN0;
				this.PSTX = loader.PSTX;
				this.YWI = loader.YWI;
				this.BTA = loader.BTA;
				this.EXPK = loader.EXPK;
				this.QG = loader.QG;
				this.QCF = loader.QCF;
				this.CHS0 = loader.CHS0;
				this.BWD = loader.BWD;
				this.FCW = loader.FCW;
				this.FPS0 = loader.FPS0;
				this.GWS0 = loader.GWS0;
				this.RFT0 = loader.RFT0;
				this.RFP0 = loader.RFP0;
				this.SAT0 = loader.SAT0;
				this.FL0 = loader.FL0;
				this.FW0 = loader.FW0;
				this.ANG0 = loader.ANG0;
				//LINE5
				this.UXP = loader.UXP;
				this.DIAM = loader.DIAM;
				this.ACW = loader.ACW;
				this.GZL0 = loader.GZL0;
				this.RTN0 = loader.RTN0;
				this.BXCT = loader.BXCT;
				this.BYCT = loader.BYCT;
				this.DTHY = loader.DTHY;
				this.QTH = loader.QTH;
				this.STND = loader.STND;
				//LINE6
				this.DRV = loader.DRV;
				this.PCO0 = loader.PCO0;
				this.RCC0 = loader.RCC0;
				this.CSLT = loader.CSLT;
				this.CPV0 = loader.CPV0;
				this.CPH0 = loader.CPH0;
				this.DZDN = loader.DZDN;
				this.DTG = loader.DTG;

			    	      
		}
		
		//INTERACTIVE MODE
		else {
			
			this.nbSimulations = 1;
			this.simulationYearStart = 0;
			this.simulationMonthStart = 1;
			this.simulationDayStart = 1;	
			this.simulationNbrDays[0] = 365;
			this.exportDir = capsisRoot + File.separator + "data" + File.separator + "safe" + File.separator
					+ "output";				

			this.treePlantingYears = new ArrayList<Integer>();
			this.treePlantingDays = new ArrayList<Integer>();
			
			for (int i=0; i<safeSettings.nbTrees; i++) {
				this.treePlantingYears.add(this.simulationYearStart);			
				this.treePlantingDays.add(this.simulationDayStart);
			}

			this.treesLeafLitterIncorporated = true; 
			this.treesRootLitterIncorporated = true; 		
			this.treesDeepRootLitterIncorporated = true; 	
		}

		this.currentDay = 0;
		this.treeCropDistance[0] = 0.5;
		this.treeCropRadius[0] = 0;
		this.firstSimulation = true;
	}
	/**
	 * Initialize all simulations parameters with .sim file information
	 * For BATCH MODE only
	*/
	public void propagateRotationSettings(SafeApexInitialParameters	safeSettings, 
			String dir,  SafeApexSimulationLoader loader, int simulationIndex)  throws Exception {

		
		//**************** NBR of DAYS ********************************/		
		int nbRotation = 1;
		int nbrDays = 0;
		int nbNbrDays = 0;
		int indexDay = simulationIndex;
		String md[] = loader.simulationNbrDays.split(",");
		
		for (int i = 0; i < md.length; i++) {
			String stringDay = md[i];			
			if (md[i].contains("(") && md[i].contains(")")) {
				int index1 = md[i].indexOf("(");
				int index2 = md[i].indexOf(")");
				nbRotation = Integer.parseInt(md[i].substring(index1 + 1, index2));
				stringDay = md[i].substring(0, index1);
			}

			nbrDays = Integer.parseInt(stringDay);
			for (int j = 0; j < nbRotation; j++) {
				simulationNbrDays[indexDay] = nbrDays;
				indexDay++;
				nbNbrDays++;
			}
		}
		

		// propagation of nbrDays patern for each yeay
		int indexCible = indexDay;
		
		while (indexCible < NB_SIMULATION_MAX) {
			int indexSource = simulationIndex;
			for (int i = 0; i < nbNbrDays; i++) {
				simulationNbrDays[indexCible] = simulationNbrDays[indexSource];
				indexSource++;
				indexCible++;
			}
		}

		
			
		//**************** TREE CROP DISTANCE *********************************/
		// read the tree crop distance (distance1,distance2,distance3...)
		String td[] = loader.treeCropDistance.split(",");
		int nbDistance = 0;
		int indexDistance = simulationIndex;

		for (int i = 0; i < td.length; i++) {
			String distance = td[i];
			int nb = 1;

			if (td[i].contains("(") && td[i].contains(")")) {
				int index1 = td[i].indexOf("(");
				int index2 = td[i].indexOf(")");
				nb = Integer.parseInt(td[i].substring(index1 + 1, index2));
				distance = td[i].substring(0, index1);
			}

			for (int j = 0; j < nb; j++) {
				treeCropDistance[indexDistance] = Double.parseDouble(distance);
				nbDistance++;
				indexDistance++;
			}

		}
	
		// propagation of TREE CROP DISTANCE patern for each yeay
		indexCible = indexDistance;
		
		while (indexCible < NB_SIMULATION_MAX) {
			int indexSource = simulationIndex;
			for (int i = 0; i < nbDistance; i++) {

				treeCropDistance[indexCible] = treeCropDistance[indexSource]; // crop species
				indexSource++;
				indexCible++;
			}
		}

		//**************** WEEDED AREA RADIUS *********************************/
		// read the weeded area radius (radius1,radius2,radius3...)
		String wa[] = loader.treeCropRadius.split(",");
		int indexRadius = simulationIndex;
		int nbRadius = 0;

		for (int i = 0; i < wa.length; i++) {
			String radius = wa[i];
			int nb = 1;

			if (wa[i].contains("(") && wa[i].contains(")")) {
				int index1 = wa[i].indexOf("(");
				int index2 = wa[i].indexOf(")");
				nb = Integer.parseInt(wa[i].substring(index1 + 1, index2));
				radius = wa[i].substring(0, index1);
			}

			for (int j = 0; j < nb; j++) {
				treeCropRadius[indexRadius] = Double.parseDouble(radius);
				nbRadius++;
				indexRadius++;
			}

		}
		
		// propagation of  weeded area radius  patern for each yeay
		indexCible = indexRadius;
		
		while (indexCible < NB_SIMULATION_MAX) {
			int indexSource = simulationIndex;
			for (int i = 0; i < nbRadius; i++) {

				treeCropRadius[indexCible] = treeCropRadius[indexSource]; // crop species
				indexSource++;
				indexCible++;
			}
		}

		//****EXPORT FREQUENCIES *********************************/
		// read the  export frequencies
		if (loader.exportFrequencies != null) {
			for (int nbexport = 0; nbexport < loader.exportFrequencies.size(); nbexport++) {
				String export = loader.exportFrequencies.get(nbexport);

				if (export.contains(")")) {
					int nb = 0;
					if (export.endsWith(")")) {
						export = export.substring(0, export.length()-1);
					}
					String[] st = export.split("\\)");
					for (int j = 0; j < st.length; j++) {
						String value = st[j];
						int repet = 1; 
						if (st[j].contains("(")) {
							String[] st2 = st[j].split("\\(");
							value = st2[0];
							repet = Integer.parseInt(st2[1]);
						}										
						for (int r=0;r<repet;r++) {
							exportFrequencies[nbexport][nb] = Integer.parseInt(value);
							nb++;
						}
					}
				}
				else {
					exportFrequencies[nbexport][0] = Integer.parseInt(export);
				}

				//on rempli pour le nombre de simul MAX 
				for (int i = 1; i < NB_SIMULATION_MAX; i++) {
					if (exportFrequencies[nbexport][i] == 0) {
						exportFrequencies[nbexport][i] = exportFrequencies[nbexport][i - 1];
					}
				}
			}
		}
	}
}
