      SUBROUTINE AINLZ
!     APEX1501
!     THIS SUBPROGRAM INITIALIZES VARIABLES
      USE PARM
      IAD=0
      IAPL=0
      IDFA=0
      IDMU=1
      IDNF=0
      IDRL=0
      IDRO=1
	  IEXT=0
      IFED=0
      IGC=0
      IGO=0
      IGZ=0
      IGZX=0
      IHRL=0
      IHT=0
      IHU=0
	  IHV=0
	  IPL=0
      IPMP=0
      IPSF=0
      IPSO=1
      IPST=0
      IPY=1
      IPYI=1
      IRH=0
      IRP=0
	  ISAS=0
      ISCP=0
      JBG=0
      JCN=0
      JCN0=0
      JCN1=0
      JD0=400
      JE=MNC
      JPL=0
      KDF=0
      KDT=0
      KDT2=0
      KGO=0
      KPSN=0
      KTF=0
      LC=0
	  LW=1
	  LY=0
	  LYR=0
	  MXT=0
	  NBCF=0
	  NBFF=0
	  NCOW=0
	  NCP=0
	  NCR=0
      NDF=0
      NDFA=0
      NDP=0
      NDT=0
	  NDWT=1
	  NEV=1
	  NGZ=0
	  NHRD=0
	  NHU=0
	  NHY=0
	  NMW=0
	  NQRB=0
      NSAO=0
      NTL=0
      NWDA=0
      NYLN=0
      ACET=0.
      ADHY=0.
	  ADRF=100.
	  AFLG=0.
      AGPM=0.
	  AJHI=0.
	  ALGI=0.
	  ALMN=.02083
	  ANA=0.
!	  APQ=0.
!     APY=0.
!     AQB=0.
!     AYB=0.
	  ARSD=0.
      ASW=0.
      AWC=0.
	  BVIR=0.
	  CAW=0.
      CNDS=0.
      CNLV=0.
	  COST=0.
	  CPHT=.01
      CPVH=0.
      CSFX=0.
      CST1=0.
      CSTF=0.
      CV=0.
      CVP=0.
      CVRS=0.
      CX=1.E-10
      CYAV=0.
      CYMX=0.
      CYSD=0.
      D150=0.
	  DEPC=0.
	  DHT=0.
      DKHL=0.
	  DM=0.
      DM1=0.
      DMF=0.
	  DRAV=0.
	  DRWX=0.
	  DUMP=8.
	  EAR=1.
	  ECND=0.
	  EO5=2.
	  EP=0.
	  ERAV=0.
	  ETG=0.
      EVRS=0.
	  EXCK=0.
	  EXTC=.65
	  FCMN=0.
      FCMP=0.
	  FFED=0.
	  FGC=0.
	  FGSL=0.
	  FIXK=0.
	  FNP=0.
	  FPF=0.
      FPSO=''
	  FRTK=0.
	  FRTN=0.
	  FRTP=0.
	  FSFN=0.
	  FSFP=0.
	  FULU=0.
	  GWPS=0.
	  GZLM=1.
	  GZRT=14.
	  HU=0.
	  HUF=0.
	  HUI=0.
	  OCPD=0.
      OMAP=0.
      PAW=0.
      PDAW=0.
      PDPL=0.
      PDSKC=0.
      PDSW=0.
	  PFOL=0.
	  PHU=0.
	  PM10=0.
      PMOEO=100.
      PMORF=100.
      POP=0.
      PPL0=0.
      PPLA=0.
      PRAV=0.
      PRB=0.
      PRSD=0.
      PSTF=1.
      PSTM=0.
      PSTN='                '
      PSTS=0.                      
      PSTZ=0.
	  PSZM=2.
	  PVQ=0.
	  PVY=0.
	  QC=0.
	  QDR=0.
	  QDRN=0.
	  QDRP=0.
	  QGA=0.
	  QHY=0.
	  QIN=0.
	  QN=0.
	  QP=0.
	  QPST=0.
	  QPU=0.
	  QRBQ=0.
      QRF=0.
      QRFN=0.
	  QRQB=0.
	  RCF=1.
	  RD=0.
      RDF=0.
	  REG=0.
	  RF5=0.
	  RFQN=0.
	  RFSG=0.
      RHTT=0.
      RINT=0.
      RMXS=0.
      RMX0=0.
      RNCF=1.
      RNMN=0.
      RRUF=0.
	  RSD=0.
      RSDM=0.
      RSFN=0.
      RSPC=0.
      RSPS=0.
      RSSA=0.
      RSSF=0.
      RST0=0.
      RSTK=0.
      RSVE=0.
	  RSVP=0.
      RSPK=0.
	  RW=0.
	  RWT=0.
	  RZSW=0.
	  SDRF=0.
	  SDVR=0.
	  SET=0.
      SEV=0.
	  SFCP=0.
	  SFMO=0.
      SHRL=1.
      SHYD=0.
      SLAI=0.
      SLA0=.05
      SM=0.
      SMA4=0.
      SMAP=0.
      SMFN=0.
      SMFU=0.
      SMH=0.
      SMIO=0.
      SMLA=.01
      SMM=0.
      SMMH=0.
      SMMP=0.
	  SMMR=0.
	  SMMRP=0.
	  SMMU=0.
      SMNU=0.
      SMR=0.
      SMRP=0.
	  SMS=0.
	  SMSQ=0.
	  SMST=0.
	  SMSW=0.
	  SMY=0.
      SMYH=0.
      SMYP=0.
      SMYR=0.
      SMYRP=0.
      SOFU=0.
      SOIL=0.
      SOLK=0.
      !SPQ=0.
      !SPY=0.
	  SQB=0.
	  SQVL=0.
	  SRA=0.
	  SRAD=0.
	  SRCH=0.
	  SRD=0.
	  SRMX=0.
      SRSD=0.
      SSFCO2=0.
      SSFI=0.
      SSFK=0.
	  SSFN=0.
	  SSFN2O=0.
	  SSFO2=0.
      SSIN=0.
      SST=0.
      SSW=0.
      STD=0.
      STDA=0.
      STDK=0.
      STDL=0.
      STDN=0.
      STDO=0.
      STDOK=0.
      STDON=0.
      STDOP=0.
      STDP=0.
      STIR=0.
      STKR=0.
      STL=0.
      STV=0.
	  STY=0.
      SWLT=0.
      SYB=0.
      SYMU=0.
	  TAGP=0.
	  TAMX=0.
      TC=0.
	  TCAV=0.
	  TCAW=0.
      TCMN=100.
      TCMX=0.
	  TCN=0.
	  TCPA=0.
	  TCPY=0.
	  TCVF=0.
      TDM=0.
      TETG=0.
      TEI=0.
      TET=0.
      TEV1=0.
	  TEVP=0.
	  TFMA=0.
	  TFMN=0.
	  TFNO=0.
	  TFTN=0.
	  TFTP=0.
	  TFTK=0.
	  THK=0.
      THRL=0.
      THU=0.
	  TKR=0.
	  TLMF=0.
      TMAF=0.
      TMAP=0.
	  TMNF=1.
	  TMPD=0.
	  TMXF=0.
	  TNYL=0.
	  TPRK=0.
      TPSF=0.
      TPSP=0.
      TQ=0.
	  TQN=0.
	  TQP=0.
	  TR=0.
	  TRA=0.
      TRD=0.
      TRHT=0.
	  TRSD=0.
	  TSFC=0.
	  TSFK=0.
      TSFN=0.
      TSN=0.
	  TSNO=0.
	  TSPS=0.
	  TSR=0.
	  TSY=0.
	  TVGF=0.
	  TVIR=0.
	  TXMN=0.
	  TXMX=0.
	  TYK=0.      
      TYL1=0.
      TYL2=0.
      TYLK=0.
      TYLN=0.
      TYLP=0.
	  TYN=0.
	  TYON=0.
	  TYP=0.
	  TYTP=0.
	  TYW=0.
	  UK1=0.
	  UN1=0.
      UP1=0.
	  UW=0.
	  V56=0.
	  V57=0.
	  VAC=0.
	  VALF1=0.
      VAP=0.
      VARC=0.
      VARH=0.
      VARP=0.
      VARW=0.
      VCHA=0.
	  VCHB=0.
	  VCO2=0.
	  VFPA=0.
	  VFPB=0.
	  VIR=0.
      VIRT=0.
	  VLG=0.
	  VLGI=0.
	  VLGM=0.
	  VN2O=0.
	  VO2=0.
	  VPU=0.
	  VQ=0.
	  VSLT=0.
	  VURN=40.
      VY=0.
	  WBMC=0.
	  WCHT=0.
	  WCMU=0.
	  WCO2G=0.
	  WCO2L=0.
	  WCOU=0.
	  WHPC=0.
	  WHSC=0.
      WLMC=0.
	  WLSC=0.
	  WLV=0.
	  WN2O=0.
	  WN2OG=0.
	  WN2OL=0.
	  WNH3=0.
	  WNO2=0.
	  WNO3=0.
      WNMU=0.
      WNOU=0.
      WO2G=0.
      WO2L=0.
      WPML=0.
      WPMU=0.
      WPOU=0.
	  WOC=0.
	  WS=1.
	  WSLT=0.
      WTMU=0.
      WTN=0.
      WYLD=0.
      XHSM=0.
      XIM=0.
      XMTU=0.
	  YC=0.
	  YCOU=0.
	  YHY=0.
	  YLD=0.
	  YLD1=0.
      YLD2=0.
      YLK=0.
      YLKF=0.
      YLN=0.
	  YLNF=0.
	  YLP=0.
	  YLPF=0.
	  YLX=0.
	  YMNU=0.
	  YN=0.
	  YNOU=0.
	  YNWN=0.
	  YP=0.
	  YPOU=0.
	  YPST=0.
      ZBMC=0.
      ZHPC=0.
      ZHSC=0.
      ZLMC=0.
	  ZLSC=0.
      ZNMN=0.
      ZNOA=0.
      ZNOS=0.
      ZPMA=0.
      ZPML=0.
      ZPMS=0.
      ZPMU=0.
      ZPO=0.
	  ZPOU=0.
	  ZEK=0.
	  ZFK=0.
	  ZSK=0.
	  ZSLT=0.
      RETURN
      END