package safeapex.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;


/**
 * Pedologic layers description
 *
 * @author Isabelle Lecomte - July 2002
 */
public class SafeApexLayer implements Serializable {

	private int id;
	private int topSoil;				// 1=topsoil 0=subsoil

	private double depth;  				// m
	private double thickness;  			// m
	private double sand;				// %
	private double silt;				// %
	private double clay;				// %
	private double organicMatter;		// %
	private double medianPartSizeSand;	// %

	private int    stoneType; 			// 0-10
	private double stone; 				// %
	private double thetaSat;			// m3 m-3
	
	//Pedotransfert properties (total voxel fine soil and stone)
	private double bulkDensity;			//kg m-3
	private double fieldCapacity;		//m3 m-3
	private double wiltingPoint;		//m3 m-3
	

	//Fine soil pedotransfert properties (fine soil only)
	private double bulkDensityFineSoil;			//kg m-3
	private double fieldCapacityFineSoil;		//m3 m-3
	private double wiltingPointFineSoil;		//m3 m-3

	//Fine soil pedotransfert properties (stones)
	private double fieldCapacityStone;		//m3 m-3
	private double wiltingPointStone;		//m3 m-3
	
	
	//other pedotransfert properties
	private double kSat;
	private double alpha;
	private double lambda;
	private double n;
	
	
	
	//FROM APEX
	/*
	private double Z;		//DEPTH TO BOTTOM OF LAYERS(m)                                                                   
	private double BD;		//BULK DENSITY(t/m3)                                                                             
	private double UW;		//SOIL WATER CONTENT AT WILTING POINT(1500 KPA)(m/m)                                                                                                                         
    private double FC;		//WATER CONTENT AT FIELD CAPACITY(33KPA)(m/m)                                                                                                                               
    private double SAN;		//% SAND                                                                                         
    private double SIL;		//% SILT                                                                                         
    private double WN;		//INITIAL ORGANIC N CONC(g/t)       (BLANK IF UNKNOWN)                                           
    private double PH;		//SOIL PH                                                                                        
    private double SMB;		//SUM OF BASES(cmol/kg)              (BLANK IF UNKNOWN)                                          
    private double WOC;		//ORGANIC CARBON CONC(%)                                                                         
    private double CAC;		//CALCIUM CARBONATE(%)                                                                           
    private double CEC;		//ATION EXCHANGE CAPACITY(cmol/kg)(BLANK IF UNKNOWN)                                            
    private double ROK;		//COARSE FRAGMENTS(% VOL)              (BLANK IF UNKNOWN)                                        
    private double CNDS;	//INITIAL SOL N CONC(g/t)            (BLANK IF UNKNOWN)                                          
    private double SSF;		//INITIAL SOL P CONC(g/t)       (BLANK IF UNKNOWN)                                               
    private double RSD;		//CROP RESIDUE(t/ha)                (BLANK IF UNKNOWN)                                           
    private double BDD;		//BULK DENSITY(OVEN DRY)(t/m3)   (BLANK IF UNKNOWN)                                              
    private double PSP;		//P SORPTION RATIO                   (BLANK IF UNKNOWN)                                          
    private double SATC;	//SATURATED CONDUCTIVITY(mm/h)     (BLANK IF UNKNOWN)                                            
    private double HCL;		//LATERAL HYDRAULIC CONDUCTIVITY(mm/h)                                                           
    private double WPO;		//INITIAL ORGANIC P CONC(g/t)      (BLANK IF UNKNOWN)                                            
    private double DHN;		//EXCHANGEABLE K CONC (g/t)                                                                      
    private double ECND;	//ELECTRICAL COND (mmho/cm)                                                                      
    private double STFR;	//FRACTION OF STORAGE INTERACTING WITH NO3 LEACHING                                                                                   
    private double SWST;	//INITIAL SOIL WATER STORAGE (m/m)                                                               
    private double CPRV;	//FRACTION INFLOW PARTITIONED TO VERTICLE CRACK OR PIPE FLOW                                     
    private double CPRH;	//FRACTION INFLOW PARTITIONED TO HORIZONTAL CRACK OR PIPE FLOW                                                                                           
    private double WLS;		//STRUCTURAL LITTER(kg/ha)           (BLANK IF UNKNOWN)                                          
    private double WLM;		//METABOLIC LITTER(kg/ha)            (BLANK IF UNKNOWN)                                          
    private double WLSL;	//LIGNIN CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)                                              
    private double WLSC;	//CARBON CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)                                              
    private double WLMC;	//C CONTENT OF METABOLIC LITTER(kg/ha)(B I U)                                                    
    private double WLSLC;	//C CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(B I U)                                         
    private double WLSLNC;	//N CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(BIU)                                           
    private double WBMC;	//C CONTENT OF BIOMASS(kg/ha)(BIU)                                                               
    private double WHSC;	//C CONTENT OF SLOW HUMUS(kg/ha)(BIU)                                                            
    private double WHPC;	//C CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)                                                         
    private double WLSN;	//N CONTENT OF STRUCTURAL LITTER(kg/ha)(BIU)                                                     
    private double WLMN;	//N CONTENT OF METABOLIC LITTER(kg/ha)(BIU)                                                      
    private double WBMN;	//N CONTENT OF BIOMASS(kg/ha)(BIU)                                                               
    private double WHSN;	//N CONTENT OF SLOW HUMUS(kg/ha)(BIU)                                                            
    private double WHPN;	//N CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)                                                         
    private double FE26;	//IRON CONTENT(%)                                                                                
    private double SULF;	//SULFUR CONTENT(%)                                                                              
    private String ASHZ;	//SOIL HORIZON(A,B,C)                                                                            
    private double CGO2;	//O2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)                                                        
    private double CGCO2;	//CO2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)                                                       
    private double CGN2O;	//N2O CONC IN GAS PHASE (g/m3 OF SOIL AIR) 
    */
	//List of voxels for this layer
	private ArrayList voxelList;
	
	public SafeApexLayer (int id) {
		this.id = id;
	}
	
	public SafeApexLayer (int id, double layerThickness,
						 SafeApexInitialParameters safeSettings,
						 SafeApexPlotSettings plotSettings) {

		this.id = id;
		this.thickness = layerThickness;
		this.depth=plotSettings.Z[id-1];
		this.bulkDensity=plotSettings.BD[id-1];		//TODO verifier unité 
		this.sand=plotSettings.SAN[id-1];
		this.silt=plotSettings.SIL[id-1];
		this.organicMatter=plotSettings.WOC[id-1]*2;
		
		/*
		this.UW=plotSettings.UW[id-1];
		this.FC=plotSettings.FC[id-1];

		this.WN=plotSettings.WN[id-1];
		this.PH=plotSettings.PH[id-1];
		this.SMB=plotSettings.SMB[id-1];
		this.WOC=plotSettings.WOC[id-1];
		this.CAC=plotSettings.CAC[id-1];
		this.CEC=plotSettings.CEC[id-1];
		this.ROK=plotSettings.ROK[id-1];
		this.CNDS=plotSettings.CNDS[id-1];
		this.SSF=plotSettings.SSF[id-1];
		this.RSD=plotSettings.RSD[id-1];
		this.BDD=plotSettings.BDD[id-1];
		this.PSP=plotSettings.PSP[id-1];
		this.SATC=plotSettings.SATC[id-1];
		this.HCL=plotSettings.HCL[id-1];
		this.WPO=plotSettings.WPO[id-1];
		this.DHN=plotSettings.DHN[id-1];
		this.ECND=plotSettings.ECND[id-1];
		this.STFR=plotSettings.STFR[id-1];
		this.SWST=plotSettings.SWST[id-1];
		this.CPRV=plotSettings.CPRV[id-1];
		this.CPRH=plotSettings.CPRH[id-1];
		this.WLS=plotSettings.WLS[id-1];
		this.WLM=plotSettings.WLM[id-1];
		this.WLSL=plotSettings.WLSL[id-1];
		this.WLSC=plotSettings.WLSC[id-1];
		this.WLMC=plotSettings.WLMC[id-1];
		this.WLSLC=plotSettings.WLSLC[id-1];
		this.WLSLNC=plotSettings.WLSLNC[id-1];
		this.WBMC=plotSettings.WBMC[id-1];
		this.WHSC=plotSettings.WHSC[id-1];
		this.WHPC=plotSettings.WHPC[id-1];
		this.WLSN=plotSettings.WLSN[id-1];
		this.WLMN=plotSettings.WLMN[id-1];
		this.WBMN=plotSettings.WBMN[id-1];
		this.WHSN=plotSettings.WHSN[id-1];
		this.WHPN=plotSettings.WHPN[id-1];
		this.FE26=plotSettings.FE26[id-1];
		this.SULF=plotSettings.SULF[id-1];
		this.ASHZ=plotSettings.ASHZ[id-1];
		this.CGO2=plotSettings.CGO2[id-1];
		this.CGCO2=plotSettings.CGCO2[id-1];
		this.CGN2O=plotSettings.CGN2O[id-1];
*/

		//TOPSOIL TYPES
		this.topSoil = 0;
		if (id == 0) this.topSoil = 1;

		//Initialisation of soil pedoTransfert PROPERTIES (without stones)
		this.bulkDensityFineSoil = 	SafeApexPedotransferUtil.getBulkDensity (
							medianPartSizeSand,
							clay,
							silt,
							organicMatter,
							topSoil);
		this.thetaSat =	SafeApexPedotransferUtil.getThetaSat (
							clay,
							bulkDensityFineSoil,
							silt,
							organicMatter,
							topSoil);
		this.kSat =	SafeApexPedotransferUtil.getKSat (
							clay,
							bulkDensityFineSoil,
							silt,
							organicMatter,
							topSoil);
		this.alpha = SafeApexPedotransferUtil.getAlpha (
							clay,
							bulkDensityFineSoil,
							silt,
							organicMatter,
							topSoil);
		this.lambda = SafeApexPedotransferUtil.getLambda (
							clay,
							bulkDensityFineSoil,
							silt,
							organicMatter);
		this.n = SafeApexPedotransferUtil.getN (
							clay,
							bulkDensityFineSoil,
							silt,
							organicMatter,
							topSoil);

		//field capacity
		double p = SafeApexPedotransferUtil.getP (safeSettings.PF_FIELD_CAPACITY);
		this.fieldCapacityFineSoil = SafeApexPedotransferUtil.getTheta (p, thetaSat, alpha, n);

		//wilting point
		p = SafeApexPedotransferUtil.getP (safeSettings.PF_WILTING_POINT);
		this.wiltingPointFineSoil = SafeApexPedotransferUtil.getTheta (p, thetaSat, alpha, n);


		//If stone, calculation of fine soil properties
		// it was decided to let other variables : ksat, alpha, lambda and n unchanged 
		// This code have been copied and removed from STICS InitialGeneral (Initial.c line 165 to 175) 
		this.stoneType  =  stoneType;
		
		if (stoneType > 0) {

			this.stone   	= stone;
			
			this.fieldCapacityStone = safeSettings.STONE_VOLUMIC_DENSITY [this.stoneType-1] * safeSettings.STONE_WATER_CONTENT [this.stoneType-1];    // % 
			
			this.wiltingPointStone =  this.fieldCapacityStone * this.wiltingPointFineSoil / this.fieldCapacityFineSoil;

			
			this.bulkDensity  = (safeSettings.STONE_VOLUMIC_DENSITY [this.stoneType-1] * this.stone 
								+ (100 - this.stone) * this.bulkDensityFineSoil) 
								/ 100;
 	
			this.fieldCapacity = (this.fieldCapacityStone * this.stone
								+ (100 - this.stone) * this.fieldCapacityFineSoil)
								/ 100;
			
			this.wiltingPoint = (this.wiltingPointStone * this.stone
								+ (100 - this.stone) * this.wiltingPointFineSoil)
								 / 100;
			
													
			//to avoid STICS stop error
			if ((this.wiltingPoint/this.bulkDensity) < 0.01)
						this.wiltingPoint = 0.01 * this.bulkDensity;

		}
		else
		{
			this.stone   			= 0;
			this.bulkDensity 		= this.bulkDensityFineSoil;
			this.wiltingPoint 		= this.wiltingPointFineSoil;
			this.fieldCapacity 		= this.fieldCapacityFineSoil;
			this.wiltingPointStone 	= 0;
			this.fieldCapacityStone = 0;			
		}

	}

	public int 	  getId () {return id;}
	public int 	  getStoneType () {return stoneType;}
	public double getDepth () {return depth;}
	public double getThickness () {return thickness;}
	public double getSand () {return sand;}
	public double getSilt() {return silt;}
	public double getClay () {return clay;}
	public double getOrganicMatter () {return organicMatter;}
	public double getMedianPartSizeSand () {return medianPartSizeSand;}
	
	
	
	public double getStone () {return stone;}
	public double getResidualHumidity() {return silt/100/15;}
	public double getKSat () {return kSat;}
	public double getAlpha () {return alpha;}
	public double getLambda () {return lambda;}
	public double getN () {return n;}
	
	//voxel values (fine soil + stone) 
	public double getBulkDensity () {return bulkDensity;}
	public double getFieldCapacity() {return fieldCapacity;}
	public double getWiltingPoint() {return wiltingPoint;}
	public double getThetaSat () {return thetaSat;}
	
	
	//voxel values (fine soil only) 
	public double getBulkDensityFineSoil () {return bulkDensityFineSoil;}
	public double getFieldCapacityFineSoil() {return fieldCapacityFineSoil;}
	public double getWiltingPointFineSoil() {return wiltingPointFineSoil;}

	//voxel values (stone only) 
	public double getFieldCapacityStone() {return fieldCapacityStone;}
	public double getWiltingPointStone() {return wiltingPointStone;}
	
	
	// gt - 12.11.2009 - added this method used in SafeApexVoxel.countWaterUptakePotential
	public double getTheta(double p){			
		return(SafeApexPedotransferUtil.getTheta(p,this.getThetaSat(),this.getAlpha(),this.getN()));		
	}
	
	public void razVoxel() {
		this.voxelList = new ArrayList ();
	}
	public void addVoxel (SafeApexVoxel v) {
		if (this.voxelList == null)
			this.voxelList = new ArrayList ();
		voxelList.add(v);
	}

	public int getNbVoxels () {
		return voxelList.size();
	}
	public double getLayerVolume () {
		return this.thickness * getNbVoxels ();
	}
	

	
	//for export
	public int getIdLayer() {return getId();}
}
