package safeapex.apex;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import com.sun.jna.Structure;

import safeapex.model.SafeApexPlotSettings;

/**
 * SafeApexApexCommun - Mirror object of APEX FORTRAN modparmtype.f90 
 * 
 * 
 * @author Isabelle Lecomte - October 2018
 */

public class SafeApexApexCommun extends Structure implements Serializable {


	public int HI_IBD,HI_IBDT,HI_ICDP,HI_ICMD,HI_ICO2,HI_ICP,HI_IDA,HI_IDAY,HI_IDIR,HI_IDN1,HI_IDN2,HI_IDNT,HI_IDO,
	HI_IERT,HI_IET,HI_IGC,HI_IGN,HI_IGSD,HI_IHD,HI_IHRD,HI_IHV,HI_IHUS,HI_IHY,HI_III,HI_IKAT,HI_IMON,HI_INFL,HI_INP,
	HI_IOF,HI_IOW,HI_IOX,HI_IPAT,HI_IPC,HI_IPD,HI_IPF,HI_IPL,HI_IPRK,HI_IPY,HI_IPYI,HI_IRGX,HI_IRH,HI_IRUN,HI_ISA,HI_ISAP,
	HI_ISCN,HI_ISLF,HI_ISL,HI_ISTA,HI_ISW,HI_IT1,HI_IT2,HI_IT3,HI_ITYP,HI_IUN,HI_IWI,HI_IWTB,HI_IY,HI_IYER,HI_IYR,
	HI_IYR0,HI_IYX,HI_JD0,HI_JDA,HI_JDE,HI_JDHU,HI_JJK,HI_JT1,HI_JT2;
	
	public int HI_KDA,HI_KF,HI_KI,HI_KP,HI_LBP,HI_KND,HI_LC,HI_LGRZ,HI_LGZ,HI_LND,HI_LNS,HI_LPD,HI_LPYR,HI_LW,HI_MASP,
	HI_MBS,HI_MCA12,HI_MFT,HI_MHD,HI_MHP,HI_MHX,HI_MHY,HI_ML1,HI_MNC,HI_MNT,HI_MNUL,HI_MO,HI_MO1,HI_MOW,HI_MPO,HI_MPS,
	HI_MRO,HI_MSA,HI_MSC,HI_MSCP,HI_MSL,HI_MXT,HI_MXW,HI_NAQ,HI_NBCL,HI_NBCX,HI_NBDT,HI_NBFX,HI_NBMX,HI_NBON,HI_NBYR,
	HI_NCMD,HI_NCMO,HI_ND,HI_NDF,HI_NDP,HI_NDRV,HI_NDT,HI_NDVSS,HI_NDWT,HI_NEV,HI_NGN,HI_NGN0,HI_NJC,HI_NKA,HI_NKD,
	HI_NKS,HI_NKY,HI_NOFL,HI_NOP,HI_NPD,HI_NPRC,HI_NPSO,HI_NRF,HI_NSH,HI_NSM,HI_MSO,HI_NSNN,HI_NSTP,HI_NSX,
	HI_NSZ,HI_NYD,HI_NT0,HI_NT1,HI_NTV,HI_NUPC,HI_NWP,HI_NWTH;
	
	public int HI_KDT1[],HI_KDC1[],HI_KDF1[],HI_KDP1[],HI_KA[],HI_NXP[],HI_KR[],HI_KDT2[],HI_KD[],HI_KY[],HI_KDP[],HI_NHC[],
	HI_KS[],HI_NWDR[],HI_IX[],HI_NC[],HI_IDG[],HI_IX0[],HI_IAD[],HI_ICMO[],HI_NWPD[],HI_NDC[],HI_JX[],HI_KGN[],HI_JC[];
	

	public int HI_IAC[];
    public int HI_IAMF[];
    public int HI_IAPL[];
    public int HI_IAUF[];
    public int HI_IAUI[];
    public int HI_IAUL[];
    public int HI_IBSA[];
    

    public int HI_ICDT[];
    public int HI_ICUS[];
    public int HI_IDC[];
    public int HI_IDF0[];
    public int HI_IDFA[];
    public int HI_IDFD[];
    public int HI_IDFH[];
    public int HI_IDFT[];
    public int HI_IDMU[];
    public int HI_IDN1T[];
    public int HI_IDN2T[];
    public int HI_IDNB[];
    public int HI_IDNF[];
    public int HI_IDOA[];
    public int HI_IDON[];
    public int HI_IDOT[];
    public int HI_IDOW[];
    public int HI_IDR[];
    public int HI_IDRL[];
    public int HI_IDRO[];
    public int HI_IDS[];
    public int HI_IDSL[];
    public int HI_IDSS[];

    public int HI_IEXT[];
    public int HI_IFA[];
    public int HI_IFD[];
    public int HI_IFED[];
    public int HI_IFLO[];
    public int HI_IFLS[];
    public int HI_IGO[];
    public int HI_IGZ[];
    public int HI_IGZO[];
    public int HI_IGZX[];
    public int HI_IHBS[];
    public int HI_IHC[];
    public int HI_IHDM[];
    public int HI_IHDT[];
    public int HI_IHRL[];
    public int HI_IHT[];
    public int HI_IHU[];
    public int HI_IHX[];
    public int HI_IIR[];
    public int HI_ILQF[];
    public int HI_IMW[];
    public int HI_IPMP[];
    public int HI_IPSF[];
    public int HI_IPSO[];
    public int HI_IPST[];
    public int HI_IPTS[];
    public int HI_IRF[];
    public int HI_IRI[];
    public int HI_IRO[];
    public int HI_IRP[];
    public int HI_IRR[];
    public int HI_IRRS[];
    public int HI_ISAL[];
    public int HI_ISAO[];
    public int HI_ISAS[];
    public int HI_ISCP[];
    public int HI_ISG[];
    public int HI_ISPF[];
    public int HI_ITL[];
    public int HI_IWTH[];
    public int HI_IYH[];
    public int HI_IYHO[];
    public int HI_JBG[];
    public int HI_JCN[];
    public int HI_JCN0[];
    public int HI_JCN1[];
    public int HI_JD[];
    public int HI_JE[];
    public int HI_JH[];
    public int HI_JP[];
    public int HI_JPC[];
    public int HI_JPL[];
    public int HI_KC[];
    public int HI_KDC[];
    public int HI_KDF[];
    public int HI_KDT[];
    public int HI_KFL[];
    public int HI_KGO[];
    public int HI_KIR[];
    public int HI_KOMP[];
    public int HI_KP1[];
    public int HI_KPC[];
    public int HI_KPSN[];
    public int HI_KT[];
    public int HI_KTF[];
    public int HI_KTMX[];
    public int HI_KTT[];
    public int HI_KW[];
    public int HI_LFT[];
    public int HI_LGIR[];
    public int HI_LID[];
    public int HI_LM[];
    public int HI_LORG[];
    public int HI_LPC[];
    public int HI_LRD[];
    public int HI_LT[];
    public int HI_LUN[];
    public int HI_LUNS[];
    public int HI_LY[];
    public int HI_LYR[];
    public int HI_MXSR[];
    public int HI_NBCF[];
    public int HI_NBCT[];
    public int HI_NBE[];
    public int HI_NBFF[];
    public int HI_NBFT[];
    public int HI_NBHS[];
    public int HI_NBSA[];
    public int HI_NBSL[];
    public int HI_NBSX[];
    public int HI_NBT[];
    public int HI_NBW[];
    public int HI_NCOW[];
    public int HI_NCP[];
    public int HI_NCR[];
    public int HI_NDFA[];
    public int HI_NFED[];
    public int HI_NFRT[];
    public int HI_NGIX[];
    public int HI_NGZ[];
    public int HI_NGZA[];
    public int HI_NHBS[];
    public int HI_NHRD[];
    public int HI_NHU[];
    public int HI_NHY[];
    public int HI_NII[];
    public int HI_NIR[];
    public int HI_NISA[];
    public int HI_NMW[];
    public int HI_NPC[];
    public int HI_NPSF[];
    public int HI_NPST[];
    public int HI_NQRB[];
    public int HI_NRO[];
    public int HI_NSAL[];
    public int HI_NSAO[];
    public int HI_NSAS[];
    public int HI_NTL[];
    public int HI_NTP[];
    public int HI_NTX[];
    public int HI_NVCN[];
    public int HI_NWDA[];
    public int HI_NYHO[];
    public int HI_NYLN[];
   

 
	public float HI_ACW,HI_ADEO,HI_ADHY,HI_ADRF,HI_AEPT,HI_AET,HI_AFN,HI_AGP,HI_AHSM,HI_AJWA,HI_ALG,HI_ALMN,HI_ALTC,
	HI_AL5,HI_AMPX,HI_ANG,HI_AMSR,HI_AVT,HI_BETA,HI_BRNG,HI_BS1,HI_BS2,HI_BXCT,
	HI_BYCT,HI_CBVT,HI_CLF,HI_CLT,HI_CMM,HI_CMS,HI_CN,HI_CNO3I,HI_COIR,HI_COL,HI_CON,HI_COP,HI_CO2,HI_COS1,HI_CPH0,
	HI_CPV0,HI_CPVV,HI_CQNI,HI_CRLNC,HI_CRUNC,HI_CSFX,HI_CSLT,HI_D150,HI_DAYL,HI_DD,HI_DEMR,HI_DMN,HI_DN2O,HI_DRSW,   // Inserted MB 7/24/19
	HI_DRTO,HI_DTG,HI_DTHY,HI_DUR,HI_DURG,HI_DVOL,HI_DZ10,HI_DZDN,HI_EI,HI_ELEV,HI_EO,HI_ERTN,HI_ERTO,
	HI_ERTP,HI_ES,HI_EXNN,HI_EXPK,HI_FL,HI_FULP,HI_FW,HI_GWBX,HI_GX,HI_HGX,HI_HMN,HI_HRLT,HI_HR1,HI_PB,HI_PI2,HI_PIT,
	HI_PMOEO,HI_PMORF,HI_PRFF,HI_PSTX,HI_QAPY,HI_QRB,HI_QSFN,HI_QSFP,HI_QTH,HI_RAMX,HI_REP,HI_RFNC,HI_RFQN,
	HI_RFRA,HI_RGIN,HI_RGRF,HI_RHCF,HI_RHM,HI_RHP,HI_RHS,HI_RM,HI_RMNR,HI_RMX0,
	HI_RNO3,HI_RRF,HI_RTP,HI_RUNT,HI_RWO,HI_SAET,HI_SALF,HI_SAT,HI_SBAL,HI_SCN,HI_SCN2,HI_SDEG,
	HI_SDEP,HI_SDN,HI_SDRF,HI_SEP,HI_SGMN,HI_SHRL,HI_SK,HI_SML,HI_SMNR,HI_SMP,HI_SMSQ,HI_SN2,HI_SN2O,HI_SNIT,HI_SN,
	HI_SNMN,HI_SNOF,HI_SNPKT,HI_SOFU,HI_SP,HI_SPRC,HI_SPRF,HI_SRPM,HI_SSFK,HI_SSFN,HI_SSST,HI_STND,HI_SUK,
	HI_SUN,HI_SUP,HI_SVOL;

	public float HI_SX,HI_SYMU,HI_SYW,HI_TA,HI_TDEG,HI_TDEP,HI_TEVP,HI_TEV1,HI_TFMA,HI_TFMN,HI_TFNO,HI_THW,HI_TLA,
	HI_TMAF,HI_TMAP,HI_TMPD,HI_TPRK,HI_TPSP,HI_TREV,HI_TRFR,HI_TRSP,HI_TSAE,HI_TSFS,HI_TX,HI_TXXM,HI_UK2,HI_UKM,
	HI_UNR,HI_UN2,HI_UPM,HI_UPR,HI_UP2,HI_USTRT,HI_USTT,HI_USTW,HI_UX,HI_UXP,HI_V56,HI_V57,HI_VGF,HI_VMU,HI_VPD,
	HI_V1,HI_V3,HI_WAGE,HI_WB,HI_WCF,HI_WCYD,HI_WDN,HI_WFX,HI_WIM,HI_WIP,HI_WKA,HI_WKMNH3,HI_WKMNO2,HI_WKMNO3,
	HI_WMP,HI_WNCMAX,HI_WNCMIN,HI_WTN,HI_XCS,HI_XDA,HI_XDA1,HI_XET,HI_XK1,HI_XK2,HI_XKN1,HI_XKN3,HI_XKN5,HI_XKP1,
	HI_XKP2,HI_XSA,HI_XSL,HI_YCS,HI_YERO,HI_YEW,HI_YEWN,HI_YLAT,HI_YLAZ,HI_YLN,HI_YLP,HI_YMP,HI_YSL,HI_YWKS,HI_ZF,HI_ZQT,
	HI_TCL,HI_TCF,HI_TCR,HI_TLF,HI_TNF,HI_TNC;																			
	
	
	public float HI_XTP[],HI_XYP[],HI_PRMT[],HI_SMYR[],HI_VARS[],HI_RNCF[],HI_TAV[],
	HI_TMNF[],HI_TMXF[],HI_UAV0[],HI_UAVM[],HI_AWXP[],HI_RFSG[],HI_SMSO[],
	HI_OPV[],HI_SMSW[],HI_PSZ[],HI_PSZX[],HI_PSZY[],HI_BUS[],HI_WX[],HI_XAV[],HI_XDV[],
	HI_XIM[],HI_XRG[],HI_UNM[];                                                                 //Inserted MB 8.13.19
    
    
	public float HI_SMMR[],HI_SMR[],HI_DIR[],HI_OBMN[],HI_OBMNX[],
	HI_OBMX[],HI_OBSL[],HI_PCF[],HI_RH[],HI_SDTMN[],HI_SDTMX[],
	HI_WFT[],HI_WI[],HI_SCRP[];
	
	public float HI_CQRB[],HI_RST[],HI_PRW[];
	
	
	public float HI_ABD[];
    public float HI_ACET[];
    public float HI_ACO2C[];
    public float HI_AEP[];
    public float HI_AFLG[];
    public float HI_AFP[];
    public float HI_AGPM[];
    public float HI_AJHI[];
    public float HI_ALGI[];
    public float HI_ALQ[];
    public float HI_ALS[];
    public float HI_ALT[];
    public float HI_AN2OC[];
    public float HI_ANA[];
    public float HI_AO2C[];
    public float HI_ARMN[];
    public float HI_ARMX[];
    public float HI_ARSD[];
    public float HI_ASW[];
    public float HI_AWC[];
    public float HI_BA1[];
    public float HI_BA2[];
    public float HI_BCOF[];
    public float HI_BCV[];
    public float HI_BD[];
    public float HI_BDD[];
    public float HI_BDM[];
    public float HI_BDP[];
    public float HI_BFFL[];
    public float HI_BFSN[];
    public float HI_BFT[];
    public float HI_BGWS[];
    public float HI_BIG[];
    public float HI_BIR[];
    public float HI_BK[];
    public float HI_BLG[];
    public float HI_BN[];
    public float HI_BP[];
    public float HI_BPT[];
    public float HI_BR1[];
    public float HI_BR2[];
    public float HI_BRSV[];
    public float HI_BSALA[];
    public float HI_BSNO[];
    public float HI_BTC[];
    public float HI_BTCX[];
    public float HI_BTCZ[];
    public float HI_BTK[];
    public float HI_BTN[];
    public float HI_BTNX[];
    public float HI_BTNZ[];
    public float HI_BTP[];
    public float HI_BTPX[];
    public float HI_BTPZ[];
    public float HI_BV1[];
    public float HI_BV2[];
    public float HI_BVIR[];
    public float HI_BWN[];
    public float HI_CAC[];
    public float HI_CAF[];
    public float HI_CAW[];
    public float HI_CBN[];
    public float HI_CDG[];
    public float HI_CEC[];
    public float HI_CFNP[];
    public float HI_CGCO2[];
    public float HI_CGN2O[];
    public float HI_CGO2[];
    public float HI_CHL[];
    public float HI_CHN[];
    public float HI_CHS[];
    public float HI_CHXA[];
    public float HI_CHXP[];
    public float HI_CKY[];
    public float HI_CLA[];
    public float HI_CLCO2[];
    public float HI_CLG[];
    public float HI_CLN2O[];
    public float HI_CLO2[];
    public float HI_CN0[];
    public float HI_CN2[];
    public float HI_CND[];
    public float HI_CNDS[];
    public float HI_CNLV[];
    public float HI_CNRT[];
    public float HI_CNSC[];
    public float HI_CNSX[];
    public float HI_CNY[];
    public float HI_COOP[];
    public float HI_COST[];
    public float HI_COTL[];
    public float HI_COWW[];
    public float HI_CPFH[];
    public float HI_CPHT[];
    public float HI_CPMX[];
    public float HI_CPRH[];
    public float HI_CPRV[];
    public float HI_CPVH[];
    public float HI_CPY[];
    public float HI_CST1[];
    public float HI_CSTF[];
    public float HI_CSTS[];
    public float HI_CTSA[];
    public float HI_CV[];
    public float HI_CVF[];
    public float HI_CVP[];
    public float HI_CVRS[];
    public float HI_CX[];
    public float HI_CYAV[];
    public float HI_CYMX[];
    public float HI_CYSD[];
    public float HI_DALG[];
    public float HI_DCO2GEN[];
    public float HI_DDLG[];
    public float HI_DDM[];
    public float HI_DEPC[];
    public float HI_DHN[];
    public float HI_DHT[];
    public float HI_DKH[];
    public float HI_DKHL[];
    public float HI_DKI[];
    public float HI_DKIN[];
    public float HI_DLAI[];
    public float HI_DLAP[];
    public float HI_DM[];
    public float HI_DM1[];
    public float HI_DMF[];
    public float HI_DMLA[];
    public float HI_DMLX[];
    public float HI_DN2G[];
    public float HI_DN2OG[];
    public float HI_DO2CONS[];
    public float HI_DPMT[];
    public float HI_DPRC[];
    public float HI_DPRN[];
    public float HI_DPRO[];
    public float HI_DRAV[];
    public float HI_DRT[];
    public float HI_DRWX[];
    public float HI_DST0[];
    public float HI_DUMP[];
    public float HI_DWOC[];
    public float HI_EAR[];
    public float HI_ECND[];
    public float HI_EFI[];
    public float HI_EFM[];
    public float HI_EK[];
    public float HI_EM10[];
    public float HI_EMX[];
    public float HI_EO5[];
    public float HI_EP[];
    public float HI_EQKE[];
    public float HI_EQKS[];
    public float HI_ERAV[];
    public float HI_ETG[];
    public float HI_EVRS[];
    public float HI_EVRT[];
    public float HI_EXCK[];
    public float HI_EXTC[];
    public float HI_FBM[];
    public float HI_FC[];
    public float HI_FCMN[];
    public float HI_FCMP[];
    public float HI_FCST[];
    public float HI_FDSF[];
    public float HI_FE26[];
    public float HI_FFC[];
    public float HI_FFED[];
    public float HI_FFPQ[];
    public float HI_FGC[];
    public float HI_FGSL[];
    public float HI_FHP[];
    public float HI_FIRG[];
    public float HI_FIRX[];
    public float HI_FIXK[];
    public float HI_FK[];
    public float HI_FLT[];
    public float HI_FN[];
    public float HI_FNMA[];
    public float HI_FNMN[];
    public float HI_FNMX[];
    public float HI_FNO[];
    public float HI_FNP[];
    public float HI_FOC[];
    public float HI_FOP[];
    public float HI_FP[];
    public float HI_FPF[];
    public float HI_FPO[];
    public float HI_FPOP[];
    public float HI_FPSC[];
    public float HI_FRCP[];
    public float HI_FRST[];
    public float HI_FRTK[];
    public float HI_FRTN[];
    public float HI_FRTP[];
    public float HI_FSFN[];
    public float HI_FSFP[];
    public float HI_FSLT[];
    public float HI_FTO[];
    public float HI_FULU[];
    public float HI_GCOW[];
    public float HI_GMA[];
    public float HI_GMHU[];
    public float HI_GRDD[];
    public float HI_GRDL[];
    public float HI_GRLV[];
    public float HI_GSI[];
    public float HI_GWMX[];
    public float HI_GWPS[];
    public float HI_GWSN[];
    public float HI_GWST[];
    public float HI_GZLM[];
    public float HI_GZRT[];
    public float HI_HA[];
    public float HI_HCL[];
    public float HI_HCLD[];
    public float HI_HCLN[];
    public float HI_HE[];
    public float HI_HI[];
    public float HI_HKPC[];
    public float HI_HKPN[];
    public float HI_HKPO[];
    public float HI_HLMN[];
    public float HI_HMO[];
    public float HI_HMX[];
    public float HI_HR0[];
    public float HI_HSM[];
    public float HI_HU[];
    public float HI_HUF[];
    public float HI_HUI[];
    public float HI_HUSC[];
    public float HI_HYDV[];
    public float HI_OCPD[];
    public float HI_OMAP[];
    public float HI_ORHI[];
    public float HI_ORSD[];
    public float HI_OSAA[];
    public float HI_OWSA[];
    public float HI_PAW[];
    public float HI_PCOF[];
    public float HI_PCST[];
    public float HI_PCT[];
    public float HI_PCTH[];
    public float HI_PDAW[];
    public float HI_PDPL[];
    public float HI_PDPL0[];
    public float HI_PDPLC[];
    public float HI_PDPLX[];
    public float HI_PDSKC[];
    public float HI_PDSW[];
    public float HI_PEC[];
    public float HI_PFOL[];
    public float HI_PH[];
    public float HI_PHLF[];
    public float HI_PHLS[];
    public float HI_PHU[];
    public float HI_PHUX[];
    public float HI_PKOC[];
    public float HI_PKRZ[];
    public float HI_PLAX[];
    public float HI_PLCH[];
    public float HI_PM10[];
    public float HI_PMX[];
    public float HI_PO[];
    public float HI_POP[];
    public float HI_POPX[];
    public float HI_PPCF[];
    public float HI_PPL0[];
    public float HI_PPLA[];
    public float HI_PPLP[];
    public float HI_PPX[];
    public float HI_PQPS[];
    public float HI_PRAV[];
    public float HI_PRB[];
    public float HI_PRSD[];
    public float HI_PRYF[];
    public float HI_PRYG[];
    public float HI_PSO3[];
    public float HI_PSOL[];
    public float HI_PSON[];
    public float HI_PSOP[];
    public float HI_PSOQ[];
    public float HI_PSOY[];
    public float HI_PSP[];
    public float HI_PSSF[];
    public float HI_PSSP[];
    public float HI_PST[];
    public float HI_PSTE[];
    public float HI_PSTF[];
    public float HI_PSTM[];
    public float HI_PSTR[];
    public float HI_PSTS[];
    public float HI_PSTZ[];
    public float HI_PSZM[];
    public float HI_PVQ[];
    public float HI_PVY[];
    public float HI_PWOF[];
    public float HI_PYPS[];
    public float HI_QC[];
    public float HI_QCAP[];
    public float HI_QDR[];
    public float HI_QDRN[];
    public float HI_QDRP[];
    public float HI_QGA[];
    public float HI_QHY[];
    public float HI_QIN[];
    public float HI_QIR[];
    public float HI_QN[];
    public float HI_QP[];
    public float HI_QPR[];
    public float HI_QPST[];
    public float HI_QPU[];
    public float HI_QRBQ[];
    public float HI_QRF[];
    public float HI_QRFN[];
    public float HI_QRFP[];
    public float HI_QRP[];
    public float HI_QRQB[];
    public float HI_QSF[];
    public float HI_QURB[];
    public float HI_QVOL[];
    public float HI_RBMD[];
    public float HI_RCBW[];
    public float HI_RCF[];
    public float HI_RCHC[];
    public float HI_RCHD[];
    public float HI_RCHK[];
    public float HI_RCHL[];
    public float HI_RCHN[];
    public float HI_RCHS[];
    public float HI_RCHX[];
    public float HI_RCSS[];
    public float HI_RCTC[];
    public float HI_RCTW[];
    public float HI_RD[];
    public float HI_RDF[];
    public float HI_RDMX[];
    public float HI_REG[];
    public float HI_REPI[];
    public float HI_RF5[];
    public float HI_RFDT[];
    public float HI_RFPK[];
    public float HI_RFPL[];
    public float HI_RFPS[];
    public float HI_RFPW[];
    public float HI_RFPX[];
    public float HI_RFTT[];
    public float HI_RFV[];
    public float HI_RFV0[];
    public float HI_RHD[];
    public float HI_RHT[];
    public float HI_RHTT[];
    public float HI_RIN[];
    public float HI_RINT[];
    public float HI_RLAD[];
    public float HI_RLF[];
    public float HI_RMXS[];
    public float HI_RNMN[];
    public float HI_ROK[];
    public float HI_ROSP[];
    public float HI_RQRB[];
    public float HI_RR[];
    public float HI_RRUF[];
    public float HI_RSAE[];
    public float HI_RSAP[];
    public float HI_RSBD[];
    public float HI_RSD[];
    public float HI_RSDM[];
    public float HI_RSDP[];
    public float HI_RSEE[];
    public float HI_RSEP[];
    public float HI_RSF[];
    public float HI_RSFN[];
    public float HI_RSHC[];
    public float HI_RSK[];
    public float HI_RSLK[];
    public float HI_RSO3[];
    public float HI_RSOC[];
    public float HI_RSON[];
    public float HI_RSOP[];
    public float HI_RSPC[];
    public float HI_RSPK[];
    public float HI_RSPS[];
    public float HI_RSRR[];
    public float HI_RSSA[];
    public float HI_RSSF[];
    public float HI_RSSP[];
    public float HI_RST0[];
    public float HI_RSTK[];
    public float HI_RSV[];
    public float HI_RSVB[];
    public float HI_RSVE[];
    public float HI_RSVF[];
    public float HI_RSVP[];
    public float HI_RSYB[];
    public float HI_RSYF[];
    public float HI_RSYN[];
    public float HI_RSYS[];
    public float HI_RVE0[];
    public float HI_RVP0[];
    public float HI_RW[];
    public float HI_RWPC[];
    public float HI_RWSA[];
    public float HI_RWT[];
    public float HI_RWTZ[];
    public float HI_RZ[];
    public float HI_RZSW[];
    public float HI_S15[];
    public float HI_S3[];
    public float HI_SALA[];
    public float HI_SALB[];
    public float HI_SAMA[];
    public float HI_SAN[];
    public float HI_SATC[];
    public float HI_SATK[];
    public float HI_SCFS[];
    public float HI_SCI[];
    public float HI_SCNX[];
    public float HI_SDVR[];
    public float HI_SDW[];
    public float HI_SET[];
    public float HI_SEV[];
    public float HI_SFCP[];
    public float HI_SFMO[];
    public float HI_SHYD[];
    public float HI_SIL[];
    public float HI_SLA0[];
    public float HI_SLAI[];
    public float HI_SLF[];
    public float HI_SLT0[];
    public float HI_SLTX[];
    public float HI_SM[];
    public float HI_SMAP[];
    public float HI_SMAS[];
    public float HI_SMB[];
    public float HI_SMEA[];
    public float HI_SMEO[];
    public float HI_SMES[];
    public float HI_SMFN[];
    public float HI_SMFU[];
    public float HI_SMH[];
    public float HI_SMIO[];
    public float HI_SMKS[];
    public float HI_SMLA[];
    public float HI_SMM[];
    public float HI_SMMC[];
    public float HI_SMMH[];
    public float HI_SMMP[];
    public float HI_SMMRP[];
    public float HI_SMMU[];
    public float HI_SMNS[];
    public float HI_SMNU[];
    public float HI_SMPL[];
    public float HI_SMPQ[];
    public float HI_SMPS[];
    public float HI_SMPY[];
    public float HI_SMRF[];
    public float HI_SMRP[];
    public float HI_SMS[];
    public float HI_SMSS[];
    public float HI_SMST[];
    public float HI_SMTS[];
    public float HI_SMWS[];
    public float HI_SMX[];
    public float HI_SMY[];
    public float HI_SMY1[];
    public float HI_SMY2[];
    public float HI_SMYH[];
    public float HI_SMYP[];
    public float HI_SMYRP[];
    public float HI_SNO[];
    public float HI_SOIL[];
    public float HI_SOL[];
    public float HI_SOLK[];
    public float HI_SOLQ[];
    public float HI_SOT[];
    public float HI_SPLG[];
    public float HI_SQB[];
    public float HI_SQVL[];
    public float HI_SRA[];
    public float HI_SRAD[];
    public float HI_SRCH[];
    public float HI_SRD[];
    public float HI_SRMX[];
    public float HI_SRSD[];
    public float HI_SSF[];
    public float HI_SSFCO2[];
    public float HI_SSFI[];
    public float HI_SSFN2O[];
    public float HI_SSFO2[];
    public float HI_SSIN[];
    public float HI_SSPS[];
    public float HI_SST[];
    public float HI_SSW[];
    public float HI_ST0[];
    public float HI_STD[];
    public float HI_STDA[];
    public float HI_STDK[];
    public float HI_STDL[];
    public float HI_STDN[];
    public float HI_STDO[];
    public float HI_STDOK[];
    public float HI_STDON[];
    public float HI_STDOP[];
    public float HI_STDP[];
    public float HI_STFR[];
    public float HI_STIR[];
    public float HI_STKR[];
    public float HI_STL[];
    public float HI_STLT[];
    public float HI_STMP[];
    public float HI_STP[];
    public float HI_STV[];
    public float HI_STX[];
    public float HI_STY[];
    public float HI_SULF[];
    public float HI_SUT[];
    public float HI_SW[];
    public float HI_SWB[];
    public float HI_SWBD[];
    public float HI_SWBX[];
    public float HI_SWH[];
    public float HI_SWLT[];
    public float HI_SWP[];
    public float HI_SWST[];
    public float HI_SYB[];
    public float HI_TAGP[];
    public float HI_TAMX[];
    public float HI_TBSC[];
    public float HI_TC[];
    public float HI_TCAV[];
    public float HI_TCAW[];
    public float HI_TCC[];
    public float HI_TCMN[];
    public float HI_TCMX[];
    public float HI_TCN[];
    public float HI_TCPA[];
    public float HI_TCPY[];
    public float HI_TCS[];
    public float HI_TCVF[];
    public float HI_TDM[];
    public float HI_TEI[];
    public float HI_TET[];
    public float HI_TETG[];
    public float HI_TFLG[];
    public float HI_TFTK[];
    public float HI_TFTN[];
    public float HI_TFTP[];
    public float HI_THK[];
    public float HI_THRL[];
    public float HI_THU[];
    public float HI_TILG[];
    public float HI_TIR[];
    public float HI_TKR[];
    public float HI_TLD[];
    public float HI_TLMF[];
    public float HI_TMN[];
    public float HI_TMX[];
    public float HI_TNOR[];
    public float HI_TNYL[];
    public float HI_TOC[];
    public float HI_TOPC[];
    public float HI_TPOR[];
    public float HI_TPSF[];
    public float HI_TQ[];
    public float HI_TQN[];
    public float HI_TQP[];
    public float HI_TQPU[];
    public float HI_TR[];
    public float HI_TRA[];
    public float HI_TRD[];
    public float HI_TRHT[];
    public float HI_TRSD[];
    public float HI_TSFC[];
    public float HI_TSFK[];
    public float HI_TSFN[];
    public float HI_TSLA[];
    public float HI_TSMY[];
    public float HI_TSN[];
    public float HI_TSNO[];
    public float HI_TSPS[];
    public float HI_TSR[];
    public float HI_TSY[];
    public float HI_TVGF[];
    public float HI_TVIR[];
    public float HI_TXMN[];
    public float HI_TXMX[];
    public float HI_TYK[];
    public float HI_TYL1[];
    public float HI_TYL2[];
    public float HI_TYLK[];
    public float HI_TYLN[];
    public float HI_TYLP[];
    public float HI_TYN[];
    public float HI_TYON[];
    public float HI_TYP[];
    public float HI_TYTP[];
    public float HI_TYW[];
    public float HI_U10[];
    public float HI_UB1[];
    public float HI_UK[];
    public float HI_UK1[];
    public float HI_UN[];
    public float HI_UN1[];
    public float HI_UNA[];
    public float HI_UOB[];
    public float HI_UP[];
    public float HI_UP1[];
    public float HI_UPSX[];
    public float HI_URBF[];
    public float HI_USL[];
    public float HI_UW[];
    public float HI_VAC[];
    public float HI_VALF1[];
    public float HI_VAP[];
    public float HI_VAR[];
    public float HI_VARC[];
    public float HI_VARH[];
    public float HI_VARP[];
    public float HI_VARW[];
    public float HI_VCHA[];
    public float HI_VCHB[];
    public float HI_VCO2[];
    public float HI_VFC[];
    public float HI_VFPA[];
    public float HI_VFPB[];
    public float HI_VIMX[];
    public float HI_VIR[];
    public float HI_VIRR[];
    public float HI_VIRT[];
    public float HI_VLG[];
    public float HI_VLGB[];
    public float HI_VLGI[];
    public float HI_VLGM[];
    public float HI_VLGN[];
    public float HI_VN2O[];
    public float HI_VNO3[];
    public float HI_VO2[];
    public float HI_VPD2[];
    public float HI_VPTH[];
    public float HI_VPU[];
    public float HI_VQ[];
    public float HI_VRSE[];
    public float HI_VSK[];
    public float HI_VSLT[];
    public float HI_VURN[];
    public float HI_VWC[];
    public float HI_VWP[];
    public float HI_VY[];
    public float HI_WA[];
    public float HI_WAC2[];
    public float HI_WAVP[];
    public float HI_WBMC[];
    public float HI_WBMN[];
    public float HI_WCHT[];
    public float HI_WCMU[];
    public float HI_WCO2G[];
    public float HI_WCO2L[];
    public float HI_WCOU[];
    public float HI_WCY[];
    public float HI_WDRM[];
    public float HI_WFA[];
    public float HI_WHPC[];
    public float HI_WHPN[];
    public float HI_WHSC[];
    public float HI_WHSN[];
    public float HI_WK[];
    public float HI_WKMU[];
    public float HI_WLM[];
    public float HI_WLMC[];
    public float HI_WLMN[];
    public float HI_WLS[];
    public float HI_WLSC[];
    public float HI_WLSL[];
    public float HI_WLSLC[];
    public float HI_WLSLNC[];
    public float HI_WLSN[];
    public float HI_WLV[];
    public float HI_WN2O[];
    public float HI_WN2OG[];
    public float HI_WN2OL[];
    public float HI_WNH3[];
    public float HI_WNMU[];
    public float HI_WNO2[];
    public float HI_WNO3[];
    public float HI_WNOU[];
    public float HI_WO2G[];
    public float HI_WO2L[];
    public float HI_WOC[];
    public float HI_WON[];
    public float HI_WPMA[];
    public float HI_WPML[];
    public float HI_WPMS[];
    public float HI_WPMU[];
    public float HI_WPO[];
    public float HI_WPOU[];
    public float HI_WS[];
    public float HI_WSA[];
    public float HI_WSLT[];
    public float HI_WSX[];
    public float HI_WSYF[];
    public float HI_WT[];
    public float HI_WTBL[];
    public float HI_WTMB[];
    public float HI_WTMN[];
    public float HI_WTMU[];
    public float HI_WTMX[];
    public float HI_WXYF[];
    public float HI_WYLD[];
    public float HI_XCT[];
    public float HI_XDLA0[];
    public float HI_XDLAI[];
    public float HI_XHSM[];
    public float HI_XIDK[];
    public float HI_XIDS[];
    public float HI_XLAI[];
    public float HI_XMAP[];
    public float HI_XMS[];
    public float HI_XMTU[];
    public float HI_XN2O[];
    public float HI_XNS[];
    public float HI_XRFI[];
    public float HI_XZP[];
    public float HI_YC[];
    public float HI_YCOU[];
    public float HI_YCT[];
    public float HI_YCWN[];
    public float HI_YHY[];
    public float HI_YLC[];
    public float HI_YLD[];
    public float HI_YLD1[];
    public float HI_YLD2[];
    public float HI_YLKF[];
    public float HI_YLNF[];
    public float HI_YLPF[];
    public float HI_YLS[];
    public float HI_YLX[];
    public float HI_YMNU[];
    public float HI_YN[];
    public float HI_YNOU[];
    public float HI_YNWN[];
    public float HI_YP[];
    public float HI_YPOU[];
    public float HI_YPST[];
    public float HI_YPWN[];
    public float HI_YSD[];
    public float HI_YTN[];
    public float HI_YTX[];
    public float HI_YW[];
    public float HI_Z[];
    public float HI_ZBMC[];
    public float HI_ZBMN[];
    public float HI_ZC[];
    public float HI_ZCO[];
    public float HI_ZCOB[];
    public float HI_ZEK[];
    public float HI_ZFK[];
    public float HI_ZFOP[];
    public float HI_ZHPC[];
    public float HI_ZHPN[];
    public float HI_ZHSC[];
    public float HI_ZHSN[];
    public float HI_ZLM[];
    public float HI_ZLMC[];
    public float HI_ZLMN[];
    public float HI_ZLS[];
    public float HI_ZLSC[];
    public float HI_ZLSL[];
    public float HI_ZLSLC[];
    public float HI_ZLSLNC[];
    public float HI_ZLSN[];
    public float HI_ZNMA[];
    public float HI_ZNMN[];
    public float HI_ZNMU[];
    public float HI_ZNOA[];
    public float HI_ZNOS[];
    public float HI_ZNOU[];
    public float HI_ZOC[];
    public float HI_ZON[];
    public float HI_ZPMA[];
    public float HI_ZPML[];
    public float HI_ZPMS[];
    public float HI_ZPMU[];
    public float HI_ZPO[];
    public float HI_ZPOU[];
    public float HI_ZSK[];
    public float HI_ZSLT[];
    public float HI_ZTP[];
    
    //Missing added by IL 26/11/2018
    public float HI_HSG;
    public float HI_RTN1;
    public float HI_ZTK;
    public float HI_XLOG;
    public float HI_APM;
    public float HI_BCHL,HI_BCHS;
    public float HI_CHD,HI_UPN;
    public float HI_SAT1,HI_FPS1,HI_CO2X,HI_CQNX,HI_RFNX;
    public float HI_FMX,HI_SFLG;
    public float HI_YWI,HI_BTA,HI_QG,HI_QCF,HI_CHS0,HI_BWD;
    
    public int HI_FI,HI_IWND,HI_IRFT,HI_ISOL,HI_IGMX,HI_IAZM,HI_IMO;
 

    public float HI_NVCN0,HI_INFL0,HI_IMW0,HI_CO20,HI_CQN0,HI_FCW,HI_FPS0,HI_GWS0;
    public float HI_RFT0,HI_RFP0,HI_SAT0,HI_FL0,HI_FW0,HI_ANG0,HI_DRV;
    public float HI_DIAM,HI_GZL0,HI_RTN0,HI_PCO0,HI_RCC0,HI_RFN0;
    
    public SafeApexApexCommun (SafeApexPlotSettings plotSettings) {
	  
    	
        // INIT APEX DIMENSIONS
    	HI_MPS = 60;	// MPS = MAX # PESTICIDES
    	HI_MRO = 45;	// MRO = MAX # YRS CROP ROTATION
    	HI_MNT = 300;	// MNT = MAX # TILLAGE OPERATIONS
    	HI_MNC = 200;	// MNC = MAX # CROPS USED
    	HI_MHD = 10;	// MHD = MAX # ANIMAL HERDS
    	HI_MBS = 4;		// MBS = MAX # BUY/SELL LIVESTOCK TRANSACTIONS
    	HI_MFT = 60;	// MFT = MAX # FERTILIZER
    	HI_MPO = 5;		// MPO = MAX # POINT SOURCES
    	HI_MHP = 720;	// MHP = MAX# HYDROGRAPH POINTS
    	HI_MHX = 3;		// MHX = MAX# DAYS FOR STORM HYDROGRAPH BASE
    	HI_MSA = 1;  	// MSA = MAX# SUBAREAS0


    	//FROM ALLOCATE_PARMS CODE
    	HI_MSL=12;
    	HI_MSO=49;       
    	HI_NSM=155; 
    	HI_MSC=31;                                                                                                                                                          
    	HI_NSH=35; 
    	HI_ML1=HI_MSL+1;                                                                           
    	HI_MHY=HI_MSA*4;                                                                      
    	HI_NBMX=Math.max(HI_NBMX,HI_MHY); 
        
        //FROM MICHAEL 
    	HI_MOW = 1;
    	HI_NPD = 24;
        
        
    	HI_KDT1 = new int[800];
    	HI_KDC1 = new int[1500];
    	HI_KDF1 = new int[1200];
    	HI_KDP1 = new int[1000] ;
    	HI_KA = new int[100] ;
    	HI_NXP = new int[90] ;
    	HI_KR = new int[60] ;
    	HI_KDT2 = new int[50] ;
    	HI_KD = new int[40] ;
    	HI_KY = new int[40] ;
    	HI_KDP = new int[50] ;
    	HI_NHC = new int[26] ;
    	HI_KS = new int[20] ;
    	HI_NWDR = new int[16] ;
    	HI_IX = new int[13] ;
    	HI_NC = new int[13] ;
    	HI_IDG = new int[12] ;
    	HI_IX0 = new int[12] ;
    	HI_IAD = new int[10] ;
    	HI_ICMO = new int[10] ;
    	HI_NWPD = new int[10] ;
    	HI_NDC = new int[11] ;
    	HI_JX = new int[7] ;
    	HI_KGN = new int[5] ;
    	HI_JC = new int[4] ;
	    
//replace allocate int
    	
    	HI_IAC = new int [1];
    	
    	HI_IAMF = new int [1];
    	HI_IAPL = new int [1];
    	HI_IAUF = new int [1];
    	HI_IAUI = new int [1];
    	HI_IAUL = new int [1];
    	HI_IBSA = new int [1];

    	HI_ICDT = new int [4];
    	HI_ICUS = new int [300];
    	HI_IDC = new int [200];
    	HI_IDF0 = new int [6*1];
    	HI_IDFA = new int [10*1];
    	HI_IDFD = new int [10*1];
    	HI_IDFH = new int [1];
    	HI_IDFT = new int [6*1];
    	HI_IDMU = new int [10*1];
    	
    	HI_IDN1T = new int [4];
    	HI_IDN2T = new int [4];
    	HI_IDNB = new int [4];
    	HI_IDNF = new int [1];
    	HI_IDOA = new int [1];
    	HI_IDON = new int [1];
    	HI_IDOT = new int [4];
    	HI_IDOW = new int [1*1];
    	HI_IDR = new int [1];
    	HI_IDRL = new int [1];
    	HI_IDRO = new int [4];
    	HI_IDS = new int [1];
    	HI_IDSL = new int [1*1];
    	HI_IDSS = new int [1*1];
    
    	HI_IEXT = new int [1];
    	HI_IFA = new int [1];
    	HI_IFD = new int [1];
    	HI_IFED = new int [10*1];
    	HI_IFLO = new int [12*1];
    	HI_IFLS = new int [1];
    	HI_IGO = new int [1];
    	HI_IGZ = new int [1];
    	HI_IGZO = new int [10*1];
    	HI_IGZX = new int [10*1];
    	HI_IHBS = new int [10*1];
    	HI_IHC = new int [300];
    	HI_IHDM = new int [1];
    	HI_IHDT = new int [4*10*1];
    	HI_IHRL = new int [12*1];
    	HI_IHT = new int [300*1];
    	HI_IHU = new int [200*1];
    	HI_IHX = new int [3];
    	HI_IIR = new int [45];
    	HI_ILQF = new int [1];
    	HI_IMW = new int [1];
    	HI_IPMP = new int [1];
    	HI_IPSF = new int [5];
    	HI_IPSO = new int [1];
    	HI_IPST = new int [1];
    	HI_IPTS = new int [1];
    	HI_IRF = new int [1];
    	HI_IRI = new int [1];
    	HI_IRO = new int [1];
    	HI_IRP = new int [1];
    	HI_IRR = new int [1];
    	HI_IRRS = new int [1];
    	HI_ISAL = new int [1];
    	HI_ISAO = new int [1];
    	HI_ISAS = new int [1];
    	HI_ISCP = new int [1];
    	HI_ISG = new int [1];
    	HI_ISPF = new int [1];
    	HI_ITL = new int [45*300*1];
    	HI_IWTH = new int [1];
    	HI_IYH = new int [200*1];
    	HI_IYHO = new int [10*1];
    	HI_JBG = new int [1];
    	HI_JCN = new int [1];
    	HI_JCN0 = new int [1];
    	HI_JCN1 = new int [1];
    	HI_JD = new int [1];
    	HI_JE = new int [200*1];
    	HI_JH = new int [45*300*1];
    	HI_JP = new int [200*1];
    	HI_JPC = new int [60];
    	HI_JPL = new int [200*1];
    	HI_KC = new int [1];
    	HI_KDC = new int [200];
    	HI_KDF = new int [60];
    	HI_KDT = new int [12*200*1];
    	HI_KFL = new int [50];
    	HI_KGO = new int [200*1];
    	HI_KIR = new int [45];
    	HI_KOMP = new int [300*1];
    	HI_KP1 = new int [1];
    	HI_KPC = new int [60];
    	HI_KPSN = new int [5];
    	HI_KT = new int [1];
    	HI_KTF = new int [1];
    	HI_KTMX = new int [1];
    	HI_KTT = new int [1];
    	HI_KW = new int [51];
    	HI_LFT = new int [45*300*1];
    	HI_LGIR = new int [10*1];
    	HI_LID = new int [13*1];
    	HI_LM = new int [1];
    	HI_LORG = new int [12*1];
    	HI_LPC = new int [45*60*1];
    	HI_LRD = new int [1];
    	HI_LT = new int [45*300*1];
    	HI_LUN = new int [1];
    	HI_LUNS = new int [1];
    	HI_LY = new int [45*200*1];
    	HI_LYR = new int [45*300*1];
    	HI_MXSR = new int [1];
    	HI_NBCF = new int [1];
    	HI_NBCT = new int [1];
    	HI_NBE = new int [300];
    	HI_NBFF = new int [1];
    	HI_NBFT = new int [1];
    	HI_NBHS = new int [10*1];
    	HI_NBSA = new int [1];
    	HI_NBSL = new int [1];
    	HI_NBSX = new int [4*10*1];
    	HI_NBT = new int [300];
    	HI_NBW = new int [1];
    	HI_NCOW = new int [10*1];
    	HI_NCP = new int [45*1];
    	HI_NCR = new int [200*1];
    	HI_NDFA = new int [1];
    	HI_NFED = new int [1];
    	HI_NFRT = new int [45*1];
    	HI_NGIX = new int [1*10*1];
    	HI_NGZ = new int [10*1];
    	HI_NGZA = new int [10*1];
    	HI_NHBS = new int [10*1];
    	HI_NHRD = new int [1];
    	HI_NHU = new int [200*1];
    	HI_NHY = new int [4];
    	HI_NII = new int [1];
    	HI_NIR = new int [45];
    	HI_NISA = new int [4];
    	HI_NMW = new int [1];
    	HI_NPC = new int [60];
    	HI_NPSF = new int [1];
    	HI_NPST = new int [45*1];
    	HI_NQRB = new int [4];
    	HI_NRO = new int [1];
    	HI_NSAL = new int [1];
    	HI_NSAO = new int [1];
    	HI_NSAS = new int [1];
    	HI_NTL = new int [45*1];
    	HI_NTP = new int [200];
    	HI_NTX = new int [4];
    	HI_NVCN = new int [1];
    	HI_NWDA = new int [1];
    	HI_NYHO = new int [10*1];
    	HI_NYLN = new int [200*1];
    	
    	
//end replace allocate int
		 
    	HI_XTP= new float[100];
    	HI_XYP= new float[100];
    	HI_PRMT= new float[110];
    	HI_SMYR= new float[21];
    	HI_VARS= new float[20];
    	HI_RNCF= new float[12];
    	HI_TAV= new float[12];
    	HI_TMNF= new float[12];
    	HI_TMXF= new float[12];
    	HI_UAV0= new float[12];
    	HI_UAVM= new float[12];
    	HI_AWXP= new float[10];
    	HI_RFSG= new float[10];
    	HI_SMSO= new float[9];
    	HI_OPV= new float[7];
    	HI_SMSW= new float[6];
    	HI_PSZ= new float[5];
    	HI_PSZX= new float[5];
    	HI_PSZY= new float[5];
    	HI_BUS= new float[4];
    	HI_UNM= new float[12];  //Inserted MB 8.13.19
    	HI_WX= new float[3];
    	HI_XAV= new float[3];
    	HI_XDV= new float[3];
    	HI_XIM= new float[3];
    	HI_XRG= new float[3];
		    
    	HI_SMMR= new float[21*12];
    	HI_SMR= new float[21*12];
    	HI_DIR= new float[12*16];
    	HI_OBMN= new float[10*12];
    	HI_OBMNX= new float[10*12];
    	HI_OBMX= new float[10*12];
    	HI_OBSL= new float[10*12];
    	HI_PCF= new float[10*12];
    	HI_RH= new float[10*12];
    	HI_SDTMN= new float[10*12];
    	HI_SDTMX= new float[10*12];
    	HI_WFT= new float[10*12];
    	HI_WI= new float[10*12];
    	HI_SCRP = new float [30*2];
			

    	HI_CQRB= new float[8*17*4];
    	HI_RST= new float[3*10*12];
    	HI_PRW= new float[2*10*12];
	
//replace allocate float
    	HI_ABD = new float[1];
    	HI_ACET = new float[200*1];
    	HI_ACO2C = new float[31*1];
    	HI_AEP = new float[200];
    	HI_AFLG = new float[1];
    	HI_AFP = new float[31*1];
    	HI_AGPM = new float[1];
    	HI_AJHI = new float[200*1];
    	HI_ALGI = new float[1];
    	HI_ALQ = new float[1];
    	HI_ALS = new float[12*1];
    	HI_ALT = new float[200];
    	HI_AN2OC = new float[31*1];
    	HI_ANA = new float[45*1];
    	HI_AO2C = new float[31*1];
    	HI_ARMN = new float[1];
    	HI_ARMX = new float[1];
    	HI_ARSD = new float[1];
    	HI_ASW = new float[12*1];
    	HI_AWC = new float[200*1];
    	HI_BA1 = new float[1];
    	HI_BA2 = new float[1];
    	HI_BCOF = new float[1];
    	HI_BCV = new float[1];
    	HI_BD = new float[12*1];
    	HI_BDD = new float[12*1];
    	HI_BDM = new float[12*1];
    	HI_BDP = new float[12*1];
    	HI_BFFL = new float[1];
    	HI_BFSN = new float[1];
    	HI_BFT = new float[1];
    	HI_BGWS = new float[1];
    	HI_BIG = new float[1];
    	HI_BIR = new float[1];
    	HI_BK = new float[4*200];
    	HI_BLG = new float[3*200];
    	HI_BN = new float[4*200];
    	HI_BP = new float[4*200];
    	HI_BPT = new float[12*1];
    	HI_BR1 = new float[1];
    	HI_BR2 = new float[1];
    	HI_BRSV = new float[1];
    	HI_BSALA = new float[1];
    	HI_BSNO = new float[1];
    	HI_BTC = new float[1];
    	HI_BTCX = new float[1];
    	HI_BTCZ = new float[1];
    	HI_BTK = new float[1];
    	HI_BTN = new float[1];
    	HI_BTNX = new float[1];
    	HI_BTNZ = new float[1];
    	HI_BTP = new float[1];
    	HI_BTPX = new float[1];
    	HI_BTPZ = new float[1];
    	HI_BV1 = new float[1];
    	HI_BV2 = new float[1];
    	HI_BVIR = new float[1];
    	HI_BWN = new float[3*200];
    	HI_CAC = new float[12*1];
    	HI_CAF = new float[200];
    	HI_CAW = new float[200*1];
    	HI_CBN = new float[12*1];
    	HI_CDG = new float[12*1];
    	HI_CEC = new float[12*1];
    	HI_CFNP = new float[1];
    	HI_CGCO2 = new float[31*1];
    	HI_CGN2O = new float[31*1];
    	HI_CGO2 = new float[31*1];
    	HI_CHL = new float[1];
    	HI_CHN = new float[1];
    	HI_CHS = new float[1];
    	HI_CHXA = new float[1];
    	HI_CHXP = new float[1];
    	HI_CKY = new float[200];
    	HI_CLA = new float[12*1];
    	HI_CLCO2 = new float[31*1];
    	HI_CLG = new float[1];
    	HI_CLN2O = new float[31*1];
    	HI_CLO2 = new float[31*1];
    	HI_CN0 = new float[1];
    	HI_CN2 = new float[1];
    	HI_CND = new float[45*300*1];
    	HI_CNDS = new float[12*1];
    	HI_CNLV = new float[200];
    	HI_CNRT = new float[12*1];
    	HI_CNSC = new float[2*1];
    	HI_CNSX = new float[1];
    	HI_CNY = new float[200];
    	HI_COOP = new float[300];
    	HI_COST = new float[1];
    	HI_COTL = new float[300];
    	HI_COWW = new float[1];
    	HI_CPFH = new float[12*4];
    	HI_CPHT = new float[200*1];
    	HI_CPMX = new float[1];
    	HI_CPRH = new float[12*1];
    	HI_CPRV = new float[12*1];
    	HI_CPVH = new float[4];
    	HI_CPY = new float[200];
    	HI_CST1 = new float[1];
    	HI_CSTF = new float[200*1];
    	HI_CSTS = new float[200];
    	HI_CTSA = new float[100*1];
    	HI_CV = new float[1];
    	HI_CVF = new float[1];
    	HI_CVP = new float[1];
    	HI_CVRS = new float[1];
    	HI_CX = new float[12*1];
    	HI_CYAV = new float[1];
    	HI_CYMX = new float[1];
    	HI_CYSD = new float[1];
    	HI_DALG = new float[1];
    	HI_DCO2GEN = new float[31*1];
    	HI_DDLG = new float[1];
    	HI_DDM = new float[200];
    	HI_DEPC = new float[1];
    	HI_DHN = new float[12*1];
    	HI_DHT = new float[1];
    	HI_DKH = new float[300];
    	HI_DKHL = new float[1];
    	HI_DKI = new float[300];
    	HI_DKIN = new float[1];
    	HI_DLAI = new float[200];
    	HI_DLAP = new float[2*200];
    	HI_DM = new float[200*1];
    	HI_DM1 = new float[200*1];
    	HI_DMF = new float[200*1];
    	HI_DMLA = new float[200];
    	HI_DMLX = new float[200];
    	HI_DN2G = new float[31*1];
    	HI_DN2OG = new float[31*1];
    	HI_DO2CONS = new float[31*1];
    	HI_DPMT = new float[4];
    	HI_DPRC = new float[31*1];
    	HI_DPRN = new float[31*1];
    	HI_DPRO = new float[31*1];
    	HI_DRAV = new float[4];
    	HI_DRT = new float[1];
    	HI_DRWX = new float[31*1];
    	HI_DST0 = new float[1];
    	HI_DUMP = new float[10*1];
    	HI_DWOC = new float[1];
    	HI_EAR = new float[31*1];
    	HI_ECND = new float[12*1];
    	HI_EFI = new float[1];
    	HI_EFM = new float[300];
    	HI_EK = new float[1];
    	HI_EM10 = new float[1];
    	HI_EMX = new float[300];
    	HI_EO5 = new float[30*1];
    	HI_EP = new float[200];
    	HI_EQKE = new float[12*1];
    	HI_EQKS = new float[12*1];
    	HI_ERAV = new float[4];
    	HI_ETG = new float[200*1];
    	HI_EVRS = new float[1];
    	HI_EVRT = new float[1];
    	HI_EXCK = new float[12*1];
    	HI_EXTC = new float[200];
    	HI_FBM = new float[1];
    	HI_FC = new float[31*1];
    	HI_FCMN = new float[1];
    	HI_FCMP = new float[1];
    	HI_FCST = new float[60];
    	HI_FDSF = new float[1];
    	HI_FE26 = new float[12*1];
    	HI_FFC = new float[1];
    	HI_FFED = new float[10*1];
    	HI_FFPQ = new float[1];
    	HI_FGC = new float[1];
    	HI_FGSL = new float[1];
    	HI_FHP = new float[1];
    	HI_FIRG = new float[1];
    	HI_FIRX = new float[45*300*1];
    	HI_FIXK = new float[12*1];
    	HI_FK = new float[60];
    	HI_FLT = new float[200];
    	HI_FN = new float[60];
    	HI_FNMA = new float[60];
    	HI_FNMN = new float[60];
    	HI_FNMX = new float[45*1];
    	HI_FNO = new float[60];
    	HI_FNP = new float[5*1];
    	HI_FOC = new float[60];
    	HI_FOP = new float[12*1];
    	HI_FP = new float[60];
    	HI_FPF = new float[1];
    	HI_FPO = new float[60];
    	HI_FPOP = new float[300];
    	HI_FPSC = new float[1];
    	HI_FRCP = new float[300];
    	HI_FRST = new float[2*200];
    	HI_FRTK = new float[200*1];
    	HI_FRTN = new float[200*1];
    	HI_FRTP = new float[200*1];
    	HI_FSFN = new float[1];
    	HI_FSFP = new float[1];
    	HI_FSLT = new float[60];
    	HI_FTO = new float[200];
    	HI_FULU = new float[300];
    	HI_GCOW = new float[10*1];
    	HI_GMA = new float[1];
    	HI_GMHU = new float[200];
    	HI_GRDD = new float[200];
    	HI_GRDL = new float[1];
    	HI_GRLV = new float[200];
    	HI_GSI = new float[200];
    	HI_GWMX = new float[1];
    	HI_GWPS = new float[60*1];
    	HI_GWSN = new float[1];
    	HI_GWST = new float[1];
    	HI_GZLM = new float[10*1];
    	HI_GZRT = new float[10*1];
    	HI_HA = new float[1];
    	HI_HCL = new float[12*1];
    	HI_HCLD = new float[1];
    	HI_HCLN = new float[1];
    	HI_HE = new float[300];
    	HI_HI = new float[200];
    	HI_HKPC = new float[31*1];
    	HI_HKPN = new float[31*1];
    	HI_HKPO = new float[31*1];
    	HI_HLMN = new float[1];
    	HI_HMO = new float[300];
    	HI_HMX = new float[200];
    	HI_HR0 = new float[1];
    	HI_HSM = new float[1];
    	HI_HU = new float[200*1];
    	HI_HUF = new float[200*1];
    	HI_HUI = new float[200*1];
    	HI_HUSC = new float[45*300*1];
    	HI_HYDV = new float[4];
    	HI_OCPD = new float[1];
    	HI_OMAP = new float[1];
    	HI_ORHI = new float[300];
    	HI_ORSD = new float[1];
    	HI_OSAA = new float[1];
    	HI_OWSA = new float[1];
    	HI_PAW = new float[1];
    	HI_PCOF = new float[1];
    	HI_PCST = new float[60];
    	HI_PCT = new float[5*4];
    	HI_PCTH = new float[5*4];
    	HI_PDAW = new float[1];
    	HI_PDPL = new float[1];
    	HI_PDPL0 = new float[1];
    	HI_PDPLC = new float[1];
    	HI_PDPLX = new float[1];
    	HI_PDSKC = new float[1];
    	HI_PDSW = new float[1];
    	HI_PEC = new float[1];
    	HI_PFOL = new float[60*1];
    	HI_PH = new float[12*1];
    	HI_PHLF = new float[60];
    	HI_PHLS = new float[60];
    	HI_PHU = new float[200*45*1];
    	HI_PHUX = new float[200];
    	HI_PKOC = new float[60];
    	HI_PKRZ = new float[12];
    	HI_PLAX = new float[200];
    	HI_PLCH = new float[60];
    	HI_PM10 = new float[1];
    	HI_PMX = new float[1];
    	HI_PO = new float[12*1];
    	HI_POP = new float[200*45*1];
    	HI_POPX = new float[200];
    	HI_PPCF = new float[2*200];
    	HI_PPL0 = new float[200*1];
    	HI_PPLA = new float[200*45*1];
    	HI_PPLP = new float[2*200];
    	HI_PPX = new float[13*1];
    	HI_PQPS = new float[5];
    	HI_PRAV = new float[4];
    	HI_PRB = new float[4];
    	HI_PRSD = new float[1];
    	HI_PRYF = new float[200];
    	HI_PRYG = new float[200];
    	HI_PSO3 = new float[5];
    	HI_PSOL = new float[60];
    	HI_PSON = new float[5];
    	HI_PSOP = new float[5];
    	HI_PSOQ = new float[5];
    	HI_PSOY = new float[5];
    	HI_PSP = new float[12*1];
    	HI_PSSF = new float[60*12*1];
    	HI_PSSP = new float[5];
    	HI_PST = new float[200];
    	HI_PSTE = new float[45*60*1];
    	HI_PSTF = new float[1];
    	HI_PSTM = new float[1];
    	HI_PSTR = new float[45*60*1];
    	HI_PSTS = new float[1];
    	HI_PSTZ = new float[60*12*1];
    	HI_PSZM = new float[4];
    	HI_PVQ = new float[60*90*4];
    	HI_PVY = new float[60*90*4];
    	HI_PWOF = new float[60];
    	HI_PYPS = new float[5];
    	HI_QC = new float[4];
    	HI_QCAP = new float[1];
    	HI_QDR = new float[4];
    	HI_QDRN = new float[4];
    	HI_QDRP = new float[4];
    	HI_QGA = new float[720];
    	HI_QHY = new float[24*4*3];
    	HI_QIN = new float[12*1];
    	HI_QIR = new float[45*300*1];
    	HI_QN = new float[4];
    	HI_QP = new float[4];
    	HI_QPR = new float[4];
    	HI_QPST = new float[60*4];
    	HI_QPU = new float[4];
    	HI_QRBQ = new float[1];
    	HI_QRF = new float[4];
    	HI_QRFN = new float[4];
    	HI_QRFP = new float[4];
    	HI_QRP = new float[4];
    	HI_QRQB = new float[1];
    	HI_QSF = new float[12*4];
    	HI_QURB = new float[4];
    	HI_QVOL = new float[4];
    	HI_RBMD = new float[200];
    	HI_RCBW = new float[1];
    	HI_RCF = new float[1];
    	HI_RCHC = new float[1];
    	HI_RCHD = new float[1];
    	HI_RCHK = new float[1];
    	HI_RCHL = new float[1];
    	HI_RCHN = new float[1];
    	HI_RCHS = new float[1];
    	HI_RCHX = new float[1];
    	HI_RCSS = new float[1];
    	HI_RCTC = new float[4];
    	HI_RCTW = new float[1];
    	HI_RD = new float[200*1];
    	HI_RDF = new float[200*1];
    	HI_RDMX = new float[200];
    	HI_REG = new float[200*1];
    	HI_REPI = new float[1];
    	HI_RF5 = new float[30*1];
    	HI_RFDT = new float[720];
    	HI_RFPK = new float[1];
    	HI_RFPL = new float[1];
    	HI_RFPS = new float[1];
    	HI_RFPW = new float[1];
    	HI_RFPX = new float[1];
    	HI_RFTT = new float[1];
    	HI_RFV = new float[1];
    	HI_RFV0 = new float[1];
    	HI_RHD = new float[1];
    	HI_RHT = new float[300];
    	HI_RHTT = new float[1];
    	HI_RIN = new float[300];
    	HI_RINT = new float[1];
    	HI_RLAD = new float[200];
    	HI_RLF = new float[1];
    	HI_RMXS = new float[1];
    	HI_RNMN = new float[12*1];
    	HI_ROK = new float[12*1];
    	HI_ROSP = new float[1];
    	HI_RQRB = new float[4];
    	HI_RR = new float[300];
    	HI_RRUF = new float[1];
    	HI_RSAE = new float[1];
    	HI_RSAP = new float[1];
    	HI_RSBD = new float[1];
    	HI_RSD = new float[12*1];
    	HI_RSDM = new float[12*1];
    	HI_RSDP = new float[1];
    	HI_RSEE = new float[1];
    	HI_RSEP = new float[1];
    	HI_RSF = new float[1];
    	HI_RSFN = new float[4];
    	HI_RSHC = new float[1];
    	HI_RSK = new float[1];
    	HI_RSLK = new float[1];
    	HI_RSO3 = new float[1];
    	HI_RSOC = new float[1];
    	HI_RSON = new float[1];
    	HI_RSOP = new float[1];
    	HI_RSPC = new float[31*1];
    	HI_RSPK = new float[1];
    	HI_RSPS = new float[60*4];
    	HI_RSRR = new float[1];
    	HI_RSSA = new float[1];
    	HI_RSSF = new float[4];
    	HI_RSSP = new float[1];
    	HI_RST0 = new float[1];
    	HI_RSTK = new float[45*300*1];
    	HI_RSV = new float[1];
    	HI_RSVB = new float[1];
    	HI_RSVE = new float[1];
    	HI_RSVF = new float[1];
    	HI_RSVP = new float[1];
    	HI_RSYB = new float[1];
    	HI_RSYF = new float[1];
    	HI_RSYN = new float[1];
    	HI_RSYS = new float[1];
    	HI_RVE0 = new float[1];
    	HI_RVP0 = new float[1];
    	HI_RW = new float[200*1];
    	HI_RWPC = new float[2*200];
    	HI_RWSA = new float[4];
    	HI_RWT = new float[12*200*1];
    	HI_RWTZ = new float[31*1];
    	HI_RZ = new float[1];
    	HI_RZSW = new float[1];
    	HI_S15 = new float[31*1];
    	HI_S3 = new float[1];
    	HI_SALA = new float[1];
    	HI_SALB = new float[1];
    	HI_SAMA = new float[1];
    	HI_SAN = new float[12*1];
    	HI_SATC = new float[12*1];
    	HI_SATK = new float[1];
    	HI_SCFS = new float[30*1];
    	HI_SCI = new float[1];
    	HI_SCNX = new float[1];
    	HI_SDVR = new float[1];
    	HI_SDW = new float[200];
    	HI_SET = new float[12*1];
    	HI_SEV = new float[12*1];
    	HI_SFCP = new float[7*200*1];
    	HI_SFMO = new float[7*200*1];
    	HI_SHYD = new float[4];
    	HI_SIL = new float[12*1];
    	HI_SLA0 = new float[200*1];
    	HI_SLAI = new float[200*1];
    	HI_SLF = new float[1];
    	HI_SLT0 = new float[1];
    	HI_SLTX = new float[1];
    	HI_SM = new float[155*1];
    	HI_SMAP = new float[13*60*4];
    	HI_SMAS = new float[1];
    	HI_SMB = new float[12*1];
    	HI_SMEA = new float[31*1];
    	HI_SMEO = new float[1];
    	HI_SMES = new float[31*1];
    	HI_SMFN = new float[1];
    	HI_SMFU = new float[1];
    	HI_SMH = new float[35*4];
    	HI_SMIO = new float[4];
    	HI_SMKS = new float[1];
    	HI_SMLA = new float[1];
    	HI_SMM = new float[155*12*1];
    	HI_SMMC = new float[17*200*12*1];
    	HI_SMMH = new float[35*12*4];
    	HI_SMMP = new float[20*60*13*4];
    	HI_SMMRP = new float[5*60*12];
    	HI_SMMU = new float[1];
    	HI_SMNS = new float[1];
    	HI_SMNU = new float[1];
    	HI_SMPL = new float[1];
    	HI_SMPQ = new float[1];
    	HI_SMPS = new float[1];
    	HI_SMPY = new float[1];
    	HI_SMRF = new float[1];
    	HI_SMRP = new float[5*60*12];
    	HI_SMS = new float[11*13*1];
    	HI_SMSS = new float[1];
    	HI_SMST = new float[1];
    	HI_SMTS = new float[1];
    	HI_SMWS = new float[1];
    	HI_SMX = new float[1];
    	HI_SMY = new float[155*1];
    	HI_SMY1 = new float[1];
    	HI_SMY2 = new float[1];
    	HI_SMYH = new float[35*4];
    	HI_SMYP = new float[13*60*4];
    	HI_SMYRP = new float[5*60];
    	HI_SNO = new float[1];
    	HI_SOIL = new float[17*12*1];
    	HI_SOL = new float[23*12*1];
    	HI_SOLK = new float[31*1];
    	HI_SOLQ = new float[1];
    	HI_SOT = new float[31*1];
    	HI_SPLG = new float[1];
    	HI_SQB = new float[5*4];
    	HI_SQVL = new float[4];
    	HI_SRA = new float[200*1];
    	HI_SRAD = new float[1];
    	HI_SRCH = new float[27*4];
    	HI_SRD = new float[12*1];
    	HI_SRMX = new float[12*1];
    	HI_SRSD = new float[1];
    	HI_SSF = new float[12*4];
    	HI_SSFCO2 = new float[31*1];
    	HI_SSFI = new float[1];
    	HI_SSFN2O = new float[31*1];
    	HI_SSFO2 = new float[31*1];
    	HI_SSIN = new float[1];
    	HI_SSPS = new float[60];
    	HI_SST = new float[4];
    	HI_SSW = new float[1];
    	HI_ST0 = new float[1];
    	HI_STD = new float[200*1];
    	HI_STDA = new float[4*200*1];
    	HI_STDK = new float[200*1];
    	HI_STDL = new float[200*1];
    	HI_STDN = new float[200*1];
    	HI_STDO = new float[1];
    	HI_STDOK = new float[1];
    	HI_STDON = new float[1];
    	HI_STDOP = new float[1];
    	HI_STDP = new float[200*1];
    	HI_STFR = new float[12*1];
    	HI_STIR = new float[300];
    	HI_STKR = new float[1];
    	HI_STL = new float[200*1];
    	HI_STLT = new float[1];
    	HI_STMP = new float[12*1];
    	HI_STP = new float[1];
    	HI_STV = new float[20*12*1];
    	HI_STX = new float[2*200];
    	HI_STY = new float[4];
    	HI_SULF = new float[12*1];
    	HI_SUT = new float[12*1];
    	HI_SW = new float[1];
    	HI_SWB = new float[1];
    	HI_SWBD = new float[1];
    	HI_SWBX = new float[1];
    	HI_SWH = new float[200*1];
    	HI_SWLT = new float[1];
    	HI_SWP = new float[200*1];
    	HI_SWST = new float[12*1];
    	HI_SYB = new float[5*4];
    	HI_TAGP = new float[1];
    	HI_TAMX = new float[12*1];
    	HI_TBSC = new float[200];
    	HI_TC = new float[4];
    	HI_TCAV = new float[4];
    	HI_TCAW = new float[200*1];
    	HI_TCC = new float[1];
    	HI_TCMN = new float[4];
    	HI_TCMX = new float[4];
    	HI_TCN = new float[12*1];
    	HI_TCPA = new float[200];
    	HI_TCPY = new float[200];
    	HI_TCS = new float[1];
    	HI_TCVF = new float[12*1];
    	HI_TDM = new float[200*1];
    	HI_TEI = new float[12*1];
    	HI_TET = new float[12*1];
    	HI_TETG = new float[200*1];
    	HI_TFLG = new float[1];
    	HI_TFTK = new float[200*1];
    	HI_TFTN = new float[200*1];
    	HI_TFTP = new float[200*1];
    	HI_THK = new float[1];
    	HI_THRL = new float[12*1];
    	HI_THU = new float[200*1];
    	HI_TILG = new float[1];
    	HI_TIR = new float[45*300*1];
    	HI_TKR = new float[1];
    	HI_TLD = new float[300];
    	HI_TLMF = new float[1];
    	HI_TMN = new float[1];
    	HI_TMX = new float[1];
    	HI_TNOR = new float[1];
    	HI_TNYL = new float[4];
    	HI_TOC = new float[1];
    	HI_TOPC = new float[200];
    	HI_TPOR = new float[31*1];
    	HI_TPSF = new float[1];
    	HI_TQ = new float[12*1];
    	HI_TQN = new float[12*1];
    	HI_TQP = new float[12*1];
    	HI_TQPU = new float[12*1];
    	HI_TR = new float[12*1];
    	HI_TRA = new float[200*1];
    	HI_TRD = new float[200*1];
    	HI_TRHT = new float[12*1];
    	HI_TRSD = new float[1];
    	HI_TSFC = new float[7*200*1];
    	HI_TSFK = new float[4];
    	HI_TSFN = new float[4];
    	HI_TSLA = new float[1];
    	HI_TSMY = new float[1];
    	HI_TSN = new float[12*1];
    	HI_TSNO = new float[1];
    	HI_TSPS = new float[60*4];
    	HI_TSR = new float[12*1];
    	HI_TSY = new float[12*1];
    	HI_TVGF = new float[1];
    	HI_TVIR = new float[200*1];
    	HI_TXMN = new float[12*1];
    	HI_TXMX = new float[12*1];
    	HI_TYK = new float[1];
    	HI_TYL1 = new float[200*1];
    	HI_TYL2 = new float[200*1];
    	HI_TYLK = new float[200*1];
    	HI_TYLN = new float[200*1];
    	HI_TYLP = new float[200*1];
    	HI_TYN = new float[1];
    	HI_TYON = new float[12*1];
    	HI_TYP = new float[1];
    	HI_TYTP = new float[12*1];
    	HI_TYW = new float[12*1];
    	HI_U10 = new float[1];
    	HI_UB1 = new float[1];
    	HI_UK = new float[12];
    	HI_UK1 = new float[200*1];
    	HI_UN = new float[12];
    	HI_UN1 = new float[200*1];
    	HI_UNA = new float[200*1];
    	HI_UOB = new float[1];
    	HI_UP = new float[12];
    	HI_UP1 = new float[200*1];
    	HI_UPSX = new float[1];
    	HI_URBF = new float[1];
    	HI_USL = new float[1];
    	HI_UW = new float[12];
    	HI_VAC = new float[1];
    	HI_VALF1 = new float[1];
    	HI_VAP = new float[1];
    	HI_VAR = new float[155*1];
    	HI_VARC = new float[17*200*1];
    	HI_VARH = new float[35*4];
    	HI_VARP = new float[12*60*4];
    	HI_VARW = new float[155];
    	HI_VCHA = new float[1];
    	HI_VCHB = new float[1];
    	HI_VCO2 = new float[31*1];
    	HI_VFC = new float[31*1];
    	HI_VFPA = new float[1];
    	HI_VFPB = new float[1];
    	HI_VIMX = new float[1];
    	HI_VIR = new float[200*1];
    	HI_VIRR = new float[45*300*1];
    	HI_VIRT = new float[1];
    	HI_VLG = new float[1];
    	HI_VLGB = new float[1];
    	HI_VLGI = new float[1];
    	HI_VLGM = new float[1];
    	HI_VLGN = new float[1];
    	HI_VN2O = new float[31*1];
    	HI_VNO3 = new float[12*1];
    	HI_VO2 = new float[31*1];
    	HI_VPD2 = new float[200];
    	HI_VPTH = new float[200];
    	HI_VPU = new float[1];
    	HI_VQ = new float[90*4];
    	HI_VRSE = new float[1];
    	HI_VSK = new float[1];
    	HI_VSLT = new float[1];
    	HI_VURN = new float[10*1];
    	HI_VWC = new float[31*1];
    	HI_VWP = new float[31*1];
    	HI_VY = new float[90*4];
    	HI_WA = new float[200];
    	HI_WAC2 = new float[2*200];
    	HI_WAVP = new float[200];
    	HI_WBMC = new float[31*1];
    	HI_WBMN = new float[12*1];
    	HI_WCHT = new float[200*1];
    	HI_WCMU = new float[12*1];
    	HI_WCO2G = new float[31*1];
    	HI_WCO2L = new float[31*1];
    	HI_WCOU = new float[12*1];
    	HI_WCY = new float[200];
    	HI_WDRM = new float[1];
    	HI_WFA = new float[45*300*1];
    	HI_WHPC = new float[12*1];
    	HI_WHPN = new float[12*1];
    	HI_WHSC = new float[12*1];
    	HI_WHSN = new float[12*1];
    	HI_WK = new float[1];
    	HI_WKMU = new float[12*1];
    	HI_WLM = new float[12*1];
    	HI_WLMC = new float[12*1];
    	HI_WLMN = new float[12*1];
    	HI_WLS = new float[12*1];
    	HI_WLSC = new float[12*1];
    	HI_WLSL = new float[12*1];
    	HI_WLSLC = new float[12*1];
    	HI_WLSLNC = new float[12*1];
    	HI_WLSN = new float[12*1];
    	HI_WLV = new float[200*1];
    	HI_WN2O = new float[31*1];
    	HI_WN2OG = new float[31*1];
    	HI_WN2OL = new float[31*1];
    	HI_WNH3 = new float[31*1];
    	HI_WNMU = new float[12*1];
    	HI_WNO2 = new float[31*1];
    	HI_WNO3 = new float[31*1];
    	HI_WNOU = new float[12*1];
    	HI_WO2G = new float[31*1];
    	HI_WO2L = new float[31*1];
    	HI_WOC = new float[12*1];
    	HI_WON = new float[12*1];
    	HI_WPMA = new float[12*1];
    	HI_WPML = new float[31*1];
    	HI_WPMS = new float[12*1];
    	HI_WPMU = new float[12*1];
    	HI_WPO = new float[12*1];
    	HI_WPOU = new float[12*1];
    	HI_WS = new float[1];
    	HI_WSA = new float[1];
    	HI_WSLT = new float[12*1];
    	HI_WSX = new float[1];
    	HI_WSYF = new float[200];
    	HI_WT = new float[12*1];
    	HI_WTBL = new float[1];
    	HI_WTMB = new float[1];
    	HI_WTMN = new float[1];
    	HI_WTMU = new float[1];
    	HI_WTMX = new float[1];
    	HI_WXYF = new float[200];
    	HI_WYLD = new float[4];
    	HI_XCT = new float[1];
    	HI_XDLA0 = new float[200*1];
    	HI_XDLAI = new float[200];
    	HI_XHSM = new float[1];
    	HI_XIDK = new float[1];
    	HI_XIDS = new float[1];
    	HI_XLAI = new float[200*1];
    	HI_XMAP = new float[1];
    	HI_XMS = new float[30*1];
    	HI_XMTU = new float[200];
    	HI_XN2O = new float[31*1];
    	HI_XNS = new float[1];
    	HI_XRFI = new float[1];
    	HI_XZP = new float[13*13*1];
    	HI_YC = new float[4];
    	HI_YCOU = new float[4];
    	HI_YCT = new float[1];
    	HI_YCWN = new float[4];
    	HI_YHY = new float[720*4];
    	HI_YLC = new float[1];
    	HI_YLD = new float[200];
    	HI_YLD1 = new float[200*1];
    	HI_YLD2 = new float[200*1];
    	HI_YLKF = new float[200*1];
    	HI_YLNF = new float[200*1];
    	HI_YLPF = new float[200*1];
    	HI_YLS = new float[1];
    	HI_YLX = new float[200];
    	HI_YMNU = new float[4];
    	HI_YN = new float[4];
    	HI_YNOU = new float[4];
    	HI_YNWN = new float[4];
    	HI_YP = new float[4];
    	HI_YPOU = new float[4];
    	HI_YPST = new float[60*4];
    	HI_YPWN = new float[4];
    	HI_YSD = new float[8*4];
    	HI_YTN = new float[1];
    	HI_YTX = new float[1];
    	HI_YW = new float[4];
    	HI_Z = new float[12*1];
    	HI_ZBMC = new float[1];
    	HI_ZBMN = new float[1];
    	HI_ZC = new float[31*1];
    	HI_ZCO = new float[1];
    	HI_ZCOB = new float[1];
    	HI_ZEK = new float[1];
    	HI_ZFK = new float[1];
    	HI_ZFOP = new float[1];
    	HI_ZHPC = new float[1];
    	HI_ZHPN = new float[1];
    	HI_ZHSC = new float[1];
    	HI_ZHSN = new float[1];
    	HI_ZLM = new float[1];
    	HI_ZLMC = new float[1];
    	HI_ZLMN = new float[1];
    	HI_ZLS = new float[1];
    	HI_ZLSC = new float[1];
    	HI_ZLSL = new float[1];
    	HI_ZLSLC = new float[1];
    	HI_ZLSLNC = new float[1];
    	HI_ZLSN = new float[1];
    	HI_ZNMA = new float[1];
    	HI_ZNMN = new float[1];
    	HI_ZNMU = new float[1];
    	HI_ZNOA = new float[1];
    	HI_ZNOS = new float[1];
    	HI_ZNOU = new float[1];
    	HI_ZOC = new float[1];
    	HI_ZON = new float[1];
    	HI_ZPMA = new float[1];
    	HI_ZPML = new float[1];
    	HI_ZPMS = new float[1];
    	HI_ZPMU = new float[1];
    	HI_ZPO = new float[1];
    	HI_ZPOU = new float[1];
    	HI_ZSK = new float[1];
    	HI_ZSLT = new float[1];
    	HI_ZTP = new float[1];	
//end replace allocate float		  
		      
		      //===================================================
		      //APEX Initialisation with data read in plot setting
		      //===================================================
		      //SUBAREA
    	HI_IOW=plotSettings.IOW;			//OWNER ID 
		//PROBLEM of DEFINITION
    	HI_FI=plotSettings.FI;				//FEEDING AREAS
    	HI_IAPL[0]=plotSettings.IAPL;		//MANURE APPLICATION AREAS
    	HI_NVCN[0]=plotSettings.NVCN;		//CN-CN2 CODE
    	HI_IPTS[0]=plotSettings.IPTS;		//POINT SOURCE NUMBER
    	HI_ISAO[0]=plotSettings.ISAO;		//OUTFLOW RELEASE METHOD
    	HI_LUNS[0]=plotSettings.LUNS;		//LAND USE NUMBER FROM NRCS LAND USE-HYDROLOGIC SOIL GROUP
    	HI_IMW[0]=plotSettings.IMW;		//MIN INTERVAL BETWEEN AUTO MOW
		    	

    	HI_YCT[0]=plotSettings.YLAT;		//LATITUDE(deg)
    	HI_XCT[0]=plotSettings.XLOG;		//LONGITUDE(deg)
    	HI_FL=plotSettings.plotHeight/1000;		//FIELD LENGTH(km)
    	HI_FW=plotSettings.plotWidth/1000;			//FIELD WIDTH(km)
		        
		        //TODO a v�rifier
		        //AZM = plotSettings.slopeAspect;		//AZIMUTH ORIENTATION OF LAND SLOPE (DEGREES CLOCKWISE FROM NORTH)	
		        //ANGL = plotSettings.northOrientation; //CLOCKWISE ANGLE OF FIELD LENGTH FROM NORTH(deg)

		        //INITIAL CONDITIONS
    	HI_SNO[0]=plotSettings.SNO;		//WATER CONTENT OF SNOW COVER(mm)
    	HI_STDO[0]=plotSettings.STDO;		//STANDING DEAD CROP RESIDUE(t/ha)
		        
		        //CATCHMENT CHARACTERISTICS
    	HI_WSA[0]=plotSettings.WSA;		//DRAINAGE AREA(ha)
    	HI_CHL[0]=plotSettings.CHL;		//CHANNEL LENGTH(km)(BLANK IF UNKNOWN)
    	HI_CHD=plotSettings.CHD;			//CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
    	HI_CHS[0]=plotSettings.CHS;		//CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
    	HI_CHN[0]=plotSettings.CHN;		//MANNINGS N FOR CHANNEL(BLANK IF UNKNOWN)
    	HI_STP[0]=plotSettings.STP;		//AVE UPLAND SLOPE(m/m)
    	HI_SPLG[0]=plotSettings.SPLG;		//AVE UPLAND SLOPE LENGTH(m)
    	HI_UPN=plotSettings.UPN;			//MANNINGS N FOR UPLAND(BLANK IF UNKNOWN)
    	HI_FFPQ[0]=plotSettings.FFPQ;		//FRACTION FLOODPLAIN FLOW--PARTITIONS FLOW THRU FILTER STRIPS
    	HI_URBF[0]=plotSettings.URBF;		//URBAN FRACTION OF SUBAREA

		        //CHANNEL GEOMETRY OF ROUTING REACH THRU SUBAREA
    	HI_RCHL[0]=plotSettings.RCHL;		//CHANNEL LENGTH OF ROUTING REACH(km)
    	HI_RCHD[0]=plotSettings.RCHD;		//CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
    	HI_RCBW[0]=plotSettings.RCBW;		//BOTTOM WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
    	HI_RCTW[0]=plotSettings.RCTW;		//TOP WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
    	HI_RCHS[0]=plotSettings.RCHS;		//CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
    	HI_RCHN[0]=plotSettings.RCHN;		//MANNINGS N VALUE OF CHANNEL(BLANK IF UNKNOWN)
    	HI_RCHC[0]=plotSettings.RCHC;		//USLE C FOR CHANNEL
    	HI_RCHK[0]=plotSettings.RCHK;		//USLE K FOR CHANNEL
    	HI_RFPW[0]=plotSettings.RFPW;		//FLOODPLAIN WIDTH(m)(BLANK IF UNKNOWN)
    	HI_RFPL[0]=plotSettings.RFPL;		//FLOODPLAIN LENGTH(km)(BLANK IF UNKNOWN)
    	HI_SAT1=plotSettings.SAT1;			//SATURARTED CONDUCTIVITY(GREEN & AMPT) ADJUSTMENT FACTOR(.01_10.)
    	HI_FPS1=plotSettings.FPS1;			//FLOODPLAIN SATURATED CONDUCTIVITY ADJUSTMENT FACTOR(.0001_10.)
		        
		        //RESERVOIR DATA
    	HI_RSEE[0]=plotSettings.RSEE;		//ELEV AT EMERGENCY SPILLWAY ELEV(m)
    	HI_RSAE[0]=plotSettings.RSAE;		//SURFACE AREA AT EMERGENCY SPILLWAY ELEV(ha)
    	HI_RVE0[0]=plotSettings.RVE0;		//VOLUME AT EMERGENCY SPILLWAY ELEV(mm)
    	HI_RSEP[0]=plotSettings.RSEP;		//ELEV AT PRINCIPAL SPILLWAY ELEV(m)
    	HI_RSAP[0]=plotSettings.RSAP;		//SURFACE AREA AT PRINCIPAL SPILLWAY ELEV(ha)
    	HI_RVP0[0]=plotSettings.RVP0;		//VOLUME AT PRINCIPAL SPILLWAY ELEV(mm)
    	HI_RSV[0]=plotSettings.RSV;		//INITIAL VOLUME(mm)
    	HI_RSRR[0]=plotSettings.RSRR;		//TIME TO RELEASE FLOOD STORAGE(d)
    	HI_RSYS[0]=plotSettings.RSYS;		//INITIAL SEDIMENT CONCENTRATION(ppm)
    	HI_RSYN[0]=plotSettings.RSYN;		//NORMAL SEDIMENT CONC(ppm)
    	HI_RSHC[0]=plotSettings.RSHC;		//BOTTOM HYDRAULIC CONDUCTIVITY(mm/h)
    	HI_RSDP[0]=plotSettings.RSDP;		//TIME REQUIRED TO RETURN TO NORMAL SED CONC AFTER RUNOFF EVENT(d)
    	HI_RSBD[0]=plotSettings.RSBD;		//BULK DENSITY OF SEDIMENT IN RESERVOIR(t/m^3)
    	HI_PCOF[0]=plotSettings.PCOF;		//FRACTION OF SUBAREA CONTROLLED BY PONDS
    	HI_BCOF[0]=plotSettings.BCOF;		//FRACTION OF SUBAREA CONTROLLED BY BUFFERS
    	HI_BFFL[0]=plotSettings.BFFL;		//BUFFER FLOW LENGTH (m)
		        
		        //MANAGEMENT INFORMATION
    	HI_IRR[0]=plotSettings.IRR;		//0 FOR DRYLAND AREAS                                               
    	HI_IRI[0]=plotSettings.IRI;		//N DAY APPLICATION INTERVAL FOR AUTOMATIC IRRIGATION                                            
    	HI_IFA[0]=plotSettings.IFA;		//MIN FERT APPL INTERVAL(BLANK FOR USER SPECIFIED)                                               
    	HI_LM[0]=plotSettings.LM;			//OPTION  APPLIES LIME                                                                                 
    	HI_IFD[0]=plotSettings.IFD;		//OPTION FURROW DIKES                                                                         
    	HI_IDR[0]=plotSettings.IDR;		//OPTION  DRAINAGE  
    	HI_IDF0[0]=plotSettings.IDF0;		//FERT #  
    	HI_IDF0[1]=plotSettings.IDF0;		//FERT # 
    	HI_IDF0[2]=plotSettings.IDF0;		//FERT # 
    	HI_IDF0[3]=plotSettings.IDF0;		//FERT # 
    	HI_IDF0[4]=plotSettings.IDF0;		//FERT # 
    	HI_IDF0[5]=plotSettings.IDF0;		//FERT # 
    	HI_IRRS[0]=plotSettings.IRRS;		//ID OF SA SUPPLYING IRRIGATION WATER FROM A RESERVOIR                                           

    	HI_BIR[0]=plotSettings.BIR;		//IRRIGATION TRIGGER--3 OPTIONS                                                                  
    	HI_EFI[0]=plotSettings.EFI;		//RUNOFF VOL / VOL IRR WATER APPLIED(BLANK IF IRR=0)                                             
    	HI_VIMX[0]=plotSettings.VIMX;		//MAXIMUM ANNUAL IRRIGATION VOLUME ALLOWED FOR EACH CROP (mm)                                    
    	HI_ARMN[0]=plotSettings.ARMN;		//MINIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)                                                 
    	HI_ARMX[0]=plotSettings.ARMX;		//MAXIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)                                                 
    	HI_BFT[0]=plotSettings.BFT;		//AUTO FERTILIZER TRIGGER--2 OPTIONS                                                             
    	HI_FNP[3]=plotSettings.FNP4;		//AUTO FERT FIXED APPLICATION RATE (kg/ha)                                                       
    	HI_FMX=plotSettings.FMX;			//MAXIMUM ANNUAL N FERTILIZER APPLICATION FOR A CROP (kg/ha)                                     
    	HI_DRT[0]=plotSettings.DRT;		//TIME REQUIRED FOR DRAINAGE SYSTEM TO REDUCE PLANT STRESS(d)                                    
    	HI_FDSF[0]=plotSettings.FDSF;		//FURROW DIKE SAFETY FACTOR(0-1.)                                                                
    	HI_PEC[0]=plotSettings.PEC;		//CONSERVATION PRACTICE FACTOR(=0.0 ELIMINATES WATER EROSION)                                    
    	HI_DALG[0]=plotSettings.DALG;		//FRACTION OF SUBAREA CONTROLLED BY LAGOON.                                                      
    	HI_VLGN[0]=plotSettings.VLGN;		//LAGOON VOLUME RATIO--NORMAL / MAXIMUM                                                          
    	HI_COWW[0]=plotSettings.COWW;		//LAGOON INPUT FROM WASH WATER (m3/hd/d)                                                         
    	HI_DDLG[0]=plotSettings.DDLG;		//TIME TO REDUCE LAGOON STORAGE FROM MAX TO NORM (d)                                             
    	HI_SOLQ[0]=plotSettings.SOLQ;		//RATIO LIQUID/TOTAL MANURE PRODUCED.                                                            
    	HI_SFLG=plotSettings.SFLG;			//SAFETY FACTOR FOR LAGOON DESIGN (VLG=VLG0/(1.-SFLG)                                            
    	HI_FNP[1]=plotSettings.FNP2;		//FEEDING AREA STOCK PILE AUTO SOLID MANURE APPL RATE (kg/ha)                                    
    	HI_FNP[4]=plotSettings.FNP5;		//AUTOMATIC MANURE APPLICATION RATE (kg/ha)                                                      
    	HI_FIRG[0]=plotSettings.FIRG;		//FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)    
				//NY=plotSettings.;				//HERD NUMBERS FOR GRAZING AREA
    	HI_XTP[0]=plotSettings.XTP;		//GRAZING LIMIT FOR EACH HERD--MINIMUM PLANT MATERIAL(t/ha) 

		        
		        //SITE
    	HI_YLAT=plotSettings.YLAT;			//LATITUDE(deg)
    	HI_XLOG=plotSettings.XLOG;			//LONGITUDE(deg)
    	HI_ELEV=plotSettings.ELEV;			//ELEVATION OF WATERSHED (m)
    	HI_APM=plotSettings.APM;			//PEAK RATE - EI ADJUSTMENT FACTOR (BLANK IF UNKNOWN)
    	HI_CO2X=plotSettings.CO2X;			//CO2 CONCENTRATION IN ATMOSPHERE (ppm)
    	HI_CQNX=plotSettings.CQNX;			//CONC OF NO3 IN IRRIGATION WATER (ppm)
    	HI_RFNX=plotSettings.RFNX;			//AVE CONC OF N IN RAINFALL (ppm)
    	HI_UPR=plotSettings.UPR;			//MANURE APPL RATE TO SUPPLY P UPTAKE RATE (kg/ha/y)
    	HI_UNR=plotSettings.UNR;			//MANURE APPL RATE TO SUPPLY N UPTAKE RATE (kg/ha/y)                                                                
        if (plotSettings.FIR0<1.E-10)                                                                                   
        	HI_FIRG[0]=1;                                                                                       
        else                                                                                                    
        	HI_FIRG[0]=plotSettings.FIR0;     //FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)                                                                                                                                                          
        HI_BCHL=plotSettings.BCHL;			//SWAT BASIN CHANNEL LENGTH(km) 
        HI_BCHS=plotSettings.BCHS;			//SWAT BASIN CHANNEL SLOPE(m/m)
		        
		        //SOIL
        HI_SALB[0]=plotSettings.SALB;
        HI_HSG=plotSettings.HSG;
        HI_FFC[0]=plotSettings.FFC;
        HI_WTMN[0]=plotSettings.WTMN;
        HI_WTMX[0]=plotSettings.WTMX;
        HI_WTBL[0]=plotSettings.WTBL;
        HI_GWST[0]=plotSettings.GWST;
        HI_GWMX[0]=plotSettings.GWMX;
        HI_RFTT[0]=plotSettings.RFTT;
        HI_RFPK[0]=plotSettings.RFPK;
        HI_TSLA[0]=plotSettings.TSLA;
        HI_XIDS[0]=plotSettings.XIDS;
        HI_RTN1=plotSettings.RTN1;
        HI_XIDK[0]=plotSettings.XIDK;
        HI_ZQT=plotSettings.ZQT;
        HI_ZF=plotSettings.ZF;
        HI_ZTK=plotSettings.ZTK;
        HI_FBM[0]=plotSettings.FBM;
        HI_FHP[0]=plotSettings.FHP;
		    	//XCC=plotSettings.XCC;
    	
    	//LAYERS
    	int nbLayer =(int)plotSettings.TSLA;
    	for (int i=0; i<nbLayer; i++) {
    		HI_Z[i]=plotSettings.Z[i];
    		HI_BD[i]=plotSettings.BD[i];
    		HI_UW[i]=plotSettings.UW[i];
    		HI_FC[i]=plotSettings.FC[i];
    		HI_SAN[i]=plotSettings.SAN[i];
    		HI_SIL[i]=plotSettings.SIL[i];
    		HI_WON[i]=plotSettings.WON[i];
    		HI_PH[i]=plotSettings.PH[i];
    		HI_SMB[i]=plotSettings.SMB[i];
    		HI_WOC[i]=plotSettings.WOC[i];
    		HI_CAC[i]=plotSettings.CAC[i];
    		HI_CEC[i]=plotSettings.CEC[i];
    		HI_ROK[i]=plotSettings.ROK[i];
    		HI_CNDS[i]=plotSettings.CNDS[i];
    		HI_SSF[i]=plotSettings.SSF[i];
    		HI_RSD[i]=plotSettings.RSD[i];
    		HI_BDD[i]=plotSettings.BDD[i];
    		HI_PSP[i]=plotSettings.PSP[i];
    		HI_SATC[i]=plotSettings.SATC[i];
    		HI_HCL[i]=plotSettings.HCL[i];
    		HI_WPO[i]=plotSettings.WPO[i];
    		HI_DHN[i]=plotSettings.DHN[i];
    		HI_ECND[i]=plotSettings.ECND[i];
    		HI_STFR[i]=plotSettings.STFR[i];
    		HI_SWST[i]=plotSettings.SWST[i];
    		HI_CPRV[i]=plotSettings.CPRV[i];
    		HI_CPRH[i]=plotSettings.CPRH[i];
    		HI_WLS[i]=plotSettings.WLS[i];
    		HI_WLM[i]=plotSettings.WLM[i];
    		HI_WLSL[i]=plotSettings.WLSL[i];
    		HI_WLSC[i]=plotSettings.WLSC[i];
    		HI_WLMC[i]=plotSettings.WLMC[i];
    		HI_WLSLC[i]=plotSettings.WLSLC[i];
    		HI_WLSLNC[i]=plotSettings.WLSLNC[i];
    		HI_WBMC[i]=plotSettings.WBMC[i];
    		HI_WHSC[i]=plotSettings.WHSC[i];
    		HI_WHPC[i]=plotSettings.WHPC[i];
    		HI_WLSN[i]=plotSettings.WLSN[i];
    		HI_WLMN[i]=plotSettings.WLMN[i];
    		HI_WBMN[i]=plotSettings.WBMN[i];
    		HI_WHSN[i]=plotSettings.WHSN[i];
    		HI_WHPN[i]=plotSettings.WHPN[i];
    		HI_FE26[i]=plotSettings.FE26[i];
    		HI_SULF[i]=plotSettings.SULF[i];
    		//ASHZ[i]=plotSettings.ASHZ[i];
    		HI_CGO2[i]=plotSettings.CGO2[i];
    		HI_CGCO2[i]=plotSettings.CGCO2[i];
    		HI_CGN2O[i]=plotSettings.CGN2O[i];

    	}
		  	
	}
    
    public SafeApexApexCommun (SafeApexApexCommun origin) {

    	HI_IBD=origin.HI_IBD;
    	HI_IBDT=origin.HI_IBDT;
    	HI_ICDP=origin.HI_ICDP;
    	HI_ICMD=origin.HI_ICMD;
    	HI_ICO2=origin.HI_ICO2;
    	HI_ICP=origin.HI_ICP;
    	HI_IDA=origin.HI_IDA;
    	HI_IDAY=origin.HI_IDAY;
    	HI_IDIR=origin.HI_IDIR;
    	HI_IDN1=origin.HI_IDN1;
    	HI_IDN2=origin.HI_IDN2;
    	HI_IDNT=origin.HI_IDNT;
    	HI_IDO=origin.HI_IDO;
    	HI_IERT=origin.HI_IERT;
    	HI_IET=origin.HI_IET;
    	HI_IGC=origin.HI_IGC;
    	HI_IGN=origin.HI_IGN;
    	HI_IGSD=origin.HI_IGSD;
    	HI_IHD=origin.HI_IHD;
    	HI_IHRD=origin.HI_IHRD;
    	HI_IHV=origin.HI_IHV;
    	HI_IHUS=origin.HI_IHUS;
    	HI_IHY=origin.HI_IHY;
    	HI_III=origin.HI_III;
    	HI_IKAT=origin.HI_IKAT;
    	HI_IMON=origin.HI_IMON;
    	HI_INFL=origin.HI_INFL;
    	HI_INP=origin.HI_INP;
    	HI_IOF=origin.HI_IOF;
    	HI_IOW=origin.HI_IOW;
    	HI_IOX=origin.HI_IOX;
    	HI_IPAT=origin.HI_IPAT;
    	HI_IPC=origin.HI_IPC;
    	HI_IPD=origin.HI_IPD;
    	HI_IPF=origin.HI_IPF;
    	HI_IPL=origin.HI_IPL;
    	HI_IPRK=origin.HI_IPRK;
    	HI_IPY=origin.HI_IPY;
    	HI_IPYI=origin.HI_IPYI;
    	HI_IRGX=origin.HI_IRGX;
    	HI_IRH=origin.HI_IRH;
    	HI_IRUN=origin.HI_IRUN;
    	HI_ISA=origin.HI_ISA;
    	HI_ISAP=origin.HI_ISAP;
    	HI_ISCN=origin.HI_ISCN;
    	HI_ISLF=origin.HI_ISLF;
    	HI_ISL=origin.HI_ISL;
    	HI_ISTA=origin.HI_ISTA;
    	HI_ISW=origin.HI_ISW;
    	HI_IT1=origin.HI_IT1;
    	HI_IT2=origin.HI_IT2;
    	HI_IT3=origin.HI_IT3;
    	HI_ITYP=origin.HI_ITYP;
    	HI_IUN=origin.HI_IUN;
    	HI_IWI=origin.HI_IWI;
    	HI_IWTB=origin.HI_IWTB;
    	HI_IY=origin.HI_IY;
    	HI_IYER=origin.HI_IYER;
    	HI_IYR=origin.HI_IYR;
    	HI_IYR0=origin.HI_IYR0;
    	HI_IYX=origin.HI_IYX;
    	HI_JD0=origin.HI_JD0;
    	HI_JDA=origin.HI_JDA;
    	HI_JDE=origin.HI_JDE;
    	HI_JDHU=origin.HI_JDHU;
    	HI_JJK=origin.HI_JJK;
    	HI_JT1=origin.HI_JT1;
    	HI_JT2=origin.HI_JT2;
    	HI_KDA=origin.HI_KDA;
    	HI_KF=origin.HI_KF;
    	HI_KI=origin.HI_KI;
    	HI_KP=origin.HI_KP;
    	HI_LBP=origin.HI_LBP;
    	HI_KND=origin.HI_KND;
    	HI_LC=origin.HI_LC;
    	HI_LGRZ=origin.HI_LGRZ;
    	HI_LGZ=origin.HI_LGZ;
    	HI_LND=origin.HI_LND;
    	HI_LNS=origin.HI_LNS;
    	HI_LPD=origin.HI_LPD;
    	HI_LPYR=origin.HI_LPYR;
    	HI_LW=origin.HI_LW;
    	HI_MASP=origin.HI_MASP;
    	HI_MBS=origin.HI_MBS;
    	HI_MCA12=origin.HI_MCA12;
    	HI_MFT=origin.HI_MFT;
    	HI_MHD=origin.HI_MHD;
    	HI_MHP=origin.HI_MHP;
    	HI_MHX=origin.HI_MHX;
    	HI_MHY=origin.HI_MHY;
    	HI_ML1=origin.HI_ML1;
    	HI_MNC=origin.HI_MNC;
    	HI_MNT=origin.HI_MNT;
    	HI_MNUL=origin.HI_MNUL;
    	HI_MO=origin.HI_MO;
    	HI_MO1=origin.HI_MO1;
    	HI_MOW=origin.HI_MOW;
    	HI_MPO=origin.HI_MPO;
    	HI_MPS=origin.HI_MPS;
    	HI_MRO=origin.HI_MRO;
    	HI_MSA=origin.HI_MSA;
    	HI_MSC=origin.HI_MSC;
    	HI_MSCP=origin.HI_MSCP;
    	HI_MSL=origin.HI_MSL;
    	HI_MXT=origin.HI_MXT;
    	HI_MXW=origin.HI_MXW;
    	HI_NAQ=origin.HI_NAQ;
    	HI_NBCL=origin.HI_NBCL;
    	HI_NBCX=origin.HI_NBCX;
    	HI_NBDT=origin.HI_NBDT;
    	HI_NBFX=origin.HI_NBFX;
    	HI_NBMX=origin.HI_NBMX;
    	HI_NBON=origin.HI_NBON;
    	HI_NBYR=origin.HI_NBYR;
    	HI_NCMD=origin.HI_NCMD;
    	HI_NCMO=origin.HI_NCMO;
    	HI_ND=origin.HI_ND;
    	HI_NDF=origin.HI_NDF;
    	HI_NDP=origin.HI_NDP;
    	HI_NDRV=origin.HI_NDRV;
    	HI_NDT=origin.HI_NDT;
    	HI_NDVSS=origin.HI_NDVSS;
    	HI_NDWT=origin.HI_NDWT;
    	HI_NEV=origin.HI_NEV;
    	HI_NGN=origin.HI_NGN;
    	HI_NGN0=origin.HI_NGN0;
    	HI_NJC=origin.HI_NJC;
    	HI_NKA=origin.HI_NKA;
    	HI_NKD=origin.HI_NKD;
    	HI_NKS=origin.HI_NKS;
    	HI_NKY=origin.HI_NKY;
    	HI_NOFL=origin.HI_NOFL;
    	HI_NOP=origin.HI_NOP;
    	HI_NPD=origin.HI_NPD;
    	HI_NPRC=origin.HI_NPRC;
    	HI_NPSO=origin.HI_NPSO;
    	HI_NRF=origin.HI_NRF;
    	HI_NSH=origin.HI_NSH;
    	HI_NSM=origin.HI_NSM;
    	HI_MSO=origin.HI_MSO;
    	HI_NSNN=origin.HI_NSNN;
    	HI_NSTP=origin.HI_NSTP;
    	HI_NSX=origin.HI_NSX;
    	HI_NSZ=origin.HI_NSZ;
    	HI_NYD=origin.HI_NYD;
    	HI_NT0=origin.HI_NT0;
    	HI_NT1=origin.HI_NT1;
    	HI_NTV=origin.HI_NTV;
    	HI_NUPC=origin.HI_NUPC;
    	HI_NWP=origin.HI_NWP;
    	HI_NWTH=origin.HI_NWTH;
    
    	HI_ACW=origin.HI_ACW;
    	HI_ADEO=origin.HI_ADEO;
    	HI_ADHY=origin.HI_ADHY;
    	HI_ADRF=origin.HI_ADRF;
    	HI_AEPT=origin.HI_AEPT;
    	HI_AET=origin.HI_AET;
    	HI_AFN=origin.HI_AFN;
    	HI_AGP=origin.HI_AGP;
    	HI_AHSM=origin.HI_AHSM;
    	HI_AJWA=origin.HI_AJWA;
    	HI_ALG=origin.HI_ALG;
    	HI_ALMN=origin.HI_ALMN;
    	HI_ALTC=origin.HI_ALTC;
    	HI_AL5=origin.HI_AL5;
    	HI_AMPX=origin.HI_AMPX;
    	HI_ANG=origin.HI_ANG;
    	HI_AMSR=origin.HI_AMSR;
    	HI_AVT=origin.HI_AVT;
    	HI_BETA=origin.HI_BETA;
    	HI_BRNG=origin.HI_BRNG;
    	HI_BS1=origin.HI_BS1;
    	HI_BS2=origin.HI_BS2;
    	HI_BXCT=origin.HI_BXCT;
    	HI_BYCT=origin.HI_BYCT;
    	HI_CBVT=origin.HI_CBVT;
    	HI_CLF=origin.HI_CLF;
    	HI_CLT=origin.HI_CLT;
    	HI_CMM=origin.HI_CMM;
    	HI_CMS=origin.HI_CMS;
    	HI_CN=origin.HI_CN;
    	HI_CNO3I=origin.HI_CNO3I;
    	HI_COIR=origin.HI_COIR;
    	HI_COL=origin.HI_COL;
    	HI_CON=origin.HI_CON;
    	HI_COP=origin.HI_COP;
    	HI_CO2=origin.HI_CO2;
    	HI_COS1=origin.HI_COS1;
    	HI_CPH0=origin.HI_CPH0;
    	HI_CPV0=origin.HI_CPV0;
    	HI_CPVV=origin.HI_CPVV;
    	HI_CQNI=origin.HI_CQNI;
    	HI_CRLNC=origin.HI_CRLNC;
    	HI_CRUNC=origin.HI_CRUNC;
    	HI_CSFX=origin.HI_CSFX;
    	HI_CSLT=origin.HI_CSLT;
    	HI_D150=origin.HI_D150;
    	HI_DAYL=origin.HI_DAYL;
    	HI_DD=origin.HI_DD;
    	HI_DEMR=origin.HI_DEMR;
    	HI_DMN=origin.HI_DMN;    // Inserted MB 7/24/19
    	HI_DN2O=origin.HI_DN2O;
    	HI_DRSW=origin.HI_DRSW;
    	HI_DRTO=origin.HI_DRTO;
    	HI_DTG=origin.HI_DTG;
    	HI_DTHY=origin.HI_DTHY;
    	HI_DUR=origin.HI_DUR;
    	HI_DURG=origin.HI_DURG;
    	HI_DVOL=origin.HI_DVOL;
    	HI_DZ10=origin.HI_DZ10;
    	HI_DZDN=origin.HI_DZDN;
    	HI_EI=origin.HI_EI;
    	HI_ELEV=origin.HI_ELEV;
    	HI_EO=origin.HI_EO;
    	HI_ERTN=origin.HI_ERTN;
    	HI_ERTO=origin.HI_ERTO;
    	HI_ERTP=origin.HI_ERTP;
    	HI_ES=origin.HI_ES;
    	HI_EXNN=origin.HI_EXNN;
    	HI_EXPK=origin.HI_EXPK;
    	HI_FL=origin.HI_FL;
    	HI_FULP=origin.HI_FULP;
    	HI_FW=origin.HI_FW;
    	HI_GWBX=origin.HI_GWBX;
    	HI_GX=origin.HI_GX;
    	HI_HGX=origin.HI_HGX;
    	HI_HMN=origin.HI_HMN;
    	HI_HRLT=origin.HI_HRLT;
    	HI_HR1=origin.HI_HR1;
    	HI_PB=origin.HI_PB;
    	HI_PI2=origin.HI_PI2;
    	HI_PIT=origin.HI_PIT;
    	HI_PMOEO=origin.HI_PMOEO;
    	HI_PMORF=origin.HI_PMORF;
    	HI_PRFF=origin.HI_PRFF;
    	HI_PSTX=origin.HI_PSTX;
    	HI_QAPY=origin.HI_QAPY;
    	HI_QRB=origin.HI_QRB;
    	HI_QSFN=origin.HI_QSFN;
    	HI_QSFP=origin.HI_QSFP;
    	HI_QTH=origin.HI_QTH;
    	HI_RAMX=origin.HI_RAMX;
    	HI_REP=origin.HI_REP;
    	HI_RFNC=origin.HI_RFNC;
    	HI_RFQN=origin.HI_RFQN;
    	HI_RFRA=origin.HI_RFRA;
    	HI_RGIN=origin.HI_RGIN;
    	HI_RGRF=origin.HI_RGRF;
    	HI_RHCF=origin.HI_RHCF;
    	HI_RHM=origin.HI_RHM;
    	HI_RHP=origin.HI_RHP;
    	HI_RHS=origin.HI_RHS;
    	HI_RM=origin.HI_RM;
    	HI_RMNR=origin.HI_RMNR;
    	HI_RMX0=origin.HI_RMX0;
    	HI_RNO3=origin.HI_RNO3;
    	HI_RRF=origin.HI_RRF;
    	HI_RTP=origin.HI_RTP;
    	HI_RUNT=origin.HI_RUNT;
    	HI_RWO=origin.HI_RWO;
    	HI_SAET=origin.HI_SAET;
    	HI_SALF=origin.HI_SALF;
    	HI_SAT=origin.HI_SAT;
    	HI_SBAL=origin.HI_SBAL;
    	HI_SCN=origin.HI_SCN;
    	HI_SCN2=origin.HI_SCN2;
    	HI_SDEG=origin.HI_SDEG;
    	HI_SDEP=origin.HI_SDEP;
    	HI_SDN=origin.HI_SDN;
    	HI_SDRF=origin.HI_SDRF;
    	HI_SEP=origin.HI_SEP;
    	HI_SGMN=origin.HI_SGMN;
    	HI_SHRL=origin.HI_SHRL;
    	HI_SK=origin.HI_SK;
    	HI_SML=origin.HI_SML;
    	HI_SMNR=origin.HI_SMNR;
    	HI_SMP=origin.HI_SMP;
    	HI_SMSQ=origin.HI_SMSQ;
    	HI_SN2=origin.HI_SN2;
    	HI_SN2O=origin.HI_SN2O;
    	HI_SNIT=origin.HI_SNIT;
    	HI_SN=origin.HI_SN;
    	HI_SNMN=origin.HI_SNMN;
    	HI_SNOF=origin.HI_SNOF;
    	HI_SNPKT=origin.HI_SNPKT;
    	HI_SOFU=origin.HI_SOFU;
    	HI_SP=origin.HI_SP;
    	HI_SPRC=origin.HI_SPRC;
    	HI_SPRF=origin.HI_SPRF;
    	HI_SRPM=origin.HI_SRPM;
    	HI_SSFK=origin.HI_SSFK;
    	HI_SSFN=origin.HI_SSFN;
    	HI_SSST=origin.HI_SSST;
    	HI_STND=origin.HI_STND;
    	HI_SUK=origin.HI_SUK;
    	HI_SUN=origin.HI_SUN;
    	HI_SUP=origin.HI_SUP;
    	HI_SVOL=origin.HI_SVOL;
    	HI_SX=origin.HI_SX;
    	HI_SYMU=origin.HI_SYMU;
    	HI_SYW=origin.HI_SYW;
    	HI_TA=origin.HI_TA;
    	HI_TCF=origin.HI_TCF;       //Inserted MB 7/29/19
    	HI_TCL=origin.HI_TCL;		//Inserted MB 7/29/19
    	HI_TCR=origin.HI_TCR;		//Inserted MB 7/29/19
    	HI_TDEG=origin.HI_TDEG;
    	HI_TDEP=origin.HI_TDEP;
    	HI_TEVP=origin.HI_TEVP;
    	HI_TEV1=origin.HI_TEV1;
    	HI_TFMA=origin.HI_TFMA;
    	HI_TFMN=origin.HI_TFMN;
    	HI_TFNO=origin.HI_TFNO;
    	HI_THW=origin.HI_THW;
    	HI_TLA=origin.HI_TLA;
    	HI_TLF=origin.HI_TLF;		//Inserted MB 7/29/19
    	HI_TMAF=origin.HI_TMAF;
    	HI_TMAP=origin.HI_TMAP;
    	HI_TNC=origin.HI_TNC;		//Inserted MB 7/29/19
    	HI_TNF=origin.HI_TNF;		//Inserted MB 7/29/19
    	HI_TMPD=origin.HI_TMPD;
    	HI_TPRK=origin.HI_TPRK;
    	HI_TPSP=origin.HI_TPSP;
    	HI_TREV=origin.HI_TREV;
    	HI_TRFR=origin.HI_TRFR;
    	HI_TRSP=origin.HI_TRSP;
    	HI_TSAE=origin.HI_TSAE;
    	HI_TSFS=origin.HI_TSFS;
    	HI_TX=origin.HI_TX;
    	HI_TXXM=origin.HI_TXXM;
    	HI_UK2=origin.HI_UK2;
    	HI_UKM=origin.HI_UKM;
    	
    	HI_UNR=origin.HI_UNR;
    	HI_UN2=origin.HI_UN2;
    	HI_UPM=origin.HI_UPM;
    	HI_UPR=origin.HI_UPR;
    	HI_UP2=origin.HI_UP2;
    	HI_USTRT=origin.HI_USTRT;
    	HI_USTT=origin.HI_USTT;
    	HI_USTW=origin.HI_USTW;
    	HI_UX=origin.HI_UX;
    	HI_UXP=origin.HI_UXP;
    	HI_V56=origin.HI_V56;
    	HI_V57=origin.HI_V57;
    	HI_VGF=origin.HI_VGF;
    	HI_VMU=origin.HI_VMU;
    	HI_VPD=origin.HI_VPD;
    	HI_V1=origin.HI_V1;
    	HI_V3=origin.HI_V3;
    	HI_WAGE=origin.HI_WAGE;
    	HI_WB=origin.HI_WB;
    	HI_WCF=origin.HI_WCF;
    	HI_WCYD=origin.HI_WCYD;
    	HI_WDN=origin.HI_WDN;
    	HI_WFX=origin.HI_WFX;
    	HI_WIM=origin.HI_WIM;
    	HI_WIP=origin.HI_WIP;
    	HI_WKA=origin.HI_WKA;
    	HI_WKMNH3=origin.HI_WKMNH3;
    	HI_WKMNO2=origin.HI_WKMNO2;
    	HI_WKMNO3=origin.HI_WKMNO3;
    	HI_WMP=origin.HI_WMP;
    	HI_WNCMAX=origin.HI_WNCMAX;
    	HI_WNCMIN=origin.HI_WNCMIN;
    	HI_WTN=origin.HI_WTN;
    	HI_XCS=origin.HI_XCS;
    	HI_XDA=origin.HI_XDA;
    	HI_XDA1=origin.HI_XDA1;
    	HI_XET=origin.HI_XET;
    	HI_XK1=origin.HI_XK1;
    	HI_XK2=origin.HI_XK2;
    	HI_XKN1=origin.HI_XKN1;
    	HI_XKN3=origin.HI_XKN3;
    	HI_XKN5=origin.HI_XKN5;
    	HI_XKP1=origin.HI_XKP1;
    	HI_XKP2=origin.HI_XKP2;
    	HI_XSA=origin.HI_XSA;
    	HI_XSL=origin.HI_XSL;
    	HI_YCS=origin.HI_YCS;
    	HI_YERO=origin.HI_YERO;
    	HI_YEW=origin.HI_YEW;
    	HI_YEWN=origin.HI_YEWN;
    	HI_YLAT=origin.HI_YLAT;
    	HI_YLAZ=origin.HI_YLAZ;
    	HI_YLN=origin.HI_YLN;
    	HI_YLP=origin.HI_YLP;
    	HI_YMP=origin.HI_YMP;
    	HI_YSL=origin.HI_YSL;
    	HI_YWKS=origin.HI_YWKS;
    	HI_ZF=origin.HI_ZF;
    	HI_ZQT=origin.HI_ZQT;

    	HI_HSG=origin.HI_HSG;
    	HI_RTN1=origin.HI_RTN1;
    	HI_ZTK=origin.HI_ZTK;
    	HI_XLOG=origin.HI_XLOG;
    	HI_APM=origin.HI_APM;
    	HI_BCHL=origin.HI_BCHL;
    	HI_BCHS=origin.HI_BCHS;
    	HI_CHD=origin.HI_CHD;
    	HI_UPN=origin.HI_UPN;
 
    	HI_SAT1=origin.HI_SAT1;
    	HI_FPS1=origin.HI_FPS1;
    	HI_CO2X=origin.HI_CO2X;
    	HI_CQNX=origin.HI_CQNX;
    	HI_RFNX=origin.HI_RFNX;
    	HI_FMX=origin.HI_FMX;
    	HI_SFLG=origin.HI_SFLG;
    	HI_YWI=origin.HI_YWI;
    	HI_BTA=origin.HI_BTA;
    	HI_QG=origin.HI_QG;
    	HI_QCF=origin.HI_QCF;
    	HI_CHS0=origin.HI_CHS0;
    	HI_BWD=origin.HI_BWD;
        
        
    	HI_FI=origin.HI_FI;
    	HI_IWND=origin.HI_IWND;
    	HI_IRFT=origin.HI_IRFT;
    	HI_ISOL=origin.HI_ISOL;
    	HI_IGMX=origin.HI_IGMX;
    	HI_IAZM=origin.HI_IAZM;
    	HI_IMO=origin.HI_IMO;
    	
        HI_NVCN0=origin.HI_NVCN0; 
        HI_INFL0=origin.HI_INFL0; 
        HI_IMW0=origin.HI_IMW0; 
        HI_CO20=origin.HI_CO20; 
        HI_CQN0=origin.HI_CQN0; 
        HI_FCW=origin.HI_FCW; 
        HI_FPS0=origin.HI_FPS0; 
        HI_GWS0=origin.HI_GWS0;
        HI_RFT0=origin.HI_RFT0; 
        HI_RFP0=origin.HI_RFP0; 
        HI_SAT0=origin.HI_SAT0; 
        HI_FL0=origin.HI_FL0; 
        HI_FW0=origin.HI_FW0; 
        HI_ANG0=origin.HI_ANG0; 
        HI_DRV=origin.HI_DRV;
        HI_DIAM=origin.HI_DIAM; 
        HI_GZL0=origin.HI_GZL0; 
        HI_RTN0=origin.HI_RTN0; 
        HI_PCO0=origin.HI_PCO0; 
        HI_RCC0=origin.HI_RCC0; 
        HI_RFN0=origin.HI_RFN0;
    	  
    	  
        
        HI_KDT1 = new int[800];
    	HI_KDC1 = new int[1500];
    	HI_KDF1 = new int[1200];
    	HI_KDP1 = new int[1000] ;
    	HI_KA = new int[100] ;
    	HI_NXP = new int[90] ;
    	HI_KR = new int[60] ;
    	HI_KDT2 = new int[50] ;
    	HI_KD = new int[40] ;
    	HI_KY = new int[40] ;
    	HI_KDP = new int[50] ;
    	HI_NHC = new int[26] ;
    	HI_KS = new int[20] ;
    	HI_NWDR = new int[16] ;
    	HI_IX = new int[13] ;
    	HI_NC = new int[13] ;
    	HI_IDG = new int[12] ;
    	HI_IX0 = new int[12] ;
    	HI_IAD = new int[10] ;
    	HI_ICMO = new int[10] ;
    	HI_NWPD = new int[10] ;
    	HI_NDC = new int[11] ;
    	HI_JX = new int[7] ;
    	HI_KGN = new int[5] ;
    	HI_JC = new int[4] ;
	    
//replace allocate int
    	HI_IAC = new int [1];
    	HI_IAMF = new int [1];
    	HI_IAPL = new int [1];
    	HI_IAUF = new int [1];
    	HI_IAUI = new int [1];
    	HI_IAUL = new int [1];
    	HI_IBSA = new int [1];
    	HI_ICDT = new int [4];
    	HI_ICUS = new int [300];
    	HI_IDC = new int [200];
    	HI_IDF0 = new int [6*1];
    	HI_IDFA = new int [10*1];
    	HI_IDFD = new int [10*1];
    	HI_IDFH = new int [1];
    	HI_IDFT = new int [6*1];
    	HI_IDMU = new int [10*1];
    	HI_IDN1T = new int [4];
    	HI_IDN2T = new int [4];
    	HI_IDNB = new int [4];
    	HI_IDNF = new int [1];
    	HI_IDOA = new int [1];
    	HI_IDON = new int [1];
    	HI_IDOT = new int [4];
    	HI_IDOW = new int [1*1];
    	HI_IDR = new int [1];
    	HI_IDRL = new int [1];
    	HI_IDRO = new int [4];
    	HI_IDS = new int [1];
    	HI_IDSL = new int [1*1];
    	HI_IDSS = new int [1*1];
    	HI_IEXT = new int [1];
    	HI_IFA = new int [1];
    	HI_IFD = new int [1];
    	HI_IFED = new int [10*1];
    	HI_IFLO = new int [12*1];
    	HI_IFLS = new int [1];
    	HI_IGO = new int [1];
    	HI_IGZ = new int [1];
    	HI_IGZO = new int [10*1];
    	HI_IGZX = new int [10*1];
    	HI_IHBS = new int [10*1];
    	HI_IHC = new int [300];
    	HI_IHDM = new int [1];
    	HI_IHDT = new int [4*10*1];
    	HI_IHRL = new int [12*1];
    	HI_IHT = new int [300*1];
    	HI_IHU = new int [200*1];
    	HI_IHX = new int [3];
    	HI_IIR = new int [45];
    	HI_ILQF = new int [1];
    	HI_IMW = new int [1];
    	HI_IPMP = new int [1];
    	HI_IPSF = new int [5];
    	HI_IPSO = new int [1];
    	HI_IPST = new int [1];
    	HI_IPTS = new int [1];
    	HI_IRF = new int [1];
    	HI_IRI = new int [1];
    	HI_IRO = new int [1];
    	HI_IRP = new int [1];
    	HI_IRR = new int [1];
    	HI_IRRS = new int [1];
    	HI_ISAL = new int [1];
    	HI_ISAO = new int [1];
    	HI_ISAS = new int [1];
    	HI_ISCP = new int [1];
    	HI_ISG = new int [1];
    	HI_ISPF = new int [1];
    	HI_ITL = new int [45*300*1];
    	HI_IWTH = new int [1];
    	HI_IYH = new int [200*1];
    	HI_IYHO = new int [10*1];
    	HI_JBG = new int [1];
    	HI_JCN = new int [1];
    	HI_JCN0 = new int [1];
    	HI_JCN1 = new int [1];
    	HI_JD = new int [1];
    	HI_JE = new int [200*1];
    	HI_JH = new int [45*300*1];
    	HI_JP = new int [200*1];
    	HI_JPC = new int [60];
    	HI_JPL = new int [200*1];
    	HI_KC = new int [1];
    	HI_KDC = new int [200];
    	HI_KDF = new int [60];
    	HI_KDT = new int [12*200*1];
    	HI_KFL = new int [50];
    	HI_KGO = new int [200*1];
    	HI_KIR = new int [45];
    	HI_KOMP = new int [300*1];
    	HI_KP1 = new int [1];
    	HI_KPC = new int [60];
    	HI_KPSN = new int [5];
    	HI_KT = new int [1];
    	HI_KTF = new int [1];
    	HI_KTMX = new int [1];
    	HI_KTT = new int [1];
    	HI_KW = new int [51];
    	HI_LFT = new int [45*300*1];
    	HI_LGIR = new int [10*1];
    	HI_LID = new int [13*1];
    	HI_LM = new int [1];
    	HI_LORG = new int [12*1];
    	HI_LPC = new int [45*60*1];
    	HI_LRD = new int [1];
    	HI_LT = new int [45*300*1];
    	HI_LUN = new int [1];
    	HI_LUNS = new int [1];
    	HI_LY = new int [45*200*1];
    	HI_LYR = new int [45*300*1];
    	HI_MXSR = new int [1];
    	HI_NBCF = new int [1];
    	HI_NBCT = new int [1];
    	HI_NBE = new int [300];
    	HI_NBFF = new int [1];
    	HI_NBFT = new int [1];
    	HI_NBHS = new int [10*1];
    	HI_NBSA = new int [1];
    	HI_NBSL = new int [1];
    	HI_NBSX = new int [4*10*1];
    	HI_NBT = new int [300];
    	HI_NBW = new int [1];
    	HI_NCOW = new int [10*1];
    	HI_NCP = new int [45*1];
    	HI_NCR = new int [200*1];
    	HI_NDFA = new int [1];
    	HI_NFED = new int [1];
    	HI_NFRT = new int [45*1];
    	HI_NGIX = new int [1*10*1];
    	HI_NGZ = new int [10*1];
    	HI_NGZA = new int [10*1];
    	HI_NHBS = new int [10*1];
    	HI_NHRD = new int [1];
    	HI_NHU = new int [200*1];
    	HI_NHY = new int [4];
    	HI_NII = new int [1];
    	HI_NIR = new int [45];
    	HI_NISA = new int [4];
    	HI_NMW = new int [1];
    	HI_NPC = new int [60];
    	HI_NPSF = new int [1];
    	HI_NPST = new int [45*1];
    	HI_NQRB = new int [4];
    	HI_NRO = new int [1];
    	HI_NSAL = new int [1];
    	HI_NSAO = new int [1];
    	HI_NSAS = new int [1];
    	HI_NTL = new int [45*1];
    	HI_NTP = new int [200];
    	HI_NTX = new int [4];
    	HI_NVCN = new int [1];
    	HI_NWDA = new int [1];
    	HI_NYHO = new int [10*1];
    	HI_NYLN = new int [200*1];
//end replace allocate int
		  
    	HI_XTP= new float[100];
    	HI_XYP= new float[100];
    	HI_PRMT= new float[110];
    	HI_SMYR= new float[21];
    	HI_VARS= new float[20];
    	HI_RNCF= new float[12];
    	HI_TAV= new float[12];
    	HI_TMNF= new float[12];
    	HI_TMXF= new float[12];
    	HI_UAV0= new float[12];
    	HI_UAVM= new float[12];
    	HI_AWXP= new float[10];
    	HI_RFSG= new float[10];
    	HI_SMSO= new float[9];
    	HI_OPV= new float[7];
    	HI_SMSW= new float[6];
    	HI_PSZ= new float[5];
    	HI_PSZX= new float[5];
    	HI_PSZY= new float[5];
    	HI_BUS= new float[4];
    	HI_WX= new float[3];
    	HI_XAV= new float[3];
    	HI_XDV= new float[3];
    	HI_UNM= new float[12];  //Inserted MB 8.13.19
    	HI_XIM= new float[3];
    	HI_XRG= new float[3];
		    
    	HI_SMMR= new float[21*12];
    	HI_SMR= new float[21*12];
    	HI_DIR= new float[12*16];
    	HI_OBMN= new float[10*12];
    	HI_OBMNX= new float[10*12];
    	HI_OBMX= new float[10*12];
    	HI_OBSL= new float[10*12];
    	HI_PCF= new float[10*12];
    	HI_RH= new float[10*12];
    	HI_SDTMN= new float[10*12];
    	HI_SDTMX= new float[10*12];
    	HI_WFT= new float[10*12];
    	HI_WI= new float[10*12];
    	HI_SCRP = new float [30*2];
			

    	HI_CQRB= new float[8*17*4];
    	HI_RST= new float[3*10*12];
    	HI_PRW= new float[2*10*12];
	
//replace allocate float
    	HI_ABD = new float[1];
    	HI_ACET = new float[200*1];
    	HI_ACO2C = new float[31*1];
    	HI_AEP = new float[200];
    	HI_AFLG = new float[1];
    	HI_AFP = new float[31*1];
    	HI_AGPM = new float[1];
    	HI_AJHI = new float[200*1];
    	HI_ALGI = new float[1];
    	HI_ALQ = new float[1];
    	HI_ALS = new float[12*1];
    	HI_ALT = new float[200];
    	HI_AN2OC = new float[31*1];
    	HI_ANA = new float[45*1];
    	HI_AO2C = new float[31*1];
    	HI_ARMN = new float[1];
    	HI_ARMX = new float[1];
    	HI_ARSD = new float[1];
    	HI_ASW = new float[12*1];
    	HI_AWC = new float[200*1];
    	HI_BA1 = new float[1];
    	HI_BA2 = new float[1];
    	HI_BCOF = new float[1];
    	HI_BCV = new float[1];
    	HI_BD = new float[12*1];
    	HI_BDD = new float[12*1];
    	HI_BDM = new float[12*1];
    	HI_BDP = new float[12*1];
    	HI_BFFL = new float[1];
    	HI_BFSN = new float[1];
    	HI_BFT = new float[1];
    	HI_BGWS = new float[1];
    	HI_BIG = new float[1];
    	HI_BIR = new float[1];
    	HI_BK = new float[4*200];
    	HI_BLG = new float[3*200];
    	HI_BN = new float[4*200];
    	HI_BP = new float[4*200];
    	HI_BPT = new float[12*1];
    	HI_BR1 = new float[1];
    	HI_BR2 = new float[1];
    	HI_BRSV = new float[1];
    	HI_BSALA = new float[1];
    	HI_BSNO = new float[1];
    	HI_BTC = new float[1];
    	HI_BTCX = new float[1];
    	HI_BTCZ = new float[1];
    	HI_BTK = new float[1];
    	HI_BTN = new float[1];
    	HI_BTNX = new float[1];
    	HI_BTNZ = new float[1];
    	HI_BTP = new float[1];
    	HI_BTPX = new float[1];
    	HI_BTPZ = new float[1];
    	HI_BV1 = new float[1];
    	HI_BV2 = new float[1];
    	HI_BVIR = new float[1];
    	HI_BWN = new float[3*200];
    	HI_CAC = new float[12*1];
    	HI_CAF = new float[200];
    	HI_CAW = new float[200*1];
    	HI_CBN = new float[12*1];
    	HI_CDG = new float[12*1];
    	HI_CEC = new float[12*1];
    	HI_CFNP = new float[1];
    	HI_CGCO2 = new float[31*1];
    	HI_CGN2O = new float[31*1];
    	HI_CGO2 = new float[31*1];
    	HI_CHL = new float[1];
    	HI_CHN = new float[1];
    	HI_CHS = new float[1];
    	HI_CHXA = new float[1];
    	HI_CHXP = new float[1];
    	HI_CKY = new float[200];
    	HI_CLA = new float[12*1];
    	HI_CLCO2 = new float[31*1];
    	HI_CLG = new float[1];
    	HI_CLN2O = new float[31*1];
    	HI_CLO2 = new float[31*1];
    	HI_CN0 = new float[1];
    	HI_CN2 = new float[1];
    	HI_CND = new float[45*300*1];
    	HI_CNDS = new float[12*1];
    	HI_CNLV = new float[200];
    	HI_CNRT = new float[12*1];
    	HI_CNSC = new float[2*1];
    	HI_CNSX = new float[1];
    	HI_CNY = new float[200];
    	HI_COOP = new float[300];
    	HI_COST = new float[1];
    	HI_COTL = new float[300];
    	HI_COWW = new float[1];
    	HI_CPFH = new float[12*4];
    	HI_CPHT = new float[200*1];
    	HI_CPMX = new float[1];
    	HI_CPRH = new float[12*1];
    	HI_CPRV = new float[12*1];
    	HI_CPVH = new float[4];
    	HI_CPY = new float[200];
    	HI_CST1 = new float[1];
    	HI_CSTF = new float[200*1];
    	HI_CSTS = new float[200];
    	HI_CTSA = new float[100*1];
    	HI_CV = new float[1];
    	HI_CVF = new float[1];
    	HI_CVP = new float[1];
    	HI_CVRS = new float[1];
    	HI_CX = new float[12*1];
    	HI_CYAV = new float[1];
    	HI_CYMX = new float[1];
    	HI_CYSD = new float[1];
    	HI_DALG = new float[1];
    	HI_DCO2GEN = new float[31*1];
    	HI_DDLG = new float[1];
    	HI_DDM = new float[200];
    	HI_DEPC = new float[1];
    	HI_DHN = new float[12*1];
    	HI_DHT = new float[1];
    	HI_DKH = new float[300];
    	HI_DKHL = new float[1];
    	HI_DKI = new float[300];
    	HI_DKIN = new float[1];
    	HI_DLAI = new float[200];
    	HI_DLAP = new float[2*200];
    	HI_DM = new float[200*1];
    	HI_DM1 = new float[200*1];
    	HI_DMF = new float[200*1];
    	HI_DMLA = new float[200];
    	HI_DMLX = new float[200];
    	HI_DN2G = new float[31*1];
    	HI_DN2OG = new float[31*1];
    	HI_DO2CONS = new float[31*1];
    	HI_DPMT = new float[4];
    	HI_DPRC = new float[31*1];
    	HI_DPRN = new float[31*1];
    	HI_DPRO = new float[31*1];
    	HI_DRAV = new float[4];
    	HI_DRT = new float[1];
    	HI_DRWX = new float[31*1];
    	HI_DST0 = new float[1];
    	HI_DUMP = new float[10*1];
    	HI_DWOC = new float[1];
    	HI_EAR = new float[31*1];
    	HI_ECND = new float[12*1];
    	HI_EFI = new float[1];
    	HI_EFM = new float[300];
    	HI_EK = new float[1];
    	HI_EM10 = new float[1];
    	HI_EMX = new float[300];
    	HI_EO5 = new float[30*1];
    	HI_EP = new float[200];
    	HI_EQKE = new float[12*1];
    	HI_EQKS = new float[12*1];
    	HI_ERAV = new float[4];
    	HI_ETG = new float[200*1];
    	HI_EVRS = new float[1];
    	HI_EVRT = new float[1];
    	HI_EXCK = new float[12*1];
    	HI_EXTC = new float[200];
    	HI_FBM = new float[1];
    	HI_FC = new float[31*1];
    	HI_FCMN = new float[1];
    	HI_FCMP = new float[1];
    	HI_FCST = new float[60];
    	HI_FDSF = new float[1];
    	HI_FE26 = new float[12*1];
    	HI_FFC = new float[1];
    	HI_FFED = new float[10*1];
    	HI_FFPQ = new float[1];
    	HI_FGC = new float[1];
    	HI_FGSL = new float[1];
    	HI_FHP = new float[1];
    	HI_FIRG = new float[1];
    	HI_FIRX = new float[45*300*1];
    	HI_FIXK = new float[12*1];
    	HI_FK = new float[60];
    	HI_FLT = new float[200];
    	HI_FN = new float[60];
    	HI_FNMA = new float[60];
    	HI_FNMN = new float[60];
    	HI_FNMX = new float[45*1];
    	HI_FNO = new float[60];
    	HI_FNP = new float[5*1];
    	HI_FOC = new float[60];
    	HI_FOP = new float[12*1];
    	HI_FP = new float[60];
    	HI_FPF = new float[1];
    	HI_FPO = new float[60];
    	HI_FPOP = new float[300];
    	HI_FPSC = new float[1];
    	HI_FRCP = new float[300];
    	HI_FRST = new float[2*200];
    	HI_FRTK = new float[200*1];
    	HI_FRTN = new float[200*1];
    	HI_FRTP = new float[200*1];
    	HI_FSFN = new float[1];
    	HI_FSFP = new float[1];
    	HI_FSLT = new float[60];
    	HI_FTO = new float[200];
    	HI_FULU = new float[300];
    	HI_GCOW = new float[10*1];
    	HI_GMA = new float[1];
    	HI_GMHU = new float[200];
    	HI_GRDD = new float[200];
    	HI_GRDL = new float[1];
    	HI_GRLV = new float[200];
    	HI_GSI = new float[200];
    	HI_GWMX = new float[1];
    	HI_GWPS = new float[60*1];
    	HI_GWSN = new float[1];
    	HI_GWST = new float[1];
    	HI_GZLM = new float[10*1];
    	HI_GZRT = new float[10*1];
    	HI_HA = new float[1];
    	HI_HCL = new float[12*1];
    	HI_HCLD = new float[1];
    	HI_HCLN = new float[1];
    	HI_HE = new float[300];
    	HI_HI = new float[200];
    	HI_HKPC = new float[31*1];
    	HI_HKPN = new float[31*1];
    	HI_HKPO = new float[31*1];
    	HI_HLMN = new float[1];
    	HI_HMO = new float[300];
    	HI_HMX = new float[200];
    	HI_HR0 = new float[1];
    	HI_HSM = new float[1];
    	HI_HU = new float[200*1];
    	HI_HUF = new float[200*1];
    	HI_HUI = new float[200*1];
    	HI_HUSC = new float[45*300*1];
    	HI_HYDV = new float[4];
    	HI_OCPD = new float[1];
    	HI_OMAP = new float[1];
    	HI_ORHI = new float[300];
    	HI_ORSD = new float[1];
    	HI_OSAA = new float[1];
    	HI_OWSA = new float[1];
    	HI_PAW = new float[1];
    	HI_PCOF = new float[1];
    	HI_PCST = new float[60];
    	HI_PCT = new float[5*4];
    	HI_PCTH = new float[5*4];
    	HI_PDAW = new float[1];
    	HI_PDPL = new float[1];
    	HI_PDPL0 = new float[1];
    	HI_PDPLC = new float[1];
    	HI_PDPLX = new float[1];
    	HI_PDSKC = new float[1];
    	HI_PDSW = new float[1];
    	HI_PEC = new float[1];
    	HI_PFOL = new float[60*1];
    	HI_PH = new float[12*1];
    	HI_PHLF = new float[60];
    	HI_PHLS = new float[60];
    	HI_PHU = new float[200*45*1];
    	HI_PHUX = new float[200];
    	HI_PKOC = new float[60];
    	HI_PKRZ = new float[12];
    	HI_PLAX = new float[200];
    	HI_PLCH = new float[60];
    	HI_PM10 = new float[1];
    	HI_PMX = new float[1];
    	HI_PO = new float[12*1];
    	HI_POP = new float[200*45*1];
    	HI_POPX = new float[200];
    	HI_PPCF = new float[2*200];
    	HI_PPL0 = new float[200*1];
    	HI_PPLA = new float[200*45*1];
    	HI_PPLP = new float[2*200];
    	HI_PPX = new float[13*1];
    	HI_PQPS = new float[5];
    	HI_PRAV = new float[4];
    	HI_PRB = new float[4];
    	HI_PRSD = new float[1];
    	HI_PRYF = new float[200];
    	HI_PRYG = new float[200];
    	HI_PSO3 = new float[5];
    	HI_PSOL = new float[60];
    	HI_PSON = new float[5];
    	HI_PSOP = new float[5];
    	HI_PSOQ = new float[5];
    	HI_PSOY = new float[5];
    	HI_PSP = new float[12*1];
    	HI_PSSF = new float[60*12*1];
    	HI_PSSP = new float[5];
    	HI_PST = new float[200];
    	HI_PSTE = new float[45*60*1];
    	HI_PSTF = new float[1];
    	HI_PSTM = new float[1];
    	HI_PSTR = new float[45*60*1];
    	HI_PSTS = new float[1];
    	HI_PSTZ = new float[60*12*1];
    	HI_PSZM = new float[4];
    	HI_PVQ = new float[60*90*4];
    	HI_PVY = new float[60*90*4];
    	HI_PWOF = new float[60];
    	HI_PYPS = new float[5];
    	HI_QC = new float[4];
    	HI_QCAP = new float[1];
    	HI_QDR = new float[4];
    	HI_QDRN = new float[4];
    	HI_QDRP = new float[4];
    	HI_QGA = new float[720];
    	HI_QHY = new float[24*4*3];
    	HI_QIN = new float[12*1];
    	HI_QIR = new float[45*300*1];
    	HI_QN = new float[4];
    	HI_QP = new float[4];
    	HI_QPR = new float[4];
    	HI_QPST = new float[60*4];
    	HI_QPU = new float[4];
    	HI_QRBQ = new float[1];
    	HI_QRF = new float[4];
    	HI_QRFN = new float[4];
    	HI_QRFP = new float[4];
    	HI_QRP = new float[4];
    	HI_QRQB = new float[1];
    	HI_QSF = new float[12*4];
    	HI_QURB = new float[4];
    	HI_QVOL = new float[4];
    	HI_RBMD = new float[200];
    	HI_RCBW = new float[1];
    	HI_RCF = new float[1];
    	HI_RCHC = new float[1];
    	HI_RCHD = new float[1];
    	HI_RCHK = new float[1];
    	HI_RCHL = new float[1];
    	HI_RCHN = new float[1];
    	HI_RCHS = new float[1];
    	HI_RCHX = new float[1];
    	HI_RCSS = new float[1];
    	HI_RCTC = new float[4];
    	HI_RCTW = new float[1];
    	HI_RD = new float[200*1];
    	HI_RDF = new float[200*1];
    	HI_RDMX = new float[200];
    	HI_REG = new float[200*1];
    	HI_REPI = new float[1];
    	HI_RF5 = new float[30*1];
    	HI_RFDT = new float[720];
    	HI_RFPK = new float[1];
    	HI_RFPL = new float[1];
    	HI_RFPS = new float[1];
    	HI_RFPW = new float[1];
    	HI_RFPX = new float[1];
    	HI_RFTT = new float[1];
    	HI_RFV = new float[1];
    	HI_RFV0 = new float[1];
    	HI_RHD = new float[1];
    	HI_RHT = new float[300];
    	HI_RHTT = new float[1];
    	HI_RIN = new float[300];
    	HI_RINT = new float[1];
    	HI_RLAD = new float[200];
    	HI_RLF = new float[1];
    	HI_RMXS = new float[1];
    	HI_RNMN = new float[12*1];
    	HI_ROK = new float[12*1];
    	HI_ROSP = new float[1];
    	HI_RQRB = new float[4];
    	HI_RR = new float[300];
    	HI_RRUF = new float[1];
    	HI_RSAE = new float[1];
    	HI_RSAP = new float[1];
    	HI_RSBD = new float[1];
    	HI_RSD = new float[12*1];
    	HI_RSDM = new float[12*1];
    	HI_RSDP = new float[1];
    	HI_RSEE = new float[1];
    	HI_RSEP = new float[1];
    	HI_RSF = new float[1];
    	HI_RSFN = new float[4];
    	HI_RSHC = new float[1];
    	HI_RSK = new float[1];
    	HI_RSLK = new float[1];
    	HI_RSO3 = new float[1];
    	HI_RSOC = new float[1];
    	HI_RSON = new float[1];
    	HI_RSOP = new float[1];
    	HI_RSPC = new float[31*1];
    	HI_RSPK = new float[1];
    	HI_RSPS = new float[60*4];
    	HI_RSRR = new float[1];
    	HI_RSSA = new float[1];
    	HI_RSSF = new float[4];
    	HI_RSSP = new float[1];
    	HI_RST0 = new float[1];
    	HI_RSTK = new float[45*300*1];
    	HI_RSV = new float[1];
    	HI_RSVB = new float[1];
    	HI_RSVE = new float[1];
    	HI_RSVF = new float[1];
    	HI_RSVP = new float[1];
    	HI_RSYB = new float[1];
    	HI_RSYF = new float[1];
    	HI_RSYN = new float[1];
    	HI_RSYS = new float[1];
    	HI_RVE0 = new float[1];
    	HI_RVP0 = new float[1];
    	HI_RW = new float[200*1];
    	HI_RWPC = new float[2*200];
    	HI_RWSA = new float[4];
    	HI_RWT = new float[12*200*1];
    	HI_RWTZ = new float[31*1];
    	HI_RZ = new float[1];
    	HI_RZSW = new float[1];
    	HI_S15 = new float[31*1];
    	HI_S3 = new float[1];
    	HI_SALA = new float[1];
    	HI_SALB = new float[1];
    	HI_SAMA = new float[1];
    	HI_SAN = new float[12*1];
    	HI_SATC = new float[12*1];
    	HI_SATK = new float[1];
    	HI_SCFS = new float[30*1];
    	HI_SCI = new float[1];
    	HI_SCNX = new float[1];
    	HI_SDVR = new float[1];
    	HI_SDW = new float[200];
    	HI_SET = new float[12*1];
    	HI_SEV = new float[12*1];
    	HI_SFCP = new float[7*200*1];
    	HI_SFMO = new float[7*200*1];
    	HI_SHYD = new float[4];
    	HI_SIL = new float[12*1];
    	HI_SLA0 = new float[200*1];
    	HI_SLAI = new float[200*1];
    	HI_SLF = new float[1];
    	HI_SLT0 = new float[1];
    	HI_SLTX = new float[1];
    	HI_SM = new float[155*1];
    	HI_SMAP = new float[13*60*4];
    	HI_SMAS = new float[1];
    	HI_SMB = new float[12*1];
    	HI_SMEA = new float[31*1];
    	HI_SMEO = new float[1];
    	HI_SMES = new float[31*1];
    	HI_SMFN = new float[1];
    	HI_SMFU = new float[1];
    	HI_SMH = new float[35*4];
    	HI_SMIO = new float[4];
    	HI_SMKS = new float[1];
    	HI_SMLA = new float[1];
    	HI_SMM = new float[155*12*1];
    	HI_SMMC = new float[17*200*12*1];
    	HI_SMMH = new float[35*12*4];
    	HI_SMMP = new float[20*60*13*4];
    	HI_SMMRP = new float[5*60*12];
    	HI_SMMU = new float[1];
    	HI_SMNS = new float[1];
    	HI_SMNU = new float[1];
    	HI_SMPL = new float[1];
    	HI_SMPQ = new float[1];
    	HI_SMPS = new float[1];
    	HI_SMPY = new float[1];
    	HI_SMRF = new float[1];
    	HI_SMRP = new float[5*60*12];
    	HI_SMS = new float[11*13*1];
    	HI_SMSS = new float[1];
    	HI_SMST = new float[1];
    	HI_SMTS = new float[1];
    	HI_SMWS = new float[1];
    	HI_SMX = new float[1];
    	HI_SMY = new float[155*1];
    	HI_SMY1 = new float[1];
    	HI_SMY2 = new float[1];
    	HI_SMYH = new float[35*4];
    	HI_SMYP = new float[13*60*4];
    	HI_SMYRP = new float[5*60];
    	HI_SNO = new float[1];
    	HI_SOIL = new float[17*12*1];
    	HI_SOL = new float[23*12*1];
    	HI_SOLK = new float[31*1];
    	HI_SOLQ = new float[1];
    	HI_SOT = new float[31*1];
    	HI_SPLG = new float[1];
    	HI_SQB = new float[5*4];
    	HI_SQVL = new float[4];
    	HI_SRA = new float[200*1];
    	HI_SRAD = new float[1];
    	HI_SRCH = new float[27*4];
    	HI_SRD = new float[12*1];
    	HI_SRMX = new float[12*1];
    	HI_SRSD = new float[1];
    	HI_SSF = new float[12*4];
    	HI_SSFCO2 = new float[31*1];
    	HI_SSFI = new float[1];
    	HI_SSFN2O = new float[31*1];
    	HI_SSFO2 = new float[31*1];
    	HI_SSIN = new float[1];
    	HI_SSPS = new float[60];
    	HI_SST = new float[4];
    	HI_SSW = new float[1];
    	HI_ST0 = new float[1];
    	HI_STD = new float[200*1];
    	HI_STDA = new float[4*200*1];
    	HI_STDK = new float[200*1];
    	HI_STDL = new float[200*1];
    	HI_STDN = new float[200*1];
    	HI_STDO = new float[1];
    	HI_STDOK = new float[1];
    	HI_STDON = new float[1];
    	HI_STDOP = new float[1];
    	HI_STDP = new float[200*1];
    	HI_STFR = new float[12*1];
    	HI_STIR = new float[300];
    	HI_STKR = new float[1];
    	HI_STL = new float[200*1];
    	HI_STLT = new float[1];
    	HI_STMP = new float[12*1];
    	HI_STP = new float[1];
    	HI_STV = new float[20*12*1];
    	HI_STX = new float[2*200];
    	HI_STY = new float[4];
    	HI_SULF = new float[12*1];
    	HI_SUT = new float[12*1];
    	HI_SW = new float[1];
    	HI_SWB = new float[1];
    	HI_SWBD = new float[1];
    	HI_SWBX = new float[1];
    	HI_SWH = new float[200*1];
    	HI_SWLT = new float[1];
    	HI_SWP = new float[200*1];
    	HI_SWST = new float[12*1];
    	HI_SYB = new float[5*4];
    	HI_TAGP = new float[1];
    	HI_TAMX = new float[12*1];
    	HI_TBSC = new float[200];
    	HI_TC = new float[4];
    	HI_TCAV = new float[4];
    	HI_TCAW = new float[200*1];
    	HI_TCC = new float[1];
    	HI_TCMN = new float[4];
    	HI_TCMX = new float[4];
    	HI_TCN = new float[12*1];
    	HI_TCPA = new float[200];
    	HI_TCPY = new float[200];
    	HI_TCS = new float[1];
    	HI_TCVF = new float[12*1];
    	HI_TDM = new float[200*1];
    	HI_TEI = new float[12*1];
    	HI_TET = new float[12*1];
    	HI_TETG = new float[200*1];
    	HI_TFLG = new float[1];
    	HI_TFTK = new float[200*1];
    	HI_TFTN = new float[200*1];
    	HI_TFTP = new float[200*1];
    	HI_THK = new float[1];
    	HI_THRL = new float[12*1];
    	HI_THU = new float[200*1];
    	HI_TILG = new float[1];
    	HI_TIR = new float[45*300*1];
    	HI_TKR = new float[1];
    	HI_TLD = new float[300];
    	HI_TLMF = new float[1];
    	HI_TMN = new float[1];
    	HI_TMX = new float[1];
    	HI_TNOR = new float[1];
    	HI_TNYL = new float[4];
    	HI_TOC = new float[1];
    	HI_TOPC = new float[200];
    	HI_TPOR = new float[31*1];
    	HI_TPSF = new float[1];
    	HI_TQ = new float[12*1];
    	HI_TQN = new float[12*1];
    	HI_TQP = new float[12*1];
    	HI_TQPU = new float[12*1];
    	HI_TR = new float[12*1];
    	HI_TRA = new float[200*1];
    	HI_TRD = new float[200*1];
    	HI_TRHT = new float[12*1];
    	HI_TRSD = new float[1];
    	HI_TSFC = new float[7*200*1];
    	HI_TSFK = new float[4];
    	HI_TSFN = new float[4];
    	HI_TSLA = new float[1];
    	HI_TSMY = new float[1];
    	HI_TSN = new float[12*1];
    	HI_TSNO = new float[1];
    	HI_TSPS = new float[60*4];
    	HI_TSR = new float[12*1];
    	HI_TSY = new float[12*1];
    	HI_TVGF = new float[1];
    	HI_TVIR = new float[200*1];
    	HI_TXMN = new float[12*1];
    	HI_TXMX = new float[12*1];
    	HI_TYK = new float[1];
    	HI_TYL1 = new float[200*1];
    	HI_TYL2 = new float[200*1];
    	HI_TYLK = new float[200*1];
    	HI_TYLN = new float[200*1];
    	HI_TYLP = new float[200*1];
    	HI_TYN = new float[1];
    	HI_TYON = new float[12*1];
    	HI_TYP = new float[1];
    	HI_TYTP = new float[12*1];
    	HI_TYW = new float[12*1];
    	HI_U10 = new float[1];
    	HI_UB1 = new float[1];
    	HI_UK = new float[12];
    	HI_UK1 = new float[200*1];
    	HI_UN = new float[12];
    	HI_UN1 = new float[200*1];
    	HI_UNA = new float[200*1];
    	HI_UOB = new float[1];
    	HI_UP = new float[12];
    	HI_UP1 = new float[200*1];
    	HI_UPSX = new float[1];
    	HI_URBF = new float[1];
    	HI_USL = new float[1];
    	HI_UW = new float[12];
    	HI_VAC = new float[1];
    	HI_VALF1 = new float[1];
    	HI_VAP = new float[1];
    	HI_VAR = new float[155*1];
    	HI_VARC = new float[17*200*1];
    	HI_VARH = new float[35*4];
    	HI_VARP = new float[12*60*4];
    	HI_VARW = new float[155];
    	HI_VCHA = new float[1];
    	HI_VCHB = new float[1];
    	HI_VCO2 = new float[31*1];
    	HI_VFC = new float[31*1];
    	HI_VFPA = new float[1];
    	HI_VFPB = new float[1];
    	HI_VIMX = new float[1];
    	HI_VIR = new float[200*1];
    	HI_VIRR = new float[45*300*1];
    	HI_VIRT = new float[1];
    	HI_VLG = new float[1];
    	HI_VLGB = new float[1];
    	HI_VLGI = new float[1];
    	HI_VLGM = new float[1];
    	HI_VLGN = new float[1];
    	HI_VN2O = new float[31*1];
    	HI_VNO3 = new float[12*1];
    	HI_VO2 = new float[31*1];
    	HI_VPD2 = new float[200];
    	HI_VPTH = new float[200];
    	HI_VPU = new float[1];
    	HI_VQ = new float[90*4];
    	HI_VRSE = new float[1];
    	HI_VSK = new float[1];
    	HI_VSLT = new float[1];
    	HI_VURN = new float[10*1];
    	HI_VWC = new float[31*1];
    	HI_VWP = new float[31*1];
    	HI_VY = new float[90*4];
    	HI_WA = new float[200];
    	HI_WAC2 = new float[2*200];
    	HI_WAVP = new float[200];
    	HI_WBMC = new float[31*1];
    	HI_WBMN = new float[12*1];
    	HI_WCHT = new float[200*1];
    	HI_WCMU = new float[12*1];
    	HI_WCO2G = new float[31*1];
    	HI_WCO2L = new float[31*1];
    	HI_WCOU = new float[12*1];
    	HI_WCY = new float[200];
    	HI_WDRM = new float[1];
    	HI_WFA = new float[45*300*1];
    	HI_WHPC = new float[12*1];
    	HI_WHPN = new float[12*1];
    	HI_WHSC = new float[12*1];
    	HI_WHSN = new float[12*1];
    	HI_WK = new float[1];
    	HI_WKMU = new float[12*1];
    	HI_WLM = new float[12*1];
    	HI_WLMC = new float[12*1];
    	HI_WLMN = new float[12*1];
    	HI_WLS = new float[12*1];
    	HI_WLSC = new float[12*1];
    	HI_WLSL = new float[12*1];
    	HI_WLSLC = new float[12*1];
    	HI_WLSLNC = new float[12*1];
    	HI_WLSN = new float[12*1];
    	HI_WLV = new float[200*1];
    	HI_WN2O = new float[31*1];
    	HI_WN2OG = new float[31*1];
    	HI_WN2OL = new float[31*1];
    	HI_WNH3 = new float[31*1];
    	HI_WNMU = new float[12*1];
    	HI_WNO2 = new float[31*1];
    	HI_WNO3 = new float[31*1];
    	HI_WNOU = new float[12*1];
    	HI_WO2G = new float[31*1];
    	HI_WO2L = new float[31*1];
    	HI_WOC = new float[12*1];
    	HI_WON = new float[12*1];
    	HI_WPMA = new float[12*1];
    	HI_WPML = new float[31*1];
    	HI_WPMS = new float[12*1];
    	HI_WPMU = new float[12*1];
    	HI_WPO = new float[12*1];
    	HI_WPOU = new float[12*1];
    	HI_WS = new float[1];
    	HI_WSA = new float[1];
    	HI_WSLT = new float[12*1];
    	HI_WSX = new float[1];
    	HI_WSYF = new float[200];
    	HI_WT = new float[12*1];
    	HI_WTBL = new float[1];
    	HI_WTMB = new float[1];
    	HI_WTMN = new float[1];
    	HI_WTMU = new float[1];
    	HI_WTMX = new float[1];
    	HI_WXYF = new float[200];
    	HI_WYLD = new float[4];
    	HI_XCT = new float[1];
    	HI_XDLA0 = new float[200*1];
    	HI_XDLAI = new float[200];
    	HI_XHSM = new float[1];
    	HI_XIDK = new float[1];
    	HI_XIDS = new float[1];
    	HI_XLAI = new float[200*1];
    	HI_XMAP = new float[1];
    	HI_XMS = new float[30*1];
    	HI_XMTU = new float[200];
    	HI_XN2O = new float[31*1];
    	HI_XNS = new float[1];
    	HI_XRFI = new float[1];
    	HI_XZP = new float[13*13*1];
    	HI_YC = new float[4];
    	HI_YCOU = new float[4];
    	HI_YCT = new float[1];
    	HI_YCWN = new float[4];
    	HI_YHY = new float[720*4];
    	HI_YLC = new float[1];
    	HI_YLD = new float[200];
    	HI_YLD1 = new float[200*1];
    	HI_YLD2 = new float[200*1];
    	HI_YLKF = new float[200*1];
    	HI_YLNF = new float[200*1];
    	HI_YLPF = new float[200*1];
    	HI_YLS = new float[1];
    	HI_YLX = new float[200];
    	HI_YMNU = new float[4];
    	HI_YN = new float[4];
    	HI_YNOU = new float[4];
    	HI_YNWN = new float[4];
    	HI_YP = new float[4];
    	HI_YPOU = new float[4];
    	HI_YPST = new float[60*4];
    	HI_YPWN = new float[4];
    	HI_YSD = new float[8*4];
    	HI_YTN = new float[1];
    	HI_YTX = new float[1];
    	HI_YW = new float[4];
    	HI_Z = new float[12*1];
    	HI_ZBMC = new float[1];
    	HI_ZBMN = new float[1];
    	HI_ZC = new float[31*1];
    	HI_ZCO = new float[1];
    	HI_ZCOB = new float[1];
    	HI_ZEK = new float[1];
    	HI_ZFK = new float[1];
    	HI_ZFOP = new float[1];
    	HI_ZHPC = new float[1];
    	HI_ZHPN = new float[1];
    	HI_ZHSC = new float[1];
    	HI_ZHSN = new float[1];
    	HI_ZLM = new float[1];
    	HI_ZLMC = new float[1];
    	HI_ZLMN = new float[1];
    	HI_ZLS = new float[1];
    	HI_ZLSC = new float[1];
    	HI_ZLSL = new float[1];
    	HI_ZLSLC = new float[1];
    	HI_ZLSLNC = new float[1];
    	HI_ZLSN = new float[1];
    	HI_ZNMA = new float[1];
    	HI_ZNMN = new float[1];
    	HI_ZNMU = new float[1];
    	HI_ZNOA = new float[1];
    	HI_ZNOS = new float[1];
    	HI_ZNOU = new float[1];
    	HI_ZOC = new float[1];
    	HI_ZON = new float[1];
    	HI_ZPMA = new float[1];
    	HI_ZPML = new float[1];
    	HI_ZPMS = new float[1];
    	HI_ZPMU = new float[1];
    	HI_ZPO = new float[1];
    	HI_ZPOU = new float[1];
    	HI_ZSK = new float[1];
    	HI_ZSLT = new float[1];
    	HI_ZTP = new float[1];	
		      
		      System.arraycopy(origin.HI_KDT1,0,this.HI_KDT1,0,800);
		      System.arraycopy(origin.HI_KDC1,0,this.HI_KDC1,0,1500);
		      System.arraycopy(origin.HI_KDF1,0,this.HI_KDF1,0,1200);
		      System.arraycopy(origin.HI_KDP1,0,this.HI_KDP1,0,1000);
		      System.arraycopy(origin.HI_KA,0,this.HI_KA,0,100);
		      System.arraycopy(origin.HI_NXP,0,this.HI_NXP,0,90);
		      System.arraycopy(origin.HI_KR,0,this.HI_KR,0,60);
		      System.arraycopy(origin.HI_KDT2,0,this.HI_KDT2,0,50);
		      System.arraycopy(origin.HI_KD,0,this.HI_KD,0,40);
		      System.arraycopy(origin.HI_KY,0,this.HI_KY,0,40);
		      System.arraycopy(origin.HI_KDP,0,this.HI_KDP,0,50);
		      System.arraycopy(origin.HI_NHC,0,this.HI_NHC,0,26);
		      System.arraycopy(origin.HI_KS,0,this.HI_KS,0,20);
		      System.arraycopy(origin.HI_NWDR,0,this.HI_NWDR,0,16);
		      System.arraycopy(origin.HI_IX,0,this.HI_IX,0,13);
		      System.arraycopy(origin.HI_NC,0,this.HI_NC,0,13);
		      System.arraycopy(origin.HI_IDG,0,this.HI_IDG,0,12);
		      System.arraycopy(origin.HI_IX0,0,this.HI_IX0,0,12);
		      System.arraycopy(origin.HI_IAD,0,this.HI_IAD,0,10);
		      System.arraycopy(origin.HI_ICMO,0,this.HI_ICMO,0,10);
		      System.arraycopy(origin.HI_NWPD,0,this.HI_NWPD,0,10);
		      System.arraycopy(origin.HI_NDC,0,this.HI_NDC,0,11);
		      System.arraycopy(origin.HI_JX,0,this.HI_JX,0,7);
		      System.arraycopy(origin.HI_KGN,0,this.HI_KGN,0,5);
		      System.arraycopy(origin.HI_JC,0,this.HI_JC,0,4);
		      System.arraycopy(origin.HI_IAC,0,this.HI_IAC,0,1);
		      System.arraycopy(origin.HI_IAMF,0,this.HI_IAMF,0,1);
		      System.arraycopy(origin.HI_IAPL,0,this.HI_IAPL,0,1);
		      System.arraycopy(origin.HI_IAUF,0,this.HI_IAUF,0,1);
		      System.arraycopy(origin.HI_IAUI,0,this.HI_IAUI,0,1);
		      System.arraycopy(origin.HI_IAUL,0,this.HI_IAUL,0,1);
		      System.arraycopy(origin.HI_IBSA,0,this.HI_IBSA,0,1);
		      System.arraycopy(origin.HI_ICDT,0,this.HI_ICDT,0,4);
		      System.arraycopy(origin.HI_ICUS,0,this.HI_ICUS,0,300);
		      System.arraycopy(origin.HI_IDC,0,this.HI_IDC,0,200);
		      System.arraycopy(origin.HI_IDF0,0,this.HI_IDF0,0,6*1);
		      System.arraycopy(origin.HI_IDFA,0,this.HI_IDFA,0,10*1);
		      System.arraycopy(origin.HI_IDFD,0,this.HI_IDFD,0,10*1);
		      System.arraycopy(origin.HI_IDFH,0,this.HI_IDFH,0,1);
		      System.arraycopy(origin.HI_IDFT,0,this.HI_IDFT,0,6*1);
		      System.arraycopy(origin.HI_IDMU,0,this.HI_IDMU,0,10*1);
		      System.arraycopy(origin.HI_IDN1T,0,this.HI_IDN1T,0,4);
		      System.arraycopy(origin.HI_IDN2T,0,this.HI_IDN2T,0,4);
		      System.arraycopy(origin.HI_IDNB,0,this.HI_IDNB,0,4);
		      System.arraycopy(origin.HI_IDNF,0,this.HI_IDNF,0,1);
		      System.arraycopy(origin.HI_IDOA,0,this.HI_IDOA,0,1);
		      System.arraycopy(origin.HI_IDON,0,this.HI_IDON,0,1);
		      System.arraycopy(origin.HI_IDOT,0,this.HI_IDOT,0,4);
		      System.arraycopy(origin.HI_IDOW,0,this.HI_IDOW,0,1*1);
		      System.arraycopy(origin.HI_IDR,0,this.HI_IDR,0,1);
		      System.arraycopy(origin.HI_IDRL,0,this.HI_IDRL,0,1);
		      System.arraycopy(origin.HI_IDRO,0,this.HI_IDRO,0,4);
		      System.arraycopy(origin.HI_IDS,0,this.HI_IDS,0,1);
		      System.arraycopy(origin.HI_IDSL,0,this.HI_IDSL,0,1*1);
		      System.arraycopy(origin.HI_IDSS,0,this.HI_IDSS,0,1*1);
		      System.arraycopy(origin.HI_IEXT,0,this.HI_IEXT,0,1);
		      System.arraycopy(origin.HI_IFA,0,this.HI_IFA,0,1);
		      System.arraycopy(origin.HI_IFD,0,this.HI_IFD,0,1);
		      System.arraycopy(origin.HI_IFED,0,this.HI_IFED,0,10*1);
		      System.arraycopy(origin.HI_IFLO,0,this.HI_IFLO,0,12*1);
		      System.arraycopy(origin.HI_IFLS,0,this.HI_IFLS,0,1);
		      System.arraycopy(origin.HI_IGO,0,this.HI_IGO,0,1);
		      System.arraycopy(origin.HI_IGZ,0,this.HI_IGZ,0,1);
		      System.arraycopy(origin.HI_IGZO,0,this.HI_IGZO,0,10*1);
		      System.arraycopy(origin.HI_IGZX,0,this.HI_IGZX,0,10*1);
		      System.arraycopy(origin.HI_IHBS,0,this.HI_IHBS,0,10*1);
		      System.arraycopy(origin.HI_IHC,0,this.HI_IHC,0,300);
		      System.arraycopy(origin.HI_IHDM,0,this.HI_IHDM,0,1);
		      System.arraycopy(origin.HI_IHDT,0,this.HI_IHDT,0,4*10*1);
		      System.arraycopy(origin.HI_IHRL,0,this.HI_IHRL,0,12*1);
		      System.arraycopy(origin.HI_IHT,0,this.HI_IHT,0,300*1);
		      System.arraycopy(origin.HI_IHU,0,this.HI_IHU,0,200*1);
		      System.arraycopy(origin.HI_IHX,0,this.HI_IHX,0,3);
		      System.arraycopy(origin.HI_IIR,0,this.HI_IIR,0,45);
		      System.arraycopy(origin.HI_ILQF,0,this.HI_ILQF,0,1);
		      System.arraycopy(origin.HI_IMW,0,this.HI_IMW,0,1);
		      System.arraycopy(origin.HI_IPMP,0,this.HI_IPMP,0,1);
		      System.arraycopy(origin.HI_IPSF,0,this.HI_IPSF,0,5);
		      System.arraycopy(origin.HI_IPSO,0,this.HI_IPSO,0,1);
		      System.arraycopy(origin.HI_IPST,0,this.HI_IPST,0,1);
		      System.arraycopy(origin.HI_IPTS,0,this.HI_IPTS,0,1);
		      System.arraycopy(origin.HI_IRF,0,this.HI_IRF,0,1);
		      System.arraycopy(origin.HI_IRI,0,this.HI_IRI,0,1);
		      System.arraycopy(origin.HI_IRO,0,this.HI_IRO,0,1);
		      System.arraycopy(origin.HI_IRP,0,this.HI_IRP,0,1);
		      System.arraycopy(origin.HI_IRR,0,this.HI_IRR,0,1);
		      System.arraycopy(origin.HI_IRRS,0,this.HI_IRRS,0,1);
		      System.arraycopy(origin.HI_ISAL,0,this.HI_ISAL,0,1);
		      System.arraycopy(origin.HI_ISAO,0,this.HI_ISAO,0,1);
		      System.arraycopy(origin.HI_ISAS,0,this.HI_ISAS,0,1);
		      System.arraycopy(origin.HI_ISCP,0,this.HI_ISCP,0,1);
		      System.arraycopy(origin.HI_ISG,0,this.HI_ISG,0,1);
		      System.arraycopy(origin.HI_ISPF,0,this.HI_ISPF,0,1);
		      System.arraycopy(origin.HI_ITL,0,this.HI_ITL,0,45*300*1);
		      System.arraycopy(origin.HI_IWTH,0,this.HI_IWTH,0,1);
		      System.arraycopy(origin.HI_IYH,0,this.HI_IYH,0,200*1);
		      System.arraycopy(origin.HI_IYHO,0,this.HI_IYHO,0,10*1);
		      System.arraycopy(origin.HI_JBG,0,this.HI_JBG,0,1);
		      System.arraycopy(origin.HI_JCN,0,this.HI_JCN,0,1);
		      System.arraycopy(origin.HI_JCN0,0,this.HI_JCN0,0,1);
		      System.arraycopy(origin.HI_JCN1,0,this.HI_JCN1,0,1);
		      System.arraycopy(origin.HI_JD,0,this.HI_JD,0,1);
		      System.arraycopy(origin.HI_JE,0,this.HI_JE,0,200*1);
		      System.arraycopy(origin.HI_JH,0,this.HI_JH,0,45*300*1);
		      System.arraycopy(origin.HI_JP,0,this.HI_JP,0,200*1);
		      System.arraycopy(origin.HI_JPC,0,this.HI_JPC,0,60);
		      System.arraycopy(origin.HI_JPL,0,this.HI_JPL,0,200*1);
		      System.arraycopy(origin.HI_KC,0,this.HI_KC,0,1);
		      System.arraycopy(origin.HI_KDC,0,this.HI_KDC,0,200);
		      System.arraycopy(origin.HI_KDF,0,this.HI_KDF,0,60);
		      System.arraycopy(origin.HI_KDT,0,this.HI_KDT,0,12*200*1);
		      System.arraycopy(origin.HI_KFL,0,this.HI_KFL,0,50);
		      System.arraycopy(origin.HI_KGO,0,this.HI_KGO,0,200*1);
		      System.arraycopy(origin.HI_KIR,0,this.HI_KIR,0,45);
		      System.arraycopy(origin.HI_KOMP,0,this.HI_KOMP,0,300*1);
		      System.arraycopy(origin.HI_KP1,0,this.HI_KP1,0,1);
		      System.arraycopy(origin.HI_KPC,0,this.HI_KPC,0,60);
		      System.arraycopy(origin.HI_KPSN,0,this.HI_KPSN,0,5);
		      System.arraycopy(origin.HI_KT,0,this.HI_KT,0,1);
		      System.arraycopy(origin.HI_KTF,0,this.HI_KTF,0,1);
		      System.arraycopy(origin.HI_KTMX,0,this.HI_KTMX,0,1);
		      System.arraycopy(origin.HI_KTT,0,this.HI_KTT,0,1);
		      System.arraycopy(origin.HI_KW,0,this.HI_KW,0,51);
		      System.arraycopy(origin.HI_LFT,0,this.HI_LFT,0,45*300*1);
		      System.arraycopy(origin.HI_LGIR,0,this.HI_LGIR,0,10*1);
		      System.arraycopy(origin.HI_LID,0,this.HI_LID,0,13*1);
		      System.arraycopy(origin.HI_LM,0,this.HI_LM,0,1);
		      System.arraycopy(origin.HI_LORG,0,this.HI_LORG,0,12*1);
		      System.arraycopy(origin.HI_LPC,0,this.HI_LPC,0,45*60*1);
		      System.arraycopy(origin.HI_LRD,0,this.HI_LRD,0,1);
		      System.arraycopy(origin.HI_LT,0,this.HI_LT,0,45*300*1);
		      System.arraycopy(origin.HI_LUN,0,this.HI_LUN,0,1);
		      System.arraycopy(origin.HI_LUNS,0,this.HI_LUNS,0,1);
		      System.arraycopy(origin.HI_LY,0,this.HI_LY,0,45*200*1);
		      System.arraycopy(origin.HI_LYR,0,this.HI_LYR,0,45*300*1);
		      System.arraycopy(origin.HI_MXSR,0,this.HI_MXSR,0,1);
		      System.arraycopy(origin.HI_NBCF,0,this.HI_NBCF,0,1);
		      System.arraycopy(origin.HI_NBCT,0,this.HI_NBCT,0,1);
		      System.arraycopy(origin.HI_NBE,0,this.HI_NBE,0,300);
		      System.arraycopy(origin.HI_NBFF,0,this.HI_NBFF,0,1);
		      System.arraycopy(origin.HI_NBFT,0,this.HI_NBFT,0,1);
		      System.arraycopy(origin.HI_NBHS,0,this.HI_NBHS,0,10*1);
		      System.arraycopy(origin.HI_NBSA,0,this.HI_NBSA,0,1);
		      System.arraycopy(origin.HI_NBSL,0,this.HI_NBSL,0,1);
		      System.arraycopy(origin.HI_NBSX,0,this.HI_NBSX,0,4*10*1);
		      System.arraycopy(origin.HI_NBT,0,this.HI_NBT,0,300);
		      System.arraycopy(origin.HI_NBW,0,this.HI_NBW,0,1);
		      System.arraycopy(origin.HI_NCOW,0,this.HI_NCOW,0,10*1);
		      System.arraycopy(origin.HI_NCP,0,this.HI_NCP,0,45*1);
		      System.arraycopy(origin.HI_NCR,0,this.HI_NCR,0,200*1);
		      System.arraycopy(origin.HI_NDFA,0,this.HI_NDFA,0,1);
		      System.arraycopy(origin.HI_NFED,0,this.HI_NFED,0,1);
		      System.arraycopy(origin.HI_NFRT,0,this.HI_NFRT,0,45*1);
		      System.arraycopy(origin.HI_NGIX,0,this.HI_NGIX,0,1*10*1);
		      System.arraycopy(origin.HI_NGZ,0,this.HI_NGZ,0,10*1);
		      System.arraycopy(origin.HI_NGZA,0,this.HI_NGZA,0,10*1);
		      System.arraycopy(origin.HI_NHBS,0,this.HI_NHBS,0,10*1);
		      System.arraycopy(origin.HI_NHRD,0,this.HI_NHRD,0,1);
		      System.arraycopy(origin.HI_NHU,0,this.HI_NHU,0,200*1);
		      System.arraycopy(origin.HI_NHY,0,this.HI_NHY,0,4);
		      System.arraycopy(origin.HI_NII,0,this.HI_NII,0,1);
		      System.arraycopy(origin.HI_NIR,0,this.HI_NIR,0,45);
		      System.arraycopy(origin.HI_NISA,0,this.HI_NISA,0,4);
		      System.arraycopy(origin.HI_NMW,0,this.HI_NMW,0,1);
		      System.arraycopy(origin.HI_NPC,0,this.HI_NPC,0,60);
		      System.arraycopy(origin.HI_NPSF,0,this.HI_NPSF,0,1);
		      System.arraycopy(origin.HI_NPST,0,this.HI_NPST,0,45*1);
		      System.arraycopy(origin.HI_NQRB,0,this.HI_NQRB,0,4);
		      System.arraycopy(origin.HI_NRO,0,this.HI_NRO,0,1);
		      System.arraycopy(origin.HI_NSAL,0,this.HI_NSAL,0,1);
		      System.arraycopy(origin.HI_NSAO,0,this.HI_NSAO,0,1);
		      System.arraycopy(origin.HI_NSAS,0,this.HI_NSAS,0,1);
		      System.arraycopy(origin.HI_NTL,0,this.HI_NTL,0,45*1);
		      System.arraycopy(origin.HI_NTP,0,this.HI_NTP,0,200);
		      System.arraycopy(origin.HI_NTX,0,this.HI_NTX,0,4);
		      System.arraycopy(origin.HI_NVCN,0,this.HI_NVCN,0,1);
		      System.arraycopy(origin.HI_NWDA,0,this.HI_NWDA,0,1);
		      System.arraycopy(origin.HI_NYHO,0,this.HI_NYHO,0,10*1);
		      System.arraycopy(origin.HI_NYLN,0,this.HI_NYLN,0,200*1);
		      System.arraycopy(origin.HI_XTP,0,this.HI_XTP,0,100);
		      System.arraycopy(origin.HI_XYP,0,this.HI_XYP,0,100);
		      System.arraycopy(origin.HI_PRMT,0,this.HI_PRMT,0,110);
		      System.arraycopy(origin.HI_SMYR,0,this.HI_SMYR,0,21);
		      System.arraycopy(origin.HI_VARS,0,this.HI_VARS,0,20);
		      System.arraycopy(origin.HI_RNCF,0,this.HI_RNCF,0,12);
		      System.arraycopy(origin.HI_TAV,0,this.HI_TAV,0,12);
		      System.arraycopy(origin.HI_TMNF,0,this.HI_TMNF,0,12);
		      System.arraycopy(origin.HI_TMXF,0,this.HI_TMXF,0,12);
		      System.arraycopy(origin.HI_UAV0,0,this.HI_UAV0,0,12);
		      System.arraycopy(origin.HI_UAVM,0,this.HI_UAVM,0,12);
		      System.arraycopy(origin.HI_AWXP,0,this.HI_AWXP,0,10);
		      System.arraycopy(origin.HI_RFSG,0,this.HI_RFSG,0,10);
		      System.arraycopy(origin.HI_SMSO,0,this.HI_SMSO,0,9);
		      System.arraycopy(origin.HI_OPV,0,this.HI_OPV,0,7);
		      System.arraycopy(origin.HI_SMSW,0,this.HI_SMSW,0,6);
		      System.arraycopy(origin.HI_PSZ,0,this.HI_PSZ,0,5);
		      System.arraycopy(origin.HI_PSZX,0,this.HI_PSZX,0,5);
		      System.arraycopy(origin.HI_PSZY,0,this.HI_PSZY,0,5);
		      System.arraycopy(origin.HI_BUS,0,this.HI_BUS,0,4);
		      System.arraycopy(origin.HI_WX,0,this.HI_WX,0,3);
		      System.arraycopy(origin.HI_XAV,0,this.HI_XAV,0,3);
		      System.arraycopy(origin.HI_XDV,0,this.HI_XDV,0,3);
		      System.arraycopy(origin.HI_XIM,0,this.HI_XIM,0,3);
		      System.arraycopy(origin.HI_UNM,0,this.HI_UNM,0,12); //Inserted MB 8.13.19
		      System.arraycopy(origin.HI_XRG,0,this.HI_XRG,0,3);
		      System.arraycopy(origin.HI_SMMR,0,this.HI_SMMR,0,21*12);
		      System.arraycopy(origin.HI_SMR,0,this.HI_SMR,0,21*12);
		      System.arraycopy(origin.HI_DIR,0,this.HI_DIR,0,12*16);
		      System.arraycopy(origin.HI_OBMN,0,this.HI_OBMN,0,10*12);
		      System.arraycopy(origin.HI_OBMNX,0,this.HI_OBMNX,0,10*12);
		      System.arraycopy(origin.HI_OBMX,0,this.HI_OBMX,0,10*12);
		      System.arraycopy(origin.HI_OBSL,0,this.HI_OBSL,0,10*12);
		      System.arraycopy(origin.HI_PCF,0,this.HI_PCF,0,10*12);
		      System.arraycopy(origin.HI_RH,0,this.HI_RH,0,10*12);
		      System.arraycopy(origin.HI_SDTMN,0,this.HI_SDTMN,0,10*12);
		      System.arraycopy(origin.HI_SDTMX,0,this.HI_SDTMX,0,10*12);
		      System.arraycopy(origin.HI_WFT,0,this.HI_WFT,0,10*12);
		      System.arraycopy(origin.HI_WI,0,this.HI_WI,0,10*12);
		      System.arraycopy(origin.HI_SCRP,0,this.HI_SCRP,0,30*2);
		      System.arraycopy(origin.HI_CQRB,0,this.HI_CQRB,0,8*17*4);
		      System.arraycopy(origin.HI_RST,0,this.HI_RST,0,3*10*12);
		      System.arraycopy(origin.HI_PRW,0,this.HI_PRW,0,2*10*12);
		      System.arraycopy(origin.HI_ABD,0,this.HI_ABD,0,1);
		      System.arraycopy(origin.HI_ACET,0,this.HI_ACET,0,200*1);
		      System.arraycopy(origin.HI_ACO2C,0,this.HI_ACO2C,0,31*1);
		      System.arraycopy(origin.HI_AEP,0,this.HI_AEP,0,200);
		      System.arraycopy(origin.HI_AFLG,0,this.HI_AFLG,0,1);
		      System.arraycopy(origin.HI_AFP,0,this.HI_AFP,0,31*1);
		      System.arraycopy(origin.HI_AGPM,0,this.HI_AGPM,0,1);
		      System.arraycopy(origin.HI_AJHI,0,this.HI_AJHI,0,200*1);
		      System.arraycopy(origin.HI_ALGI,0,this.HI_ALGI,0,1);
		      System.arraycopy(origin.HI_ALQ,0,this.HI_ALQ,0,1);
		      System.arraycopy(origin.HI_ALS,0,this.HI_ALS,0,12*1);
		      System.arraycopy(origin.HI_ALT,0,this.HI_ALT,0,200);
		      System.arraycopy(origin.HI_AN2OC,0,this.HI_AN2OC,0,31*1);
		      System.arraycopy(origin.HI_ANA,0,this.HI_ANA,0,45*1);
		      System.arraycopy(origin.HI_AO2C,0,this.HI_AO2C,0,31*1);
		      System.arraycopy(origin.HI_ARMN,0,this.HI_ARMN,0,1);
		      System.arraycopy(origin.HI_ARMX,0,this.HI_ARMX,0,1);
		      System.arraycopy(origin.HI_ARSD,0,this.HI_ARSD,0,1);
		      System.arraycopy(origin.HI_ASW,0,this.HI_ASW,0,12*1);
		      System.arraycopy(origin.HI_AWC,0,this.HI_AWC,0,200*1);
		      System.arraycopy(origin.HI_BA1,0,this.HI_BA1,0,1);
		      System.arraycopy(origin.HI_BA2,0,this.HI_BA2,0,1);
		      System.arraycopy(origin.HI_BCOF,0,this.HI_BCOF,0,1);
		      System.arraycopy(origin.HI_BCV,0,this.HI_BCV,0,1);
		      System.arraycopy(origin.HI_BD,0,this.HI_BD,0,12*1);
		      System.arraycopy(origin.HI_BDD,0,this.HI_BDD,0,12*1);
		      System.arraycopy(origin.HI_BDM,0,this.HI_BDM,0,12*1);
		      System.arraycopy(origin.HI_BDP,0,this.HI_BDP,0,12*1);
		      System.arraycopy(origin.HI_BFFL,0,this.HI_BFFL,0,1);
		      System.arraycopy(origin.HI_BFSN,0,this.HI_BFSN,0,1);
		      System.arraycopy(origin.HI_BFT,0,this.HI_BFT,0,1);
		      System.arraycopy(origin.HI_BGWS,0,this.HI_BGWS,0,1);
		      System.arraycopy(origin.HI_BIG,0,this.HI_BIG,0,1);
		      System.arraycopy(origin.HI_BIR,0,this.HI_BIR,0,1);
		      System.arraycopy(origin.HI_BK,0,this.HI_BK,0,4*200);
		      System.arraycopy(origin.HI_BLG,0,this.HI_BLG,0,3*200);
		      System.arraycopy(origin.HI_BN,0,this.HI_BN,0,4*200);
		      System.arraycopy(origin.HI_BP,0,this.HI_BP,0,4*200);
		      System.arraycopy(origin.HI_BPT,0,this.HI_BPT,0,12*1);
		      System.arraycopy(origin.HI_BR1,0,this.HI_BR1,0,1);
		      System.arraycopy(origin.HI_BR2,0,this.HI_BR2,0,1);
		      System.arraycopy(origin.HI_BRSV,0,this.HI_BRSV,0,1);
		      System.arraycopy(origin.HI_BSALA,0,this.HI_BSALA,0,1);
		      System.arraycopy(origin.HI_BSNO,0,this.HI_BSNO,0,1);
		      System.arraycopy(origin.HI_BTC,0,this.HI_BTC,0,1);
		      System.arraycopy(origin.HI_BTCX,0,this.HI_BTCX,0,1);
		      System.arraycopy(origin.HI_BTCZ,0,this.HI_BTCZ,0,1);
		      System.arraycopy(origin.HI_BTK,0,this.HI_BTK,0,1);
		      System.arraycopy(origin.HI_BTN,0,this.HI_BTN,0,1);
		      System.arraycopy(origin.HI_BTNX,0,this.HI_BTNX,0,1);
		      System.arraycopy(origin.HI_BTNZ,0,this.HI_BTNZ,0,1);
		      System.arraycopy(origin.HI_BTP,0,this.HI_BTP,0,1);
		      System.arraycopy(origin.HI_BTPX,0,this.HI_BTPX,0,1);
		      System.arraycopy(origin.HI_BTPZ,0,this.HI_BTPZ,0,1);
		      System.arraycopy(origin.HI_BV1,0,this.HI_BV1,0,1);
		      System.arraycopy(origin.HI_BV2,0,this.HI_BV2,0,1);
		      System.arraycopy(origin.HI_BVIR,0,this.HI_BVIR,0,1);
		      System.arraycopy(origin.HI_BWN,0,this.HI_BWN,0,3*200);
		      System.arraycopy(origin.HI_CAC,0,this.HI_CAC,0,12*1);
		      System.arraycopy(origin.HI_CAF,0,this.HI_CAF,0,200);
		      System.arraycopy(origin.HI_CAW,0,this.HI_CAW,0,200*1);
		      System.arraycopy(origin.HI_CBN,0,this.HI_CBN,0,12*1);
		      System.arraycopy(origin.HI_CDG,0,this.HI_CDG,0,12*1);
		      System.arraycopy(origin.HI_CEC,0,this.HI_CEC,0,12*1);
		      System.arraycopy(origin.HI_CFNP,0,this.HI_CFNP,0,1);
		      System.arraycopy(origin.HI_CGCO2,0,this.HI_CGCO2,0,31*1);
		      System.arraycopy(origin.HI_CGN2O,0,this.HI_CGN2O,0,31*1);
		      System.arraycopy(origin.HI_CGO2,0,this.HI_CGO2,0,31*1);
		      System.arraycopy(origin.HI_CHL,0,this.HI_CHL,0,1);
		      System.arraycopy(origin.HI_CHN,0,this.HI_CHN,0,1);
		      System.arraycopy(origin.HI_CHS,0,this.HI_CHS,0,1);
		      System.arraycopy(origin.HI_CHXA,0,this.HI_CHXA,0,1);
		      System.arraycopy(origin.HI_CHXP,0,this.HI_CHXP,0,1);
		      System.arraycopy(origin.HI_CKY,0,this.HI_CKY,0,200);
		      System.arraycopy(origin.HI_CLA,0,this.HI_CLA,0,12*1);
		      System.arraycopy(origin.HI_CLCO2,0,this.HI_CLCO2,0,31*1);
		      System.arraycopy(origin.HI_CLG,0,this.HI_CLG,0,1);
		      System.arraycopy(origin.HI_CLN2O,0,this.HI_CLN2O,0,31*1);
		      System.arraycopy(origin.HI_CLO2,0,this.HI_CLO2,0,31*1);
		      System.arraycopy(origin.HI_CN0,0,this.HI_CN0,0,1);
		      System.arraycopy(origin.HI_CN2,0,this.HI_CN2,0,1);
		      System.arraycopy(origin.HI_CND,0,this.HI_CND,0,45*300*1);
		      System.arraycopy(origin.HI_CNDS,0,this.HI_CNDS,0,12*1);
		      System.arraycopy(origin.HI_CNLV,0,this.HI_CNLV,0,200);
		      System.arraycopy(origin.HI_CNRT,0,this.HI_CNRT,0,12*1);
		      System.arraycopy(origin.HI_CNSC,0,this.HI_CNSC,0,2*1);
		      System.arraycopy(origin.HI_CNSX,0,this.HI_CNSX,0,1);
		      System.arraycopy(origin.HI_CNY,0,this.HI_CNY,0,200);
		      System.arraycopy(origin.HI_COOP,0,this.HI_COOP,0,300);
		      System.arraycopy(origin.HI_COST,0,this.HI_COST,0,1);
		      System.arraycopy(origin.HI_COTL,0,this.HI_COTL,0,300);
		      System.arraycopy(origin.HI_COWW,0,this.HI_COWW,0,1);
		      System.arraycopy(origin.HI_CPFH,0,this.HI_CPFH,0,12*4);
		      System.arraycopy(origin.HI_CPHT,0,this.HI_CPHT,0,200*1);
		      System.arraycopy(origin.HI_CPMX,0,this.HI_CPMX,0,1);
		      System.arraycopy(origin.HI_CPRH,0,this.HI_CPRH,0,12*1);
		      System.arraycopy(origin.HI_CPRV,0,this.HI_CPRV,0,12*1);
		      System.arraycopy(origin.HI_CPVH,0,this.HI_CPVH,0,4);
		      System.arraycopy(origin.HI_CPY,0,this.HI_CPY,0,200);
		      System.arraycopy(origin.HI_CST1,0,this.HI_CST1,0,1);
		      System.arraycopy(origin.HI_CSTF,0,this.HI_CSTF,0,200*1);
		      System.arraycopy(origin.HI_CSTS,0,this.HI_CSTS,0,200);
		      System.arraycopy(origin.HI_CTSA,0,this.HI_CTSA,0,100*1);
		      System.arraycopy(origin.HI_CV,0,this.HI_CV,0,1);
		      System.arraycopy(origin.HI_CVF,0,this.HI_CVF,0,1);
		      System.arraycopy(origin.HI_CVP,0,this.HI_CVP,0,1);
		      System.arraycopy(origin.HI_CVRS,0,this.HI_CVRS,0,1);
		      System.arraycopy(origin.HI_CX,0,this.HI_CX,0,12*1);
		      System.arraycopy(origin.HI_CYAV,0,this.HI_CYAV,0,1);
		      System.arraycopy(origin.HI_CYMX,0,this.HI_CYMX,0,1);
		      System.arraycopy(origin.HI_CYSD,0,this.HI_CYSD,0,1);
		      System.arraycopy(origin.HI_DALG,0,this.HI_DALG,0,1);
		      System.arraycopy(origin.HI_DCO2GEN,0,this.HI_DCO2GEN,0,31*1);
		      System.arraycopy(origin.HI_DDLG,0,this.HI_DDLG,0,1);
		      System.arraycopy(origin.HI_DDM,0,this.HI_DDM,0,200);
		      System.arraycopy(origin.HI_DEPC,0,this.HI_DEPC,0,1);
		      System.arraycopy(origin.HI_DHN,0,this.HI_DHN,0,12*1);
		      System.arraycopy(origin.HI_DHT,0,this.HI_DHT,0,1);
		      System.arraycopy(origin.HI_DKH,0,this.HI_DKH,0,300);
		      System.arraycopy(origin.HI_DKHL,0,this.HI_DKHL,0,1);
		      System.arraycopy(origin.HI_DKI,0,this.HI_DKI,0,300);
		      System.arraycopy(origin.HI_DKIN,0,this.HI_DKIN,0,1);
		      System.arraycopy(origin.HI_DLAI,0,this.HI_DLAI,0,200);
		      System.arraycopy(origin.HI_DLAP,0,this.HI_DLAP,0,2*200);
		      System.arraycopy(origin.HI_DM,0,this.HI_DM,0,200*1);
		      System.arraycopy(origin.HI_DM1,0,this.HI_DM1,0,200*1);
		      System.arraycopy(origin.HI_DMF,0,this.HI_DMF,0,200*1);
		      System.arraycopy(origin.HI_DMLA,0,this.HI_DMLA,0,200);
		      System.arraycopy(origin.HI_DMLX,0,this.HI_DMLX,0,200);
		      System.arraycopy(origin.HI_DN2G,0,this.HI_DN2G,0,31*1);
		      System.arraycopy(origin.HI_DN2OG,0,this.HI_DN2OG,0,31*1);
		      System.arraycopy(origin.HI_DO2CONS,0,this.HI_DO2CONS,0,31*1);
		      System.arraycopy(origin.HI_DPMT,0,this.HI_DPMT,0,4);
		      System.arraycopy(origin.HI_DPRC,0,this.HI_DPRC,0,31*1);
		      System.arraycopy(origin.HI_DPRN,0,this.HI_DPRN,0,31*1);
		      System.arraycopy(origin.HI_DPRO,0,this.HI_DPRO,0,31*1);
		      System.arraycopy(origin.HI_DRAV,0,this.HI_DRAV,0,4);
		      System.arraycopy(origin.HI_DRT,0,this.HI_DRT,0,1);
		      System.arraycopy(origin.HI_DRWX,0,this.HI_DRWX,0,31*1);
		      System.arraycopy(origin.HI_DST0,0,this.HI_DST0,0,1);
		      System.arraycopy(origin.HI_DUMP,0,this.HI_DUMP,0,10*1);
		      System.arraycopy(origin.HI_DWOC,0,this.HI_DWOC,0,1);
		      System.arraycopy(origin.HI_EAR,0,this.HI_EAR,0,31*1);
		      System.arraycopy(origin.HI_ECND,0,this.HI_ECND,0,12*1);
		      System.arraycopy(origin.HI_EFI,0,this.HI_EFI,0,1);
		      System.arraycopy(origin.HI_EFM,0,this.HI_EFM,0,300);
		      System.arraycopy(origin.HI_EK,0,this.HI_EK,0,1);
		      System.arraycopy(origin.HI_EM10,0,this.HI_EM10,0,1);
		      System.arraycopy(origin.HI_EMX,0,this.HI_EMX,0,300);
		      System.arraycopy(origin.HI_EO5,0,this.HI_EO5,0,30*1);
		      System.arraycopy(origin.HI_EP,0,this.HI_EP,0,200);
		      System.arraycopy(origin.HI_EQKE,0,this.HI_EQKE,0,12*1);
		      System.arraycopy(origin.HI_EQKS,0,this.HI_EQKS,0,12*1);
		      System.arraycopy(origin.HI_ERAV,0,this.HI_ERAV,0,4);
		      System.arraycopy(origin.HI_ETG,0,this.HI_ETG,0,200*1);
		      System.arraycopy(origin.HI_EVRS,0,this.HI_EVRS,0,1);
		      System.arraycopy(origin.HI_EVRT,0,this.HI_EVRT,0,1);
		      System.arraycopy(origin.HI_EXCK,0,this.HI_EXCK,0,12*1);
		      System.arraycopy(origin.HI_EXTC,0,this.HI_EXTC,0,200);
		      System.arraycopy(origin.HI_FBM,0,this.HI_FBM,0,1);
		      System.arraycopy(origin.HI_FC,0,this.HI_FC,0,31*1);
		      System.arraycopy(origin.HI_FCMN,0,this.HI_FCMN,0,1);
		      System.arraycopy(origin.HI_FCMP,0,this.HI_FCMP,0,1);
		      System.arraycopy(origin.HI_FCST,0,this.HI_FCST,0,60);
		      System.arraycopy(origin.HI_FDSF,0,this.HI_FDSF,0,1);
		      System.arraycopy(origin.HI_FE26,0,this.HI_FE26,0,12*1);
		      System.arraycopy(origin.HI_FFC,0,this.HI_FFC,0,1);
		      System.arraycopy(origin.HI_FFED,0,this.HI_FFED,0,10*1);
		      System.arraycopy(origin.HI_FFPQ,0,this.HI_FFPQ,0,1);
		      System.arraycopy(origin.HI_FGC,0,this.HI_FGC,0,1);
		      System.arraycopy(origin.HI_FGSL,0,this.HI_FGSL,0,1);
		      System.arraycopy(origin.HI_FHP,0,this.HI_FHP,0,1);
		      System.arraycopy(origin.HI_FIRG,0,this.HI_FIRG,0,1);
		      System.arraycopy(origin.HI_FIRX,0,this.HI_FIRX,0,45*300*1);
		      System.arraycopy(origin.HI_FIXK,0,this.HI_FIXK,0,12*1);
		      System.arraycopy(origin.HI_FK,0,this.HI_FK,0,60);
		      System.arraycopy(origin.HI_FLT,0,this.HI_FLT,0,200);
		      System.arraycopy(origin.HI_FN,0,this.HI_FN,0,60);
		      System.arraycopy(origin.HI_FNMA,0,this.HI_FNMA,0,60);
		      System.arraycopy(origin.HI_FNMN,0,this.HI_FNMN,0,60);
		      System.arraycopy(origin.HI_FNMX,0,this.HI_FNMX,0,45*1);
		      System.arraycopy(origin.HI_FNO,0,this.HI_FNO,0,60);
		      System.arraycopy(origin.HI_FNP,0,this.HI_FNP,0,5*1);
		      System.arraycopy(origin.HI_FOC,0,this.HI_FOC,0,60);
		      System.arraycopy(origin.HI_FOP,0,this.HI_FOP,0,12*1);
		      System.arraycopy(origin.HI_FP,0,this.HI_FP,0,60);
		      System.arraycopy(origin.HI_FPF,0,this.HI_FPF,0,1);
		      System.arraycopy(origin.HI_FPO,0,this.HI_FPO,0,60);
		      System.arraycopy(origin.HI_FPOP,0,this.HI_FPOP,0,300);
		      System.arraycopy(origin.HI_FPSC,0,this.HI_FPSC,0,1);
		      System.arraycopy(origin.HI_FRCP,0,this.HI_FRCP,0,300);
		      System.arraycopy(origin.HI_FRST,0,this.HI_FRST,0,2*200);
		      System.arraycopy(origin.HI_FRTK,0,this.HI_FRTK,0,200*1);
		      System.arraycopy(origin.HI_FRTN,0,this.HI_FRTN,0,200*1);
		      System.arraycopy(origin.HI_FRTP,0,this.HI_FRTP,0,200*1);
		      System.arraycopy(origin.HI_FSFN,0,this.HI_FSFN,0,1);
		      System.arraycopy(origin.HI_FSFP,0,this.HI_FSFP,0,1);
		      System.arraycopy(origin.HI_FSLT,0,this.HI_FSLT,0,60);
		      System.arraycopy(origin.HI_FTO,0,this.HI_FTO,0,200);
		      System.arraycopy(origin.HI_FULU,0,this.HI_FULU,0,300);
		      System.arraycopy(origin.HI_GCOW,0,this.HI_GCOW,0,10*1);
		      System.arraycopy(origin.HI_GMA,0,this.HI_GMA,0,1);
		      System.arraycopy(origin.HI_GMHU,0,this.HI_GMHU,0,200);
		      System.arraycopy(origin.HI_GRDD,0,this.HI_GRDD,0,200);
		      System.arraycopy(origin.HI_GRDL,0,this.HI_GRDL,0,1);
		      System.arraycopy(origin.HI_GRLV,0,this.HI_GRLV,0,200);
		      System.arraycopy(origin.HI_GSI,0,this.HI_GSI,0,200);
		      System.arraycopy(origin.HI_GWMX,0,this.HI_GWMX,0,1);
		      System.arraycopy(origin.HI_GWPS,0,this.HI_GWPS,0,60*1);
		      System.arraycopy(origin.HI_GWSN,0,this.HI_GWSN,0,1);
		      System.arraycopy(origin.HI_GWST,0,this.HI_GWST,0,1);
		      System.arraycopy(origin.HI_GZLM,0,this.HI_GZLM,0,10*1);
		      System.arraycopy(origin.HI_GZRT,0,this.HI_GZRT,0,10*1);
		      System.arraycopy(origin.HI_HA,0,this.HI_HA,0,1);
		      System.arraycopy(origin.HI_HCL,0,this.HI_HCL,0,12*1);
		      System.arraycopy(origin.HI_HCLD,0,this.HI_HCLD,0,1);
		      System.arraycopy(origin.HI_HCLN,0,this.HI_HCLN,0,1);
		      System.arraycopy(origin.HI_HE,0,this.HI_HE,0,300);
		      System.arraycopy(origin.HI_HI,0,this.HI_HI,0,200);
		      System.arraycopy(origin.HI_HKPC,0,this.HI_HKPC,0,31*1);
		      System.arraycopy(origin.HI_HKPN,0,this.HI_HKPN,0,31*1);
		      System.arraycopy(origin.HI_HKPO,0,this.HI_HKPO,0,31*1);
		      System.arraycopy(origin.HI_HLMN,0,this.HI_HLMN,0,1);
		      System.arraycopy(origin.HI_HMO,0,this.HI_HMO,0,300);
		      System.arraycopy(origin.HI_HMX,0,this.HI_HMX,0,200);
		      System.arraycopy(origin.HI_HR0,0,this.HI_HR0,0,1);
		      System.arraycopy(origin.HI_HSM,0,this.HI_HSM,0,1);
		      System.arraycopy(origin.HI_HU,0,this.HI_HU,0,200*1);
		      System.arraycopy(origin.HI_HUF,0,this.HI_HUF,0,200*1);
		      System.arraycopy(origin.HI_HUI,0,this.HI_HUI,0,200*1);
		      System.arraycopy(origin.HI_HUSC,0,this.HI_HUSC,0,45*300*1);
		      System.arraycopy(origin.HI_HYDV,0,this.HI_HYDV,0,4);
		      System.arraycopy(origin.HI_OCPD,0,this.HI_OCPD,0,1);
		      System.arraycopy(origin.HI_OMAP,0,this.HI_OMAP,0,1);
		      System.arraycopy(origin.HI_ORHI,0,this.HI_ORHI,0,300);
		      System.arraycopy(origin.HI_ORSD,0,this.HI_ORSD,0,1);
		      System.arraycopy(origin.HI_OSAA,0,this.HI_OSAA,0,1);
		      System.arraycopy(origin.HI_OWSA,0,this.HI_OWSA,0,1);
		      System.arraycopy(origin.HI_PAW,0,this.HI_PAW,0,1);
		      System.arraycopy(origin.HI_PCOF,0,this.HI_PCOF,0,1);
		      System.arraycopy(origin.HI_PCST,0,this.HI_PCST,0,60);
		      System.arraycopy(origin.HI_PCT,0,this.HI_PCT,0,5*4);
		      System.arraycopy(origin.HI_PCTH,0,this.HI_PCTH,0,5*4);
		      System.arraycopy(origin.HI_PDAW,0,this.HI_PDAW,0,1);
		      System.arraycopy(origin.HI_PDPL,0,this.HI_PDPL,0,1);
		      System.arraycopy(origin.HI_PDPL0,0,this.HI_PDPL0,0,1);
		      System.arraycopy(origin.HI_PDPLC,0,this.HI_PDPLC,0,1);
		      System.arraycopy(origin.HI_PDPLX,0,this.HI_PDPLX,0,1);
		      System.arraycopy(origin.HI_PDSKC,0,this.HI_PDSKC,0,1);
		      System.arraycopy(origin.HI_PDSW,0,this.HI_PDSW,0,1);
		      System.arraycopy(origin.HI_PEC,0,this.HI_PEC,0,1);
		      System.arraycopy(origin.HI_PFOL,0,this.HI_PFOL,0,60*1);
		      System.arraycopy(origin.HI_PH,0,this.HI_PH,0,12*1);
		      System.arraycopy(origin.HI_PHLF,0,this.HI_PHLF,0,60);
		      System.arraycopy(origin.HI_PHLS,0,this.HI_PHLS,0,60);
		      System.arraycopy(origin.HI_PHU,0,this.HI_PHU,0,200*45*1);
		      System.arraycopy(origin.HI_PHUX,0,this.HI_PHUX,0,200);
		      System.arraycopy(origin.HI_PKOC,0,this.HI_PKOC,0,60);
		      System.arraycopy(origin.HI_PKRZ,0,this.HI_PKRZ,0,12);
		      System.arraycopy(origin.HI_PLAX,0,this.HI_PLAX,0,200);
		      System.arraycopy(origin.HI_PLCH,0,this.HI_PLCH,0,60);
		      System.arraycopy(origin.HI_PM10,0,this.HI_PM10,0,1);
		      System.arraycopy(origin.HI_PMX,0,this.HI_PMX,0,1);
		      System.arraycopy(origin.HI_PO,0,this.HI_PO,0,12*1);
		      System.arraycopy(origin.HI_POP,0,this.HI_POP,0,200*45*1);
		      System.arraycopy(origin.HI_POPX,0,this.HI_POPX,0,200);
		      System.arraycopy(origin.HI_PPCF,0,this.HI_PPCF,0,2*200);
		      System.arraycopy(origin.HI_PPL0,0,this.HI_PPL0,0,200*1);
		      System.arraycopy(origin.HI_PPLA,0,this.HI_PPLA,0,200*45*1);
		      System.arraycopy(origin.HI_PPLP,0,this.HI_PPLP,0,2*200);
		      System.arraycopy(origin.HI_PPX,0,this.HI_PPX,0,13*1);
		      System.arraycopy(origin.HI_PQPS,0,this.HI_PQPS,0,5);
		      System.arraycopy(origin.HI_PRAV,0,this.HI_PRAV,0,4);
		      System.arraycopy(origin.HI_PRB,0,this.HI_PRB,0,4);
		      System.arraycopy(origin.HI_PRSD,0,this.HI_PRSD,0,1);
		      System.arraycopy(origin.HI_PRYF,0,this.HI_PRYF,0,200);
		      System.arraycopy(origin.HI_PRYG,0,this.HI_PRYG,0,200);
		      System.arraycopy(origin.HI_PSO3,0,this.HI_PSO3,0,5);
		      System.arraycopy(origin.HI_PSOL,0,this.HI_PSOL,0,60);
		      System.arraycopy(origin.HI_PSON,0,this.HI_PSON,0,5);
		      System.arraycopy(origin.HI_PSOP,0,this.HI_PSOP,0,5);
		      System.arraycopy(origin.HI_PSOQ,0,this.HI_PSOQ,0,5);
		      System.arraycopy(origin.HI_PSOY,0,this.HI_PSOY,0,5);
		      System.arraycopy(origin.HI_PSP,0,this.HI_PSP,0,12*1);
		      System.arraycopy(origin.HI_PSSF,0,this.HI_PSSF,0,60*12*1);
		      System.arraycopy(origin.HI_PSSP,0,this.HI_PSSP,0,5);
		      System.arraycopy(origin.HI_PST,0,this.HI_PST,0,200);
		      System.arraycopy(origin.HI_PSTE,0,this.HI_PSTE,0,45*60*1);
		      System.arraycopy(origin.HI_PSTF,0,this.HI_PSTF,0,1);
		      System.arraycopy(origin.HI_PSTM,0,this.HI_PSTM,0,1);
		      System.arraycopy(origin.HI_PSTR,0,this.HI_PSTR,0,45*60*1);
		      System.arraycopy(origin.HI_PSTS,0,this.HI_PSTS,0,1);
		      System.arraycopy(origin.HI_PSTZ,0,this.HI_PSTZ,0,60*12*1);
		      System.arraycopy(origin.HI_PSZM,0,this.HI_PSZM,0,4);
		      System.arraycopy(origin.HI_PVQ,0,this.HI_PVQ,0,60*90*4);
		      System.arraycopy(origin.HI_PVY,0,this.HI_PVY,0,60*90*4);
		      System.arraycopy(origin.HI_PWOF,0,this.HI_PWOF,0,60);
		      System.arraycopy(origin.HI_PYPS,0,this.HI_PYPS,0,5);
		      System.arraycopy(origin.HI_QC,0,this.HI_QC,0,4);
		      System.arraycopy(origin.HI_QCAP,0,this.HI_QCAP,0,1);
		      System.arraycopy(origin.HI_QDR,0,this.HI_QDR,0,4);
		      System.arraycopy(origin.HI_QDRN,0,this.HI_QDRN,0,4);
		      System.arraycopy(origin.HI_QDRP,0,this.HI_QDRP,0,4);
		      System.arraycopy(origin.HI_QGA,0,this.HI_QGA,0,720);
		      System.arraycopy(origin.HI_QHY,0,this.HI_QHY,0,24*4*3);
		      System.arraycopy(origin.HI_QIN,0,this.HI_QIN,0,12*1);
		      System.arraycopy(origin.HI_QIR,0,this.HI_QIR,0,45*300*1);
		      System.arraycopy(origin.HI_QN,0,this.HI_QN,0,4);
		      System.arraycopy(origin.HI_QP,0,this.HI_QP,0,4);
		      System.arraycopy(origin.HI_QPR,0,this.HI_QPR,0,4);
		      System.arraycopy(origin.HI_QPST,0,this.HI_QPST,0,60*4);
		      System.arraycopy(origin.HI_QPU,0,this.HI_QPU,0,4);
		      System.arraycopy(origin.HI_QRBQ,0,this.HI_QRBQ,0,1);
		      System.arraycopy(origin.HI_QRF,0,this.HI_QRF,0,4);
		      System.arraycopy(origin.HI_QRFN,0,this.HI_QRFN,0,4);
		      System.arraycopy(origin.HI_QRFP,0,this.HI_QRFP,0,4);
		      System.arraycopy(origin.HI_QRP,0,this.HI_QRP,0,4);
		      System.arraycopy(origin.HI_QRQB,0,this.HI_QRQB,0,1);
		      System.arraycopy(origin.HI_QSF,0,this.HI_QSF,0,12*4);
		      System.arraycopy(origin.HI_QURB,0,this.HI_QURB,0,4);
		      System.arraycopy(origin.HI_QVOL,0,this.HI_QVOL,0,4);
		      System.arraycopy(origin.HI_RBMD,0,this.HI_RBMD,0,200);
		      System.arraycopy(origin.HI_RCBW,0,this.HI_RCBW,0,1);
		      System.arraycopy(origin.HI_RCF,0,this.HI_RCF,0,1);
		      System.arraycopy(origin.HI_RCHC,0,this.HI_RCHC,0,1);
		      System.arraycopy(origin.HI_RCHD,0,this.HI_RCHD,0,1);
		      System.arraycopy(origin.HI_RCHK,0,this.HI_RCHK,0,1);
		      System.arraycopy(origin.HI_RCHL,0,this.HI_RCHL,0,1);
		      System.arraycopy(origin.HI_RCHN,0,this.HI_RCHN,0,1);
		      System.arraycopy(origin.HI_RCHS,0,this.HI_RCHS,0,1);
		      System.arraycopy(origin.HI_RCHX,0,this.HI_RCHX,0,1);
		      System.arraycopy(origin.HI_RCSS,0,this.HI_RCSS,0,1);
		      System.arraycopy(origin.HI_RCTC,0,this.HI_RCTC,0,4);
		      System.arraycopy(origin.HI_RCTW,0,this.HI_RCTW,0,1);
		      System.arraycopy(origin.HI_RD,0,this.HI_RD,0,200*1);
		      System.arraycopy(origin.HI_RDF,0,this.HI_RDF,0,200*1);
		      System.arraycopy(origin.HI_RDMX,0,this.HI_RDMX,0,200);
		      System.arraycopy(origin.HI_REG,0,this.HI_REG,0,200*1);
		      System.arraycopy(origin.HI_REPI,0,this.HI_REPI,0,1);
		      System.arraycopy(origin.HI_RF5,0,this.HI_RF5,0,30*1);
		      System.arraycopy(origin.HI_RFDT,0,this.HI_RFDT,0,720);
		      System.arraycopy(origin.HI_RFPK,0,this.HI_RFPK,0,1);
		      System.arraycopy(origin.HI_RFPL,0,this.HI_RFPL,0,1);
		      System.arraycopy(origin.HI_RFPS,0,this.HI_RFPS,0,1);
		      System.arraycopy(origin.HI_RFPW,0,this.HI_RFPW,0,1);
		      System.arraycopy(origin.HI_RFPX,0,this.HI_RFPX,0,1);
		      System.arraycopy(origin.HI_RFTT,0,this.HI_RFTT,0,1);
		      System.arraycopy(origin.HI_RFV,0,this.HI_RFV,0,1);
		      System.arraycopy(origin.HI_RFV0,0,this.HI_RFV0,0,1);
		      System.arraycopy(origin.HI_RHD,0,this.HI_RHD,0,1);
		      System.arraycopy(origin.HI_RHT,0,this.HI_RHT,0,300);
		      System.arraycopy(origin.HI_RHTT,0,this.HI_RHTT,0,1);
		      System.arraycopy(origin.HI_RIN,0,this.HI_RIN,0,300);
		      System.arraycopy(origin.HI_RINT,0,this.HI_RINT,0,1);
		      System.arraycopy(origin.HI_RLAD,0,this.HI_RLAD,0,200);
		      System.arraycopy(origin.HI_RLF,0,this.HI_RLF,0,1);
		      System.arraycopy(origin.HI_RMXS,0,this.HI_RMXS,0,1);
		      System.arraycopy(origin.HI_RNMN,0,this.HI_RNMN,0,12*1);
		      System.arraycopy(origin.HI_ROK,0,this.HI_ROK,0,12*1);
		      System.arraycopy(origin.HI_ROSP,0,this.HI_ROSP,0,1);
		      System.arraycopy(origin.HI_RQRB,0,this.HI_RQRB,0,4);
		      System.arraycopy(origin.HI_RR,0,this.HI_RR,0,300);
		      System.arraycopy(origin.HI_RRUF,0,this.HI_RRUF,0,1);
		      System.arraycopy(origin.HI_RSAE,0,this.HI_RSAE,0,1);
		      System.arraycopy(origin.HI_RSAP,0,this.HI_RSAP,0,1);
		      System.arraycopy(origin.HI_RSBD,0,this.HI_RSBD,0,1);
		      System.arraycopy(origin.HI_RSD,0,this.HI_RSD,0,12*1);
		      System.arraycopy(origin.HI_RSDM,0,this.HI_RSDM,0,12*1);
		      System.arraycopy(origin.HI_RSDP,0,this.HI_RSDP,0,1);
		      System.arraycopy(origin.HI_RSEE,0,this.HI_RSEE,0,1);
		      System.arraycopy(origin.HI_RSEP,0,this.HI_RSEP,0,1);
		      System.arraycopy(origin.HI_RSF,0,this.HI_RSF,0,1);
		      System.arraycopy(origin.HI_RSFN,0,this.HI_RSFN,0,4);
		      System.arraycopy(origin.HI_RSHC,0,this.HI_RSHC,0,1);
		      System.arraycopy(origin.HI_RSK,0,this.HI_RSK,0,1);
		      System.arraycopy(origin.HI_RSLK,0,this.HI_RSLK,0,1);
		      System.arraycopy(origin.HI_RSO3,0,this.HI_RSO3,0,1);
		      System.arraycopy(origin.HI_RSOC,0,this.HI_RSOC,0,1);
		      System.arraycopy(origin.HI_RSON,0,this.HI_RSON,0,1);
		      System.arraycopy(origin.HI_RSOP,0,this.HI_RSOP,0,1);
		      System.arraycopy(origin.HI_RSPC,0,this.HI_RSPC,0,31*1);
		      System.arraycopy(origin.HI_RSPK,0,this.HI_RSPK,0,1);
		      System.arraycopy(origin.HI_RSPS,0,this.HI_RSPS,0,60*4);
		      System.arraycopy(origin.HI_RSRR,0,this.HI_RSRR,0,1);
		      System.arraycopy(origin.HI_RSSA,0,this.HI_RSSA,0,1);
		      System.arraycopy(origin.HI_RSSF,0,this.HI_RSSF,0,4);
		      System.arraycopy(origin.HI_RSSP,0,this.HI_RSSP,0,1);
		      System.arraycopy(origin.HI_RST0,0,this.HI_RST0,0,1);
		      System.arraycopy(origin.HI_RSTK,0,this.HI_RSTK,0,45*300*1);
		      System.arraycopy(origin.HI_RSV,0,this.HI_RSV,0,1);
		      System.arraycopy(origin.HI_RSVB,0,this.HI_RSVB,0,1);
		      System.arraycopy(origin.HI_RSVE,0,this.HI_RSVE,0,1);
		      System.arraycopy(origin.HI_RSVF,0,this.HI_RSVF,0,1);
		      System.arraycopy(origin.HI_RSVP,0,this.HI_RSVP,0,1);
		      System.arraycopy(origin.HI_RSYB,0,this.HI_RSYB,0,1);
		      System.arraycopy(origin.HI_RSYF,0,this.HI_RSYF,0,1);
		      System.arraycopy(origin.HI_RSYN,0,this.HI_RSYN,0,1);
		      System.arraycopy(origin.HI_RSYS,0,this.HI_RSYS,0,1);
		      System.arraycopy(origin.HI_RVE0,0,this.HI_RVE0,0,1);
		      System.arraycopy(origin.HI_RVP0,0,this.HI_RVP0,0,1);
		      System.arraycopy(origin.HI_RW,0,this.HI_RW,0,200*1);
		      System.arraycopy(origin.HI_RWPC,0,this.HI_RWPC,0,2*200);
		      System.arraycopy(origin.HI_RWSA,0,this.HI_RWSA,0,4);
		      System.arraycopy(origin.HI_RWT,0,this.HI_RWT,0,12*200*1);
		      System.arraycopy(origin.HI_RWTZ,0,this.HI_RWTZ,0,31*1);
		      System.arraycopy(origin.HI_RZ,0,this.HI_RZ,0,1);
		      System.arraycopy(origin.HI_RZSW,0,this.HI_RZSW,0,1);
		      System.arraycopy(origin.HI_S15,0,this.HI_S15,0,31*1);
		      System.arraycopy(origin.HI_S3,0,this.HI_S3,0,1);
		      System.arraycopy(origin.HI_SALA,0,this.HI_SALA,0,1);
		      System.arraycopy(origin.HI_SALB,0,this.HI_SALB,0,1);
		      System.arraycopy(origin.HI_SAMA,0,this.HI_SAMA,0,1);
		      System.arraycopy(origin.HI_SAN,0,this.HI_SAN,0,12*1);
		      System.arraycopy(origin.HI_SATC,0,this.HI_SATC,0,12*1);
		      System.arraycopy(origin.HI_SATK,0,this.HI_SATK,0,1);
		      System.arraycopy(origin.HI_SCFS,0,this.HI_SCFS,0,30*1);
		      System.arraycopy(origin.HI_SCI,0,this.HI_SCI,0,1);
		      System.arraycopy(origin.HI_SCNX,0,this.HI_SCNX,0,1);
		      System.arraycopy(origin.HI_SDVR,0,this.HI_SDVR,0,1);
		      System.arraycopy(origin.HI_SDW,0,this.HI_SDW,0,200);
		      System.arraycopy(origin.HI_SET,0,this.HI_SET,0,12*1);
		      System.arraycopy(origin.HI_SEV,0,this.HI_SEV,0,12*1);
		      System.arraycopy(origin.HI_SFCP,0,this.HI_SFCP,0,7*200*1);
		      System.arraycopy(origin.HI_SFMO,0,this.HI_SFMO,0,7*200*1);
		      System.arraycopy(origin.HI_SHYD,0,this.HI_SHYD,0,4);
		      System.arraycopy(origin.HI_SIL,0,this.HI_SIL,0,12*1);
		      System.arraycopy(origin.HI_SLA0,0,this.HI_SLA0,0,200*1);
		      System.arraycopy(origin.HI_SLAI,0,this.HI_SLAI,0,200*1);
		      System.arraycopy(origin.HI_SLF,0,this.HI_SLF,0,1);
		      System.arraycopy(origin.HI_SLT0,0,this.HI_SLT0,0,1);
		      System.arraycopy(origin.HI_SLTX,0,this.HI_SLTX,0,1);
		      System.arraycopy(origin.HI_SM,0,this.HI_SM,0,155*1);
		      System.arraycopy(origin.HI_SMAP,0,this.HI_SMAP,0,13*60*4);
		      System.arraycopy(origin.HI_SMAS,0,this.HI_SMAS,0,1);
		      System.arraycopy(origin.HI_SMB,0,this.HI_SMB,0,12*1);
		      System.arraycopy(origin.HI_SMEA,0,this.HI_SMEA,0,31*1);
		      System.arraycopy(origin.HI_SMEO,0,this.HI_SMEO,0,1);
		      System.arraycopy(origin.HI_SMES,0,this.HI_SMES,0,31*1);
		      System.arraycopy(origin.HI_SMFN,0,this.HI_SMFN,0,1);
		      System.arraycopy(origin.HI_SMFU,0,this.HI_SMFU,0,1);
		      System.arraycopy(origin.HI_SMH,0,this.HI_SMH,0,35*4);
		      System.arraycopy(origin.HI_SMIO,0,this.HI_SMIO,0,4);
		      System.arraycopy(origin.HI_SMKS,0,this.HI_SMKS,0,1);
		      System.arraycopy(origin.HI_SMLA,0,this.HI_SMLA,0,1);
		      System.arraycopy(origin.HI_SMM,0,this.HI_SMM,0,155*12*1);
		      System.arraycopy(origin.HI_SMMC,0,this.HI_SMMC,0,17*200*12*1);
		      System.arraycopy(origin.HI_SMMH,0,this.HI_SMMH,0,35*12*4);
		      System.arraycopy(origin.HI_SMMP,0,this.HI_SMMP,0,20*60*13*4);
		      System.arraycopy(origin.HI_SMMRP,0,this.HI_SMMRP,0,5*60*12);
		      System.arraycopy(origin.HI_SMMU,0,this.HI_SMMU,0,1);
		      System.arraycopy(origin.HI_SMNS,0,this.HI_SMNS,0,1);
		      System.arraycopy(origin.HI_SMNU,0,this.HI_SMNU,0,1);
		      System.arraycopy(origin.HI_SMPL,0,this.HI_SMPL,0,1);
		      System.arraycopy(origin.HI_SMPQ,0,this.HI_SMPQ,0,1);
		      System.arraycopy(origin.HI_SMPS,0,this.HI_SMPS,0,1);
		      System.arraycopy(origin.HI_SMPY,0,this.HI_SMPY,0,1);
		      System.arraycopy(origin.HI_SMRF,0,this.HI_SMRF,0,1);
		      System.arraycopy(origin.HI_SMRP,0,this.HI_SMRP,0,5*60*12);
		      System.arraycopy(origin.HI_SMS,0,this.HI_SMS,0,11*13*1);
		      System.arraycopy(origin.HI_SMSS,0,this.HI_SMSS,0,1);
		      System.arraycopy(origin.HI_SMST,0,this.HI_SMST,0,1);
		      System.arraycopy(origin.HI_SMTS,0,this.HI_SMTS,0,1);
		      System.arraycopy(origin.HI_SMWS,0,this.HI_SMWS,0,1);
		      System.arraycopy(origin.HI_SMX,0,this.HI_SMX,0,1);
		      System.arraycopy(origin.HI_SMY,0,this.HI_SMY,0,155*1);
		      System.arraycopy(origin.HI_SMY1,0,this.HI_SMY1,0,1);
		      System.arraycopy(origin.HI_SMY2,0,this.HI_SMY2,0,1);
		      System.arraycopy(origin.HI_SMYH,0,this.HI_SMYH,0,35*4);
		      System.arraycopy(origin.HI_SMYP,0,this.HI_SMYP,0,13*60*4);
		      System.arraycopy(origin.HI_SMYRP,0,this.HI_SMYRP,0,5*60);
		      System.arraycopy(origin.HI_SNO,0,this.HI_SNO,0,1);
		      System.arraycopy(origin.HI_SOIL,0,this.HI_SOIL,0,17*12*1);
		      System.arraycopy(origin.HI_SOL,0,this.HI_SOL,0,23*12*1);
		      System.arraycopy(origin.HI_SOLK,0,this.HI_SOLK,0,31*1);
		      System.arraycopy(origin.HI_SOLQ,0,this.HI_SOLQ,0,1);
		      System.arraycopy(origin.HI_SOT,0,this.HI_SOT,0,31*1);
		      System.arraycopy(origin.HI_SPLG,0,this.HI_SPLG,0,1);
		      System.arraycopy(origin.HI_SQB,0,this.HI_SQB,0,5*4);
		      System.arraycopy(origin.HI_SQVL,0,this.HI_SQVL,0,4);
		      System.arraycopy(origin.HI_SRA,0,this.HI_SRA,0,200*1);
		      System.arraycopy(origin.HI_SRAD,0,this.HI_SRAD,0,1);
		      System.arraycopy(origin.HI_SRCH,0,this.HI_SRCH,0,27*4);
		      System.arraycopy(origin.HI_SRD,0,this.HI_SRD,0,12*1);
		      System.arraycopy(origin.HI_SRMX,0,this.HI_SRMX,0,12*1);
		      System.arraycopy(origin.HI_SRSD,0,this.HI_SRSD,0,1);
		      System.arraycopy(origin.HI_SSF,0,this.HI_SSF,0,12*4);
		      System.arraycopy(origin.HI_SSFCO2,0,this.HI_SSFCO2,0,31*1);
		      System.arraycopy(origin.HI_SSFI,0,this.HI_SSFI,0,1);
		      System.arraycopy(origin.HI_SSFN2O,0,this.HI_SSFN2O,0,31*1);
		      System.arraycopy(origin.HI_SSFO2,0,this.HI_SSFO2,0,31*1);
		      System.arraycopy(origin.HI_SSIN,0,this.HI_SSIN,0,1);
		      System.arraycopy(origin.HI_SSPS,0,this.HI_SSPS,0,60);
		      System.arraycopy(origin.HI_SST,0,this.HI_SST,0,4);
		      System.arraycopy(origin.HI_SSW,0,this.HI_SSW,0,1);
		      System.arraycopy(origin.HI_ST0,0,this.HI_ST0,0,1);
		      System.arraycopy(origin.HI_STD,0,this.HI_STD,0,200*1);
		      System.arraycopy(origin.HI_STDA,0,this.HI_STDA,0,4*200*1);
		      System.arraycopy(origin.HI_STDK,0,this.HI_STDK,0,200*1);
		      System.arraycopy(origin.HI_STDL,0,this.HI_STDL,0,200*1);
		      System.arraycopy(origin.HI_STDN,0,this.HI_STDN,0,200*1);
		      System.arraycopy(origin.HI_STDO,0,this.HI_STDO,0,1);
		      System.arraycopy(origin.HI_STDOK,0,this.HI_STDOK,0,1);
		      System.arraycopy(origin.HI_STDON,0,this.HI_STDON,0,1);
		      System.arraycopy(origin.HI_STDOP,0,this.HI_STDOP,0,1);
		      System.arraycopy(origin.HI_STDP,0,this.HI_STDP,0,200*1);
		      System.arraycopy(origin.HI_STFR,0,this.HI_STFR,0,12*1);
		      System.arraycopy(origin.HI_STIR,0,this.HI_STIR,0,300);
		      System.arraycopy(origin.HI_STKR,0,this.HI_STKR,0,1);
		      System.arraycopy(origin.HI_STL,0,this.HI_STL,0,200*1);
		      System.arraycopy(origin.HI_STLT,0,this.HI_STLT,0,1);
		      System.arraycopy(origin.HI_STMP,0,this.HI_STMP,0,12*1);
		      System.arraycopy(origin.HI_STP,0,this.HI_STP,0,1);
		      System.arraycopy(origin.HI_STV,0,this.HI_STV,0,20*12*1);
		      System.arraycopy(origin.HI_STX,0,this.HI_STX,0,2*200);
		      System.arraycopy(origin.HI_STY,0,this.HI_STY,0,4);
		      System.arraycopy(origin.HI_SULF,0,this.HI_SULF,0,12*1);
		      System.arraycopy(origin.HI_SUT,0,this.HI_SUT,0,12*1);
		      System.arraycopy(origin.HI_SW,0,this.HI_SW,0,1);
		      System.arraycopy(origin.HI_SWB,0,this.HI_SWB,0,1);
		      System.arraycopy(origin.HI_SWBD,0,this.HI_SWBD,0,1);
		      System.arraycopy(origin.HI_SWBX,0,this.HI_SWBX,0,1);
		      System.arraycopy(origin.HI_SWH,0,this.HI_SWH,0,200*1);
		      System.arraycopy(origin.HI_SWLT,0,this.HI_SWLT,0,1);
		      System.arraycopy(origin.HI_SWP,0,this.HI_SWP,0,200*1);
		      System.arraycopy(origin.HI_SWST,0,this.HI_SWST,0,12*1);
		      System.arraycopy(origin.HI_SYB,0,this.HI_SYB,0,5*4);
		      System.arraycopy(origin.HI_TAGP,0,this.HI_TAGP,0,1);
		      System.arraycopy(origin.HI_TAMX,0,this.HI_TAMX,0,12*1);
		      System.arraycopy(origin.HI_TBSC,0,this.HI_TBSC,0,200);
		      System.arraycopy(origin.HI_TC,0,this.HI_TC,0,4);
		      System.arraycopy(origin.HI_TCAV,0,this.HI_TCAV,0,4);
		      System.arraycopy(origin.HI_TCAW,0,this.HI_TCAW,0,200*1);
		      System.arraycopy(origin.HI_TCC,0,this.HI_TCC,0,1);
		      System.arraycopy(origin.HI_TCMN,0,this.HI_TCMN,0,4);
		      System.arraycopy(origin.HI_TCMX,0,this.HI_TCMX,0,4);
		      System.arraycopy(origin.HI_TCN,0,this.HI_TCN,0,12*1);
		      System.arraycopy(origin.HI_TCPA,0,this.HI_TCPA,0,200);
		      System.arraycopy(origin.HI_TCPY,0,this.HI_TCPY,0,200);
		      System.arraycopy(origin.HI_TCS,0,this.HI_TCS,0,1);
		      System.arraycopy(origin.HI_TCVF,0,this.HI_TCVF,0,12*1);
		      System.arraycopy(origin.HI_TDM,0,this.HI_TDM,0,200*1);
		      System.arraycopy(origin.HI_TEI,0,this.HI_TEI,0,12*1);
		      System.arraycopy(origin.HI_TET,0,this.HI_TET,0,12*1);
		      System.arraycopy(origin.HI_TETG,0,this.HI_TETG,0,200*1);
		      System.arraycopy(origin.HI_TFLG,0,this.HI_TFLG,0,1);
		      System.arraycopy(origin.HI_TFTK,0,this.HI_TFTK,0,200*1);
		      System.arraycopy(origin.HI_TFTN,0,this.HI_TFTN,0,200*1);
		      System.arraycopy(origin.HI_TFTP,0,this.HI_TFTP,0,200*1);
		      System.arraycopy(origin.HI_THK,0,this.HI_THK,0,1);
		      System.arraycopy(origin.HI_THRL,0,this.HI_THRL,0,12*1);
		      System.arraycopy(origin.HI_THU,0,this.HI_THU,0,200*1);
		      System.arraycopy(origin.HI_TILG,0,this.HI_TILG,0,1);
		      System.arraycopy(origin.HI_TIR,0,this.HI_TIR,0,45*300*1);
		      System.arraycopy(origin.HI_TKR,0,this.HI_TKR,0,1);
		      System.arraycopy(origin.HI_TLD,0,this.HI_TLD,0,300);
		      System.arraycopy(origin.HI_TLMF,0,this.HI_TLMF,0,1);
		      System.arraycopy(origin.HI_TMN,0,this.HI_TMN,0,1);
		      System.arraycopy(origin.HI_TMX,0,this.HI_TMX,0,1);
		      System.arraycopy(origin.HI_TNOR,0,this.HI_TNOR,0,1);
		      System.arraycopy(origin.HI_TNYL,0,this.HI_TNYL,0,4);
		      System.arraycopy(origin.HI_TOC,0,this.HI_TOC,0,1);
		      System.arraycopy(origin.HI_TOPC,0,this.HI_TOPC,0,200);
		      System.arraycopy(origin.HI_TPOR,0,this.HI_TPOR,0,31*1);
		      System.arraycopy(origin.HI_TPSF,0,this.HI_TPSF,0,1);
		      System.arraycopy(origin.HI_TQ,0,this.HI_TQ,0,12*1);
		      System.arraycopy(origin.HI_TQN,0,this.HI_TQN,0,12*1);
		      System.arraycopy(origin.HI_TQP,0,this.HI_TQP,0,12*1);
		      System.arraycopy(origin.HI_TQPU,0,this.HI_TQPU,0,12*1);
		      System.arraycopy(origin.HI_TR,0,this.HI_TR,0,12*1);
		      System.arraycopy(origin.HI_TRA,0,this.HI_TRA,0,200*1);
		      System.arraycopy(origin.HI_TRD,0,this.HI_TRD,0,200*1);
		      System.arraycopy(origin.HI_TRHT,0,this.HI_TRHT,0,12*1);
		      System.arraycopy(origin.HI_TRSD,0,this.HI_TRSD,0,1);
		      System.arraycopy(origin.HI_TSFC,0,this.HI_TSFC,0,7*200*1);
		      System.arraycopy(origin.HI_TSFK,0,this.HI_TSFK,0,4);
		      System.arraycopy(origin.HI_TSFN,0,this.HI_TSFN,0,4);
		      System.arraycopy(origin.HI_TSLA,0,this.HI_TSLA,0,1);
		      System.arraycopy(origin.HI_TSMY,0,this.HI_TSMY,0,1);
		      System.arraycopy(origin.HI_TSN,0,this.HI_TSN,0,12*1);
		      System.arraycopy(origin.HI_TSNO,0,this.HI_TSNO,0,1);
		      System.arraycopy(origin.HI_TSPS,0,this.HI_TSPS,0,60*4);
		      System.arraycopy(origin.HI_TSR,0,this.HI_TSR,0,12*1);
		      System.arraycopy(origin.HI_TSY,0,this.HI_TSY,0,12*1);
		      System.arraycopy(origin.HI_TVGF,0,this.HI_TVGF,0,1);
		      System.arraycopy(origin.HI_TVIR,0,this.HI_TVIR,0,200*1);
		      System.arraycopy(origin.HI_TXMN,0,this.HI_TXMN,0,12*1);
		      System.arraycopy(origin.HI_TXMX,0,this.HI_TXMX,0,12*1);
		      System.arraycopy(origin.HI_TYK,0,this.HI_TYK,0,1);
		      System.arraycopy(origin.HI_TYL1,0,this.HI_TYL1,0,200*1);
		      System.arraycopy(origin.HI_TYL2,0,this.HI_TYL2,0,200*1);
		      System.arraycopy(origin.HI_TYLK,0,this.HI_TYLK,0,200*1);
		      System.arraycopy(origin.HI_TYLN,0,this.HI_TYLN,0,200*1);
		      System.arraycopy(origin.HI_TYLP,0,this.HI_TYLP,0,200*1);
		      System.arraycopy(origin.HI_TYN,0,this.HI_TYN,0,1);
		      System.arraycopy(origin.HI_TYON,0,this.HI_TYON,0,12*1);
		      System.arraycopy(origin.HI_TYP,0,this.HI_TYP,0,1);
		      System.arraycopy(origin.HI_TYTP,0,this.HI_TYTP,0,12*1);
		      System.arraycopy(origin.HI_TYW,0,this.HI_TYW,0,12*1);
		      System.arraycopy(origin.HI_U10,0,this.HI_U10,0,1);
		      System.arraycopy(origin.HI_UB1,0,this.HI_UB1,0,1);
		      System.arraycopy(origin.HI_UK,0,this.HI_UK,0,12);
		      System.arraycopy(origin.HI_UK1,0,this.HI_UK1,0,200*1);
		      System.arraycopy(origin.HI_UN,0,this.HI_UN,0,12);
		      System.arraycopy(origin.HI_UN1,0,this.HI_UN1,0,200*1);
		      System.arraycopy(origin.HI_UNA,0,this.HI_UNA,0,200*1);
		      System.arraycopy(origin.HI_UOB,0,this.HI_UOB,0,1);
		      System.arraycopy(origin.HI_UP,0,this.HI_UP,0,12);
		      System.arraycopy(origin.HI_UP1,0,this.HI_UP1,0,200*1);
		      System.arraycopy(origin.HI_UPSX,0,this.HI_UPSX,0,1);
		      System.arraycopy(origin.HI_URBF,0,this.HI_URBF,0,1);
		      System.arraycopy(origin.HI_USL,0,this.HI_USL,0,1);
		      System.arraycopy(origin.HI_UW,0,this.HI_UW,0,12);
		      System.arraycopy(origin.HI_VAC,0,this.HI_VAC,0,1);
		      System.arraycopy(origin.HI_VALF1,0,this.HI_VALF1,0,1);
		      System.arraycopy(origin.HI_VAP,0,this.HI_VAP,0,1);
		      System.arraycopy(origin.HI_VAR,0,this.HI_VAR,0,155*1);
		      System.arraycopy(origin.HI_VARC,0,this.HI_VARC,0,17*200*1);
		      System.arraycopy(origin.HI_VARH,0,this.HI_VARH,0,35*4);
		      System.arraycopy(origin.HI_VARP,0,this.HI_VARP,0,12*60*4);
		      System.arraycopy(origin.HI_VARW,0,this.HI_VARW,0,155);
		      System.arraycopy(origin.HI_VCHA,0,this.HI_VCHA,0,1);
		      System.arraycopy(origin.HI_VCHB,0,this.HI_VCHB,0,1);
		      System.arraycopy(origin.HI_VCO2,0,this.HI_VCO2,0,31*1);
		      System.arraycopy(origin.HI_VFC,0,this.HI_VFC,0,31*1);
		      System.arraycopy(origin.HI_VFPA,0,this.HI_VFPA,0,1);
		      System.arraycopy(origin.HI_VFPB,0,this.HI_VFPB,0,1);
		      System.arraycopy(origin.HI_VIMX,0,this.HI_VIMX,0,1);
		      System.arraycopy(origin.HI_VIR,0,this.HI_VIR,0,200*1);
		      System.arraycopy(origin.HI_VIRR,0,this.HI_VIRR,0,45*300*1);
		      System.arraycopy(origin.HI_VIRT,0,this.HI_VIRT,0,1);
		      System.arraycopy(origin.HI_VLG,0,this.HI_VLG,0,1);
		      System.arraycopy(origin.HI_VLGB,0,this.HI_VLGB,0,1);
		      System.arraycopy(origin.HI_VLGI,0,this.HI_VLGI,0,1);
		      System.arraycopy(origin.HI_VLGM,0,this.HI_VLGM,0,1);
		      System.arraycopy(origin.HI_VLGN,0,this.HI_VLGN,0,1);
		      System.arraycopy(origin.HI_VN2O,0,this.HI_VN2O,0,31*1);
		      System.arraycopy(origin.HI_VNO3,0,this.HI_VNO3,0,12*1);
		      System.arraycopy(origin.HI_VO2,0,this.HI_VO2,0,31*1);
		      System.arraycopy(origin.HI_VPD2,0,this.HI_VPD2,0,200);
		      System.arraycopy(origin.HI_VPTH,0,this.HI_VPTH,0,200);
		      System.arraycopy(origin.HI_VPU,0,this.HI_VPU,0,1);
		      System.arraycopy(origin.HI_VQ,0,this.HI_VQ,0,90*4);
		      System.arraycopy(origin.HI_VRSE,0,this.HI_VRSE,0,1);
		      System.arraycopy(origin.HI_VSK,0,this.HI_VSK,0,1);
		      System.arraycopy(origin.HI_VSLT,0,this.HI_VSLT,0,1);
		      System.arraycopy(origin.HI_VURN,0,this.HI_VURN,0,10*1);
		      System.arraycopy(origin.HI_VWC,0,this.HI_VWC,0,31*1);
		      System.arraycopy(origin.HI_VWP,0,this.HI_VWP,0,31*1);
		      System.arraycopy(origin.HI_VY,0,this.HI_VY,0,90*4);
		      System.arraycopy(origin.HI_WA,0,this.HI_WA,0,200);
		      System.arraycopy(origin.HI_WAC2,0,this.HI_WAC2,0,2*200);
		      System.arraycopy(origin.HI_WAVP,0,this.HI_WAVP,0,200);
		      System.arraycopy(origin.HI_WBMC,0,this.HI_WBMC,0,31*1);
		      System.arraycopy(origin.HI_WBMN,0,this.HI_WBMN,0,12*1);
		      System.arraycopy(origin.HI_WCHT,0,this.HI_WCHT,0,200*1);
		      System.arraycopy(origin.HI_WCMU,0,this.HI_WCMU,0,12*1);
		      System.arraycopy(origin.HI_WCO2G,0,this.HI_WCO2G,0,31*1);
		      System.arraycopy(origin.HI_WCO2L,0,this.HI_WCO2L,0,31*1);
		      System.arraycopy(origin.HI_WCOU,0,this.HI_WCOU,0,12*1);
		      System.arraycopy(origin.HI_WCY,0,this.HI_WCY,0,200);
		      System.arraycopy(origin.HI_WDRM,0,this.HI_WDRM,0,1);
		      System.arraycopy(origin.HI_WFA,0,this.HI_WFA,0,45*300*1);
		      System.arraycopy(origin.HI_WHPC,0,this.HI_WHPC,0,12*1);
		      System.arraycopy(origin.HI_WHPN,0,this.HI_WHPN,0,12*1);
		      System.arraycopy(origin.HI_WHSC,0,this.HI_WHSC,0,12*1);
		      System.arraycopy(origin.HI_WHSN,0,this.HI_WHSN,0,12*1);
		      System.arraycopy(origin.HI_WK,0,this.HI_WK,0,1);
		      System.arraycopy(origin.HI_WKMU,0,this.HI_WKMU,0,12*1);
		      System.arraycopy(origin.HI_WLM,0,this.HI_WLM,0,12*1);
		      System.arraycopy(origin.HI_WLMC,0,this.HI_WLMC,0,12*1);
		      System.arraycopy(origin.HI_WLMN,0,this.HI_WLMN,0,12*1);
		      System.arraycopy(origin.HI_WLS,0,this.HI_WLS,0,12*1);
		      System.arraycopy(origin.HI_WLSC,0,this.HI_WLSC,0,12*1);
		      System.arraycopy(origin.HI_WLSL,0,this.HI_WLSL,0,12*1);
		      System.arraycopy(origin.HI_WLSLC,0,this.HI_WLSLC,0,12*1);
		      System.arraycopy(origin.HI_WLSLNC,0,this.HI_WLSLNC,0,12*1);
		      System.arraycopy(origin.HI_WLSN,0,this.HI_WLSN,0,12*1);
		      System.arraycopy(origin.HI_WLV,0,this.HI_WLV,0,200*1);
		      System.arraycopy(origin.HI_WN2O,0,this.HI_WN2O,0,31*1);
		      System.arraycopy(origin.HI_WN2OG,0,this.HI_WN2OG,0,31*1);
		      System.arraycopy(origin.HI_WN2OL,0,this.HI_WN2OL,0,31*1);
		      System.arraycopy(origin.HI_WNH3,0,this.HI_WNH3,0,31*1);
		      System.arraycopy(origin.HI_WNMU,0,this.HI_WNMU,0,12*1);
		      System.arraycopy(origin.HI_WNO2,0,this.HI_WNO2,0,31*1);
		      System.arraycopy(origin.HI_WNO3,0,this.HI_WNO3,0,31*1);
		      System.arraycopy(origin.HI_WNOU,0,this.HI_WNOU,0,12*1);
		      System.arraycopy(origin.HI_WO2G,0,this.HI_WO2G,0,31*1);
		      System.arraycopy(origin.HI_WO2L,0,this.HI_WO2L,0,31*1);
		      System.arraycopy(origin.HI_WOC,0,this.HI_WOC,0,12*1);
		      System.arraycopy(origin.HI_WON,0,this.HI_WON,0,12*1);
		      System.arraycopy(origin.HI_WPMA,0,this.HI_WPMA,0,12*1);
		      System.arraycopy(origin.HI_WPML,0,this.HI_WPML,0,31*1);
		      System.arraycopy(origin.HI_WPMS,0,this.HI_WPMS,0,12*1);
		      System.arraycopy(origin.HI_WPMU,0,this.HI_WPMU,0,12*1);
		      System.arraycopy(origin.HI_WPO,0,this.HI_WPO,0,12*1);
		      System.arraycopy(origin.HI_WPOU,0,this.HI_WPOU,0,12*1);
		      System.arraycopy(origin.HI_WS,0,this.HI_WS,0,1);
		      System.arraycopy(origin.HI_WSA,0,this.HI_WSA,0,1);
		      System.arraycopy(origin.HI_WSLT,0,this.HI_WSLT,0,12*1);
		      System.arraycopy(origin.HI_WSX,0,this.HI_WSX,0,1);
		      System.arraycopy(origin.HI_WSYF,0,this.HI_WSYF,0,200);
		      System.arraycopy(origin.HI_WT,0,this.HI_WT,0,12*1);
		      System.arraycopy(origin.HI_WTBL,0,this.HI_WTBL,0,1);
		      System.arraycopy(origin.HI_WTMB,0,this.HI_WTMB,0,1);
		      System.arraycopy(origin.HI_WTMN,0,this.HI_WTMN,0,1);
		      System.arraycopy(origin.HI_WTMU,0,this.HI_WTMU,0,1);
		      System.arraycopy(origin.HI_WTMX,0,this.HI_WTMX,0,1);
		      System.arraycopy(origin.HI_WXYF,0,this.HI_WXYF,0,200);
		      System.arraycopy(origin.HI_WYLD,0,this.HI_WYLD,0,4);
		      System.arraycopy(origin.HI_XCT,0,this.HI_XCT,0,1);
		      System.arraycopy(origin.HI_XDLA0,0,this.HI_XDLA0,0,200*1);
		      System.arraycopy(origin.HI_XDLAI,0,this.HI_XDLAI,0,200);
		      System.arraycopy(origin.HI_XHSM,0,this.HI_XHSM,0,1);
		      System.arraycopy(origin.HI_XIDK,0,this.HI_XIDK,0,1);
		      System.arraycopy(origin.HI_XIDS,0,this.HI_XIDS,0,1);
		      System.arraycopy(origin.HI_XLAI,0,this.HI_XLAI,0,200*1);
		      System.arraycopy(origin.HI_XMAP,0,this.HI_XMAP,0,1);
		      System.arraycopy(origin.HI_XMS,0,this.HI_XMS,0,30*1);
		      System.arraycopy(origin.HI_XMTU,0,this.HI_XMTU,0,200);
		      System.arraycopy(origin.HI_XN2O,0,this.HI_XN2O,0,31*1);
		      System.arraycopy(origin.HI_XNS,0,this.HI_XNS,0,1);
		      System.arraycopy(origin.HI_XRFI,0,this.HI_XRFI,0,1);
		      System.arraycopy(origin.HI_XZP,0,this.HI_XZP,0,13*13*1);
		      System.arraycopy(origin.HI_YC,0,this.HI_YC,0,4);
		      System.arraycopy(origin.HI_YCOU,0,this.HI_YCOU,0,4);
		      System.arraycopy(origin.HI_YCT,0,this.HI_YCT,0,1);
		      System.arraycopy(origin.HI_YCWN,0,this.HI_YCWN,0,4);
		      System.arraycopy(origin.HI_YHY,0,this.HI_YHY,0,720*4);
		      System.arraycopy(origin.HI_YLC,0,this.HI_YLC,0,1);
		      System.arraycopy(origin.HI_YLD,0,this.HI_YLD,0,200);
		      System.arraycopy(origin.HI_YLD1,0,this.HI_YLD1,0,200*1);
		      System.arraycopy(origin.HI_YLD2,0,this.HI_YLD2,0,200*1);
		      System.arraycopy(origin.HI_YLKF,0,this.HI_YLKF,0,200*1);
		      System.arraycopy(origin.HI_YLNF,0,this.HI_YLNF,0,200*1);
		      System.arraycopy(origin.HI_YLPF,0,this.HI_YLPF,0,200*1);
		      System.arraycopy(origin.HI_YLS,0,this.HI_YLS,0,1);
		      System.arraycopy(origin.HI_YLX,0,this.HI_YLX,0,200);
		      System.arraycopy(origin.HI_YMNU,0,this.HI_YMNU,0,4);
		      System.arraycopy(origin.HI_YN,0,this.HI_YN,0,4);
		      System.arraycopy(origin.HI_YNOU,0,this.HI_YNOU,0,4);
		      System.arraycopy(origin.HI_YNWN,0,this.HI_YNWN,0,4);
		      System.arraycopy(origin.HI_YP,0,this.HI_YP,0,4);
		      System.arraycopy(origin.HI_YPOU,0,this.HI_YPOU,0,4);
		      System.arraycopy(origin.HI_YPST,0,this.HI_YPST,0,60*4);
		      System.arraycopy(origin.HI_YPWN,0,this.HI_YPWN,0,4);
		      System.arraycopy(origin.HI_YSD,0,this.HI_YSD,0,8*4);
		      System.arraycopy(origin.HI_YTN,0,this.HI_YTN,0,1);
		      System.arraycopy(origin.HI_YTX,0,this.HI_YTX,0,1);
		      System.arraycopy(origin.HI_YW,0,this.HI_YW,0,4);
		      System.arraycopy(origin.HI_Z,0,this.HI_Z,0,12*1);
		      System.arraycopy(origin.HI_ZBMC,0,this.HI_ZBMC,0,1);
		      System.arraycopy(origin.HI_ZBMN,0,this.HI_ZBMN,0,1);
		      System.arraycopy(origin.HI_ZC,0,this.HI_ZC,0,31*1);
		      System.arraycopy(origin.HI_ZCO,0,this.HI_ZCO,0,1);
		      System.arraycopy(origin.HI_ZCOB,0,this.HI_ZCOB,0,1);
		      System.arraycopy(origin.HI_ZEK,0,this.HI_ZEK,0,1);
		      System.arraycopy(origin.HI_ZFK,0,this.HI_ZFK,0,1);
		      System.arraycopy(origin.HI_ZFOP,0,this.HI_ZFOP,0,1);
		      System.arraycopy(origin.HI_ZHPC,0,this.HI_ZHPC,0,1);
		      System.arraycopy(origin.HI_ZHPN,0,this.HI_ZHPN,0,1);
		      System.arraycopy(origin.HI_ZHSC,0,this.HI_ZHSC,0,1);
		      System.arraycopy(origin.HI_ZHSN,0,this.HI_ZHSN,0,1);
		      System.arraycopy(origin.HI_ZLM,0,this.HI_ZLM,0,1);
		      System.arraycopy(origin.HI_ZLMC,0,this.HI_ZLMC,0,1);
		      System.arraycopy(origin.HI_ZLMN,0,this.HI_ZLMN,0,1);
		      System.arraycopy(origin.HI_ZLS,0,this.HI_ZLS,0,1);
		      System.arraycopy(origin.HI_ZLSC,0,this.HI_ZLSC,0,1);
		      System.arraycopy(origin.HI_ZLSL,0,this.HI_ZLSL,0,1);
		      System.arraycopy(origin.HI_ZLSLC,0,this.HI_ZLSLC,0,1);
		      System.arraycopy(origin.HI_ZLSLNC,0,this.HI_ZLSLNC,0,1);
		      System.arraycopy(origin.HI_ZLSN,0,this.HI_ZLSN,0,1);
		      System.arraycopy(origin.HI_ZNMA,0,this.HI_ZNMA,0,1);
		      System.arraycopy(origin.HI_ZNMN,0,this.HI_ZNMN,0,1);
		      System.arraycopy(origin.HI_ZNMU,0,this.HI_ZNMU,0,1);
		      System.arraycopy(origin.HI_ZNOA,0,this.HI_ZNOA,0,1);
		      System.arraycopy(origin.HI_ZNOS,0,this.HI_ZNOS,0,1);
		      System.arraycopy(origin.HI_ZNOU,0,this.HI_ZNOU,0,1);
		      System.arraycopy(origin.HI_ZOC,0,this.HI_ZOC,0,1);
		      System.arraycopy(origin.HI_ZON,0,this.HI_ZON,0,1);
		      System.arraycopy(origin.HI_ZPMA,0,this.HI_ZPMA,0,1);
		      System.arraycopy(origin.HI_ZPML,0,this.HI_ZPML,0,1);
		      System.arraycopy(origin.HI_ZPMS,0,this.HI_ZPMS,0,1);
		      System.arraycopy(origin.HI_ZPMU,0,this.HI_ZPMU,0,1);
		      System.arraycopy(origin.HI_ZPO,0,this.HI_ZPO,0,1);
		      System.arraycopy(origin.HI_ZPOU,0,this.HI_ZPOU,0,1);
		      System.arraycopy(origin.HI_ZSK,0,this.HI_ZSK,0,1);
		      System.arraycopy(origin.HI_ZSLT,0,this.HI_ZSLT,0,1);
		      System.arraycopy(origin.HI_ZTP,0,this.HI_ZTP,0,1);

    }


	@Override
	protected List getFieldOrder() {
		return Arrays.asList(new String[] { 
				"HI_IBD","HI_IBDT","HI_ICDP","HI_ICMD","HI_ICO2","HI_ICP","HI_IDA","HI_IDAY","HI_IDIR","HI_IDN1","HI_IDN2","HI_IDNT","HI_IDO",
				"HI_IERT","HI_IET","HI_IGC","HI_IGN","HI_IGSD","HI_IHD","HI_IHRD","HI_IHV","HI_IHUS","HI_IHY","HI_III","HI_IKAT","HI_IMON","HI_INFL","HI_INP",
				"HI_IOF","HI_IOW","HI_IOX","HI_IPAT","HI_IPC","HI_IPD","HI_IPF","HI_IPL","HI_IPRK","HI_IPY","HI_IPYI","HI_IRGX","HI_IRH","HI_IRUN","HI_ISA","HI_ISAP",
				"HI_ISCN","HI_ISLF","HI_ISL","HI_ISTA","HI_ISW","HI_IT1","HI_IT2","HI_IT3","HI_ITYP","HI_IUN","HI_IWI","HI_IWTB","HI_IY","HI_IYER","HI_IYR",
				"HI_IYR0","HI_IYX","HI_JD0","HI_JDA","HI_JDE","HI_JDHU","HI_JJK","HI_JT1","HI_JT2",
				"HI_KDA","HI_KF","HI_KI","HI_KP","HI_LBP","HI_KND","HI_LC","HI_LGRZ","HI_LGZ","HI_LND","HI_LNS","HI_LPD","HI_LPYR","HI_LW","HI_MASP",
				"HI_MBS","HI_MCA12","HI_MFT","HI_MHD","HI_MHP","HI_MHX","HI_MHY","HI_ML1","HI_MNC","HI_MNT","HI_MNUL","HI_MO","HI_MO1","HI_MOW","HI_MPO","HI_MPS",
				"HI_MRO","HI_MSA","HI_MSC","HI_MSCP","HI_MSL","HI_MXT","HI_MXW","HI_NAQ","HI_NBCL","HI_NBCX","HI_NBDT","HI_NBFX","HI_NBMX","HI_NBON","HI_NBYR",
				"HI_NCMD","HI_NCMO","HI_ND","HI_NDF","HI_NDP","HI_NDRV","HI_NDT","HI_NDVSS","HI_NDWT","HI_NEV","HI_NGN","HI_NGN0","HI_NJC","HI_NKA","HI_NKD",
				"HI_NKS","HI_NKY","HI_NOFL","HI_NOP","HI_NPD","HI_NPRC","HI_NPSO","HI_NRF","HI_NSH","HI_NSM","HI_MSO","HI_NSNN","HI_NSTP","HI_NSX",
				"HI_NSZ","HI_NYD","HI_NT0","HI_NT1","HI_NTV","HI_NUPC","HI_NWP","HI_NWTH",
				"HI_KDT1","HI_KDC1","HI_KDF1","HI_KDP1","HI_KA","HI_NXP","HI_KR","HI_KDT2","HI_KD","HI_KY","HI_KDP","HI_NHC",
				"HI_KS","HI_NWDR","HI_IX","HI_NC","HI_IDG","HI_IX0","HI_IAD","HI_ICMO","HI_NWPD","HI_NDC","HI_JX","HI_KGN","HI_JC",
				"HI_IAC","HI_IAMF","HI_IAPL", "HI_IAUF","HI_IAUI","HI_IAUL","HI_IBSA",
				"HI_ICDT","HI_ICUS","HI_IDC","HI_IDF0",
			    "HI_IDFA","HI_IDFD","HI_IDFH","HI_IDFT","HI_IDMU",
			    "HI_IDN1T","HI_IDN2T","HI_IDNB","HI_IDNF","HI_IDOA","HI_IDON","HI_IDOT","HI_IDOW",
			    "HI_IDR","HI_IDRL","HI_IDRO","HI_IDS","HI_IDSL","HI_IDSS",
			    "HI_IEXT","HI_IFA","HI_IFD","HI_IFED","HI_IFLO","HI_IFLS","HI_IGO","HI_IGZ",
			    "HI_IGZO","HI_IGZX","HI_IHBS","HI_IHC","HI_IHDM","HI_IHDT","HI_IHRL","HI_IHT","HI_IHU","HI_IHX","HI_IIR","HI_ILQF","HI_IMW","HI_IPMP",
			    "HI_IPSF","HI_IPSO","HI_IPST","HI_IPTS","HI_IRF","HI_IRI","HI_IRO","HI_IRP","HI_IRR","HI_IRRS","HI_ISAL","HI_ISAO","HI_ISAS","HI_ISCP",
			    "HI_ISG","HI_ISPF","HI_ITL","HI_IWTH","HI_IYH","HI_IYHO","HI_JBG","HI_JCN","HI_JCN0","HI_JCN1","HI_JD","HI_JE","HI_JH","HI_JP","HI_JPC","HI_JPL",
			    "HI_KC","HI_KDC","HI_KDF","HI_KDT","HI_KFL","HI_KGO","HI_KIR","HI_KOMP","HI_KP1","HI_KPC","HI_KPSN","HI_KT","HI_KTF","HI_KTMX","HI_KTT","HI_KW",
			    "HI_LFT","HI_LGIR","HI_LID","HI_LM","HI_LORG","HI_LPC","HI_LRD","HI_LT","HI_LUN","HI_LUNS","HI_LY","HI_LYR",
			    "HI_MXSR","HI_NBCF","HI_NBCT","HI_NBE","HI_NBFF","HI_NBFT","HI_NBHS","HI_NBSA","HI_NBSL","HI_NBSX","HI_NBT","HI_NBW",
			    "HI_NCOW","HI_NCP","HI_NCR","HI_NDFA","HI_NFED","HI_NFRT","HI_NGIX","HI_NGZ","HI_NGZA","HI_NHBS","HI_NHRD","HI_NHU","HI_NHY",
			    "HI_NII","HI_NIR","HI_NISA","HI_NMW","HI_NPC","HI_NPSF","HI_NPST","HI_NQRB","HI_NRO","HI_NSAL",
			    "HI_NSAO","HI_NSAS","HI_NTL","HI_NTP","HI_NTX","HI_NVCN","HI_NWDA","HI_NYHO","HI_NYLN",
				"HI_ACW","HI_ADEO","HI_ADHY","HI_ADRF","HI_AEPT","HI_AET","HI_AFN","HI_AGP","HI_AHSM","HI_AJWA","HI_ALG","HI_ALMN","HI_ALTC",
				"HI_AL5","HI_AMPX","HI_ANG","HI_AMSR","HI_AVT","HI_BETA","HI_BRNG","HI_BS1","HI_BS2","HI_BXCT",
				"HI_BYCT","HI_CBVT","HI_CLF","HI_CLT","HI_CMM","HI_CMS","HI_CN","HI_CNO3I","HI_COIR","HI_COL","HI_CON","HI_COP","HI_CO2","HI_COS1","HI_CPH0",
				"HI_CPV0","HI_CPVV","HI_CQNI","HI_CRLNC","HI_CRUNC","HI_CSFX","HI_CSLT","HI_D150","HI_DAYL","HI_DD","HI_DEMR","HI_DN2O","HI_DRSW",
				"HI_DRTO","HI_DTG","HI_DTHY","HI_DUR","HI_DURG","HI_DVOL","HI_DZ10","HI_DZDN","HI_EI","HI_ELEV","HI_EO","HI_ERTN","HI_ERTO",
				"HI_ERTP","HI_ES","HI_EXNN","HI_EXPK","HI_FL","HI_FULP","HI_FW","HI_GWBX","HI_GX","HI_HGX","HI_HMN","HI_HRLT","HI_HR1","HI_PB","HI_PI2","HI_PIT",
				"HI_PMOEO","HI_PMORF","HI_PRFF","HI_PSTX","HI_QAPY","HI_QRB","HI_QSFN","HI_QSFP","HI_QTH","HI_RAMX","HI_REP","HI_RFNC","HI_RFQN",
			    "HI_RFRA","HI_RGIN","HI_RGRF","HI_RHCF","HI_RHM","HI_RHP","HI_RHS","HI_RM","HI_RMNR","HI_RMX0","HI_RNO3",
			    "HI_RRF","HI_RTP","HI_RUNT","HI_RWO","HI_SAET","HI_SALF","HI_SAT","HI_SBAL","HI_SCN","HI_SCN2","HI_SDEG",
			    "HI_SDEP","HI_SDN","HI_SDRF","HI_SEP","HI_SGMN","HI_SHRL","HI_SK","HI_SML","HI_SMNR","HI_SMP","HI_SMSQ","HI_SN2","HI_SN2O","HI_SNIT","HI_SN",
			    "HI_SNMN","HI_SNOF","HI_SNPKT","HI_SOFU","HI_SP","HI_SPRC","HI_SPRF","HI_SRPM","HI_SSFK","HI_SSFN","HI_SSST","HI_STND","HI_SUK",
			    "HI_SUN","HI_SUP","HI_SVOL",
				"HI_SX","HI_SYMU","HI_SYW","HI_TA","HI_TDEG","HI_TDEP","HI_TEVP","HI_TEV1","HI_TFMA","HI_TFMN","HI_TFNO","HI_THW","HI_TLA",
				"HI_TMAF","HI_TMAP","HI_TMPD","HI_TPRK","HI_TPSP","HI_TREV","HI_TRFR","HI_TRSP","HI_TSAE","HI_TSFS","HI_TX","HI_TXXM","HI_UK2","HI_UKM",
				"HI_UNM","HI_UNR","HI_UN2","HI_UPM","HI_UPR","HI_UP2","HI_USTRT","HI_USTT","HI_USTW","HI_UX","HI_UXP","HI_V56","HI_V57","HI_VGF","HI_VMU","HI_VPD",
				"HI_V1","HI_V3","HI_WAGE","HI_WB","HI_WCF","HI_WCYD","HI_WDN","HI_WFX","HI_WIM","HI_WIP","HI_WKA","HI_WKMNH3","HI_WKMNO2","HI_WKMNO3",
				"HI_WMP","HI_WNCMAX","HI_WNCMIN","HI_WTN","HI_XCS","HI_XDA","HI_XDA1","HI_XET","HI_XK1","HI_XK2","HI_XKN1","HI_XKN3","HI_XKN5","HI_XKP1",
				"HI_XKP2","HI_XSA","HI_XSL","HI_YCS","HI_YERO","HI_YEW","HI_YEWN","HI_YLAT","HI_YLAZ","HI_YLN","HI_YLP","HI_YMP","HI_YSL","HI_YWKS","HI_ZF","HI_ZQT",
				"HI_XTP","HI_XYP","HI_PRMT","HI_SMYR","HI_VARS","HI_RNCF","HI_TAV","HI_TMNF","HI_TMXF","HI_UAV0","HI_UAVM","HI_AWXP","HI_RFSG","HI_SMSO",
				"HI_OPV","HI_SMSW","HI_PSZ","HI_PSZX","HI_PSZY","HI_BUS","HI_WX","HI_XAV","HI_XDV",
				"HI_XIM","HI_XRG","HI_SMMR","HI_SMR","HI_DIR","HI_OBMN","HI_OBMNX","HI_OBMX","HI_OBSL","HI_PCF","HI_RH","HI_SDTMN",
				"HI_SDTMX","HI_WFT","HI_WI","HI_SCRP","HI_CQRB","HI_RST","HI_PRW",			
				"HI_ABD",
			    "HI_ACET",
			    "HI_ACO2C",
			    "HI_AEP",
			    "HI_AFLG",
			    "HI_AFP",
			    "HI_AGPM",
			    "HI_AJHI",
			    "HI_ALGI",
			    "HI_ALQ",
			    "HI_ALS",
			    "HI_ALT",
			    "HI_AN2OC",
			    "HI_ANA",
			    "HI_AO2C",
			    "HI_ARMN",
			    "HI_ARMX",
			    "HI_ARSD",
			    "HI_ASW",
			    "HI_AWC",
			    "HI_BA1",
			    "HI_BA2",
			    "HI_BCOF",
			    "HI_BCV",
			    "HI_BD",
			    "HI_BDD",
			    "HI_BDM",
			    "HI_BDP",
			    "HI_BFFL",
			    "HI_BFSN",
			    "HI_BFT",
			    "HI_BGWS",
			    "HI_BIG",
			    "HI_BIR",
			    "HI_BK",
			    "HI_BLG",
			    "HI_BN",
			    "HI_BP",
			    "HI_BPT",
			    "HI_BR1",
			    "HI_BR2",
			    "HI_BRSV",
			    "HI_BSALA",
			    "HI_BSNO",
			    "HI_BTC",
			    "HI_BTCX",
			    "HI_BTCZ",
			    "HI_BTK",
			    "HI_BTN",
			    "HI_BTNX",
			    "HI_BTNZ",
			    "HI_BTP",
			    "HI_BTPX",
			    "HI_BTPZ",
			    "HI_BV1",
			    "HI_BV2",
			    "HI_BVIR",
			    "HI_BWN",
			    "HI_CAC",
			    "HI_CAF",
			    "HI_CAW",
			    "HI_CBN",
			    "HI_CDG",
			    "HI_CEC",
			    "HI_CFNP",
			    "HI_CGCO2",
			    "HI_CGN2O",
			    "HI_CGO2",
			    "HI_CHL",
			    "HI_CHN",
			    "HI_CHS",
			    "HI_CHXA",
			    "HI_CHXP",
			    "HI_CKY",
			    "HI_CLA",
			    "HI_CLCO2",
			    "HI_CLG",
			    "HI_CLN2O",
			    "HI_CLO2",
			    "HI_CN0",
			    "HI_CN2",
			    "HI_CND",
			    "HI_CNDS",
			    "HI_CNLV",
			    "HI_CNRT",
			    "HI_CNSC",
			    "HI_CNSX",
			    "HI_CNY",
			    "HI_COOP",
			    "HI_COST",
			    "HI_COTL",
			    "HI_COWW",
			    "HI_CPFH",
			    "HI_CPHT",
			    "HI_CPMX",
			    "HI_CPRH",
			    "HI_CPRV",
			    "HI_CPVH",
			    "HI_CPY",
			    "HI_CST1",
			    "HI_CSTF",
			    "HI_CSTS",
			    "HI_CTSA",
			    "HI_CV",
			    "HI_CVF",
			    "HI_CVP",
			    "HI_CVRS",
			    "HI_CX",
			    "HI_CYAV",
			    "HI_CYMX",
			    "HI_CYSD",
			    "HI_DALG",
			    "HI_DCO2GEN",
			    "HI_DDLG",
			    "HI_DDM",
			    "HI_DEPC",
			    "HI_DHN",
			    "HI_DHT",
			    "HI_DKH",
			    "HI_DKHL",
			    "HI_DKI",
			    "HI_DKIN",
			    "HI_DLAI",
			    "HI_DLAP",
			    "HI_DM",
			    "HI_DM1",
			    "HI_DMF",
			    "HI_DMLA",
			    "HI_DMLX",
			    "HI_DMN", // Inserted MB 7/24/19
			    "HI_DN2G",
			    "HI_DN2OG",
			    "HI_DO2CONS",
			    "HI_DPMT",
			    "HI_DPRC",
			    "HI_DPRN",
			    "HI_DPRO",
			    "HI_DRAV",
			    "HI_DRT",
			    "HI_DRWX",
			    "HI_DST0",
			    "HI_DUMP",
			    "HI_DWOC",
			    "HI_EAR",
			    "HI_ECND",
			    "HI_EFI",
			    "HI_EFM",
			    "HI_EK",
			    "HI_EM10",
			    "HI_EMX",
			    "HI_EO5",
			    "HI_EP",
			    "HI_EQKE",
			    "HI_EQKS",
			    "HI_ERAV",
			    "HI_ETG",
			    "HI_EVRS",
			    "HI_EVRT",
			    "HI_EXCK",
			    "HI_EXTC",
			    "HI_FBM",
			    "HI_FC",
			    "HI_FCMN",
			    "HI_FCMP",
			    "HI_FCST",
			    "HI_FDSF",
			    "HI_FE26",
			    "HI_FFC",
			    "HI_FFED",
			    "HI_FFPQ",
			    "HI_FGC",
			    "HI_FGSL",
			    "HI_FHP",
			    "HI_FIRG",
			    "HI_FIRX",
			    "HI_FIXK",
			    "HI_FK",
			    "HI_FLT",
			    "HI_FN",
			    "HI_FNMA",
			    "HI_FNMN",
			    "HI_FNMX",
			    "HI_FNO",
			    "HI_FNP",
			    "HI_FOC",
			    "HI_FOP",
			    "HI_FP",
			    "HI_FPF",
			    "HI_FPO",
			    "HI_FPOP",
			    "HI_FPSC",
			    "HI_FRCP",
			    "HI_FRST",
			    "HI_FRTK",
			    "HI_FRTN",
			    "HI_FRTP",
			    "HI_FSFN",
			    "HI_FSFP",
			    "HI_FSLT",
			    "HI_FTO",
			    "HI_FULU",
			    "HI_GCOW",
			    "HI_GMA",
			    "HI_GMHU",
			    "HI_GRDD",
			    "HI_GRDL",
			    "HI_GRLV",
			    "HI_GSI",
			    "HI_GWMX",
			    "HI_GWPS",
			    "HI_GWSN",
			    "HI_GWST",
			    "HI_GZLM",
			    "HI_GZRT",
			    "HI_HA",
			    "HI_HCL",
			    "HI_HCLD",
			    "HI_HCLN",
			    "HI_HE",
			    "HI_HI",
			    "HI_HKPC",
			    "HI_HKPN",
			    "HI_HKPO",
			    "HI_HLMN",
			    "HI_HMO",
			    "HI_HMX",
			    "HI_HR0",
			    "HI_HSM",
			    "HI_HU",
			    "HI_HUF",
			    "HI_HUI",
			    "HI_HUSC",
			    "HI_HYDV",
			    "HI_OCPD",
			    "HI_OMAP",
			    "HI_ORHI",
			    "HI_ORSD",
			    "HI_OSAA",
			    "HI_OWSA",
			    "HI_PAW",
			    "HI_PCOF",
			    "HI_PCST",
			    "HI_PCT",
			    "HI_PCTH",
			    "HI_PDAW",
			    "HI_PDPL",
			    "HI_PDPL0",
			    "HI_PDPLC",
			    "HI_PDPLX",
			    "HI_PDSKC",
			    "HI_PDSW",
			    "HI_PEC",
			    "HI_PFOL",
			    "HI_PH",
			    "HI_PHLF",
			    "HI_PHLS",
			    "HI_PHU",
			    "HI_PHUX",
			    "HI_PKOC",
			    "HI_PKRZ",
			    "HI_PLAX",
			    "HI_PLCH",
			    "HI_PM10",
			    "HI_PMX",
			    "HI_PO",
			    "HI_POP",
			    "HI_POPX",
			    "HI_PPCF",
			    "HI_PPL0",
			    "HI_PPLA",
			    "HI_PPLP",
			    "HI_PPX",
			    "HI_PQPS",
			    "HI_PRAV",
			    "HI_PRB",
			    "HI_PRSD",
			    "HI_PRYF",
			    "HI_PRYG",
			    "HI_PSO3",
			    "HI_PSOL",
			    "HI_PSON",
			    "HI_PSOP",
			    "HI_PSOQ",
			    "HI_PSOY",
			    "HI_PSP",
			    "HI_PSSF",
			    "HI_PSSP",
			    "HI_PST",
			    "HI_PSTE",
			    "HI_PSTF",
			    "HI_PSTM",
			    "HI_PSTR",
			    "HI_PSTS",
			    "HI_PSTZ",
			    "HI_PSZM",
			    "HI_PVQ",
			    "HI_PVY",
			    "HI_PWOF",
			    "HI_PYPS",
			    "HI_QC",
			    "HI_QCAP",
			    "HI_QDR",
			    "HI_QDRN",
			    "HI_QDRP",
			    "HI_QGA",
			    "HI_QHY",
			    "HI_QIN",
			    "HI_QIR",
			    "HI_QN",
			    "HI_QP",
			    "HI_QPR",
			    "HI_QPST",
			    "HI_QPU",
			    "HI_QRBQ",
			    "HI_QRF",
			    "HI_QRFN",
			    "HI_QRFP",
			    "HI_QRP",
			    "HI_QRQB",
			    "HI_QSF",
			    "HI_QURB",
			    "HI_QVOL",
			    "HI_RBMD",
			    "HI_RCBW",
			    "HI_RCF",
			    "HI_RCHC",
			    "HI_RCHD",
			    "HI_RCHK",
			    "HI_RCHL",
			    "HI_RCHN",
			    "HI_RCHS",
			    "HI_RCHX",
			    "HI_RCSS",
			    "HI_RCTC",
			    "HI_RCTW",
			    "HI_RD",
			    "HI_RDF",
			    "HI_RDMX",
			    "HI_REG",
			    "HI_REPI",
			    "HI_RF5",
			    "HI_RFDT",
			    "HI_RFPK",
			    "HI_RFPL",
			    "HI_RFPS",
			    "HI_RFPW",
			    "HI_RFPX",
			    "HI_RFTT",
			    "HI_RFV",
			    "HI_RFV0",
			    "HI_RHD",
			    "HI_RHT",
			    "HI_RHTT",
			    "HI_RIN",
			    "HI_RINT",
			    "HI_RLAD",
			    "HI_RLF",
			    "HI_RMXS",
			    "HI_RNMN",
			    "HI_ROK",
			    "HI_ROSP",
			    "HI_RQRB",
			    "HI_RR",
			    "HI_RRUF",
			    "HI_RSAE",
			    "HI_RSAP",
			    "HI_RSBD",
			    "HI_RSD",
			    "HI_RSDM",
			    "HI_RSDP",
			    "HI_RSEE",
			    "HI_RSEP",
			    "HI_RSF",
			    "HI_RSFN",
			    "HI_RSHC",
			    "HI_RSK",
			    "HI_RSLK",
			    "HI_RSO3",
			    "HI_RSOC",
			    "HI_RSON",
			    "HI_RSOP",
			    "HI_RSPC",
			    "HI_RSPK",
			    "HI_RSPS",
			    "HI_RSRR",
			    "HI_RSSA",
			    "HI_RSSF",
			    "HI_RSSP",
			    "HI_RST0",
			    "HI_RSTK",
			    "HI_RSV",
			    "HI_RSVB",
			    "HI_RSVE",
			    "HI_RSVF",
			    "HI_RSVP",
			    "HI_RSYB",
			    "HI_RSYF",
			    "HI_RSYN",
			    "HI_RSYS",
			    "HI_RVE0",
			    "HI_RVP0",
			    "HI_RW",
			    "HI_RWPC",
			    "HI_RWSA",
			    "HI_RWT",
			    "HI_RWTZ",
			    "HI_RZ",
			    "HI_RZSW",
			    "HI_S15",
			    "HI_S3",
			    "HI_SALA",
			    "HI_SALB",
			    "HI_SAMA",
			    "HI_SAN",
			    "HI_SATC",
			    "HI_SATK",
			    "HI_SCFS",
			    "HI_SCI",
			    "HI_SCNX",
			    "HI_SDVR",
			    "HI_SDW",
			    "HI_SET",
			    "HI_SEV",
			    "HI_SFCP",
			    "HI_SFMO",
			    "HI_SHYD",
			    "HI_SIL",
			    "HI_SLA0",
			    "HI_SLAI",
			    "HI_SLF",
			    "HI_SLT0",
			    "HI_SLTX",
			    "HI_SM",
			    "HI_SMAP",
			    "HI_SMAS",
			    "HI_SMB",
			    "HI_SMEA",
			    "HI_SMEO",
			    "HI_SMES",
			    "HI_SMFN",
			    "HI_SMFU",
			    "HI_SMH",
			    "HI_SMIO",
			    "HI_SMKS",
			    "HI_SMLA",
			    "HI_SMM",
			    "HI_SMMC",
			    "HI_SMMH",
			    "HI_SMMP",
			    "HI_SMMRP",
			    "HI_SMMU",
			    "HI_SMNS",
			    "HI_SMNU",
			    "HI_SMPL",
			    "HI_SMPQ",
			    "HI_SMPS",
			    "HI_SMPY",
			    "HI_SMRF",
			    "HI_SMRP",
			    "HI_SMS",
			    "HI_SMSS",
			    "HI_SMST",
			    "HI_SMTS",
			    "HI_SMWS",
			    "HI_SMX",
			    "HI_SMY",
			    "HI_SMY1",
			    "HI_SMY2",
			    "HI_SMYH",
			    "HI_SMYP",
			    "HI_SMYRP",
			    "HI_SNO",
			    "HI_SOIL",
			    "HI_SOL",
			    "HI_SOLK",
			    "HI_SOLQ",
			    "HI_SOT",
			    "HI_SPLG",
			    "HI_SQB",
			    "HI_SQVL",
			    "HI_SRA",
			    "HI_SRAD",
			    "HI_SRCH",
			    "HI_SRD",
			    "HI_SRMX",
			    "HI_SRSD",
			    "HI_SSF",
			    "HI_SSFCO2",
			    "HI_SSFI",
			    "HI_SSFN2O",
			    "HI_SSFO2",
			    "HI_SSIN",
			    "HI_SSPS",
			    "HI_SST",
			    "HI_SSW",
			    "HI_ST0",
			    "HI_STD",
			    "HI_STDA",
			    "HI_STDK",
			    "HI_STDL",
			    "HI_STDN",
			    "HI_STDO",
			    "HI_STDOK",
			    "HI_STDON",
			    "HI_STDOP",
			    "HI_STDP",
			    "HI_STFR",
			    "HI_STIR",
			    "HI_STKR",
			    "HI_STL",
			    "HI_STLT",
			    "HI_STMP",
			    "HI_STP",
			    "HI_STV",
			    "HI_STX",
			    "HI_STY",
			    "HI_SULF",
			    "HI_SUT",
			    "HI_SW",
			    "HI_SWB",
			    "HI_SWBD",
			    "HI_SWBX",
			    "HI_SWH",
			    "HI_SWLT",
			    "HI_SWP",
			    "HI_SWST",
			    "HI_SYB",
			    "HI_TAGP",
			    "HI_TAMX",
			    "HI_TBSC",
			    "HI_TC",
			    "HI_TCAV",
			    "HI_TCAW",
			    "HI_TCC",
			    "HI_TCF",		//Inserted MB 7/29/19
			    "HI_TCL",		//Inserted MB 7/29/19
			    "HI_TCMN",
			    "HI_TCMX",
			    "HI_TCN",
			    "HI_TCPA",
			    "HI_TCPY",
			    "HI_TCR",		//Inserted MB 7/29/19
			    "HI_TCS",
			    "HI_TCVF",
			    "HI_TDM",
			    "HI_TEI",
			    "HI_TET",
			    "HI_TETG",
			    "HI_TFLG",
			    "HI_TFTK",
			    "HI_TFTN",
			    "HI_TFTP",
			    "HI_THK",
			    "HI_THRL",
			    "HI_THU",
			    "HI_TILG",
			    "HI_TIR",
			    "HI_TKR",
			    "HI_TLD",
			    "HI_TLF",		//Inserted MB 7/29/19
			    "HI_TLMF",
			    "HI_TMN",
			    "HI_TMX",
			    "HI_TNC",		//Inserted MB 7/29/19
			    "HI_TNF",		//Inserted MB 7/29/19
			    "HI_TNOR",
			    "HI_TNYL",
			    "HI_TOC",
			    "HI_TOPC",
			    "HI_TPOR",
			    "HI_TPSF",
			    "HI_TQ",
			    "HI_TQN",
			    "HI_TQP",
			    "HI_TQPU",
			    "HI_TR",
			    "HI_TRA",
			    "HI_TRD",
			    "HI_TRHT",
			    "HI_TRSD",
			    "HI_TSFC",
			    "HI_TSFK",
			    "HI_TSFN",
			    "HI_TSLA",
			    "HI_TSMY",
			    "HI_TSN",
			    "HI_TSNO",
			    "HI_TSPS",
			    "HI_TSR",
			    "HI_TSY",
			    "HI_TVGF",
			    "HI_TVIR",
			    "HI_TXMN",
			    "HI_TXMX",
			    "HI_TYK",
			    "HI_TYL1",
			    "HI_TYL2",
			    "HI_TYLK",
			    "HI_TYLN",
			    "HI_TYLP",
			    "HI_TYN",
			    "HI_TYON",
			    "HI_TYP",
			    "HI_TYTP",
			    "HI_TYW",
			    "HI_U10",
			    "HI_UB1",
			    "HI_UK",
			    "HI_UK1",
			    "HI_UN",
			    "HI_UN1",
			    "HI_UNA",
			    "HI_UOB",
			    "HI_UP",
			    "HI_UP1",
			    "HI_UPSX",
			    "HI_URBF",
			    "HI_USL",
			    "HI_UW",
			    "HI_VAC",
			    "HI_VALF1",
			    "HI_VAP",
			    "HI_VAR",
			    "HI_VARC",
			    "HI_VARH",
			    "HI_VARP",
			    "HI_VARW",
			    "HI_VCHA",
			    "HI_VCHB",
			    "HI_VCO2",
			    "HI_VFC",
			    "HI_VFPA",
			    "HI_VFPB",
			    "HI_VIMX",
			    "HI_VIR",
			    "HI_VIRR",
			    "HI_VIRT",
			    "HI_VLG",
			    "HI_VLGB",
			    "HI_VLGI",
			    "HI_VLGM",
			    "HI_VLGN",
			    "HI_VN2O",
			    "HI_VNO3",
			    "HI_VO2",
			    "HI_VPD2",
			    "HI_VPTH",
			    "HI_VPU",
			    "HI_VQ",
			    "HI_VRSE",
			    "HI_VSK",
			    "HI_VSLT",
			    "HI_VURN",
			    "HI_VWC",
			    "HI_VWP",
			    "HI_VY",
			    "HI_WA",
			    "HI_WAC2",
			    "HI_WAVP",
			    "HI_WBMC",
			    "HI_WBMN",
			    "HI_WCHT",
			    "HI_WCMU",
			    "HI_WCO2G",
			    "HI_WCO2L",
			    "HI_WCOU",
			    "HI_WCY",
			    "HI_WDRM",
			    "HI_WFA",
			    "HI_WHPC",
			    "HI_WHPN",
			    "HI_WHSC",
			    "HI_WHSN",
			    "HI_WK",
			    "HI_WKMU",
			    "HI_WLM",
			    "HI_WLMC",
			    "HI_WLMN",
			    "HI_WLS",
			    "HI_WLSC",
			    "HI_WLSL",
			    "HI_WLSLC",
			    "HI_WLSLNC",
			    "HI_WLSN",
			    "HI_WLV",
			    "HI_WN2O",
			    "HI_WN2OG",
			    "HI_WN2OL",
			    "HI_WNH3",
			    "HI_WNMU",
			    "HI_WNO2",
			    "HI_WNO3",
			    "HI_WNOU",
			    "HI_WO2G",
			    "HI_WO2L",
			    "HI_WOC",
			    "HI_WON",
			    "HI_WPMA",
			    "HI_WPML",
			    "HI_WPMS",
			    "HI_WPMU",
			    "HI_WPO",
			    "HI_WPOU",
			    "HI_WS",
			    "HI_WSA",
			    "HI_WSLT",
			    "HI_WSX",
			    "HI_WSYF",
			    "HI_WT",
			    "HI_WTBL",
			    "HI_WTMB",
			    "HI_WTMN",
			    "HI_WTMU",
			    "HI_WTMX",
			    "HI_WXYF",
			    "HI_WYLD",
			    "HI_XCT",
			    "HI_XDLA0",
			    "HI_XDLAI",
			    "HI_XHSM",
			    "HI_XIDK",
			    "HI_XIDS",
			    "HI_XLAI",
			    "HI_XMAP",
			    "HI_XMS",
			    "HI_XMTU",
			    "HI_XN2O",
			    "HI_XNS",
			    "HI_XRFI",
			    "HI_XZP",
			    "HI_YC",
			    "HI_YCOU",
			    "HI_YCT",
			    "HI_YCWN",
			    "HI_YHY",
			    "HI_YLC",
			    "HI_YLD",
			    "HI_YLD1",
			    "HI_YLD2",
			    "HI_YLKF",
			    "HI_YLNF",
			    "HI_YLPF",
			    "HI_YLS",
			    "HI_YLX",
			    "HI_YMNU",
			    "HI_YN",
			    "HI_YNOU",
			    "HI_YNWN",
			    "HI_YP",
			    "HI_YPOU",
			    "HI_YPST",
			    "HI_YPWN",
			    "HI_YSD",
			    "HI_YTN",
			    "HI_YTX",
			    "HI_YW",
			    "HI_Z",
			    "HI_ZBMC",
			    "HI_ZBMN",
			    "HI_ZC",
			    "HI_ZCO",
			    "HI_ZCOB",
			    "HI_ZEK",
			    "HI_ZFK",
			    "HI_ZFOP",
			    "HI_ZHPC",
			    "HI_ZHPN",
			    "HI_ZHSC",
			    "HI_ZHSN",
			    "HI_ZLM",
			    "HI_ZLMC",
			    "HI_ZLMN",
			    "HI_ZLS",
			    "HI_ZLSC",
			    "HI_ZLSL",
			    "HI_ZLSLC",
			    "HI_ZLSLNC",
			    "HI_ZLSN",
			    "HI_ZNMA",
			    "HI_ZNMN",
			    "HI_ZNMU",
			    "HI_ZNOA",
			    "HI_ZNOS",
			    "HI_ZNOU",
			    "HI_ZOC",
			    "HI_ZON",
			    "HI_ZPMA",
			    "HI_ZPML",
			    "HI_ZPMS",
			    "HI_ZPMU",
			    "HI_ZPO",
			    "HI_ZPOU",
			    "HI_ZSK",
			    "HI_ZSLT",
			    "HI_ZTP",
			    "HI_HSG",
			    "HI_RTN1",
			    "HI_ZTK",
			    "HI_XLOG",
			    "HI_APM",
		        "HI_BCHL","HI_BCHS","HI_CHD","HI_UPN","HI_SAT1","HI_FPS1","HI_CO2X",
		        "HI_CQNX","HI_RFNX","HI_FMX","HI_SFLG",
		        "HI_YWI","HI_BTA","HI_QG","HI_QCF","HI_CHS0","HI_BWD",
		        "HI_FI","HI_IWND","HI_IRFT","HI_ISOL","HI_IGMX","HI_IAZM","HI_IMO",
		        "HI_NVCN0","HI_INFL0","HI_IMW0","HI_CO20","HI_CQN0","HI_FCW","HI_FPS0","HI_GWS0",
			    "HI_RFT0","HI_RFP0","HI_SAT0","HI_FL0","HI_FW0","HI_ANG0","HI_DRV",
			    "HI_DIAM","HI_GZL0","HI_RTN0","HI_PCO0","HI_RCC0","HI_RFN0"
	
		});
	}
	    
	 
}

	
	



