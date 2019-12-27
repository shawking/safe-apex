package safeapex.model;

import java.io.Serializable;
import com.sun.jna.Library;
import com.sun.jna.Native;
import safeapex.apex.*;



/**
 * SafeApexJNA is the class for calling native functions in APEX via JNA 
 * 
 * Available native functions are : 
 * =================================
 * simulationStart : general parameters initialization 
 * simulationEnd : end simulation with output
 * yearLoopStart : annual loop start process
 * yearLoopEnd : annual loop end process
 * addTreeLitters : add carbon litters from tree
 * dayLoopStart : daily loop start process
 * dayLoopEnd : daily loop end process
 * 
 * @author Isabelle Lecomte - October 2018
 */


public class SafeApexJNA implements  Serializable {

	public interface JNA extends Library {

		// Loads the ApexV15.so library (libApexV15.so under Linux, ApexV15.dll under Windows, libApexV15.dylib under MacOS).
		JNA INSTANCE_APEX = (JNA) Native.loadLibrary("ApexV15", JNA.class);

		void simulationStart (SafeApexApexCommun c, 
				int lg, String dir, 	//name of folder file
				int lg2, String wfile,  //name of windfile
				int lg3, String hfile,  //name of herd file
				int lg4, String rFile,	//name of rain storm file
				int lg5, String sFile,	//name of station file
				int lg6, String tFile,	//name of daily weather file
				int lg7, String oFile);	//name of opc file

		void simulationEnd (SafeApexApexCommun c);
		
		void yearLoopStart (SafeApexApexCommun c);
		void yearLoopEnd (SafeApexApexCommun c);
		void dayLoopStart (SafeApexApexCommun c);
		void dayLoopEnd (SafeApexApexCommun c);
		void addTreeLitters (SafeApexApexCommun c);
	}


	/**
	 * initSimulation : apex parameters initialization 
	 */
	 
    public static void simulationStart (SafeApexCrop crop,
    		                           SafeApexEvolutionParameters ep, 
    								   SafeApexPlotSettings soil, 
    								   String dir) { 

    	SafeApexApexCommun c = crop.getApexCrop();
    	
        //Simulation parameters
		c.HI_NBYR = ep.nbSimulations;
		c.HI_IYR0 = ep.simulationYearStart;
		c.HI_IMO = ep.simulationMonthStart;
		c.HI_IDA = ep.simulationDayStart;
		
		c.HI_IPD=ep.IPD;
		c.HI_NGN0=ep.NGN0;
		c.HI_IGN=ep.IGN;
		c.HI_IGSD=ep.IGSD;
		c.HI_LPYR=ep.LPYR;
		c.HI_IET=ep.IET;
		c.HI_ISCN=ep.ISCN;
		c.HI_ITYP=ep.ITYP;
		c.HI_ISTA=ep.ISTA;
		c.HI_IHUS=ep.IHUS;
		c.HI_NVCN0=ep.NVCN0;
		c.HI_INFL0=ep.INFL0;
		c.HI_MASP=ep.MASP;
		c.HI_IERT=ep.IERT;
		c.HI_LBP=ep.LBP;
		c.HI_NUPC=ep.NUPC;
		c.HI_MNUL=ep.MNUL;
		c.HI_LPD=ep.LPD;
		c.HI_MSCP=ep.MSCP;
		c.HI_ISLF=ep.ISLF;
		c.HI_NAQ=ep.NAQ;
		c.HI_IHY=ep.IHY;
		c.HI_ICO2=ep.ICO2;
		c.HI_ISW=ep.ISW;
		c.HI_IGMX=ep.IGMX;
		c.HI_IDIR=ep.IDIR;
		c.HI_IMW0=ep.IMW0;
		c.HI_IOX=ep.IOX;
		c.HI_IDNT=ep.IDNT;
		c.HI_IAZM=ep.IAZM;
		c.HI_IPAT=ep.IPAT;
		c.HI_IHRD=ep.IHRD;
		c.HI_IWTB=ep.IWTB;
		c.HI_IKAT=ep.IKAT;
		c.HI_NSTP=ep.NSTP;
		c.HI_IPRK=ep.IPRK;
		c.HI_ICP=ep.ICP;
		c.HI_NTV=ep.NTV;
		c.HI_ISAP=ep.ISAP;
	
		c.HI_RFN0=ep.RFN0;
		c.HI_CO20=ep.CO20;
		c.HI_CQN0=ep.CQN0;
		c.HI_PSTX=ep.PSTX;
		c.HI_YWI=ep.YWI;
		c.HI_BTA=ep.BTA;
		c.HI_EXPK=ep.EXPK;
		c.HI_QG=ep.QG;
		c.HI_QCF=ep.QCF;
		c.HI_CHS0=ep.CHS0;

		c.HI_BWD=ep.BWD;
		c.HI_FCW=ep.FCW;
		c.HI_FPS0=ep.FPS0;
		c.HI_GWS0=ep.GWS0;
		c.HI_RFT0=ep.RFT0;
		c.HI_RFP0=ep.RFP0;
		c.HI_SAT0=ep.SAT0;
		c.HI_FL0=ep.FL0;
		c.HI_FW0=ep.FW0;
		c.HI_ANG0=ep.ANG0;

		c.HI_UXP=ep.UXP;
		c.HI_DIAM=ep.DIAM;
		c.HI_ACW=ep.ACW;
		c.HI_GZL0=ep.GZL0;
		c.HI_RTN0=ep.RTN0;
		c.HI_BXCT=ep.BXCT;
		c.HI_BYCT=ep.BYCT;
		c.HI_DTHY=ep.DTHY;
		c.HI_QTH=ep.QTH;
		c.HI_STND=ep.STND;
	
		c.HI_DRV=ep.DRV;
		c.HI_PCO0=ep.PCO0;
		c.HI_RCC0=ep.RCC0;
		c.HI_CSLT=ep.CSLT;
		c.HI_CPV0=ep.CPV0;
		c.HI_CPH0=ep.CPH0;
		c.HI_DZDN=ep.DZDN;
		c.HI_DTG=ep.DTG;

		//soil parameters
    	c.HI_IOW 	 = soil.IOW;		//OWNER ID 
    	c.HI_FI 	 = soil.FI;			//FEEDING AREAS (OLD II) 
        c.HI_IAPL[0] = soil.IAPL;		//MANURE APPLICATION AREAS
        c.HI_NVCN[0] = soil.NVCN;		//CN-CN2 CODE
        c.HI_IPTS[0] = soil.IPTS;		//POINT SOURCE NUMBER
        c.HI_ISAO[0] = soil.ISAO;		//OUTFLOW RELEASE METHOD
        c.HI_LUNS[0] = soil.LUNS;		//LAND USE NUMBER FROM NRCS LAND USE-HYDROLOGIC SOIL GROUP
        c.HI_IMW[0]  = soil.IMW;		//MIN INTERVAL BETWEEN AUTO MOW
        
        //INITIAL CONDITIONS
        c.HI_SNO[0]  = soil.SNO;		//WATER CONTENT OF SNOW COVER(mm)
        c.HI_STDO[0] = soil.STDO;		//STANDING DEAD CROP RESIDUE(t/ha)

        //CATCHMENT CHARACTERISTICS
        c.HI_WSA[0]  = soil.WSA;		//DRAINAGE AREA(ha)
        c.HI_CHL[0]  = soil.CHL;		//CHANNEL LENGTH(km)(BLANK IF UNKNOWN)
        c.HI_CHD 	 = soil.CHD;		//CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
        c.HI_CHS[0]  = soil.CHS;		//CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
        c.HI_CHN[0]  = soil.CHN;		//MANNINGS N FOR CHANNEL(BLANK IF UNKNOWN)
        c.HI_STP[0]  = soil.STP;		//AVE UPLAND SLOPE(m/m)
        c.HI_SPLG[0] = soil.SPLG;		//AVE UPLAND SLOPE LENGTH(m)
        c.HI_UPN 	 = soil.UPN;		//MANNINGS N FOR UPLAND(BLANK IF UNKNOWN)
        c.HI_FFPQ[0] = soil.FFPQ;		//FRACTION FLOODPLAIN FLOW--PARTITIONS FLOW THRU FILTER STRIPS
        c.HI_URBF[0] = soil.URBF;		//URBAN FRACTION OF SUBAREA
        
        //CHANNEL GEOMETRY OF ROUTING REACH THRU SUBAREA
        c.HI_RCHL[0] = soil.RCHL;		//CHANNEL LENGTH OF ROUTING REACH(km)
        c.HI_RCHD[0] = soil.RCHD;		//CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
        c.HI_RCBW[0] = soil.RCBW;		//BOTTOM WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
        c.HI_RCTW[0] = soil.RCTW;		//TOP WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
        c.HI_RCHS[0] = soil.RCHS;		//CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
        c.HI_RCHN[0] = soil.RCHN;		//MANNINGS N VALUE OF CHANNEL(BLANK IF UNKNOWN)
        c.HI_RCHC[0] = soil.RCHC;		//USLE C FOR CHANNEL
        c.HI_RCHK[0] = soil.RCHK;		//USLE K FOR CHANNEL
        c.HI_RFPW[0] = soil.RFPW;		//FLOODPLAIN WIDTH(m)(BLANK IF UNKNOWN)
        c.HI_RFPL[0] = soil.RFPL;		//FLOODPLAIN LENGTH(km)(BLANK IF UNKNOWN)
        c.HI_SAT1 	 = soil.SAT1;		//SATURARTED CONDUCTIVITY(GREEN & AMPT) ADJUSTMENT FACTOR(.01_10.)
        c.HI_FPS1	 = soil.FPS1;		//FLOODPLAIN SATURATED CONDUCTIVITY ADJUSTMENT FACTOR(.0001_10.)

        //RESERVOIR DATA
        c.HI_RSEE[0] = soil.RSEE;		//ELEV AT EMERGENCY SPILLWAY ELEV(m)
        c.HI_RSAE[0] = soil.RSAE;		//SURFACE AREA AT EMERGENCY SPILLWAY ELEV(ha)
        c.HI_RVE0[0] = soil.RVE0;		//VOLUME AT EMERGENCY SPILLWAY ELEV(mm)
        c.HI_RSEP[0] = soil.RSEP;		//ELEV AT PRINCIPAL SPILLWAY ELEV(m)
        c.HI_RSAP[0] = soil.RSAP;		//SURFACE AREA AT PRINCIPAL SPILLWAY ELEV(ha)
        c.HI_RVP0[0] = soil.RVP0;		//VOLUME AT PRINCIPAL SPILLWAY ELEV(mm)
        c.HI_RSV[0]  = soil.RSV;		//INITIAL VOLUME(mm)
        c.HI_RSRR[0] = soil.RSRR;		//TIME TO RELEASE FLOOD STORAGE(d)
        c.HI_RSYS[0] = soil.RSYS;		//INITIAL SEDIMENT CONCENTRATION(ppm)
        c.HI_RSYN[0] = soil.RSYN;		//NORMAL SEDIMENT CONC(ppm)
        c.HI_RSHC[0] = soil.RSHC;		//BOTTOM HYDRAULIC CONDUCTIVITY(mm/h)
        c.HI_RSDP[0] = soil.RSDP;		//TIME REQUIRED TO RETURN TO NORMAL SED CONC AFTER RUNOFF EVENT(d)
        c.HI_RSBD[0] = soil.RSBD;		//BULK DENSITY OF SEDIMENT IN RESERVOIR(t/m^3)
        c.HI_PCOF[0] = soil.PCOF;		//FRACTION OF SUBAREA CONTROLLED BY PONDS
        c.HI_BCOF[0] = soil.BCOF;		//FRACTION OF SUBAREA CONTROLLED BY BUFFERS
        c.HI_BFFL[0] = soil.BFFL;		//BUFFER FLOW LENGTH (m)
        
        //MANAGEMENT INFORMATION                                                                           
        c.HI_IRR[0]  = soil.IRR;			//0 FOR DRYLAND AREAS                                                                                                                             
        c.HI_IRI[0]  = soil.IRI;			//N DAY APPLICATION INTERVAL FOR AUTOMATIC IRRIGATION                                            
        c.HI_IFA[0]  = soil.IFA;			//MIN FERT APPL INTERVAL(BLANK FOR USER SPECIFIED)                                               
        c.HI_LM[0]  = soil.LM;				//0 APPLIES LIME                                                                                                                                                         
        c.HI_IFD[0]  = soil.IFD;			//0 WITHOUT FURROW DIKES                                                                                                                                                  
        c.HI_IDR[0]  = soil.IDR;			//0 NO DRAINAGE                                                                                                                                                  
        c.HI_IDF0[0]  = soil.IDF0;		//FERT #                                                                                                                                  
        c.HI_IRRS[0]  = soil.IRRS;		//ID OF SA SUPPLYING IRRIGATION WATER FROM A RESERVOIR                                             
        c.HI_BIR[0]  = soil.BIR;		//IRRIGATION TRIGGER--3 OPTIONS                                                                                                          
        c.HI_EFI[0]  = soil.EFI;		//RUNOFF VOL / VOL IRR WATER APPLIED(BLANK IF IRR=0)                                             
        c.HI_VIMX[0]  = soil.VIMX;		//MAXIMUM ANNUAL IRRIGATION VOLUME ALLOWED FOR EACH CROP (mm)                                    
        c.HI_ARMN[0]  = soil.ARMN;		//MINIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)                                                 
        c.HI_ARMX[0]  = soil.ARMX;		//MAXIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)                                                 
        c.HI_BFT[0]  = soil.BFT;		//AUTO FERTILIZER TRIGGER--2 OPTIONS                                                             
        								//1. PLANT N STRESS FACTOR (0-1)                                                                 
        								//2. SOIL N CONC IN ROOT ZONE (g/t)                                                              
        c.HI_FNP[3]  = soil.FNP4;		//AUTO FERT FIXED APPLICATION RATE (kg/ha)                                                       
        c.HI_FMX = soil.FMX;			//MAXIMUM ANNUAL N FERTILIZER APPLICATION FOR A CROP (kg/ha)                                     
        c.HI_DRT[0] = soil.DRT;			//TIME REQUIRED FOR DRAINAGE SYSTEM TO REDUCE PLANT STRESS(d)                                    
        								//(BLANK IF DRAINAGE NOT USED)                                                                   
        c.HI_FDSF[0] = soil.FDSF;		//FURROW DIKE SAFETY FACTOR(0-1.)                                                                
        c.HI_PEC[0] = soil.PEC;			//CONSERVATION PRACTICE FACTOR(=0.0 ELIMINATES WATER EROSION)                                    
        c.HI_DALG[0] = soil.DALG;		//FRACTION OF SUBAREA CONTROLLED BY LAGOON.                                                      
        c.HI_VLGN[0] = soil.VLGN;		//LAGOON VOLUME RATIO--NORMAL / MAXIMUM                                                          
        c.HI_COWW[0] = soil.COWW;		//LAGOON INPUT FROM WASH WATER (m3/hd/d)                                                         
        c.HI_DDLG[0] = soil.DDLG;		//TIME TO REDUCE LAGOON STORAGE FROM MAX TO NORM (d)                                             
        c.HI_SOLQ[0] = soil.SOLQ;		//RATIO LIQUID/TOTAL MANURE PRODUCED.                                                            
        c.HI_SFLG = soil.SFLG;			//SAFETY FACTOR FOR LAGOON DESIGN (VLG=VLG0/(1.-SFLG)                                            
        c.HI_FNP[1] = soil.FNP2;		//FEEDING AREA STOCK PILE AUTO SOLID MANURE APPL RATE (kg/ha)                                    
        c.HI_FNP[4] = soil.FNP5;		//AUTOMATIC MANURE APPLICATION RATE (kg/ha)                                                      
        c.HI_FIRG[0] = soil.FIRG;		//FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)    
        
        //c.HI_NY = soil.NY;			//HERD NUMBERS FOR GRAZING AREA
        c.HI_XTP[0] = soil.XTP;			//GRAZING LIMIT FOR EACH HERD--MINIMUM PLANT MATERIAL(t/ha) 
      
    	//APEX SUBEAREA DEFINITION
    	c.HI_YCT[0] = soil.YLAT;		//LATITUDE(deg)
    	c.HI_XCT[0] = soil.XLOG;		//LONGITUDE(deg)
    	c.HI_FL= soil.plotHeight/1000;	//convert m in km
    	c.HI_FW= soil.plotWidth/1000;    //convert m in km
    	
    	
    	//APEX SITE DEFINITION
    	c.HI_YLAT = soil.YLAT;			//LATITUDE(deg)
    	c.HI_XLOG = soil.XLOG;			//LONGITUDE(deg)
    	c.HI_ELEV = soil.ELEV;			//ELEVATION OF WATERSHED (m)
    	c.HI_APM = soil.APM;			//PEAK RATE - EI ADJUSTMENT FACTOR (BLANK IF UNKNOWN)
    	c.HI_CO2X = soil.CO2X ;			//CO2 CONCENTRATION IN ATMOSPHERE (ppm)--NON ZERO VALUE
        c.HI_CQNX = soil.CQNX;			//CONC OF NO3 IN IRRIGATION WATER (ppm)--NON ZERO VALUE
        c.HI_RFNX = soil.RFNX;			//AVE CONC OF N IN RAINFALL (ppm)
        c.HI_UPR = soil.UPR;			//MANURE APPL RATE TO SUPPLY P UPTAKE RATE (kg/ha/y)
        c.HI_UNR = soil.UNR;			//MANURE APPL RATE TO SUPPLY N UPTAKE RATE (kg/ha/y)
        c.HI_FIRG[0] = soil.FIR0;		//FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)
        c.HI_BCHL = soil.BCHL;			//SWAT BASIN CHANNEL LENGTH(km) 
        c.HI_BCHS = soil.BCHS;			//SWAT BASIN CHANNEL SLOPE(m/m)

		c.HI_SALB[0] = soil.SALB; 	
		c.HI_HSG = soil.HSG;  	
		c.HI_FFC[0] = soil.FFC;  	
		c.HI_WTMN[0] = soil.WTMN; 	
		c.HI_WTMX[0] = soil.WTMX; 	
		c.HI_WTBL[0] = soil.WTBL; 
		c.HI_GWST[0] = soil.GWST; 	
		c.HI_GWMX [0]= soil.GWMX; 	
		c.HI_RFTT[0] = soil.RFTT; 	
		c.HI_RFPK[0] = soil.RFPK; 	
		c.HI_TSLA[0] = soil.TSLA; 	
		c.HI_XIDS[0] = soil.XIDS; 	
		c.HI_RTN1 = soil.RTN1;		                                                                              
		c.HI_XIDK[0] = soil.XIDK; 	                                                                                                                         
		c.HI_ZQT = soil.ZQT;  	                                                                     
		c.HI_ZF = soil.ZF;  		                                             
		c.HI_ZTK = soil.ZTK;  	                           
		c.HI_FBM[0] = soil.FBM;  	                                                  
		c.HI_FHP[0] = soil.FHP; 
		
		for (int i=0;i<soil.Z.length;i++) {
			c.HI_Z[i]  = soil.Z[i];		                                                                  
			c.HI_BD[i] = soil.BD[i];		//BULK DENSITY(t/m3)                                                                             
			c.HI_UW[i] = soil.UW[i];		//SOIL WATER CONTENT AT WILTING POINT(1500 KPA)(m/m)                                                                                                                         
			c.HI_FC[i] = soil.FC[i];		//WATER CONTENT AT FIELD CAPACITY(33KPA)(m/m)                                                                                                                               
			c.HI_SAN[i] = soil.SAN[i];		//% SAND                                                                                         
			c.HI_SIL[i] = soil.SIL[i];		//% SILT                                                                                         
			c.HI_WON[i] = soil.WON[i];		//INITIAL ORGANIC N CONC(g/t)       (BLANK IF UNKNOWN)                                           
			c.HI_PH[i] = soil.PH[i];		//SOIL PH                                                                                        
			c.HI_SMB[i] = soil.SMB[i];		//SUM OF BASES(cmol/kg)              (BLANK IF UNKNOWN)                                          
			c.HI_WOC[i] = soil.WOC[i];		//ORGANIC CARBON CONC(%)                                                                         
			c.HI_CAC[i] = soil.CAC[i];		//CALCIUM CARBONATE(%)                                                                           
			c.HI_CEC[i] = soil.CEC[i];		//ATION EXCHANGE CAPACITY(cmol/kg)(BLANK IF UNKNOWN)                                            
			c.HI_ROK[i] = soil.ROK[i];		//COARSE FRAGMENTS(% VOL)              (BLANK IF UNKNOWN)                                        
			c.HI_CNDS[i] = soil.CNDS[i];	//INITIAL SOL N CONC(g/t)            (BLANK IF UNKNOWN)                                          
			c.HI_SSF[i] = soil.SSF[i];		//INITIAL SOL P CONC(g/t)       (BLANK IF UNKNOWN)                                               
			c.HI_RSD[i] = soil.RSD[i];		//CROP RESIDUE(t/ha)                (BLANK IF UNKNOWN)                                           
			c.HI_BDD[i] = soil.BDD[i];		//BULK DENSITY(OVEN DRY)(t/m3)   (BLANK IF UNKNOWN)                                              
			c.HI_PSP[i] = soil.PSP[i];		//P SORPTION RATIO                   (BLANK IF UNKNOWN)                                          
			c.HI_SATC[i] = soil.SATC[i];	//SATURATED CONDUCTIVITY(mm/h)     (BLANK IF UNKNOWN)                                            
			c.HI_HCL[i] = soil.HCL[i];		//LATERAL HYDRAULIC CONDUCTIVITY(mm/h)                                                           
			c.HI_WPO[i] = soil.WPO[i];		//INITIAL ORGANIC P CONC(g/t)      (BLANK IF UNKNOWN)                                            
			c.HI_DHN[i] = soil.DHN[i];		//EXCHANGEABLE K CONC (g/t)                                                                      
			c.HI_ECND[i] = soil.ECND[i];	//ELECTRICAL COND (mmho/cm)                                                                      
			c.HI_STFR[i] = soil.STFR[i];	//FRACTION OF STORAGE INTERACTING WITH NO3 LEACHING                                                                                   
			c.HI_SWST[i] = soil.SWST[i];	//INITIAL SOIL WATER STORAGE (m/m)                                                               
			c.HI_CPRV[i] = soil.CPRV[i];	//FRACTION INFLOW PARTITIONED TO VERTICLE CRACK OR PIPE FLOW                                     
			c.HI_CPRH[i] = soil.CPRH[i];	//FRACTION INFLOW PARTITIONED TO HORIZONTAL CRACK OR PIPE FLOW                                                                                           
			c.HI_WLS[i] = soil.WLS[i];		//STRUCTURAL LITTER(kg/ha)           (BLANK IF UNKNOWN)                                          
			c.HI_WLM[i] = soil.WLM[i];		//METABOLIC LITTER(kg/ha)            (BLANK IF UNKNOWN)                                          
			c.HI_WLSL[i] = soil.WLSL[i];	//LIGNIN CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)                                              
			c.HI_WLSC[i] = soil.WLSC[i];	//CARBON CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)                                              
			c.HI_WLMC[i] = soil.WLMC[i];	//C CONTENT OF METABOLIC LITTER(kg/ha)(B I U)                                                    
			c.HI_WLSLC[i] = soil.WLSLC[i];	//C CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(B I U)                                         
			c.HI_WLSLNC[i] = soil.WLSLNC[i];	//N CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(BIU)                                           
			c.HI_WBMC[i] = soil.WBMC[i];	//C CONTENT OF BIOMASS(kg/ha)(BIU)                                                               
			c.HI_WHSC[i] = soil.WHSC[i];	//C CONTENT OF SLOW HUMUS(kg/ha)(BIU)                                                            
			c.HI_WHPC[i] = soil.WHPC[i];	//C CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)                                                         
			c.HI_WLSN[i] = soil.WLSN[i];	//N CONTENT OF STRUCTURAL LITTER(kg/ha)(BIU)                                                     
			c.HI_WLMN[i] = soil.WLMN[i];	//N CONTENT OF METABOLIC LITTER(kg/ha)(BIU)                                                      
			c.HI_WBMN[i] = soil.WBMN[i];	//N CONTENT OF BIOMASS(kg/ha)(BIU)                                                               
			c.HI_WHSN[i] = soil.WHSN[i];	//N CONTENT OF SLOW HUMUS(kg/ha)(BIU)                                                            
			c.HI_WHPN[i] = soil.WHPN[i];	//N CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)                                                         
			c.HI_FE26[i] = soil.FE26[i];	//IRON CONTENT(%)                                                                                
			c.HI_SULF[i] = soil.SULF[i];	//SULFUR CONTENT(%)                                                                              
		//    ASHZ;	//SOIL HORIZON(A,B,C)                                                                            
			c.HI_CGO2[i] = soil.CGO2[i];	//O2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)                                                        
			c.HI_CGCO2[i] = soil.CGCO2[i];	//CO2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)                                                       
			c.HI_CGN2O[i] = soil.CGN2O[i];	//N2O CONC IN GAS PHASE (g/m3 OF SOIL AIR) 
		}
	    

		//determine crop operation file name for APEX
		String cropOps;
		int cropOpsSize; 
		if (crop.IsMainCropSpecies()) cropOps=ep.mainCropInterventionFile;
		else cropOps=ep.interCropInterventionFile;
		cropOpsSize=cropOps.length();

    	JNA.INSTANCE_APEX.simulationStart (c, 
    									dir.length(), dir, 
										ep.windFile.length(), ep.windFile,
										ep.herdFile.length(), ep.herdFile,
										ep.rtfFile.length(), ep.rtfFile,
										ep.stationFile.length(), ep.stationFile,
										10, "A48309.DLY",	
										cropOpsSize, cropOps	
    									);

    	
    	System.out.println("crop year1="+c.HI_KDC[0]);
		return;
   } 
    
    /**
	 * endSimulation : end of the simulation
	 */
	 
    public static void simulationEnd (SafeApexCrop crop) { 

    	SafeApexApexCommun c = crop.getApexCrop();
    	
    	System.out.println("simulationEnd");
    	
    	JNA.INSTANCE_APEX.simulationEnd (c);

		return;

    }
  
    
    /**
     * initBoucleAnnuelle : annual loop initialization
     */   
 
    public static void yearLoopStart (SafeApexCrop crop) { 
    	
		//APEX SECTION

    	SafeApexApexCommun c = crop.getApexCrop();

    	System.out.println("yearLoopStart");

        JNA.INSTANCE_APEX.yearLoopStart (c);

		return;     
   } 
    /**
     * apport : add carbon litters from tree
     */
    public static void addTreeLitters(SafeApexCrop crop) { 
    	
    	SafeApexApexCommun c = crop.getApexCrop();
    	
    	System.out.println("addTreeLitters");
    	
    	JNA.INSTANCE_APEX.addTreeLitters (c);
    
    }
    /**
     * boucleJour1 : daily loop part 1
     */
    public static void dayLoopStart (SafeApexCrop crop,
    								int julianDay,
    								double	cellRad, 							   
		     						double	cellRain, 
	     							double  cellEtp) { 

		//TODO MICHAEL BORUCKE=======================================================
		//WHERE do we have to STORE these values in APEX ?????
		//CARE of UNITS !!!!
		//===========================================================================	


		System.out.println("SafeApexJNA Line 421");
    	SafeApexApexCommun c = crop.getApexCrop();
		System.out.println("SafeApexJNA Line 423");
		System.out.println("Size of c.HI_SRAD="+c.HI_SRAD.length);
		System.out.println("c.HI_SRAD="+c.HI_SRAD[0]);
    	
   		c.HI_SRAD[0] = (float) cellRad;     /* RG  (MJ m-2) */	//(APEX) SRAD even though there is no def. Instead RAD	Daily mean solar radiation on dry days in MJ m-2 d-1.
		System.out.println("SafeApexJNA Line 427");
		c.HI_RFV[0] = (float) cellRain;     /* rain (mm)    */ //RFV	Rainfall that arrives on the soil surface in mm
		System.out.println("SafeApexJNA Line 429");
		c.HI_EO = (float) cellEtp;     /* ETP  (mm)     */ //EO from HEVP.f90;
		System.out.println("SafeApexJNA Line 431");

    	
 
    	
    	System.out.println("dayLoopStart");
    	
    	JNA.INSTANCE_APEX.dayLoopStart (c);
    	
    	//in c.HI_UX i have my water demand
    	//?nitrogen demand?
    	crop.setWaterDemand(c.HI_UX);
    	//crop.setNitrogenDemand(c.HI_DMN); 
		return;
    } 
    
    /**
     * boucleJour2 : daily loop part 2
     */ 
    public static void dayLoopEnd (SafeApexCrop crop) { 

    	SafeApexApexCommun c = crop.getApexCrop();
    	
    	System.out.println("dayLoopEnd");
    	
    	SafeApexCell  cell = crop.getCell();
    	SafeApexVoxel voxels [] = cell.getVoxels();
    	for (int j=0; j < voxels.length; j++) {
    		System.out.println("SafeApexJNA Line 460 and j= "+j);
    		System.out.println("SafeApexJNA Line 461 and size of HI_UW= "+c.HI_UW.length);
			if(j>=12){
				continue;
			}
			c.HI_UW[j] = (float) voxels[j].getCropWaterUptake();  // UW = Water use rate by soil layer
    		c.HI_UNM[j] = (float) voxels[j].getCropNitrogenUptake();
    	}
    	

    	
    	JNA.INSTANCE_APEX.dayLoopEnd (c);

    	
    	for (int j=0; j < voxels.length; j++) {

    		//water content voxels[j].setWaterContent(xxxxxx);
    		//nitrogen content voxels[j].setNitrogenContent(xxxxx);
    	}
    	
    	
		return;
	}		

		


    /**
     * finBoucleAnnuelle : annual loop end process
     */   
    
    public static void yearLoopEnd (SafeApexCrop crop) { 

    	SafeApexApexCommun c = crop.getApexCrop();
    	
    	System.out.println("yearLoopEnd");
    	
    	JNA.INSTANCE_APEX.yearLoopEnd (c);

		return;
    }   
  
}
