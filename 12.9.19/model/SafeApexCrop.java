package safeapex.model;
import jeeb.lib.util.StatusDispatcher;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import capsis.defaulttype.Speciable;
import capsis.defaulttype.Species;
import safeapex.apex.*;


/**
 * SafeApexCrop represent the crop sowed on one cell of the plot (can be baresoil)
 * Only one SafeApexCrop is created by cell (state variables of the crop are homogenous)
 * Crop model is implemented by APEX (calling fortran native method) 
 *
 * @author Isabelle Lecomte - october 2018
 */

 public class SafeApexCrop  implements Speciable, Serializable {

 	private SafeApexCropSpecies cropSpecies;			// crop species (can be baresoil)
 	private SafeApexCell cell;						    // cell object reference
 	
 	//JNA APEX object
	public SafeApexApexCommun apexCrop;				//commun variable  in APEX

	//Root topology 
	private SafeApexFineRoot fineRoots;					//refer to fine root object

	private boolean isMainCropSpecies;
	private boolean isPerennial;
	private String cropType;
	private int startDay;						// First day of simulation  DOY

	
	
	
	//TODO MICHAEL BORUCKE=======================================================
	//WHERE ARE THESE DATAS STORED IN APEX ??? 
	//WHAT UNITS ??
	//===========================================================================
	private int phenologicStage;
 	private int sowingDay;						// Date of sowing           DOY
 	private int emergenceDay;					// Date of emergence        DOY
 	private int floweringDay;					// Date of flowering        DOY
 	private int harvestDay;						// Date of harvest          DOY
 	private float lai;							// m2.m-2
 	private float eai;							// m2.m-2
 	private float sla;							// cm2 g-1
 	private float biomass;						// Aboveground dry matter (masec) t.ha-1
 	private float grainBiomass;					// Grain dry matter (magrain) t.ha-1
 	private float yield;						// Yield t.ha-1 
 	private float height;						// Height of canopy (hauteur) mm
 	private float grainNumber;					// nbr m-2
 	private float grainWeight;					// g
 	private float plantDensity;					// nbr m-2
 	private float sowingDepth;					// m
 	private float rootDepth;					// m
 	private float cropTemperature;				// degree C
 	private float cropMaxTemperature;			// degree C
 	private float cropMinTemperature;			// degree C
 	private float soilSurfaceTemperature;		// degree C
 	private float soilManagementDepth;			// m

	private float resperenne;				//C crop reserve for perenial crops) t ha-1
	private float albedoLai;				//Albedo of the crop cobining soil with vegetation  SD	
	private float cNgrain;					//Nitrogen concentration of grains %
	private float cNplante;					//Nitrogen concentration of entire plant %
	private float qNgrain;					//Amount of nitrogen in harvested organs (grains / fruits)  kg ha-1
	private float qNplante;					//Amount of nitrogen taken up by the plant   kgN.ha-1

 	//Water budget inputs
	private float capillaryRise;			// mm
	private float irrigation;				// mm

	//Water budget outputs
 	private float waterDemand;				// mm
 	private float waterDemandReduced;		// mm
	private float waterUptake;				// mm
	private float soilEvaporation;			// mm
	private float runOff;					// mm
	private float surfaceRunOff;			// mm
	private float drainageWaterTable;		//mm
	private float drainageBottom;			//mm
	private float drainageArtificial;		//mm
	
	
	private float  rainIntercepted;			//mm
	private float  stemFlow;				//mm
	

	//Nitrogen budget inputs kg N ha-1
	private float nitrogenRain;
	private float nitrogenIrrigation;
	private float nitrogenFertilisationMineral;
	private float nitrogenFertilisationOrganic;
	private float nitrogenFixation;
	private float nitrogenDenitrification;
	private float nitrogenHarvested;
	private float biomassHarvested;
	private float nitrogenHumusMineralisation;
	private float nitrogenResiduMineralisation;
	

	//HUMUS (kg.ha-1) 
	private float totalNitrogenHumusStock;	    // Total quantity of N humus (active + inert fractions) in the soil // kg.ha-1
	private float totalCarbonHumusStock;		// Total amount of C humus (active + inert fractions) in the soil // kg.ha-1
	private float activeCarbonHumusStock;		// Amount of active C humus in the soil humus pool // kg.ha-1
	private float inactiveCarbonHumusStock;		// Amount of inactive C humus in the soil humus pool // kg.ha-1
	private float activeNitrogenHumusStock;	    // Amount of active N humus in the soil humus pool // kg.ha-1
	private float inactiveNitrogenHumusStock;	// Amount of inactive N humus in the soil humus pool // kg.ha-1
	
	//Residus of crop litters
	private float cnResidus;
	private float cropCarbonLeafLitter;		//cumulative mount of C in fallen leaves  (kgC.ha-1) 
	private float cropNitrogenLeafLitter;	//cumulative mount of N in fallen leaves  (kgN.ha-1) 
	private float cropCarbonRootLitter;		//cumulative amount of C in dead roots added to soil   (kgC.ha-1) 
	private float cropNitrogenRootLitter;	//cumulative amount of N in dead roots added to soil   (kgN.ha-1 )

	//Nitrogen budget outputs kg N ha-1
	private float nitrogenDemand;
	private float nitrogenUptake;			
	private float biomassRestitution;
   	private float nitrogenLeachingBottom;
   	private float nitrogenLeachingArtificial;
	private float nitrogenLeachingWaterTable;	//(AQ - 05.2011)
	private float nitrogenAddedByWaterTable;
	private float nitrogenImmobilisation;
	private float nitrogenVolatilisation;
	private float nitrogenVolatilisationOrganic;	

	// carbon and nitrogen resisus 
	private float carbonResidus;					//kgC.ha-1
	private float nitrogenResidus;					//kgN.ha-1
	
	//MULCH
	private float  carbonMulch;				// Total C in mulch at soil surface // kg.ha-1
	private float  nitrogenMulch;			// Total N in mulch at soil surface // kg.ha-1
	private float  carbonMulchTreeFoliage;	// undecomposable C in residue i present in the mulch // kg.ha-1
	private float  mulchBiomass;			//Quantity of plant mulch // t.ha-1
	private float  mulchEvaporation;		// Direct evaporation of water intercepted by the mulch // mm
	private float  mulchCoverRatio;			// Cover ratio of mulch  // 0-1
	private float  nitrogenGrain;
	private float  carbonMicrobes;	
	private float  carbonMicrobesMulch;	
	private float  nitrogenMicrobes;	
	private float  nitrogenMicrobesMulch;	
	
	//END OF DATA FRO APEX =======================================================
	//===========================================================================
	
	//Water stress
	private float hisafeWaterStress;		// calculated by hisafe 
	private float apexWaterStress;      	//  calculated by apex 
	
	//Nitrogen stress
	private float hisafeNitrogenStress;		// calculated by hisafe
	private float apexNitrogenStress;  		// calculated by apex
	
	
	//Tree SURFACE litter (above profHum)  
	//calculated by HISAFE and traited by APEX for mineralisation
	private float treeCarbonLeafLitter;
	private float treeNitrogenLeafLitter;
	private float treeCarbonFineRootLitter;
	private float treeNitrogenFineRootLitter;
	private float treeCarbonCoarseRootLitter;
	private float treeNitrogenCoarseRootLitter;

	//Tree DEEP litter (bollow profHum)   
	//calculated and traited by HISAFE with special mineralisation method (Safevoxel.deepSenescentRootsMineralization)
	//STICS cannot mineralise deep litters (maybe APEX can???) 
	private float treeCarbonFineRootDeepLitter;
	private float treeNitrogenFineRootDeepLitter;
	private float treeCarbonCoarseRootDeepLitter;
	private float treeNitrogenCoarseRootDeepLitter;
	
	// Light model output
	private float parExtinctionCoef;				// calculated
	private float extin;							// extinction coefficient for Stics formalism
	private float captureFactorForDiffusePar;		// m2 m-2 d-1
	private float captureFactorForDirectPar;		// m2 m-2 d-1
	private float directParIntercepted;				// Moles PAR m-2 d-1
	private float diffuseParIntercepted;			// Moles PAR m-2 d-1
	private float totalParInterceptedMJ;			// MJ m-2	used to force APEX
	private float competitionIndexForTotalPar;		// unitless
	private float parIntCum;						// Moles m-2
	private float parIntCumByCropPhenoStage;		// Moles m-2
	private float interceptedPar;					// imported from Stics (verif) // GT 6/03/2008
	
	//MAX values for EXPORT
 	private float laiMax;						// m2.m-2
 	private float eaiMax;						// m2.m-2
 	private float yieldMax;						// t.ha-1 (0 % water)
 	private float biomassMax;					// t.ha-1 
 	private float rootDepthMax;					// m
 	private float heightMax;					// m
 	
	//Monthly values for EXPORT
	private float monthBiomass;
	private float monthYield;
	private float monthEai;
	private float monthLai;
	private float monthDiffuseParIntercepted;
	private float monthDirecParIntercepted;
	private int monthNbrDays;
	
	//totals for EXPORT
	private float totalCapillaryRise;			// mm
	private float totalIrrigation;				// mm
 	private float totalWaterDemand;				// mm
 	private float totalWaterDemandReduced;		// mm
	private float totalWaterUptake;				// mm
	private float totalNitrogenDemand;			//kg N ha-1
	private float totalNitrogenUptake;			//kg N ha-1
	private float totalSoilEvaporation;			// mm
	private float totalRunOff;					// mm
	private float totalSurfaceRunOff;			// mm
	private float totalDrainageBottom;			// mm
	private float totalDrainageArtificial;		// mm
	private float totalRain;					// mm
	private float totalParIntercepted;			// Moles PAR m-2 d-1
	

 	public SafeApexCrop () {

 		this.cropSpecies = null;

 		this.lai = 0;
 		this.eai = 0;
 		this.extin = 0;
 		this.parExtinctionCoef = 0;
 		this.albedoLai = 0;
 		this.biomass = 0;
 		this.rootDepth = 0;
 		this.height = 0;
 		this.cropTemperature = 0;
 		this.cropMaxTemperature = 0;
 		this.cropMinTemperature = 0;
 		this.soilSurfaceTemperature = 0;
		this.yield = 0;
		this.grainNumber = 0;
		this.grainWeight = 0;
		this.plantDensity = 0;
		this.sowingDepth = 0;
		this.waterDemand = 0;
		this.waterDemandReduced = 0;
		this.soilEvaporation = 0;
		this.waterUptake = 0;
		this.hisafeWaterStress = 1;
		this.hisafeNitrogenStress = 1;
 		this.nitrogenDemand = 0;
		this.phenologicStage= 0;
		this.biomassRestitution = 0;
		this.sla = 0;
		this.captureFactorForDiffusePar= 0;
		this.captureFactorForDirectPar= 0;
		this.directParIntercepted= 0;
		this.diffuseParIntercepted= 0;
		this.totalParInterceptedMJ= 0;
		this.competitionIndexForTotalPar= 1;
		this.parIntCum= 0;
		this.parIntCumByCropPhenoStage= 0;
		this.interceptedPar=0;
		this.carbonResidus = 0;
		this.nitrogenResidus = 0;
		this.treeCarbonLeafLitter =0;
		this.treeNitrogenLeafLitter =0;
		this.treeCarbonFineRootLitter = 0;
		this.treeNitrogenFineRootLitter =0;
		this.treeCarbonCoarseRootLitter = 0;
		this.treeNitrogenCoarseRootLitter = 0;
		this.treeCarbonFineRootDeepLitter = 0;
		this.treeNitrogenFineRootDeepLitter =0;
		this.treeCarbonCoarseRootDeepLitter = 0;
		this.treeNitrogenCoarseRootDeepLitter = 0;
		this.nitrogenLeachingBottom =0;	
		this.nitrogenLeachingArtificial=0;
		this.nitrogenLeachingWaterTable =0;
		this.nitrogenAddedByWaterTable =0;

		this.razTotalWater();
		
		//Initialise roots informations
		this.fineRoots = new SafeApexFineRoot (this);
		
		//by defaut main crop species
		this.isMainCropSpecies = true;

	}
	/**
	* Constructor for cloning a crop from an old one
	*/
	public SafeApexCrop (SafeApexCrop oldCrop, boolean visible, SafeApexCell newCell) {

		this.cell				= newCell;		
		this.cropSpecies 		= oldCrop.cropSpecies;
		this.apexCrop			= oldCrop.apexCrop;


		this.isMainCropSpecies  = oldCrop.isMainCropSpecies;

		this.sowingDay   	   	= oldCrop.sowingDay;
		this.harvestDay   	   	= oldCrop.harvestDay;
		this.lai 				= oldCrop.lai;
		this.eai				= oldCrop.eai;
		this.extin				= oldCrop.extin;
		this.parExtinctionCoef  = oldCrop.parExtinctionCoef;
		this.albedoLai 			= oldCrop.albedoLai;
		this.biomass 			= oldCrop.biomass;
		this.yield = 0;
		this.height 			= oldCrop.height;
		this.grainNumber 		= oldCrop.grainNumber;
		this.plantDensity 		= oldCrop.plantDensity;
		this.grainWeight 		= oldCrop.grainWeight;
		this.rootDepth 			= oldCrop.rootDepth;
		this.sowingDepth 		= oldCrop.sowingDepth;
		this.cropTemperature 	= oldCrop.cropTemperature;
		this.cropMaxTemperature 	= oldCrop.cropMaxTemperature;
		this.cropMinTemperature 	= oldCrop.cropMinTemperature;
		this.soilSurfaceTemperature = oldCrop.soilSurfaceTemperature;
		this.phenologicStage	= oldCrop.phenologicStage;
		this.sla				= oldCrop.sla;
		this.resperenne     	= oldCrop.resperenne;
		this.grainBiomass        = oldCrop.grainBiomass;

		this.soilEvaporation	= 0;
		this.waterUptake		= 0;
		this.waterDemand		= 0;
		this.waterDemandReduced = 0;
		this.nitrogenLeachingBottom = 0;
		this.nitrogenLeachingArtificial = 0;
		this.nitrogenLeachingWaterTable = 0;
		this.nitrogenAddedByWaterTable = 0;
		this.captureFactorForDiffusePar	= 0;
		this.captureFactorForDirectPar	= 0;
		this.directParIntercepted		= 0;
		this.diffuseParIntercepted		= 0;
		this.totalParInterceptedMJ		= 0;
		this.competitionIndexForTotalPar= 1;
		this.parIntCum					= oldCrop.parIntCum;
		this.parIntCumByCropPhenoStage	= oldCrop.parIntCumByCropPhenoStage;
		this.interceptedPar				= oldCrop.interceptedPar;


		this.carbonResidus = oldCrop.carbonResidus;
		this.nitrogenResidus = oldCrop.nitrogenResidus;
		this.treeCarbonLeafLitter = oldCrop.treeCarbonLeafLitter;
		this.treeNitrogenLeafLitter = oldCrop.treeNitrogenLeafLitter;
		this.treeCarbonFineRootLitter =oldCrop.treeCarbonFineRootLitter;
		this.treeNitrogenFineRootLitter =oldCrop.treeNitrogenFineRootLitter;
		this.treeCarbonCoarseRootLitter = oldCrop.treeCarbonCoarseRootLitter;
		this.treeNitrogenCoarseRootLitter = oldCrop.treeNitrogenCoarseRootLitter;
		this.treeCarbonFineRootDeepLitter = oldCrop.treeCarbonFineRootDeepLitter;
		this.treeNitrogenFineRootDeepLitter = oldCrop.treeNitrogenFineRootDeepLitter;
		this.treeCarbonCoarseRootDeepLitter = oldCrop.treeCarbonCoarseRootDeepLitter;
		this.treeNitrogenCoarseRootDeepLitter = oldCrop.treeNitrogenCoarseRootDeepLitter;
		this.biomassRestitution = oldCrop.biomassRestitution;
		this.nitrogenDemand			= oldCrop.nitrogenDemand;	//to calculate  NitrogenSinkStrength
		this.hisafeWaterStress 		= oldCrop.hisafeWaterStress;
		this.hisafeNitrogenStress 	= oldCrop.hisafeNitrogenStress;

		//recopy fine roots informations
		this.fineRoots = new SafeApexFineRoot (oldCrop.fineRoots);

		//for annual export 
		if (oldCrop.lai > oldCrop.laiMax) 
			this.laiMax = oldCrop.lai ; 	
		else
			this.laiMax = oldCrop.laiMax ; 
	
		if (oldCrop.eai > oldCrop.eaiMax) 
			this.eaiMax = oldCrop.eai ; 	
		else
			this.eaiMax = oldCrop.eaiMax ; 
	
		if (oldCrop.rootDepth > oldCrop.rootDepthMax) 
			this.rootDepthMax = oldCrop.rootDepth ; 	
		else
			this.rootDepthMax = oldCrop.rootDepthMax ; 

		if (oldCrop.yield > oldCrop.yieldMax) 
			this.yieldMax = oldCrop.yield ; 	
		else
			this.yieldMax = oldCrop.yieldMax ; 

		
		if (oldCrop.biomass > oldCrop.biomassMax) 
			this.biomassMax = oldCrop.biomass ; 	
		else
			this.biomassMax = oldCrop.biomassMax ; 
		
		if (oldCrop.height > oldCrop.heightMax) 
			this.heightMax = oldCrop.height ; 	
		else
			this.heightMax = oldCrop.heightMax ;
		
		//Monthly values for EXPORT
		this.monthBiomass = oldCrop.monthBiomass + oldCrop.biomass;
		this.monthYield = oldCrop.monthYield + oldCrop.yield;
		this.monthEai 	= oldCrop.monthEai + oldCrop.eai;
		this.monthLai	= oldCrop.monthLai + oldCrop.lai;
		this.monthDiffuseParIntercepted = oldCrop.monthDiffuseParIntercepted + oldCrop.diffuseParIntercepted;
		this.monthDirecParIntercepted 	= oldCrop.monthDirecParIntercepted + oldCrop.directParIntercepted;	
		this.monthNbrDays = oldCrop.monthNbrDays + 1; 
		
		
		//Totals for EXPORT
		this.totalIrrigation 			= oldCrop.totalIrrigation;
		this.totalWaterDemand 			= oldCrop.totalWaterDemand;
		this.totalWaterDemandReduced	= oldCrop.totalWaterDemandReduced;
		this.totalWaterUptake 			= oldCrop.totalWaterUptake;
		this.totalNitrogenDemand 		= oldCrop.totalNitrogenDemand;
		this.totalNitrogenUptake 		= oldCrop.totalNitrogenUptake;
		this.totalSoilEvaporation 		= oldCrop.totalSoilEvaporation;
		this.totalRunOff 				= oldCrop.totalRunOff;
		this.totalSurfaceRunOff 		= oldCrop.totalSurfaceRunOff;
		this.totalDrainageBottom 		= oldCrop.totalDrainageBottom;
		this.totalDrainageArtificial    = oldCrop.totalDrainageArtificial;
		this.totalRain					= oldCrop.totalRain;
		this.totalParIntercepted        = oldCrop.totalParIntercepted;
		
	

	}
	
	/**
	* Destruction of APEX objects references (to clean memory) 
	*/
	public void razApexObjects () {
		//store usefull values for next year 

		this.apexCrop			= null;


	}
	
	/**
	* RAZ of month values
	*/
	public void razTotalMonth () {
		monthBiomass = 0; 
		monthYield = 0;
		monthEai = 0;
		monthLai = 0;
		monthDiffuseParIntercepted = 0;
		monthDirecParIntercepted = 0;
		monthNbrDays = 0;
	}
	
	/**
	* RAZ of max values
	*/
	public void razMaxValues () {
	 	laiMax = 0; 
	 	eaiMax = 0;
		yieldMax = 0;
		rootDepthMax = 0;
		biomassMax = 0;
		heightMax = 0;
	}
	
	/**
	 * RAZ Total values for water budget
	 **/
	public void razTotalWater () {
		this.totalCapillaryRise = 0;
		this.totalIrrigation = 0;
		this.totalWaterDemand = 0;
		this.totalWaterDemandReduced= 0;
		this.totalWaterUptake = 0;
		this.totalNitrogenDemand = 0;
		this.totalNitrogenUptake = 0;
		this.totalSoilEvaporation = 0;
		this.totalRunOff = 0;
		this.totalSurfaceRunOff = 0;
		this.totalDrainageBottom = 0;
		this.totalDrainageArtificial = 0;
		this.totalRain = 0;
		this.totalParIntercepted = 0;
	}
	
	/**
	 * APEX crop first initialisation with the sown crop species 
	 */
	public  void cropInitialisation (SafeApexJNA jna, 
			                        SafeApexEvolutionParameters evolutionParameters, 
			                        SafeApexPlotSettings plotSettings, 										                        
									SafeApexCropSpecies cropSpecies,									
									String dir)  throws Exception {


		this.apexCrop 		= new SafeApexApexCommun(plotSettings);
	
		this.setCropSpecies(cropSpecies);
	
	    jna.simulationStart (this, evolutionParameters, plotSettings,  dir);
	    

		return;
	}

	 /**
	* APEX initialisation copy for all cells with the same crop species 
	*/
	public void cropInitialisationCopy (SafeApexCrop initialCrop) {
		
		this.apexCrop 		= new SafeApexApexCommun(initialCrop.apexCrop);
		this.setCropSpecies (initialCrop.getCropSpecies());
	}
	
	/**
	 * APEX initialisation reload with a new crop species 
	 * SOIL IS NOT ERASED !
	 */
	public  void cropReload (SafeApexJNA jna, 
            				SafeApexEvolutionParameters evolutionParameters, 
        					SafeApexPlotSettings plotSettings, 										                        
    						SafeApexCropSpecies cropSpecies,									
							String dir)  throws Exception {

		
		
		//RAZ memory
		this.apexCrop = null; 

		
		//garbage collector
		System.gc();



		
		this.setCropSpecies(cropSpecies);

		//Initialise roots informations
		this.fineRoots = new SafeApexFineRoot (this);		
	
			
		return;
	}
	
	/**
	 * APEX initialisation reload with same perenial crop species 
	 * SOIL IS NOT ERASED !
	 */
	public  void cropPerenialReload (SafeApexJNA jna, 
									SafeApexApexCommun sc,  
									SafeApexCropSpecies cropSpecies,
									SafeApexInitialValues initialValues,
									String exportDir)  throws Exception {



		
		return;
	}

	/**
	 * APEX crop year loop start 
	 */
	public  void yearLoopStart (SafeApexJNA jna)  throws Exception {
	
	    jna.yearLoopStart (this);

		return;
	}
	
	/**
	 * APEX crop year loop end 
	 */
	public  void yearLoopEnd (SafeApexJNA jna)  throws Exception {
	
	    jna.yearLoopEnd (this);

		return;
	}
	
	/**
	 * APEX crop simulation end
	 */
	public  void simulationEnd (SafeApexJNA jna)  throws Exception {
	
	    jna.simulationEnd (this);

		return;
	}
	
	/**
	 * APEX CROP process Apport (to add tree litter to the soil mineralisation)
	 **/
	//TODO MICHAEL BORUCKE=======================================================
	//HOW CAN WE ADD TREE LITTER MINERALISATION IN APEX????
	//===========================================================================
	public void processApport (SafeApexJNA jna, 
								SafeApexApexCommun sc, 
								SafeApexEvolutionParameters evolutionParameters,								
								SafeApexCell c,		
								int julianDay,
							    double profHum, 
							    double treeRootDepth,
							    double treeCarbonLeafLitter, 
							    double treeNitrogenLeafLitter) {
		
		this.setTreeCarbonLeafLitter (treeCarbonLeafLitter);	//kg C ha-1
		this.setTreeNitrogenLeafLitter (treeNitrogenLeafLitter);	//kg N ha-1
		
		//fine and coarse roots litter calculation
		double treeCarbonFineRootsLitter = 0;
		double treeNitrogenFineRootsLitter = 0;
		double treeCarbonCoarseRootsLitter = 0;
		double treeNitrogenCoarseRootsLitter = 0;
		double treeCarbonFineRootsDeepLitter = 0;
		double treeNitrogenFineRootsDeepLitter = 0;
		double treeCarbonCoarseRootsDeepLitter = 0;
		double treeNitrogenCoarseRootsDeepLitter = 0;	

		if ((evolutionParameters.treesRootLitterIncorporated) || (evolutionParameters.treesDeepRootLitterIncorporated) )	{	

			SafeApexVoxel [] voxels = c.getVoxels();

			//FOR EACH VOXEL
			for (int i = 0; i < voxels.length; i++) {
				
				SafeApexVoxel v = voxels[i];
				double voxelTop    = v.getZ()-(v.getThickness()/2);
				double voxelBottom = v.getZ()+(v.getThickness()/2);
				double prop = 1d;
				
				//SURFACE VOXEL < PROFHUM
				if (voxelBottom <= profHum) {

					if (evolutionParameters.treesRootLitterIncorporated) {
						treeCarbonCoarseRootsLitter += (v.getTotalTreeCarbonCoarseRootSen());//in kg
						treeNitrogenCoarseRootsLitter +=(v.getTotalTreeNitrogenCoarseRootSen());
						treeCarbonFineRootsLitter += (v.getTotalTreeCarbonFineRootSen());
						treeNitrogenFineRootsLitter += (v.getTotalTreeNitrogenFineRootSen());
					}

				}
				else {
					
					if (voxelTop < profHum){
						prop = (voxelBottom - profHum)/(voxelBottom-voxelTop);
					}

					
					if (evolutionParameters.treesDeepRootLitterIncorporated) {
						treeCarbonCoarseRootsDeepLitter += (v.getTotalTreeCarbonCoarseRootSen()*prop);//in kg
						treeNitrogenCoarseRootsDeepLitter += (v.getTotalTreeNitrogenCoarseRootSen()*prop);
						treeCarbonFineRootsDeepLitter += (v.getTotalTreeCarbonFineRootSen()*prop);
						treeNitrogenFineRootsDeepLitter += (v.getTotalTreeNitrogenFineRootSen()*prop);						
					}
					
					
					//Voxel cut in 2 by profHum
					if ((prop < 1d) && (prop > 0))  {
						if (evolutionParameters.treesRootLitterIncorporated) {
							treeCarbonCoarseRootsLitter += (v.getTotalTreeCarbonCoarseRootSen()*(1-prop));//in kg
							treeNitrogenCoarseRootsLitter +=(v.getTotalTreeNitrogenCoarseRootSen()*(1-prop));
							treeCarbonFineRootsLitter += (v.getTotalTreeCarbonFineRootSen()*(1-prop));
							treeNitrogenFineRootsLitter += (v.getTotalTreeNitrogenFineRootSen()*(1-prop));
						}
					}
				}
			}

			//SURFACE LITTERS
			treeCarbonFineRootsLitter = treeCarbonFineRootsLitter  / (c.getArea() / 10000); // kg ha-1	
			treeCarbonCoarseRootsLitter = treeCarbonCoarseRootsLitter  / (c.getArea() / 10000); // kg ha-1	
			treeNitrogenCoarseRootsLitter = treeNitrogenCoarseRootsLitter  / (c.getArea() / 10000); // kg ha-1	
			treeNitrogenFineRootsLitter = treeNitrogenFineRootsLitter  / (c.getArea() / 10000); // kg ha-1	
				
			this.setTreeCarbonFineRootLitter (treeCarbonFineRootsLitter);		
			this.setTreeCarbonCoarseRootLitter (treeCarbonCoarseRootsLitter);
			this.setTreeNitrogenFineRootLitter (treeNitrogenFineRootsLitter);
			this.setTreeNitrogenCoarseRootLitter (treeNitrogenCoarseRootsLitter);		
	

			//DEEP LITTERS			
			treeCarbonFineRootsDeepLitter = treeCarbonFineRootsDeepLitter  / (c.getArea() / 10000); // kg ha-1	
			treeCarbonCoarseRootsDeepLitter = treeCarbonCoarseRootsDeepLitter  / (c.getArea() / 10000); // kg ha-1	
			treeNitrogenCoarseRootsDeepLitter = treeNitrogenCoarseRootsDeepLitter  / (c.getArea() / 10000); // kg ha-1	
			treeNitrogenFineRootsDeepLitter = treeNitrogenFineRootsDeepLitter  / (c.getArea() / 10000); // kg ha-1	
			
			this.setTreeCarbonFineRootDeepLitter (treeCarbonFineRootsDeepLitter);		
			this.setTreeCarbonCoarseRootDeepLitter (treeCarbonCoarseRootsDeepLitter);
			this.setTreeNitrogenFineRootDeepLitter (treeNitrogenFineRootsDeepLitter);
			this.setTreeNitrogenCoarseRootDeepLitter (treeNitrogenCoarseRootsDeepLitter);	

		}

		//TODO MICHAEL BORUCKE=======================================================
		//HOW CAN WE ADD TREE LITTER MINERALISATION IN APEX????
		//===========================================================================
		/*
		if (treeCarbonLeafLitter > 0 || treeCarbonFineRootsLitter > 0 || treeCarbonCoarseRootsLitter > 0) {
			sc.HI_TCL = (float) treeCarbonLeafLitter;
			sc.HI_TLF = (float) treeNitrogenLeafLitter;
			sc.HI_TCF = (float) treeCarbonFineRootsLitter;
			sc.HI_TNF = (float) treeNitrogenFineRootsLitter;
			sc.HI_TCR = (float) treeCarbonCoarseRootsLitter;
			sc.HI_TNC = (float) treeNitrogenCoarseRootsLitter;
			//call JNA native method
			jna.addTreeLitters(this);
		}
		*/
		
		if (treeCarbonLeafLitter > 0) {
			
			sc.HI_TCL = (float) treeCarbonLeafLitter;
			sc.HI_TLF = (float) treeNitrogenLeafLitter;
			
			//call JNA native method
			jna.addTreeLitters(this);
		}
		
			
		if (treeCarbonFineRootsLitter > 0) {
			
			sc.HI_TCF = (float) treeCarbonFineRootsLitter;
			sc.HI_TNF = (float) treeNitrogenFineRootsLitter;
			//call JNA native method
			jna.addTreeLitters(this);
		}
		
		//TREE COARSE ROOTS LITTER INCORPORTION 
		if (treeCarbonCoarseRootsLitter > 0) {
			
			sc.HI_TCR = (float) treeCarbonCoarseRootsLitter;
			sc.HI_TNC = (float) treeNitrogenCoarseRootsLitter;
			//call JNA native method
			jna.addTreeLitters(this);
		}	

	}
	/**
	 * APEX CROP process growth part I (before water repartition)
	 **/
	public void processGrowth1 (SafeApexJNA jna, 
								SafeApexCell cell,
							    SafeApexInitialParameters safeSettings,
								int julianDay, 
							    double cellRad, 
							    double cellRain,
							    double cellEtp
								) {
		
		//call JNA native method
		jna.dayLoopStart (this, julianDay,cellRad,cellRain,cellEtp);
		System.out.println("SafeApexCrop Line 751");
		//APEX variable storage
		
		//TODO MICHAEL BORUCKE=======================================================
		//WHERE ARE THESE CROP VALUES IN APEX  ???
		// replace the 0 values by apex object variables
		//===========================================================================

		this.soilEvaporation = 0;	 			//mm
		this.emergenceDay 	 = 0;    			//DOY
		this.floweringDay 	 = 0;    			//DOY
		this.rootDepth 		 = 0;	 			//m
		this.lai 			 = 0; 
		this.biomass 		 = 0;				//t ha-1		
		this.grainBiomass 	 = 0;				//t ha-1

		
		this.cNgrain=0;					//%
		this.cNplante=0;					//%
		this.qNgrain=0;					//kg ha-1
		this.qNplante=0;					//kgN.ha-1
		System.out.println("SafeApexCrop Line 772");
		
		
		//WATER and NITROGEN DEMAND
		this.waterDemand  	 = 0;				//mm
		this.nitrogenDemand  = 0;				//kg ha-1


		//Sum of roots calculation (for water repartition module)
		this.computeTotalRoot (cell, safeSettings);

		//Reduction factor for water demand (dimensionless)
		if (this.waterDemand > 0) {		//in mm
			this.getFineRoots().calculatePotential (safeSettings, this.waterDemand*cell.getArea());		// gt - 12.11.2009 - water demand is now expressed in liters instead of mm

			//IF RACHMAT VERSION ONLY !!!!
			double waterDemandReductionFactor = this.getFineRoots().getWaterDemandReductionFactor();
			setWaterDemandReduced (this.getWaterDemand() * waterDemandReductionFactor);		//mm
		System.out.println("SafeApexCrop Line 791");
		}

		//Nitrogen sink strength with nitrogen demand of the day before
		if (nitrogenDemand > 0)
			this.getFineRoots().calculateNitrogenSinkStrength (safeSettings, nitrogenDemand);

		//cumulation of Rain transmitted on the crop
		this.totalRain				+= cellRain;
		System.out.println("SafeApexCrop Line 799");
		return;
	}


	/**
	 * APEX CROP process growth part II (after water repartition)
	 **/
	public void processGrowth2 (SafeApexJNA jna, int julianDay) {

		//call JNA native method	
		jna.dayLoopEnd (this);
					
		//TODO MICHAEL BORUCKE=======================================================
		//WHERE ARE THESE CROP VALUES IN APEX  ???
		// replace the 0 values by apex object variables
		//===========================================================================
		/*TGRAZ.f90 Line 85:
			! GRAZING YIELD FOR STANDING LIVE 
			YLD(JJ)=GRLV(JJ)*HE(JT1)

			ALSO,

			In output file OUTPUT.ACY, there is YLDG which is
			GRAIN, FIBER, ETC CROP YIELD (T/HA)

			Why is there no YLD calculation for non-grazed crops? And where is YLDG calculated?
*/
					
		this.phenologicStage 		= 0;
		this.harvestDay 			= 0;	//DOY
		this.yield 			= 0;	//t.ha-1 (0 % water)
/*		
		Root Depth (RD) in m is calculated (in theoretical) as: 
			RD(i)=min(2.5*RDMX(i)*HUI(i),RDMX,RZ) 
			But in CGROW.f90 calculated as:
			RD(JJK,ISA)=MIN(RDMX(JJK),Z(LID(NBSL(ISA),ISA),ISA),XX)
*/			
		this.rootDepth 				= 0;	//m
		this.extin					= 0;	//ND
		this.albedoLai 				= 0;	//ND
		this.plantDensity	        = 0;	//plants.m-2
		this.cropTemperature 	    = 0;	//degree C
		this.cropMaxTemperature 	= 0;	//degree C
		this.cropMinTemperature 	= 0;	//degree C
		this.soilSurfaceTemperature = 0;	//degree C
		this.soilManagementDepth 	= 0;	//m

		this.lai 			= 0; 	//m2 m-2
		this.eai			= 0;	//m2 m-2	  
		this.height 		= 0;	//m
		this.grainNumber 	= 0;	// nbr m-2
		this.grainWeight 	= 0;	// g
		
		this.sla 			= 0;	//cm2 g-1
		this.resperenne     = 0;	//t ha-1	
		this.interceptedPar = 0; 	// MJ m-2
		this.cNgrain 		= 0;	//%
		this.cNplante 		= 0;	//%
		this.qNgrain		= 0;	//kg h-1
	

		this.qNplante 		= 0;	//kgN.ha-1
		this.biomass 		= 0;	//t ha-1		
		this.grainBiomass 	= 0;	//convert g m-2 in t ha-1
		this.carbonResidus 	= 0;	//kgC.ha-1
		this.nitrogenResidus = 0;	//kgN.ha-1
		//---------------------------------------------------------------------------

		//WATER (mm) 
		this.runOff			 = 0;			
		this.surfaceRunOff 	 = 0;	    
		this.capillaryRise	 = 0;			  
		this.irrigation 	 = 0;		
		this.drainageWaterTable = 0; 
		this.drainageBottom = 0;
		this.drainageArtificial = 0;
		this.rainIntercepted = 0; 
		this.stemFlow = 0;				

		
		//NITROGEN ENTRIES (kg ha-1 )
		this.nitrogenRain 					= 0;
		this.nitrogenIrrigation 			= 0;			
		this.nitrogenFixation 				= 0;
		this.nitrogenDenitrification 		= 0;
		this.nitrogenFertilisationMineral 	= 0;	
		this.nitrogenFertilisationOrganic 	= 0;
		
		this.nitrogenHumusMineralisation= 0;
		this.nitrogenResiduMineralisation= 0;
		
		//NITROGEN OUTPUTS (kg ha-1 )
		this.biomassRestitution = 0;			
		this.nitrogenLeachingBottom = 0;
		this.nitrogenLeachingArtificial = 0;
		this.nitrogenImmobilisation = 0;		
		this.nitrogenVolatilisation= 0;		
		this.nitrogenVolatilisationOrganic = 0;		
		this.nitrogenHarvested = 0;		
		this.biomassHarvested = 0; 
		
		//NITROGEN OUTPUTS (kg ha-1 )
		this.totalNitrogenHumusStock= 0;
		this.totalCarbonHumusStock= 0;
		this.activeCarbonHumusStock= 0;
		this.inactiveCarbonHumusStock= 0;
		this.activeNitrogenHumusStock= 0;
		this.inactiveNitrogenHumusStock= 0;
		
		//residus
		this.cnResidus = 0;	
		this.cropCarbonLeafLitter = 0;
		this.cropNitrogenLeafLitter = 0;
		this.cropCarbonRootLitter = 0;
		this.cropNitrogenRootLitter = 0;

		
		//MULCH
		this.carbonMulch= 0;
		this.nitrogenMulch= 0;
		this.carbonMulchTreeFoliage= 0;
		this.mulchBiomass= 0;
		this.mulchEvaporation= 0;
		this.mulchCoverRatio= 0;
		this.nitrogenGrain= 0;
		this.carbonMicrobes= 0;	
		this.carbonMicrobesMulch= 0;	
		this.nitrogenMicrobes= 0;	
		this.nitrogenMicrobesMulch= 0;
		
		
		//stress indexes
	    this.apexWaterStress= 0;
        this.apexNitrogenStress= 0;
 

		//TOTALS
		this.totalCapillaryRise 	+= this.capillaryRise;
		this.totalIrrigation 		+= this.irrigation;
		this.totalWaterDemand 		+= this.waterDemand;
		this.totalWaterDemandReduced += this.waterDemandReduced;
		this.totalWaterUptake 		+= this.waterUptake;
		this.totalNitrogenDemand	+= this.nitrogenDemand;
		this.totalNitrogenUptake 	+= this.nitrogenUptake;
		this.totalSoilEvaporation 	+= this.totalSoilEvaporation;
		this.totalRunOff 			+= this.runOff;
		this.totalSurfaceRunOff 	+= this.surfaceRunOff;
		this.totalDrainageBottom 	+= this.drainageBottom;		//m;
		this.totalDrainageArtificial += this.drainageArtificial;
		this.totalParIntercepted    +=  this.getDirectParIntercepted();
		this.totalParIntercepted	+= this.getDiffuseParIntercepted();


	}



	/**
	* Sum of roots calculation (for water repartition module)
	**/
	public void computeTotalRoot (Object c,  SafeApexInitialParameters settings) {
		SafeApexVoxel [] voxels = null;
		voxels = ((SafeApexCell) c).getVoxels();
		
		double cropRootLength = 0;
		double plantPotential = 0;

		double drySoilFactor = settings.harmonicWeightedMean;
		
		for (int i=0; i<voxels.length ; i++) {		// first iterator to compute totalRootLength
			cropRootLength += voxels[i].getCropRootDensity() * voxels[i].getVolume();			// m.m-3 * m3 = m
		}
		this.getFineRoots().setTotalRootLength (cropRootLength);	


		if (cropRootLength <= 0) return;
		for (int i=0; i<voxels.length ; i++) {		// second iterator to compute required plant water potential
			double neededPot = voxels[i].getWaterPotentialTheta();	// soil water potential in this voxel

			// additional potential for water flow from bulk soil to rhizosphere
			neededPot *= (1+this.getCropSpecies().getCropBufferPotential()); 

			// additional potential for water flow from root surface to xylem
			double radialTransportPotential = -this.getWaterDemand()								// L.day-1=dm3.day-1
												* 1000														// from L.day-1 to cm3.day-1
												/this.getCropSpecies().getCropRootConductivity()			// cm day-1
												/(cropRootLength*100);									// m to cm
			
			this.getFineRoots().setRadialTransportPotential(radialTransportPotential);
			neededPot += radialTransportPotential;

			
			// additional potential to account for longitudinal water transport in coarse roots from the voxel to stem base
			double longitudinalTransportPotential = -this.getWaterDemand()										//L.day-1=dm3.day-1
														* 1000															// from L.day-1 to cm3.day-1
														* this.getCropSpecies().getCropLongitudinalResistantFactor()	// day.cm-1.m-1
														/(cropRootLength*100);										// m to cm
			// in the model documentation from Meine et al, this term is not divided by totalRootLength... but it leads to very different longitudinal drop potential for small and large trees because of differences in water demand... so...

			this.getFineRoots().setLongitudinalTransportPotential(longitudinalTransportPotential);
			neededPot += longitudinalTransportPotential*voxels[i].getZ();	// topological distance (m) between the voxel and stem base

			// additional potential to account for voxel depth
			neededPot -= voxels[i].getZ()*100;		// from m to cm

			plantPotential += -(voxels[i].getCropRootDensity() * voxels[i].getVolume()	// m.m-3 * m3 = m
									/ Math.pow(-neededPot, drySoilFactor));	// cm
			
		}
		
		
		plantPotential =-Math.pow (-cropRootLength /plantPotential , 1/drySoilFactor);


		this.getFineRoots().setRequiredWaterPotential(plantPotential);
			
	}

	/**
	* Updating the results of light interception
	**/
	public void updateDailyInterceptedPar (SafeApexDailyClimat dailyClimat,
											SafeApexInitialParameters settings,
											SafeApexBeamSet beamSet){


		if(this.getLai()+this.getEai() >0){
			// Climatic input
			float dailyDiffuse = dailyClimat.getDiffusePar();	// moles m-2
			float dailyDirect = dailyClimat.getDirectPar();		// moles m-2

			// Topological mask
			float diffuseMask = (float) beamSet.getSkyDiffuseMask();
			float directMask = (float) beamSet.getSkyDirectMask();


			setDiffuseParIntercepted(getCaptureFactorForDiffusePar()*dailyDiffuse);	//moles.m-2
			setDirectParIntercepted(getCaptureFactorForDirectPar()*dailyDirect);	//moles.m-2

			float parIntercepted = getDirectParIntercepted()+getDiffuseParIntercepted(); //moles.m-2

			setTotalParInterceptedMJ(parIntercepted									//moles.m-2
									 * (float) settings.molesParCoefficient);		//*MJ.moles-1 = MJ.m-2


			// Computation of a competition index for Par =
			//		(TotalParIntercepted)/(Par intercepted by the same crop in monoculture)

			float incidentPar = dailyDiffuse*diffuseMask+dailyDirect*directMask;
			if((lai+eai)>0){
				float competitionIndex = (float) (parIntercepted	// Par intercepted (moles.m-2)
								/(0.95*(1-Math.exp(-extin*(lai+eai)))	// % of Par intercepted by monocrop
								*incidentPar));						// daily incident Par (Moles m-2)
				setCompetitionIndexForTotalPar(competitionIndex);

			} else {
				setCompetitionIndexForTotalPar(1);
			}

			this.parIntCum += parIntercepted;
			this.parIntCumByCropPhenoStage += parIntercepted;
		}
	}

	/**
	* reset capture factors for light
	**/
	public void resetDirect (){captureFactorForDirectPar = 0;}
	public void resetDiffuse (){captureFactorForDiffusePar = 0;}

	/**
	* Optimization of light extinction coefficient to be coherent with Stics
	**/
	public void findCropLightCoef(SafeApexBeamSet beamSet, SafeApexInitialParameters settings, SafeApexDailyClimat climat){

		// % of Par intercepted by monocrop with Stic's formalism
		double toBeIntercepted =1-Math.exp(-(this.lai+this.eai)*this.extin);

		// weights of direct and diffuse Par
		double dailyDiffuse = climat.getDiffusePar()/climat.getGlobalPar();
		double dailyDirect = climat.getDirectPar()/climat.getGlobalPar();

		if(toBeIntercepted!=0){
			// initialisation of k
			double kEst=extin;

			// calculation of Newton function = intercepted(kEst)-toBeIntercepted
			//				and its derivative
			double fEst=0;
			double fEstPrime=0;
			double fOld = 1;
			double kOld = 1;
			int nbIt = 0;

			while((nbIt==0)||(((Math.abs(kEst-kOld)/kOld)>0.00001)||((Math.abs(fEst-fOld)/fOld)>0.001))){
				nbIt++;
				fEst = -toBeIntercepted;
				fEstPrime = 0;

				for (Iterator ite = beamSet.getBeams ().iterator (); ite.hasNext ();) {

					SafeApexBeam b = (SafeApexBeam) ite.next ();
					fOld=fEst;
					fEst +=(dailyDiffuse*b.getDiffuseEnergy()+dailyDirect*b.getDirectEnergy())
									* (1-Math.exp(-kEst*(lai+eai)/Math.sin(b.getHeightAngle_rad())));
					fEstPrime +=(dailyDiffuse*b.getDiffuseEnergy()+dailyDirect*b.getDirectEnergy())
								*(lai+eai)/Math.sin(b.getHeightAngle_rad())
								*Math.exp(-kEst*(lai+eai)/Math.sin(b.getHeightAngle_rad()));
				}
				kOld=kEst;
				kEst += -fEst/fEstPrime;
			}

			setParExtinctionCoef (kEst);
		}
	}

	/**
	* Crop light interception calculation 
	* used when CropLightMethod=false (set in hisafeapex.par) 
	**/
	public void cropLightInterception (SafeApexInitialParameters settings, SafeApexBeamSet beamSet, double directProp, double diffuseProp){
		float lai = this.getLai();
		float eai = this.getEai();
		float extin = this.getExtin();
		float raint = (float) (0.95*(1-Math.exp(-extin*(lai+eai))));
		this.setCaptureFactorForDirectPar((float) (raint*directProp));
		this.setCaptureFactorForDiffusePar((float) (raint*diffuseProp));	
	}
	
	
	
//FOR EXPORT (IL GT 19/12/07)

	
	public SafeApexApexCommun getApexCrop() {return apexCrop;}


	
	public SafeApexFineRoot getFineRoots() {return fineRoots;}

	public void setCropSpecies (SafeApexCropSpecies cropSpecies) {this.cropSpecies=cropSpecies;}
	public SafeApexCropSpecies getCropSpecies () {return cropSpecies ;}
	//Speciable interface FC 20.12.2004
	public Species getSpecies () {return cropSpecies;}

	public void setMainCropSpecies(boolean b){isMainCropSpecies=b;}
	public boolean IsMainCropSpecies(){return isMainCropSpecies;}
	public String getCropType () {
		if (IsMainCropSpecies()) return "mainCrop";
		else return "interCrop";
	}
	
	public SafeApexCell getCell() {return cell;}
	public int getSowingDay () {return sowingDay;}
	public int getHarvestDay () {return harvestDay;}
	public int getFloweringDay () {return floweringDay;}
	public int getEmergenceDay () {return emergenceDay;}
	public int getPhenologicStage () {return phenologicStage;}
	public boolean isPerennial () {return isPerennial;} 

	public float getLai () {return lai;}
	public float getEai () {return eai;}
	public float getLaiMax () {return laiMax;}
	public float getEaiMax () {return eaiMax;}
	public float getExtin () {return extin;}
	public float getAlbedoLai () {return albedoLai;}
	public float getBiomass () {return biomass;}
	public float getGrainBiomass () {return grainBiomass;}
	public float getBiomassMax () {return biomassMax;}
	
	public float getHeight() {return  height;}
	public float getHeightMax () {return heightMax;}
	
	public float getYield() {return  yield;}
	public float getYieldMax() {return  yieldMax;}
	
	public float getGrainNumber () {return  grainNumber;}
	public float getGrainWeight () {return  grainWeight;}
	public float getPlantDensity () {return  plantDensity;}
	public float getYieldIndice () {
		if(this.biomass == 0){
			return 0;
		} else {
			return this.yield/this.biomass;
		}
	}

	public float getSowingDepth () {return  sowingDepth;}
	public float getRootDepth () {return  rootDepth;}
	public float getRootDepthMax () {return  rootDepthMax;}
	public float getCropTemperature () {return  cropTemperature;}
	public float getCropMaxTemperature () {return  cropMaxTemperature;}
	public float getCropMinTemperature () {return  cropMinTemperature;}
	public float getSoilSurfaceTemperature () {return soilSurfaceTemperature;}
	public float getSoilManagementDepth () {return soilManagementDepth;}
	
	public float getSoilEvaporation () {return  soilEvaporation;}
	public float getRunOff () {return  runOff;}
	public float getSurfaceRunOff() {return  surfaceRunOff;}
	public float getCapillaryRise () {return capillaryRise;}
	
	public float getDrainageBottom () {return drainageBottom;}
	public float getDrainageArtificial () {return drainageArtificial;}
	
	public float getRainIntercepted () {return rainIntercepted;}
	public float getStemFlow () {return stemFlow;}

	
	
	public float getIrrigation () {return  irrigation;}
	public float getQngrain() {return qNgrain;}
	public float getQnplante() {return qNplante;}
	public float getCngrain() {return cNgrain;}
	public float getCnplante() {return cNplante;}
	
	//SURFACE LEAVES LITTER--------------------------------------------------------
	public double getTreeCarbonLeafLitter () {return  (double) treeCarbonLeafLitter;}
	public double getTreeNitrogenLeafLitter () {return (double) treeNitrogenLeafLitter;}
	public void  setTreeCarbonLeafLitter (double v) {treeCarbonLeafLitter =  (float) v;}
	public void  setTreeNitrogenLeafLitter (double v) {treeNitrogenLeafLitter =  (float) v;}

	//SURFACE ROOT LITTER---------------------------------------------------------
	public double getTreeCarbonFineRootLitter (){return (double) treeCarbonFineRootLitter;}
	public double getTreeNitrogenFineRootLitter(){return (double) treeNitrogenFineRootLitter;}
	public double getTreeCarbonCoarseRootLitter (){return (double) treeCarbonCoarseRootLitter;}
	public double getTreeNitrogenCoarseRootLitter(){return (double) treeNitrogenCoarseRootLitter;}
	public void setTreeCarbonFineRootLitter (double v){treeCarbonFineRootLitter = (float) v;}
	public void setTreeNitrogenFineRootLitter(double v){treeNitrogenFineRootLitter = (float) v;}
	public void setTreeCarbonCoarseRootLitter (double v){treeCarbonCoarseRootLitter = (float) v;}
	public void setTreeNitrogenCoarseRootLitter(double v){treeNitrogenCoarseRootLitter = (float) v;}

	//DEEP ROOTS LITTER--------------------------------------------------------
	public double getTreeCarbonFineRootDeepLitter (){return (double) treeCarbonFineRootDeepLitter;}
	public double getTreeNitrogenFineRootDeepLitter(){return (double) treeNitrogenFineRootDeepLitter;}
	public double getTreeCarbonCoarseRootDeepLitter (){return (double) treeCarbonCoarseRootDeepLitter;}
	public double getTreeNitrogenCoarseRootDeepLitter(){return (double) treeNitrogenCoarseRootDeepLitter;}
	public void setTreeCarbonFineRootDeepLitter (double v){treeCarbonFineRootDeepLitter = (float) v;}
	public void setTreeNitrogenFineRootDeepLitter(double v){treeNitrogenFineRootDeepLitter = (float) v;}
	public void setTreeCarbonCoarseRootDeepLitter (double v){treeCarbonCoarseRootDeepLitter = (float) v;}
	public void setTreeNitrogenCoarseRootDeepLitter(double v){treeNitrogenCoarseRootDeepLitter = (float) v;}



	public double getTotalRootLength () {
		if (this.getFineRoots() != null)
			return this.getFineRoots().getTotalRootLength();
		else
			return 0;
	}
	
	//------------------------------------------------------------------------------------------
//WATER AND NITROGEN BUDGET
	public float getWaterDemand () {return  waterDemand;}
	public void setWaterDemand (double v) { waterDemand =  (float) v;}
	public float getWaterDemandReduced() {return  waterDemandReduced;}
	public void setWaterDemandReduced (double v) { waterDemandReduced = (float) v;}
	public float getHisafeWaterStress () {return hisafeWaterStress;}
	public void setHisafeWaterStress (double v) {hisafeWaterStress = (float) v;}
	public float getWaterUptake() {return  waterUptake;}
	public void  setWaterUptake(double v) {waterUptake =  (float) v;}
	public void addWaterUptake  (double v) {waterUptake  +=  (float) v;}

	


	public float getNitrogenDemand () {return nitrogenDemand;}
	public float getNitrogenUptake () {return nitrogenUptake;}
	public void setNitrogenUptake (double v) {nitrogenUptake =  (float) v;}
	public float getNitrogenRain () {return  nitrogenRain;}
	
	public float getDrainageWaterTable () {return drainageWaterTable;}
	public void addDrainageWaterTable (double v) {drainageWaterTable+= (float) v;}
	
	public float getNitrogenFixation () {return  nitrogenFixation;}
	public float getNitrogenDenitrification () {return  nitrogenDenitrification;}
	public float getBiomassRestitution () {return biomassRestitution;}
	public float getNitrogenLeachingBottom () {return  nitrogenLeachingBottom;}
	public float getNitrogenLeachingArtificial () {return  nitrogenLeachingArtificial;}
	
	
	
	public float getNitrogenLeachingWaterTable() {return  nitrogenLeachingWaterTable;}
	public float getNitrogenAddedByWaterTable () {return  nitrogenAddedByWaterTable;}// AQ 11/04/2011
	public void addNitrogenAddedByWaterTable (double np) {nitrogenAddedByWaterTable +=np;}// AQ 11/04/2011
	public void addNitrogenLeachingWaterTable (double lix) {nitrogenLeachingWaterTable +=lix;}		

	public float getNitrogenImmobilisation () {return  nitrogenImmobilisation;}
	public float getNitrogenVolatilisation () {return  nitrogenVolatilisation;}
	public float getNitrogenVolatilisationOrganic () {return  nitrogenVolatilisationOrganic;}
	public float getHisafeNitrogenStress () {return hisafeNitrogenStress;}
	public void setHisafeNitrogenStress (double v) {hisafeNitrogenStress = (float) v;}

	public float getNitrogenIrrigation () {return  nitrogenIrrigation;}
	public float getNitrogenFertilisationMineral () {return  nitrogenFertilisationMineral;}
	public float getNitrogenFertilisationOrganic () {return  nitrogenFertilisationOrganic;}
	public float getNitrogenHumusMineralisation () {return  nitrogenHumusMineralisation;}
	public float getNitrogenResiduMineralisation () {return  nitrogenResiduMineralisation;}
	public float getCropCarbonLeafLitter () {return  cropCarbonLeafLitter;}
	public float getCropNitrogenLeafLitter () {return  cropNitrogenLeafLitter;}
	public float getCropCarbonRootLitter () {return  cropCarbonRootLitter;}
	public float getCropNitrogenRootLitter () {return  cropNitrogenRootLitter;}
	public float getNitrogenHarvested() {return  nitrogenHarvested;}
	public float getBiomassHarvested () {return  biomassHarvested;}
	
	

	public float getCarbonResidus() {return  carbonResidus;}
	public float getNitrogenResidus() {return nitrogenResidus;}
	
	
	public float getTotalNitrogenHumusStock(){return totalNitrogenHumusStock;}
	public float getTotalCarbonHumusStock(){return totalCarbonHumusStock;}		
	public float getActiveCarbonHumusStock(){return  activeCarbonHumusStock;}
	public float getInactiveCarbonHumusStock() {return inactiveCarbonHumusStock;}	
	public float getActiveNitrogenHumusStock(){return  activeNitrogenHumusStock;}	
	public float getInactiveNitrogenHumusStock() {return inactiveNitrogenHumusStock;}
	
	public float getCnResidus(){return cnResidus;}


	public float getSla(){return sla;}


	//Monthly values for export
	public float getMonthBiomass () {
		if (monthNbrDays > 0)   return  monthBiomass/monthNbrDays;
		else return 0;
		}
	public float getMonthYield() {
		if (monthNbrDays > 0)   return  monthYield/monthNbrDays;
		else return 0;
		}
	public float getMonthEai () {
		if (monthNbrDays > 0)   return  monthEai/monthNbrDays;
		else return 0;
		}
	public float getMonthLai () {
		if (monthNbrDays > 0)   return  monthLai/monthNbrDays;
		else return 0;
		}
	public float getMonthDiffuseParIntercepted () {
		if (monthNbrDays > 0)   return  monthDiffuseParIntercepted/monthNbrDays;
		else return 0;
		}
	public float getMonthDirectParIntercepted () {
		if (monthNbrDays > 0)   return  monthDirecParIntercepted/monthNbrDays;
		else return 0;
		}


	//TOTALS
	public float getTotalCapillaryRise () {return  totalCapillaryRise;}
	public float getTotalIrrigation () {return  totalIrrigation;}
	public float getTotalWaterDemand () {return  totalWaterDemand;}
	public float getTotalWaterDemandReduced() {return  totalWaterDemandReduced;}
	public float getTotalWaterUptake () {return  totalWaterUptake;}
	public float getTotalNitrogenDemand () {return  totalNitrogenDemand;}
	public float getTotalNitrogenUptake () {return  totalNitrogenUptake;}
	public float getTotalSoilEvaporation () {return  totalSoilEvaporation;}
	public float getTotalRunOff () {return  totalRunOff;}
	public float getTotalSurfaceRunOff () {return  totalSurfaceRunOff;}
	public float getTotalDrainageBottom () {return  totalDrainageBottom;}
	public float getTotalDrainageArtificial () {return  totalDrainageArtificial;}
	
	public float getTotalRain () {return  totalRain;}
	public float getTotalParIntercepted () {return  totalParIntercepted;}




	/****************************************************
	MANAGEMENT OF THE RESULTS OF LIGHT COMPETITION MODULE
	*****************************************************/

	// accesors for light budget
	public float getCaptureFactorForDiffusePar(){return captureFactorForDiffusePar;}
	public float getCaptureFactorForDirectPar(){return captureFactorForDirectPar;}
	public float getDirectParIntercepted(){return directParIntercepted;}
	public float getDiffuseParIntercepted(){return diffuseParIntercepted;}
	public float getTotalParInterceptedMJ(){return totalParInterceptedMJ;}
	public float getParIntCum(){return parIntCum;}
	public float getParIntCumByCropPhenoStage(){return parIntCumByCropPhenoStage;}
	public float getCompetitionIndexForTotalPar(){return competitionIndexForTotalPar;}
	public float getInterceptedPar(){return interceptedPar;}

	public void setCaptureFactorForDiffusePar(float e){captureFactorForDiffusePar=e;}
	public void setCaptureFactorForDirectPar(float e){captureFactorForDirectPar=e;}
	public void setDirectParIntercepted(float e){directParIntercepted=e;}
	public void setDiffuseParIntercepted(float e){diffuseParIntercepted=e;}
	public void setTotalParInterceptedMJ(float e){totalParInterceptedMJ=e;}
	public void setParIntCum(float e){parIntCum=e;}
	public void setParIntCumByCropPhenoStage(float e){parIntCumByCropPhenoStage=e;}
	public void setCompetitionIndexForTotalPar(float e){competitionIndexForTotalPar=e;}

	public void addDirect(float e) {this.captureFactorForDirectPar += e;}
	public void addDiffuse(float e){this.captureFactorForDiffusePar += e;}

	public double getParExtinctionCoef () {return (double) parExtinctionCoef;}
	public void setParExtinctionCoef (double v) {parExtinctionCoef = (float) v;}


	
	//MULCH
	public double getCarbonMulch() {return carbonMulch;}				
	public double getNitrogenMulch() {return nitrogenMulch;}				
	public double getCarbonMulchTreeFoliage() {return carbonMulchTreeFoliage;}	
	public double getMulchBiomass() {return mulchBiomass;}				
	public double getMulchEvaporation() {return mulchEvaporation;}				
	public double getMulchCoverRatio() {return mulchCoverRatio;}		
	

	
	public double getNitrogenGrain() {return nitrogenGrain;}
	public double getCarbonMicrobes() {return carbonMicrobes;}	
	public double getCarbonMicrobesMulch() {return carbonMicrobesMulch;}	
	public double getNitrogenMicrobes() {return nitrogenMicrobes;}	
	public double getNitrogenMicrobesMulch() {return nitrogenMicrobesMulch;}	
			
	public double getWaterUptakePotential () {
		if (fineRoots==null) return 0;
		return fineRoots.getWaterUptakePotential();
	}


	
}


