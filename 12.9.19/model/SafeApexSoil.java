package safeapex.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collection;

/**
 * Soil general description 
 *
 * @author Isabelle Lecomte - July 2002
 */
public class SafeApexSoil implements Serializable {

	//TODO MICHAEL BORUCKE=======================================================
	//PUT HERE SOIL APEX PARAMETERS
	//===========================================================================	

	private float SALB; 	//SOIL ALBEDO
	private float HSG;  	// HYDROLOGIC SOIL GROUP--1.=A; 2.=B; 3.=C; 4.=D
	private float FFC;  	//FRACTION OF FIELD CAP FOR INITAL WATER STORAGE(BLANK UNKNOWN)
	private float WTMN; 	//MIN DEPTH TO WATER TABLE(m)(BLANK IF UNKNOWN)
	private float WTMX; 	//MAX DEPTH TO WATER TABLE(m)(BLANK IF UNKNOWN)
	private float WTBL; 	//INITIAL WATER TABLE HEIGHT(m)(BLANK IF UNKNOWN)
	private float GWST; 	//GROUNDWATER STORAGE (mm)
	private float GWMX; 	//MAXIMUM GROUNDWATER STORAGE (mm)
	private float RFTT; 	//GROUNDWATER RESIDENCE TIME(d)(BLANK IF UNKNOWN)
	private float RFPK; 	//RETURN FLOW / (RETURN FLOW + DEEP PERCOLATION)
	private float TSLA; 	//MAXIMUM NUMBER OF SOIL LAYERS(3-30)
	private float XIDS; 	//0. FOR CALCAREOUS SOILS AND NON CALCAREOUS WITHOUT WEATHERING INFORMATION
							//1. FOR NON CACO3 SLIGHTLY WEATHERED
    						//2. NON CACO3 MODERATELY WEATHERED
    						//3. NON CACO3 HIGHLY WEATHERED
    						//4. INPUT PSP
    
	private float RTN1;		// NUMBER YEARS OF CULTIVATION AT START OF SIMULATION. BLANK DEFAULTS TO RTN0.                                                                              
	private float XIDK; 	// 1 FOR KAOLINITIC SOIL GROUP                                                                    
							// = 2 FOR MIXED SOIL GROUP                                                                         
							// = 3 FOR SMECTITIC SOIL GROUP                                                                     
	private float ZQT;  	// MINIMUM THICKNESS OF MAXIMUM LAYER(m)(SPLITTING STOPS WHEN ZQT IS REACHED)                                                                     
	private float ZF;  		// MINIMUM PROFILE THICKNESS(m)--STOPS SIMULATION.                                                
	private float ZTK;  	// MINIMUM LAYER THICKNESS FOR BEGINNING SIMULATION LAYER SPLITTING--
    						//MODEL SPLITS FIRST LAYER WITH THICKNESS GREATER THAN ZTK(m)
    						//IF NONE EXIST THE THICKEST LAYER IS SPLIT.                                        
	private float FBM;  	// FRACTION OF ORG C IN BIOMASS POOL(.03-.05)                                                     
	private float FHP;  	// FRACTION OF HUMUS IN PASSIVE POOL(.3-.7)                                                       

	
	//Layers
	private SafeApexLayer [] layers;		//layer for soil properties
	private int nbVoxels;					//number of soil voxels per cell (in case it is different of layer number)
	private double depth;					//total soil depth (m)
	private double volume;					//total soil volume (m3)

	//Water Table
	private boolean waterTable;			//is there a water table ?
	
	// NITROGEN REPARTITION PARAMETERS
	private double no3ConcentrationInWaterTable;				
	private double nh4ConcentrationInWaterTable;

	public SafeApexSoil (SafeApexInitialParameters settings, SafeApexPlotSettings plotSettings) {


		this.waterTable = plotSettings.waterTable;
		this.no3ConcentrationInWaterTable = plotSettings.no3ConcentrationInWaterTable;
		this.nh4ConcentrationInWaterTable = plotSettings.nh4ConcentrationInWaterTable;

		
		this.SALB = plotSettings.SALB; 	
		this.HSG = plotSettings.HSG;  	
		this.FFC = plotSettings.FFC;  	
		this.WTMN = plotSettings.WTMN; 	
		this.WTMX = plotSettings.WTMX; 	
		this.WTBL = plotSettings.WTBL; 
		this.GWST = plotSettings.GWST; 	
		this.GWMX = plotSettings.GWMX; 	
		this.RFTT = plotSettings.RFTT; 	
		this.RFPK = plotSettings.RFPK; 	
		this.TSLA = plotSettings.TSLA; 	
		this.XIDS = plotSettings.XIDS; 	
		this.RTN1 = plotSettings.RTN1;		                                                                              
		this.XIDK = plotSettings.XIDK; 	                                                                                                                         
		this.ZQT = plotSettings.ZQT;  	                                                                     
		this.ZF = plotSettings.ZF;  		                                             
		this.ZTK = plotSettings.ZTK;  	                           
		this.FBM = plotSettings.FBM;  	                                                  
		this.FHP = plotSettings.FHP;  	                                                   

		// layer of soil MAX and flexible number of voxels

		int tsa =  (int) (plotSettings.TSLA);
		layers = new SafeApexLayer[tsa];

	}


	public int getNbVoxels () {return nbVoxels;}
	public double getDepth () {return depth;}
	public boolean isWaterTable () {return waterTable;}
	public double getNo3ConcentrationInWaterTable () {return no3ConcentrationInWaterTable;}
	public double getNh4ConcentrationInWaterTable () {return nh4ConcentrationInWaterTable;}
	
	public SafeApexLayer getLayer  (int i) {return  layers[i];}
	public Collection getLayers  () {return  Arrays.asList(layers);}	//Just for testing

	public void putLayer (int i, SafeApexLayer layer) {layers[i] = layer;}
	public void setDepth (double v) {depth =  v;}
	public void setVolume (double v) {volume = v;}
	public double getVolume () {return volume;}

	public void setNbVoxels (int i) {nbVoxels = i;}


}