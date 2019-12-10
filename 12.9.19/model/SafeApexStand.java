package safeapex.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Iterator;

import jeeb.lib.util.Vertex3d;
import safeapex.apex.*;
import capsis.defaulttype.TreeList;
import capsis.defaulttype.plotofcells.PlotOfCells;
import capsis.kernel.GModel;
import capsis.kernel.GScene;

/**
 * Description of the SafeApexStand 
 *
 * @author Isabelle Lecomte - July 2002
 */
public class SafeApexStand extends TreeList {

	/**
	 * This class contains immutable instance variables for a Stand
	 * A class Inmmutable already exist in super class !!!!
	 */
	public static class Immutable2 implements Cloneable, Serializable {

		public float YLAT;		//degree
		public float XLOG;		//degree
		public float ELEV;		//m
		
	}

	protected Immutable2 immutable2;

	private int julianDay;					//julianDay of simulation (0-730)
	private int weatherDay;					//julianDay of weather (1-365)
	private int weatherMonth;				//month of weather
	private int weatherYear;				//year of weather

	
	/** TO DISPLAY IN SCENARIO INSPECTOR **/
	private String display;

	// WARNING: if references to objects (not primitive types) are added here,
	// implement a "public Object clone ()" method (see RectangularPlot.clone () for template)

	public SafeApexStand (float latitude, float longitude, float elevation) {
		super ();

		createImmutable2 ();

		immutable2.YLAT  = latitude;
		immutable2.XLOG  = longitude;
		immutable2.ELEV  = elevation;
		
	}

	/**
	 * Create an Immutable object whose class is declared at one level of the hierarchy.
	 * This is called only in constructor for new logical object in superclass.
	 * If an Immutable is declared in subclass, subclass must redefine this method
	 * (same body) to create an Immutable defined in subclass.
	 */
	protected void createImmutable2 () {immutable2 = new Immutable2 ();}


	/**
	 * Creates the plot and cells.
	 */
	public void createPlot (GModel model, double cellWidth) { }

	/**
	 * Redefinition of getEvolutionBase to return a stand WITH CLONED TREES
	 */
	public GScene getEvolutionBase () {
		SafeApexStand newStand = (SafeApexStand) super.getHeavyClone ();
		newStand.display = null;
		return newStand;
	}
	

	/**
	 * Redefinition of getInterventionBase to return a stand WITH CLONED TREES
	 */
	public GScene getInterventionBase () {
		SafeApexStand newStand = (SafeApexStand) super.getHeavyClone ();
		newStand.display = null;
		return newStand;
	}
	
	/**
	 * Creation of all objets (plot, trees, soil, voxels) attached to the stand
	 */
	public void createAll (SafeApexInitialParameters safeSettings, SafeApexPlotSettings plotSettings,
							SafeApexInitialValues initialValues) throws Exception {
	
		// 1. PlotOfCells creation
		double cellWidth 	= plotSettings.cellWidth;
		double plotWidth 	= plotSettings.plotWidth;
		double plotHeight 	= plotSettings.plotHeight;
		int nLin = (int) (plotHeight / cellWidth);
		int nCol = (int) (plotWidth / cellWidth);
		
		SafeApexPlot initPlot = new SafeApexPlot (this, safeSettings, plotSettings, cellWidth, nLin, nCol);
		
		this.setPlot(initPlot);
		plotSettings.cellSurface = initPlot.getCellSurface ();

		//2. Soil creation
		//general parameters
		SafeApexSoil soil = new SafeApexSoil (safeSettings, plotSettings);		

		initPlot.setSoil(soil);

		//3. Layers creation
		int nbLayerMax =  (int) (plotSettings.TSLA);
		double voxelThicknessMax = plotSettings.voxelThicknessMax;
		int nbVoxels = 0;
		double lastZ = 0;
		int layerId = 0;
		
		for (int nbLayer=0; nbLayer<nbLayerMax; nbLayer++) {
			
			double z 				= plotSettings.Z[nbLayer];
			double layerThickness   = z;
			
			
			if (lastZ > 0) layerThickness = z-lastZ;
			
			//to avoid rounding problems !!!!  
			layerThickness =  (Math.round (layerThickness * Math.pow (10,2)) ) / (Math.pow (10,2));

			lastZ = z;
			layerId++;
			SafeApexLayer layer = new SafeApexLayer(layerId, layerThickness, safeSettings, plotSettings);
			soil.putLayer (nbLayer, layer);

			//nb  voxel calculation depending on layer thickness and voxelThicknessMax
			int nbVoxelLayer = (int) (layerThickness/voxelThicknessMax);
			double reste = layerThickness - (voxelThicknessMax*nbVoxelLayer);
			if (reste > 0) nbVoxelLayer++;
			nbVoxels += nbVoxelLayer;
		}

		
		soil.setDepth (lastZ);	//cumulation of total soil depth
		double volume = soil.getDepth() * plotWidth * plotHeight;
		soil.setVolume (volume);
		
		
		//4. Cells creation depending of
		//    1) nbr of line and nbr of column on the plot
		//    2) cell width
		int id = 0;

		for (int i=0; i < nLin; i++) {
			for (int j=0; j < nCol; j++) {
				id = id + 1;
				double x = j * cellWidth;
				double y = (nLin - (i + 1)) * cellWidth;
				double z = zCoordinate(x, y, plotSettings);
				Vertex3d coord = new Vertex3d(x, y, z);

				SafeApexCell cell = new SafeApexCell (initPlot, coord, i, j, id, nbVoxels);
				initPlot.addCell (cell);
			}
		}

		//5. Trees creation
		this.clearTrees();
		int nbTrees = plotSettings.nbTrees;
		int idTree = 1;
		for (int i=0; i<nbTrees ; i++) {

			double xTree =  initialValues.treeX[i];
			double yTree =  initialValues.treeY[i];
			double zTree =  zCoordinate(xTree, yTree, plotSettings);	//GT 2007 slope
			String treeSpeciesName = initialValues.treeSpecies[i];
			double height = initialValues.treeHeight[i];
			double crownBaseHeight = initialValues.treeCrownBaseHeight[i];
			double crownRadius = initialValues.crownRadius[i];	// gt - 5.10.2009 - added
			
			try {
					SafeApexTree tree = new SafeApexTree (idTree, this, height,
											crownBaseHeight,								
											crownRadius,	// gt - 5.10.2009 - added
											xTree, yTree, zTree, //GT 2007 slope
											treeSpeciesName,
											safeSettings);
	
					this.addTree (tree);
					idTree++;
			}
			catch (Throwable e1) {
				throw e1;
			}
		}


		//6. Voxels creation for each cell of the plot
		int voxelID = 1;
		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
			SafeApexCell cell = (SafeApexCell) c.next ();

			int voxelIndex = 0;
			double voxelDepth = 0;
			double voxelThickness=0;
			double voxelLastThickness=0;
			//for each layer, calculation of voxel to create (number and thickness)
			for (int i=0; i< layerId; i++) {
				SafeApexLayer layer = soil.getLayer(i);			//layer reference
				double layerThickness = layer.getThickness();


				//nb  voxel calculation depending on layer thickness and voxelThicknessMax
				int nbVoxelLayer = (int) (layerThickness/voxelThicknessMax);
				double reste = layerThickness - (voxelThicknessMax*nbVoxelLayer);
				reste =  (Math.round (reste * Math.pow (10,2)) ) / (Math.pow (10,2));
				
				if (reste > 0) {
					nbVoxelLayer++;
					voxelThickness = voxelThicknessMax;
					voxelLastThickness = reste;
				}
				else {
					voxelThickness = voxelThicknessMax;
					voxelLastThickness= voxelThicknessMax;				
				}

				
				
				//Firsts voxels
				for (int v=0; v < nbVoxelLayer-1; v++) {

					SafeApexVoxel voxel = new SafeApexVoxel (voxelID, layer, cell,
													voxelThickness, voxelDepth,
													nbTrees);
					
					cell.addVoxel(voxelIndex, voxel);
					layer.addVoxel(voxel);

					voxelID++;
					voxelIndex++;
					voxelDepth += voxelThickness;
					voxelDepth =  (Math.round (voxelDepth * Math.pow (10,2)) ) / (Math.pow (10,2));


				}

				//last voxel for rounding total thickness to a cm multiple

				SafeApexVoxel voxel = new SafeApexVoxel (voxelID, layer, cell,
												voxelLastThickness, voxelDepth,   
												nbTrees
												);
				
				cell.addVoxel(voxelIndex, voxel);
				layer.addVoxel(voxel);

				voxelID++;
				voxelIndex++;
				voxelDepth += voxelThickness;
			}
		}

		soil.setNbVoxels(nbVoxels);
		safeSettings.nbTrees=nbTrees;
		
	}

	/**
	 * Stand initialisation at the beginning of simulation
	 */
	public void initialisation (SafeApexInitialParameters safeSettings, SafeApexInitialValues initialValues, SafeApexPlotSettings plotSettings) {

		SafeApexPlot initPlot = (SafeApexPlot) this.getPlot();

		// Initialisation of all other cells soil initial values
		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
			SafeApexCell cell = (SafeApexCell) c.next ();
			SafeApexVoxel[] voxels = cell.getVoxels();
			int nbVoxels = voxels.length;
			for (int i=0; i<nbVoxels ; i++) {

				//Water and nitrogen initialisation
				int nbLayer = voxels[i].getLayer().getId();
				double nProp = voxels[i].getThickness()/voxels[i].getLayer().getThickness();
				voxels[i].initializeWaterNitrogen (initialValues.layerWaterContent[nbLayer],
												initialValues.layerNo3Content[nbLayer]*nProp,
											    initialValues.layerNh4Content[nbLayer]*nProp);		
			}
		}

	}
	/**
	 * Create crop object on the plot
	 */
	public void createCrop () {
		//Each cell by default is main crop
		for (Iterator c = getPlot().getCells ().iterator (); c.hasNext ();) {
			SafeApexCell cell = (SafeApexCell) c.next ();
			cell.setCrop (new SafeApexCrop());
		}
	}


	/**
	 * Crop species determination MAIN or SECONDARY 
	 */
	public void determineCropSpecies (SafeApexEvolutionParameters evolutionParameters) {

		double mainCropArea = this.getPlot().getArea();
		double interCropArea = 0;
		
		//by default maincropspecie is true
		for (Iterator c = getPlot().getCells ().iterator (); c.hasNext ();) {
			SafeApexCell cell = (SafeApexCell) c.next ();
			cell.getCrop().setMainCropSpecies(true);
		}
		
		
		//Only one main and one inter crop is only autorised at the moment
		//This method should be modified to allow more crop species on the same plot

		float treeCropDistance = ((SafeApexPlot) getPlot()).getTreeCropDistance();
		float treeCropRadius = ((SafeApexPlot) getPlot()).getTreeCropRadius();

		//If there is a secondary crop under tree line
		//depending of tree Crop Distance
		if (treeCropDistance > 0) {
			for (Iterator t = getTrees ().iterator (); t.hasNext ();) {
				SafeApexTree tree = (SafeApexTree) t.next ();

				double maxX   = tree.getX()+treeCropDistance;
				if (maxX > getPlot().getXSize()) {
					if (evolutionParameters.toricXp > 0) maxX = maxX - getPlot().getXSize();
					else maxX= getPlot().getXSize();
				}
				double minX    = tree.getX()-treeCropDistance;
				if (minX < 0) {
					if (evolutionParameters.toricXn > 0) minX = minX + getPlot().getXSize();
					else minX = 0;
				}

				for (Iterator c = getPlot().getCells ().iterator (); c.hasNext ();) {
					SafeApexCell cell = (SafeApexCell) c.next ();

					if (minX < maxX) {
						if ((cell.getX()+cell.getWidth() > minX)
						&&  (cell.getX() < maxX)) {
							if (cell.getCrop().IsMainCropSpecies()) {
								cell.getCrop().setMainCropSpecies(false);
								interCropArea = interCropArea + this.getPlot().getCellSurface();
							}
						}
					}
					//toric symetry effect
					else {
						if ((cell.getX() < maxX)
							|| (cell.getX()+cell.getWidth() > minX)) {
								if (cell.getCrop().IsMainCropSpecies()) {
									cell.getCrop().setMainCropSpecies(false);
									interCropArea = interCropArea + this.getPlot().getCellSurface();
								}
							}
					}
				}
			}
		}
		

		//If there is a secondary crop at trees trunk base
		//depending of weeded Area Radius
		if (treeCropRadius > 0) {
			for (Iterator t = getTrees ().iterator (); t.hasNext ();) {
				SafeApexTree tree = (SafeApexTree) t.next ();

				double maxX   = tree.getX()+treeCropRadius;
				if (maxX > getPlot().getXSize()) {					
					if (evolutionParameters.toricXp > 0) maxX = maxX - getPlot().getXSize();
					else maxX= getPlot().getXSize();
				}
				double minX    = tree.getX()-treeCropRadius;
				if (minX < 0) {
					if (evolutionParameters.toricXn > 0) minX = minX + getPlot().getXSize();
					else minX = 0;
				}

				double maxY   = tree.getY()+treeCropRadius;
				if (maxY > getPlot().getYSize()) {
					if (evolutionParameters.toricYp > 0) maxY = maxY - getPlot().getYSize();
					else maxY = getPlot().getYSize();
				}
				double minY    = tree.getY()-treeCropRadius;
				if (minY < 0) {
					if (evolutionParameters.toricYn > 0) minY = minY + getPlot().getYSize();
					else minY = 0;
				}
				
				
				for (Iterator c = getPlot().getCells ().iterator (); c.hasNext ();) {
					SafeApexCell cell = (SafeApexCell) c.next ();

					boolean okx = false;
					boolean oky = false;
					
					//check cellX
					if (minX < maxX) {
						if ((cell.getX()+cell.getWidth() > minX)
						&&  (cell.getX() < maxX)) {
							okx = true;
						}
					}
					//toric symetry effect on X axis
					else {
						if ((cell.getX() < maxX)
							|| (cell.getX()+cell.getWidth() > minX)) {
								okx = true;
							}
					}

					//check cellY
					if (minY < maxY) {
						if ((cell.getY()+cell.getWidth() > minY)
						&&  (cell.getY() < maxY)) {
							oky = true;
						}
					}
					//toric symetry effect on Y axis
					else {
						if ((cell.getY() < maxY)
							|| (cell.getY()+cell.getWidth() > minY)) {
								oky = true;
							}
					}
					
					if (okx && oky) {
						if (cell.getCrop().IsMainCropSpecies()) {
							cell.getCrop().setMainCropSpecies(false);
							interCropArea = interCropArea + this.getPlot().getCellSurface();
						}
					}
				}
			}
		}		
		
		mainCropArea = mainCropArea - interCropArea;
		this.getPlot().setMainCropArea (mainCropArea);
		this.getPlot().setInterCropArea (interCropArea);
	}


    /**
	 * APEX crop initialisation (First simulation) 
	 */
    public void initialiseCrop (SafeApexJNA jna, 
    		                        SafeApexEvolutionParameters evolutionParameters,
    		                        SafeApexPlotSettings plotSettings,
    								SafeApexInitialParameters safeSettings,  
    								String dir,	  								
    								int nbSimulation) throws Exception {

		
		
		SafeApexPlot initPlot = (SafeApexPlot) this.getPlot();
		
		//create the 2 species MAIN and INTER
		SafeApexCropSpecies mainCropSpecies = new SafeApexCropSpecies();
		SafeApexCropSpecies interCropSpecies = new SafeApexCropSpecies();

		//APEX initialisation for each cell
		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
			SafeApexCell cell = (SafeApexCell) c.next ();

			//Main crop species initialisation
			if (cell.getCrop().IsMainCropSpecies()) {
				
				if (!mainCropSpecies.getIsInitialized()) {
					
					cell.getCrop().cropInitialisation (jna,
							                          evolutionParameters,
							                          plotSettings, 
												      mainCropSpecies, 
												      dir);
					
					mainCropSpecies.setIsInitialized (true);
					mainCropSpecies.setFirstCell (cell);
				}
				// Copy of APEX initialisation in other cells planted with the same crop species
				else {
					SafeApexCrop firstCrop = mainCropSpecies.getFirstCell().getCrop();
					cell.getCrop().cropInitialisationCopy (firstCrop);
				}
			}
			//inter crop species initialisation
			else {
				if (!interCropSpecies.getIsInitialized()) {
					
					cell.getCrop().cropInitialisation (jna,
	                          						  evolutionParameters,
	                          						  plotSettings, 
	                          						  interCropSpecies, 
	                          						  dir);
					
					interCropSpecies.setIsInitialized (true);
					interCropSpecies.setFirstCell (cell);
				
				//TEST
				//cell.initRoots ();
				}
				// Copy of APEX initialisation in other cells planted with the same crop species
				else {
					SafeApexCrop firstCrop = interCropSpecies.getFirstCell().getCrop();
					cell.getCrop().cropInitialisationCopy (firstCrop);
				}
			}
		}
	}
 	
    /**
	 * APEX crop reinitialisation 
	 */
    public void reinitialiseCrop (SafeApexJNA jna, 
						             SafeApexEvolutionParameters evolutionParameters,
						             SafeApexPlotSettings plotSettings,
									 SafeApexInitialParameters safeSettings,  
									 String dir,	  								
									 int nbSimulation) throws Exception {


		SafeApexPlot initPlot = (SafeApexPlot) this.getPlot();
		SafeApexSoil  soil = initPlot.getSoil();
		
		//create the 2 species MAIN and INTER
		SafeApexCropSpecies mainCropSpecies = new SafeApexCropSpecies();
		SafeApexCropSpecies interCropSpecies = new SafeApexCropSpecies();

		//APEX initialisation for each cell
		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
			SafeApexCell cell = (SafeApexCell) c.next ();

			cell.getCrop().cropReload (jna,
					                   evolutionParameters,
					                   plotSettings, 
					                   interCropSpecies, 
					                   dir);
					
		}
	}
  
    /**
   	 * APEX yearLoopStart
   	 */
    public void yearLoopStart (SafeApexJNA jna) throws Exception {

   		SafeApexPlot initPlot = (SafeApexPlot) this.getPlot();
   		
   		//APEX initialisation for each cell
   		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
   			SafeApexCell cell = (SafeApexCell) c.next ();

   			cell.getCrop().yearLoopStart (jna);					
   		}
   	}
 
    /**
   	 * APEX yearLoopEnd 
   	 */
    public void yearLoopEnd (SafeApexJNA jna) throws Exception {

   		SafeApexPlot initPlot = (SafeApexPlot) this.getPlot();
   		
   		//APEX initialisation for each cell
   		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
   			SafeApexCell cell = (SafeApexCell) c.next ();

   			cell.getCrop().yearLoopEnd (jna);					
   		}
   	}
    /**
   	 * APEX crop initialisation (First simulation) 
   	 */
    public void simulationEnd (SafeApexJNA jna) throws Exception {

   		SafeApexPlot initPlot = (SafeApexPlot) this.getPlot();
   		
   		//APEX initialisation for each cell
   		for (Iterator c = initPlot.getCells ().iterator (); c.hasNext ();) {
   			SafeApexCell cell = (SafeApexCell) c.next ();

   			cell.getCrop().simulationEnd (jna);					
   		}
   	}
	/**
	 * Creation of all objets (plot, trees, soil, voxels) attached to the stand
	 */
	public void reloadTreeSpecies (SafeApexEvolutionParameters ep, SafeApexInitialParameters safeSettings) throws Exception {
		
		for (Iterator iter1=this.getTrees().iterator(); iter1.hasNext(); ) {
			SafeApexTree tree = (SafeApexTree) iter1.next();
			tree.reloadSpecies(ep, safeSettings, tree.getTreeSpecies().getName());
		}
	}
	/**
	 * Search all cells with trees above and calculate lai of tree above each cell
	 **/
	public void computeLaiAboveCells () {

		for (Iterator iter=this.getPlot().getCells().iterator(); iter.hasNext(); ) {
			
			SafeApexCell cell = (SafeApexCell) iter.next();

			double cellX = cell.getXCenter();		//Gravity center of the cell
			double cellY = cell.getYCenter();
			cell.setTreeAbove (false);
			cell.setLaiTree (0);
			
			for (Iterator iter1=this.getTrees().iterator(); iter1.hasNext(); ) {
				
				SafeApexTree tree = (SafeApexTree) iter1.next();
				
				double treeX = tree.getX ();		//tree coordinates
				double treeY = tree.getY ();
				double crownRadiusTreeLine = tree.getCrownRadiusTreeLine ();
				double crownRadiusInterRow = tree.getCrownRadiusInterRow ();
	

				//Ellipsoide formula valid also for paraboloide (greg?)
				if (
					  (Math.pow(cellX - treeX ,2) / Math.pow(crownRadiusInterRow,2))
					+ (Math.pow (cellY - treeY ,2) / Math.pow(crownRadiusTreeLine,2))
					< 1 ) {
					cell.setTreeAbove (true);
					cell.addLaiTree (tree.getLai());
					tree.addNbCellsBellow (1);
				}
			}
		}

	}	
   /**
	* Tree  roots pruning - gt-09.07.2009
	*  In case of soil management, some fine roots are removed from trees.
	*  If soil management depth is below the gravity center of a voxel
	*  the coarse root in this voxel and all depending topology are removed
	*/

	public void treeRootPruning (SafeApexCell cell, double soilManagementDepth, SafeApexInitialParameters settings) {
		

		for (Iterator it = this.getTrees().iterator(); it.hasNext();) {
			SafeApexTree t = (SafeApexTree) it.next();
			//if tree has roots
			if (t.getFineRoots().getFirstRootNode() != null) {
				int i = 0;
				SafeApexVoxel v = cell.getVoxels()[i];
				double z = 0;
				while (z < soilManagementDepth) {
					z = v.getZ();
					if ((t.getCell().getId() != cell.getId()) && (t.getFineRoots().getRootTopology(v) != null)) {
						if (t.getFineRoots().getRootTopology(v).getNodeParent() != null) {
							double removedProp = Math.max(1 - 2 * (z - soilManagementDepth) / v.getThickness(), 1);
							boolean testAnoxia = false;
							t.getFineRoots().getRootTopology(v).getNodeParent().removeSonsRoots(removedProp, v, t, settings, testAnoxia);
						}
					}
					i++;
					v = cell.getVoxels()[i];
					z = v.getSurfaceDepth();
				}
			//	t.updateRoots((SafeApexInitialParameters) settings);
			}
		}
	}
	
 	
    /**
	 * Check if tree root have colonized the all scene (at least one voxel for each cell) 
	 */
    public boolean isAllColonised (int treeID)  {

    	boolean retour = true; 
		SafeApexPlot plot = (SafeApexPlot) this.getPlot();

		//APEX initialisation for each cell
		for (Iterator c = plot.getCells().iterator(); (c.hasNext() && retour);) {
			SafeApexCell cell = (SafeApexCell) c.next ();
			retour = cell.isColonised(treeID);
		}
		return retour;
    }
    
    
   /**
	* Tree leaves Carbon litter (kg) 
	*/
	public double getTreesCarbonLeafLitter () {
		double total = 0; 
		for (Iterator it = this.getTrees().iterator(); it.hasNext();) {
			SafeApexTree t = (SafeApexTree) it.next();
			total += t.getCarbonFoliageSen();
		}
		return total;
	}
   /**
	* Tree leaves Nitrogen litter (kg) 
	*/
	public double getTreesNitrogenLeafLitter () {
		double total = 0; 
		for (Iterator it = this.getTrees().iterator(); it.hasNext();) {
			SafeApexTree t = (SafeApexTree) it.next();
			total += t.getNitrogenFoliageSen();
		}
		return total;
	}

   /**
	* Tree max root depth
	*/
	public double getTreesMaxRootDepth () {
		double max = 0; 
		for (Iterator it = this.getTrees().iterator(); it.hasNext();) {
			SafeApexTree t = (SafeApexTree) it.next();
			max = Math.max(max,t.getRootingDepth());
		}
		return max;
	}	
	

	
	public float getYLAT() {return immutable2.YLAT;}
	public float getXLOG() {return immutable2.XLOG;}
	public float getELEV () {return immutable2.ELEV;}

	public int getWeatherDay () {return weatherDay;}
	public int getWeatherMonth () {return weatherMonth;}
	public int getWeatherYear () {return weatherYear;}
	public int getJulianDay () {return julianDay;}

	public String getCaption () {
		String caption = "";
		if (isInterventionResult ()) {caption += "*";}
		caption += weatherDay + "/" +weatherMonth+ "/" + weatherYear;
		return caption;
	}

	public void setJulianDay (int d) {julianDay = d;}
	public void setWeatherDay (int d) {weatherDay = d;}
	public void setWeatherMonth (int d) {weatherMonth = d;}
	public void setWeatherYear (int d) {weatherYear = d;}


	/** TO DISPLAY IN SCENARIO INSPECTOR **/
	public void setDisplay (String s) {display = s;}
	public String getToolTip () {
		return getCaption ()+((display == null) ? "" : "-"+display);
	}

	/**
	* Compute z coordinate of a point (x,y).
	*/
	public static double zCoordinate (double x, double y, SafeApexPlotSettings plotSettings) {
		double slope = Math.toRadians(plotSettings.slopeIntensity);
		double treeLineOrientation = plotSettings.treeLineOrientation;						//degree
		double slopeAspect	= plotSettings.slopeAspect;										//degree
		double bottomAzimut = Math.toRadians(-90+treeLineOrientation-slopeAspect);
		double z = -Math.tan(slope)*(x*Math.cos(bottomAzimut)+y*Math.sin(bottomAzimut));
		return z;
	}

	@Override
	public SafeApexPlot getPlot () {
		return (SafeApexPlot) plot; // fc-30.10.2017
	}

}
