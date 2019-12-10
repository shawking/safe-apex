package safeapex.model;

import capsis.kernel.AbstractSettings;

/**
 * Plot parameters
 *
 * @author Isabelle Lecomte - July 2002 
 */

public class SafeApexPlotSettings extends AbstractSettings {

	// PLOT DEFINITION
	public String standInventory;	// name id the pld file
	public float cellWidth;			// m
	public float plotHeight;		// m 
	public float plotWidth;			// m
	public float cellSurface;  		// m2
	public int nbTrees = 0;
	
	// angle of slope bottom on the compass from the North, clockwise rotation
	// northern  : 0, eastern : 90, southern  : 180, western  : 270
	// public final double BOTTOM_AZIMUT = 270; //azimut of slope bottom from x
	// axis, trigonometric rotation (this value cannot be modified)
	// azimut of vector orthogonal to slope //GT 2007 slope
	public float slopeIntensity;
	public float slopeAspect;

	// angle of tree line on the compass from the North,  clcokwise rotation
	// northern : 0, eastern : 90, southern  : 180, western : 270
	//  vector of tree line is contrary to vector of y axis	
	public float northOrientation;
	public float treeLineOrientation;
	
	//APEX SUBAREA 
	public int IOW;		//OWNER ID 
	public int FI;		//FEEDING AREAS (OLD II) 
    public int IAPL;	//MANURE APPLICATION AREAS
    public int NVCN;	//CN-CN2 CODE
    public int IPTS;	//POINT SOURCE NUMBER
    public int ISAO;	//OUTFLOW RELEASE METHOD
    public int LUNS;	//LAND USE NUMBER FROM NRCS LAND USE-HYDROLOGIC SOIL GROUP
    public int IMW;		//MIN INTERVAL BETWEEN AUTO MOW
    
    //INITIAL CONDITIONS
    public float SNO;		//WATER CONTENT OF SNOW COVER(mm)
    public float STDO;		//STANDING DEAD CROP RESIDUE(t/ha)

    //CATCHMENT CHARACTERISTICS
    public float WSA;		//DRAINAGE AREA(ha)
    public float CHL;		//CHANNEL LENGTH(km)(BLANK IF UNKNOWN)
    public float CHD;		//CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
    public float CHS;		//CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
    public float CHN;		//MANNINGS N FOR CHANNEL(BLANK IF UNKNOWN)
    public float STP;		//AVE UPLAND SLOPE(m/m)
    public float SPLG;		//AVE UPLAND SLOPE LENGTH(m)
    public float UPN;		//MANNINGS N FOR UPLAND(BLANK IF UNKNOWN)
    public float FFPQ;		//FRACTION FLOODPLAIN FLOW--PARTITIONS FLOW THRU FILTER STRIPS
    public float URBF;		//URBAN FRACTION OF SUBAREA
    
    //CHANNEL GEOMETRY OF ROUTING REACH THRU SUBAREA
    public float RCHL;		//CHANNEL LENGTH OF ROUTING REACH(km)
    public float RCHD;		//CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
    public float RCBW;		//BOTTOM WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
    public float RCTW;		//TOP WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
    public float RCHS;		//CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
    public float RCHN;		//MANNINGS N VALUE OF CHANNEL(BLANK IF UNKNOWN)
    public float RCHC;		//USLE C FOR CHANNEL
    public float RCHK;		//USLE K FOR CHANNEL
    public float RFPW;		//FLOODPLAIN WIDTH(m)(BLANK IF UNKNOWN)
    public float RFPL;		//FLOODPLAIN LENGTH(km)(BLANK IF UNKNOWN)
    public float SAT1;		//SATURARTED CONDUCTIVITY(GREEN & AMPT) ADJUSTMENT FACTOR(.01_10.)
    public float FPS1;		//FLOODPLAIN SATURATED CONDUCTIVITY ADJUSTMENT FACTOR(.0001_10.)
    
    //RESERVOIR DATA
    public float RSEE;		//ELEV AT EMERGENCY SPILLWAY ELEV(m)
    public float RSAE;		//SURFACE AREA AT EMERGENCY SPILLWAY ELEV(ha)
    public float RVE0;		//VOLUME AT EMERGENCY SPILLWAY ELEV(mm)
    public float RSEP;		//ELEV AT PRINCIPAL SPILLWAY ELEV(m)
    public float RSAP;		//SURFACE AREA AT PRINCIPAL SPILLWAY ELEV(ha)
    public float RVP0;		//VOLUME AT PRINCIPAL SPILLWAY ELEV(mm)
    public float RSV;		//INITIAL VOLUME(mm)
    public float RSRR;		//TIME TO RELEASE FLOOD STORAGE(d)
    public float RSYS;		//INITIAL SEDIMENT CONCENTRATION(ppm)
    public float RSYN;		//NORMAL SEDIMENT CONC(ppm)
    public float RSHC;		//BOTTOM HYDRAULIC CONDUCTIVITY(mm/h)
    public float RSDP;		//TIME REQUIRED TO RETURN TO NORMAL SED CONC AFTER RUNOFF EVENT(d)
    public float RSBD;		//BULK DENSITY OF SEDIMENT IN RESERVOIR(t/m^3)
    public float PCOF;		//FRACTION OF SUBAREA CONTROLLED BY PONDS
    public float BCOF;		//FRACTION OF SUBAREA CONTROLLED BY BUFFERS
    public float BFFL;		//BUFFER FLOW LENGTH (m)
    
    
    
    //MANAGEMENT INFORMATION                                                                           
    public int IRR;			//0 FOR DRYLAND AREAS                                               
						    //1 FROM SPRINKLER IRRIGATION                                     
						    //2 FOR FURROW IRRIGATION                                           
						    //3 FOR IRR WITH FERT ADDED                                                           
						    //4 FOR IRRIGATION FROM LAGOON                                                                 
						    //5 FOR DRIP IRR                                                                               
    public int IRI;			//N DAY APPLICATION INTERVAL FOR AUTOMATIC IRRIGATION                                            
    public int IFA;			//MIN FERT APPL INTERVAL(BLANK FOR USER SPECIFIED)                                               
    public int LM;			//0 APPLIES LIME                                                                                 
    						//1 DOES NOT APPLY LIME                                                                          
    public int IFD;			//0 WITHOUT FURROW DIKES                                                                         
    						//1 WITH FURROW DIKES                                                                            
    public int IDR;			//0 NO DRAINAGE                                                                                  
    						//DEPTH OF DRAINAGE SYSTEM(mm)                                                                   
    public int IDF0;		//FERT #                                                                                         
							//1 FOR FERTIGATION FROM LAGOON                                                                  
    						//2 FOR AUTOMATIC SOLID MANURE APPL FROM FEEDING AREA STOCK PILE.                                                                                        
    						//3 AUTO COMERCIAL P FERT APPL (DEFAULTS TO ELEM P)                                              
    						//4 FOR AUTOMATIC COMERCIAL FERT APPL(DEFALTS TO ELEM N)                                         
    						//5 FOR AUTOMATIC SOLID MANURE APPLICATION.                                                      
    						//6 AUTO COMERCIAL K FERT APPL (DEFAULTS TO ELEM K)                                              
    public int IRRS;		//ID OF SA SUPPLYING IRRIGATION WATER FROM A RESERVOIR                                           
							//0 NO RESERVOIR SUPPLY OR NO IRRIGATION       

    
    
    public float BIR;		//IRRIGATION TRIGGER--3 OPTIONS                                                                  
    						//1. PLANT WATER STRESS FACTOR (0-1)                                                             
    						//2. SOIL WATER TENSION IN TOP 200 MM(> 1 KPA)                                                   
    						//3. PLANT AVAILABLE WATER DEFICIT IN ROOT ZONE (-mm)                                            
    public float EFI;		//RUNOFF VOL / VOL IRR WATER APPLIED(BLANK IF IRR=0)                                             
    public float VIMX;		//MAXIMUM ANNUAL IRRIGATION VOLUME ALLOWED FOR EACH CROP (mm)                                    
    public float ARMN;		//MINIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)                                                 
    public float ARMX;		//MAXIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)                                                 
    public float BFT;		//AUTO FERTILIZER TRIGGER--2 OPTIONS                                                             
    						//1. PLANT N STRESS FACTOR (0-1)                                                                 
    						//2. SOIL N CONC IN ROOT ZONE (g/t)                                                              
    public float FNP4;		//AUTO FERT FIXED APPLICATION RATE (kg/ha)                                                       
    public float FMX;		//MAXIMUM ANNUAL N FERTILIZER APPLICATION FOR A CROP (kg/ha)                                     
    public float DRT;		//TIME REQUIRED FOR DRAINAGE SYSTEM TO REDUCE PLANT STRESS(d)                                    
    						//(BLANK IF DRAINAGE NOT USED)                                                                   
    public float FDSF;		//FURROW DIKE SAFETY FACTOR(0-1.)                                                                
    public float PEC;		//CONSERVATION PRACTICE FACTOR(=0.0 ELIMINATES WATER EROSION)                                    
    public float DALG;		//FRACTION OF SUBAREA CONTROLLED BY LAGOON.                                                      
    public float VLGN;		//LAGOON VOLUME RATIO--NORMAL / MAXIMUM                                                          
    public float COWW;		//LAGOON INPUT FROM WASH WATER (m3/hd/d)                                                         
    public float DDLG;		//TIME TO REDUCE LAGOON STORAGE FROM MAX TO NORM (d)                                             
    public float SOLQ;		//RATIO LIQUID/TOTAL MANURE PRODUCED.                                                            
    public float SFLG;		//SAFETY FACTOR FOR LAGOON DESIGN (VLG=VLG0/(1.-SFLG)                                            
    public float FNP2;		//FEEDING AREA STOCK PILE AUTO SOLID MANURE APPL RATE (kg/ha)                                    
    public float FNP5;		//AUTOMATIC MANURE APPLICATION RATE (kg/ha)                                                      
    public float FIRG;		//FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)    
    
    public float NY;		//HERD NUMBERS FOR GRAZING AREA
    public float XTP;		//GRAZING LIMIT FOR EACH HERD--MINIMUM PLANT MATERIAL(t/ha) 
  
    
	//APEX SITE DEFINITION
	public float YLAT;		//LATITUDE(deg)
	public float XLOG;		//LONGITUDE(deg)
	public float ELEV;		//ELEVATION OF WATERSHED (m)
	public float APM;		//PEAK RATE - EI ADJUSTMENT FACTOR (BLANK IF UNKNOWN)
	public float CO2X ;		//CO2 CONCENTRATION IN ATMOSPHERE (ppm)--NON ZERO VALUE
    public float CQNX;		//CONC OF NO3 IN IRRIGATION WATER (ppm)--NON ZERO VALUE
    public float RFNX;		//AVE CONC OF N IN RAINFALL (ppm)
    public float UPR;		//MANURE APPL RATE TO SUPPLY P UPTAKE RATE (kg/ha/y)
    public float UNR;		//MANURE APPL RATE TO SUPPLY N UPTAKE RATE (kg/ha/y)
    public float FIR0;		//FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)
    public float BCHL;		//SWAT BASIN CHANNEL LENGTH(km) 
    public float BCHS;		//SWAT BASIN CHANNEL SLOPE(m/m)

	// APEX SOIL DEFINITION
	public float SALB; 		//SOIL ALBEDO
	public float HSG;  		//HYDROLOGIC SOIL GROUP 1=A 2=B 3=C 4=D
	public float FFC;  		//FRACTION OF FIELD CAP FOR INITAL WATER STORAGE(BLANK UNKNOWN)
	public float WTMN; 		//MIN DEPTH TO WATER TABLE(m)(BLANK IF UNKNOWN)
	public float WTMX; 		//MAX DEPTH TO WATER TABLE(m)(BLANK IF UNKNOWN)
	public float WTBL; 		//INITIAL WATER TABLE HEIGHT(m)(BLANK IF UNKNOWN)
	public float GWST; 		//GROUNDWATER STORAGE (mm)
	public float GWMX; 		//MAXIMUM GROUNDWATER STORAGE (mm)
	public float RFTT; 		//GROUNDWATER RESIDENCE TIME(d)(BLANK IF UNKNOWN)
	public float RFPK; 		//RETURN FLOW / (RETURN FLOW + DEEP PERCOLATION)
	public float TSLA; 		//MAXIMUM NUMBER OF SOIL LAYERS(3-30)
	public float XIDS; 		//0 FOR CALCAREOUS SOILS AND NON CALCAREOUS WITHOUT WEATHERING INFORMATION
							//1 FOR NON CACO3 SLIGHTLY WEATHERED
    						//2 NON CACO3 MODERATELY WEATHERED
    						//3 NON CACO3 HIGHLY WEATHERED
    						//4 INPUT PSP
    
	public float RTN1;		//NUMBER YEARS OF CULTIVATION AT START OF SIMULATION. BLANK DEFAULTS TO RTN0.                                                                              
	public float XIDK; 		//1 FOR KAOLINITIC SOIL GROUP                                                                    
							//2 FOR MIXED SOIL GROUP                                                                         
							//3 FOR SMECTITIC SOIL GROUP                                                                     
	public float ZQT;  		//MINIMUM THICKNESS OF MAXIMUM LAYER(m)(SPLITTING STOPS WHEN ZQT IS REACHED)                                                                     
	public float ZF;  		//MINIMUM PROFILE THICKNESS(m)--STOPS SIMULATION.                                                
	public float ZTK;  		//MINIMUM LAYER THICKNESS FOR BEGINNING SIMULATION LAYER SPLITTING--
    						//MODEL SPLITS FIRST LAYER WITH THICKNESS GREATER THAN ZTK(m)
    						//IF NONE EXIST THE THICKEST LAYER IS SPLIT.                                        
	public float FBM;  		//FRACTION OF ORG C IN BIOMASS POOL(.03-.05)                                                     
	public float FHP;  		//FRACTION OF HUMUS IN PASSIVE POOL(.3-.7)                                                        
	
	// LAYERS DEFINITION
	public float[] Z;		//DEPTH TO BOTTOM OF LAYERS(m)                                                                   
	public float[] BD;		//BULK DENSITY(t/m3)                                                                             
	public float[] UW;		//SOIL WATER CONTENT AT WILTING POINT(1500 KPA)(m/m)                                                                                                                         
    public float[] FC;		//WATER CONTENT AT FIELD CAPACITY(33KPA)(m/m)                                                                                                                               
    public float[] SAN;		//% SAND                                                                                         
    public float[] SIL;		//% SILT                                                                                         
    public float[] WON;		//INITIAL ORGANIC N CONC(g/t)       (BLANK IF UNKNOWN)                                           
    public float[] PH;		//SOIL PH                                                                                        
    public float[] SMB;		//SUM OF BASES(cmol/kg)              (BLANK IF UNKNOWN)                                          
    public float[] WOC;		//ORGANIC CARBON CONC(%)                                                                         
    public float[] CAC;		//CALCIUM CARBONATE(%)                                                                           
    public float[] CEC;		//ATION EXCHANGE CAPACITY(cmol/kg)(BLANK IF UNKNOWN)                                            
    public float[] ROK;		//COARSE FRAGMENTS(% VOL)              (BLANK IF UNKNOWN)                                        
    public float[] CNDS;	//INITIAL SOL N CONC(g/t)            (BLANK IF UNKNOWN)                                          
    public float[] SSF;		//INITIAL SOL P CONC(g/t)       (BLANK IF UNKNOWN)                                               
    public float[] RSD;		//CROP RESIDUE(t/ha)                (BLANK IF UNKNOWN)                                           
    public float[] BDD;		//BULK DENSITY(OVEN DRY)(t/m3)   (BLANK IF UNKNOWN)                                              
    public float[] PSP;		//P SORPTION RATIO                   (BLANK IF UNKNOWN)                                          
    public float[] SATC;	//SATURATED CONDUCTIVITY(mm/h)     (BLANK IF UNKNOWN)                                            
    public float[] HCL;		//LATERAL HYDRAULIC CONDUCTIVITY(mm/h)                                                           
    public float[] WPO;		//INITIAL ORGANIC P CONC(g/t)      (BLANK IF UNKNOWN)                                            
    public float[] DHN;		//EXCHANGEABLE K CONC (g/t)                                                                      
    public float[] ECND;	//ELECTRICAL COND (mmho/cm)                                                                      
    public float[] STFR;	//FRACTION OF STORAGE INTERACTING WITH NO3 LEACHING                                                                                   
    public float[] SWST;	//INITIAL SOIL WATER STORAGE (m/m)                                                               
    public float[] CPRV;	//FRACTION INFLOW PARTITIONED TO VERTICLE CRACK OR PIPE FLOW                                     
    public float[] CPRH;	//FRACTION INFLOW PARTITIONED TO HORIZONTAL CRACK OR PIPE FLOW                                                                                           
    public float[] WLS;		//STRUCTURAL LITTER(kg/ha)           (BLANK IF UNKNOWN)                                          
    public float[] WLM;		//METABOLIC LITTER(kg/ha)            (BLANK IF UNKNOWN)                                          
    public float[] WLSL;	//LIGNIN CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)                                              
    public float[] WLSC;	//CARBON CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)                                              
    public float[] WLMC;	//C CONTENT OF METABOLIC LITTER(kg/ha)(B I U)                                                    
    public float[] WLSLC;	//C CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(B I U)                                         
    public float[] WLSLNC;	//N CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(BIU)                                           
    public float[] WBMC;	//C CONTENT OF BIOMASS(kg/ha)(BIU)                                                               
    public float[] WHSC;	//C CONTENT OF SLOW HUMUS(kg/ha)(BIU)                                                            
    public float[] WHPC;	//C CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)                                                         
    public float[] WLSN;	//N CONTENT OF STRUCTURAL LITTER(kg/ha)(BIU)                                                     
    public float[] WLMN;	//N CONTENT OF METABOLIC LITTER(kg/ha)(BIU)                                                      
    public float[] WBMN;	//N CONTENT OF BIOMASS(kg/ha)(BIU)                                                               
    public float[] WHSN;	//N CONTENT OF SLOW HUMUS(kg/ha)(BIU)                                                            
    public float[] WHPN;	//N CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)                                                         
    public float[] FE26;	//IRON CONTENT(%)                                                                                
    public float[] SULF;	//SULFUR CONTENT(%)                                                                              
    public String[] ASHZ;	//SOIL HORIZON(A,B,C)                                                                            
    public float[] CGO2;	//O2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)                                                        
    public float[] CGCO2;	//CO2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)                                                       
    public float[] CGN2O;	//N2O CONC IN GAS PHASE (g/m3 OF SOIL AIR) 

	public float[] stone;				//%
	public int[] stoneType;			//0-9
	

	// VOXELS DEFINITION
	public float voxelThicknessMax;	// m

	// WATER TABLE
	public boolean waterTable = false;

	// NITROGEN REPARTITION PARAMETERS
	public float no3ConcentrationInWaterTable;				
	public float nh4ConcentrationInWaterTable;

}
