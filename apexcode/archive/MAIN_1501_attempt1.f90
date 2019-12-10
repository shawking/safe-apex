!     PROGRAM APEX1501 CROPCOM
!     THIS MODEL IS CALLED APEX(AGRICULTURAL POLICY/ENVIRONMENTAL
!     EXTENDER)
!     IT IS A COMPREHENSIVE AGRICULTURAL MANAGEMENT MODEL THAT IS USEFUL
!     IN SOLVING A VARIETY OF PROBLEMS INVOLVING SUSTAINABLE
!     AGRICULTURE, WATER QUALITY, WATER SUPPLY, AND GLOBAL CLIMATE
!     & CO2 CHANGE.  THE MODEL SIMULATES MOST COMMONLY USED
!     MANAGEMENT PRACTICES LIKE TILLAGE, IRRIGATION, FERTILIZATION,
!     PESTICIDE APPLICATION, LIMING, AND FURROW DIKING.
!     THE WATERSHED MAY BE DIVIDED INTO SUBAREAS(SUBWATERSHEDS,
!     FIELDS, LANDSCAPE POSITIONS, ETC). RUNOFF, SEDIMENT, AND AG
!     CHEMICALS ARE ROUTED AS SURFACE, SUBSURFACE, AND CHANNEL FLOW.
!     THE MAIN PROGRAM INITIALIZES VARIABLES, ACCUMULATES
!     MONTHLY AND ANNUAL VALUES, AND COMPUTES AVERAGE VALUES FOR THE
!     SIMULATION PERIOD.
!!!=================================================================
!!! MODIF HISAFE
!!!============================================================
!!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
!!!MODIF HISAFE 2 = MODIFY READING FILE PATH
!!!MODIF HISAFE 3 = WEATHER FILE FROM HISAFE

!! ******************************************************************************************
!! simulationStart
!! All MAIN PROGRAM instructions BEFORE CALL BSIM
!! ******************************************************************************************

 FUNCTION simulationStart (p,lg1,folder,lg2,wfile,lg3,hfile,lg4,rfile,lg5,sfile,lg6,tfile,lg7,ofile) BIND(C, name='simulationStart')

	  USE PARM
	  USE HISAFE

      TYPE(Hisafe_),  intent(INOUT) :: p
      INTEGER,VALUE     :: lg1,lg2,lg3,lg4,lg5,lg6,lg7
      CHARACTER         :: folder,wfile,hfile,rfile,sfile,tfile,ofile

      CHARACTER(len=lg1) :: foldername
      CHARACTER(len=lg2) :: WINDFILE
      CHARACTER(len=lg3) :: HERDFILE
      CHARACTER(len=lg4) :: RFTFILE
      CHARACTER(len=lg5) :: WPMFILE
      CHARACTER(len=lg6) :: WEATHERFILE
      CHARACTER(len=lg7) :: OPSCFILE

      CHARACTER(len=255) :: filename

      CHARACTER(1)::ASG
      CHARACTER(2)::RFPT
      CHARACTER(4)::HEDW
      CHARACTER(7)::AUNT
      CHARACTER(8)::RCMD
      CHARACTER(80)::ASTN,FPSOD,FRFDT,TITWP
      CHARACTER(80)::ADUM,AWTH,TITWN
!     REAL*8 PPX,TWB,SWBB,SWFB,TWMB
      DIMENSION HEDW(16),TITWP(10),ASG(4)
      DIMENSION IDOS(1000),NY(20),KFL0(51),IWPM(10)
      DIMENSION SAV(1000),SMWD(3000),XGCO2(200),XGN2O(30),XGO2(30),&
      TWB(13),FWXP(10),COCH(6),RCMD(5),RFPT(4)
      DIMENSION RMO(10,12),SCRX(30,2)
      DATA RFPT/' 1','1A',' 2',' 3'/,RCMD/'SUBAREA ','ROUTE   ',&
      'ADD     ','ROUTE RS','ROUTE PD'/,ASG/'A','B','C','D'/,HEDW/'   N'&
      ,' NNE','  NE',' ENE','   E',' ESE','  SE',' SSE','   S',' SSW',&
      '  SW',' WSW','   W',' WNW','  NW',' NNW'/
      DATA IFSA/0/

      CALL AHEAD

     !!!MODIF HISAFE 2 = MODIFY READING FILE PATH
      foldername = ''
      filename= ''
      do i = 1, lg1-1
         foldername(i:i+1) = folder(i:i+1)
         if (foldername(i:i+1) == "\") foldername(i:i+1) = "/"
      end do

 write (*,*) 'foldername=',foldername


      WINDFILE = ''
      do i = 1, lg2-1
         WINDFILE(i:i+1) = wfile(i:i+1)
         if (WINDFILE(i:i+1) == "\") WINDFILE(i:i+1) = "/"
      end do

 write (*,*) 'WINDFILE=',WINDFILE

      HERDFILE = ''
      do i = 1, lg3-1
         HERDFILE(i:i+1) = hfile(i:i+1)
         if (HERDFILE(i:i+1) == "\") HERDFILE(i:i+1) = "/"
      end do

 write (*,*) 'HERDFILE=',HERDFILE

      RFTFILE = ''
      do i = 1, lg4-1
         RFTFILE(i:i+1) = rfile(i:i+1)
         if (RFTFILE(i:i+1) == "\") RFTFILE(i:i+1) = "/"
      end do

 write (*,*) 'RFTFILE=',RFTFILE

      WPMFILE = ''
      do i = 1, lg5-1
         WPMFILE(i:i+1) = sfile(i:i+1)
         if (WPMFILE(i:i+1) == "\") WPMFILE(i:i+1) = "/"
      end do

 write (*,*) 'WPMFILE=',WPMFILE


      WEATHERFILE = ''
      do i = 1, lg6-1
         WEATHERFILE(i:i+1) = tfile(i:i+1)
         if (WEATHERFILE(i:i+1) == "\") WEATHERFILE(i:i+1) = "/"
      end do
      FWTH(1) = foldername//'/'//WEATHERFILE

 write (*,*) 'WEATHERFILE=',WEATHERFILE


      OPSCFILE = ''
      do i = 1, lg7-1
         OPSCFILE(i:i+1) = ofile(i:i+1)
         if (OPSCFILE(i:i+1) == "\") OPSCFILE(i:i+1) = "/"
      end do

 write (*,*) 'OPSCFILE=',OPSCFILE

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
	  !!!ADUM='APEXRUN.DAT'
      !!!CALL OPENV(KR(11),ADUM,0)

      !!!ADUM='APEXDIM.DAT'
      !!!CALL OPENV(KR(26),ADUM,0)


        MPS = 60    !! MPS = MAX # PESTICIDES
        MRO = 45    !! MRO = MAX # YRS CROP ROTATION
        MNT = 300   !! MNT = MAX # TILLAGE OPERATIONS
        MNC = 200   !! MNC = MAX # CROPS USED
        MHD = 10    !! MHD = MAX # ANIMAL HERDS
        MBS = 4     !! MBS = MAX # BUY/SELL LIVESTOCK TRANSACTIONS
        MFT = 60    !! MFT = MAX # FERTILIZER
        MPO = 5     !! MPO = MAX # POINT SOURCES
        MHP = 720   !! MHP = MAX# HYDROGRAPH POINTS
        MHX = 3     !! MHX = MAX# DAYS FOR STORM HYDROGRAPH BASE
        MSA = 1     !! MSA = MAX# SUBAREAS0

        MOW=1
        NBMX=0
        ISA=1
        N1=1

        CALL ALLOCATE_PARMS

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!ADUM='APEXFILE.DAT'
      !!!CALL OPENV(KR(12),ADUM,0)
      !!!READ(KR(12),509)FSITE,FSUBA,FWPM,FWIND,FCROP,FTILL,FPEST,FFERT,&
      !!!FSOIL,FOPSC,FTR55,FPARM,FMLRN,FPRNT,FHERD,FWLST,FPSOD,FRFDT
      !!!WRITE(*,508)'FSITE',FSITE,'FSUBA',FSUBA,'FWPM',FWPM,'FWIND',FWIND,&
      !!!'FCROP',FCROP,'FTILL',FTILL,'FPEST',FPEST,'FFERT',FFERT,'FSOIL',&
      !!!FSOIL,'FOPSC',FOPSC,'FTR55',FTR55,'FPARM',FPARM,'FMLRN',FMLRN,&
      !!!'FPRNT',FPRNT,'FHERD',FHERD,'FWLST',FWLST,'FPSOD',FPSOD,'FRFDT',FRFDT
      !!!CLOSE(KR(12))

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!filename = foldername//'/APEXCONT.DAT'
      !!!CALL OPENV(KR(20),filename,0)
      !  1  NBY0 = NUMBER OF YEARS OF SIMULATION
      !  2  IYR0 = BEGINNING YEAR OF SIMULATION
      !  3  IMO  = MONTH SIMULATION BEGINS
      !  4  IDA  = DAY OF MONTH SIMULATION BEGINS
      !  5  IPD  = N0 FOR ANNUAL WATERSHED OUTPUT
      !          = N1 FOR ANNUAL OUTPUT                       | N YEAR INTERVAL
      !          = N2 FOR ANNUAL WITH SOIL TABLE              | N=0 SAME AS
      !          = N3 FOR MONTHLY                             | N=1 EXCEPT
      !          = N4 FOR MONTHLY WITH SOIL TABLE             | N=0 PRINTS
      !          = N5 FOR MONTHLY WITH SOIL TABLE AT HARVEST  | OPERATIONS
      !          = N6 FOR N DAY INTERVAL
      !          = N7 FOR SOIL TABLE ONLY N DAY INTERVAL
      !          = N8 FOR SOIL TABLE ONLY DURING GROWING SEASON N DAY INTERVAL
      !          = N9 FOR N DAY INTERVAL DURING GROWING SEASON
      !  6  NGN0 = ID NUMBER OF WEATHER VARIABLES INPUT.  RAIN=1,  TEMP=2,
      !            RAD=3,  WIND SPEED=4,  REL HUM=5.  IF ANY VARIABLES ARE INP
      !            RAIN MUST BE INCLUDED.  THUS, IT IS NOT NECESSARY TO SPECIF
      !            ID=1 UNLESS RAIN IS THE ONLY INPUT VARIABLE.
      !            NGN=-1 ALL VARIABLES GENERATED(SAME VALUES ALL SUBAREAS).
      !            NGN=0  ALL VARIABLES GENERATED(SPATIALLY DISTRIBUTED).
      !            EXAMPLES
      !            NGN=1 INPUTS RAIN.
      !            NGN=23 INPUTS RAIN, TEMP, AND RAD.
      !            NGN=2345 INPUTS ALL 5 VARIABLES.
      !  7  IGN  = NUMBER TIMES RANDOM NUMBER GEN CYCLES BEFORE
      !            SIMULATION STARTS
      !  8  IGS0 = 0 FOR NORMAL OPERATION OF WEATHER MODEL.
      !          = N NO YRS INPUT WEATHER BEFORE REWINDING (USED FOR REAL TIME
      !            SIMULATION).
      !  9  LPYR = 0 IF LEAP YEAR IS CONSIDERED
      !          = 1 IF LEAP YEAR IS IGNORED
      ! 10  IET  = PET METHOD CODE
      !          = 1 FOR PENMAN-MONTEITH
      !          = 2 FOR PENMAN
      !          = 3 FOR PRIESTLEY-TAYLOR
      !          = 4 FOR HARGREAVES
      !          = 5 FOR BAIER-ROBERTSON
      ! 11  ISCN = 0 FOR STOCHASTIC CURVE NUMBER ESTIMATOR.
      !          > 0 FOR RIGID CURVE NUMBER ESTIMATOR.
      ! 12  ITYP = 0 FOR MODIFIED RATIONAL EQ STOCHASTIC PEAK RATE ESTIMATE.
      !          < 0 FOR MODIFIED RATIONAL EQ RIGID PEAK RATE ESTIMATE.
      !          > 0 FOR SCS TR55 PEAK RATE ESTIMATE.
      !          = 1 FOR TYPE 1 RAINFALL PATTERN
      !          = 2     TYPE 1A
      !          = 3     TYPE 2
      !          = 4     TYPE 3
      ! 13  ISTA = 0 FOR NORMAL EROSION OF SOIL PROFILE
      !          = 1 FOR STATIC SOIL PROFILE
      ! 14  IHUS = 0 FOR NORMAL OPERATION
      !          = 1 FOR AUTOMATIC HEAT UNIT SCHEDULE(PHU MUST BE INPUT AT
      !              PLANTING)
      ! 15  NVCN0= 0 VARIABLE DAILY CN NONLINEAR CN/SW WITH DEPTH SOIL WATER
      !              WEIGHTING
      !          = 1 VARIABLE DAILY CN NONLINEAR CN/SW NO DEPTH WEIGHTING
      !          = 2 VARIABLE DAILY CN LINEAR CN/SW NO DEPTH WEIGHTING
      !          = 3 NON-VARYING CN--CN2 USED FOR ALL STORMS
      !          = 4 VARIABLE DAILY CN SMI(SOIL MOISTURE INDEX)
      ! 16  INFL0= 0 FOR CN ESTIMATE OF Q
      !          = 1 FOR GREEN & AMPT ESTIMATE OF Q, RF EXP DST, PEAK RF RATE
      !              SIMULATED.
      !          = 2 FOR G&A Q, RF EXP DST, PEAK RF INPUT
      !          = 3 FOR G&A Q, RF UNIFORMLY DST, PEAK RF INPUT
      !          = 4 FOR G&A Q, RF INPUT AT TIME INTERVAL DTHY
      ! 17  MASP = 1 FOR PESTICIDE APPLIED IN g/ha
      !          = 1000 FOR PESTICIDE APPLIED IN kg/ha
      ! 18  IERT = 0 FOR EPIC ENRICHMENT RATIO METHOD
      !          = 1 FOR GLEAMS ENRICHMENT RATIO METHOD
      ! 19  LBP  = 0 FOR SOL P RUNOFF ESTIMATE USING GLEAMS PESTICIDE EQ
      !          = 1 FOR LANGMUIR EQ
      ! 20  NUPC = N AND P PLANT UPTAKE CONCENTRATION CODE
      !          = 0 FOR SMITH CURVE
      !          > 0 FOR S CURVE
      ! 21  MNUL = MANURE APPLICATION CODE
      !          = 0 FOR AUTO APPLICATION TO SUBAREA WITH MINIMUM LAB P CONC
      !          = 1 FOR VARIABLE P RATE LIMITS ON ANNUAL APPLICATION BASED ON
      !            JAN 1 LAB P CONC.
      !          = 2 FOR VARIABLE N RATE LIMITS ON ANNUAL APPLICATION BASED ON
      !            JAN 1 LAB P CONC.
      !          = 3 SAME AS 1 EXCEPT APPLICATIONS OCCUR ON ONE SUBAREA AT A
      !            TIME UNTIL LAB P CONC REACHES 200 ppm. THEN ANOTHER SUBAREA
      !            IS USED, ETC.
      ! 22  LPD  = DAY OF YEAR TO TRIGGER LAGOON PUMPING DISREGARDING NORMAL
      !            PUMPING TRIGGER--USUALLY BEFORE WINTER OR HIGH RAINFALL
      !            SEASON.
      !          = 0 DOES NOT TRIGGER EXTRA PUMPING
      ! 23  MSCP = INTERVAL FOR SCRAPING SOLID MANURE FROM FEEDING AREA (d)
      ! 24  ISLF = 0 FOR RUSLE SLOPE LENGTH/STEEPNESS FACTOR
      !          > 0 FOR MUSLE SLOPE LENGTH/STEEPNESS FACTOR
      ! 25  NAQ  > 0 FOR AIR QUALITY ANALYSIS
      !          = 0 NO AIR QUALITY ANALYSIS
      ! 26  IHY  = 0 NO FLOOD ROUTING
      !          = 1 VSC FLOOD ROUTING
      !          = 2 SVS FLOOD ROUTING
      !          = 3 MUSKINGUM-CUNGE VC
      !          = 4 MUSKINGUM-CUNGE M_CVC4
      ! 27  ICO2 = 0 FOR CONSTANT ATMOSPHERIC CO2
      !          = 1 FOR DYNAMIC ATMOSPHERIC CO2
      !          = 2 FOR INPUTTING CO2
      ! 28  ISW  = 0 FIELD CAP/WILTING PT EST RAWLS METHOD DYNAMIC.
      !          = 1 FIELD CAP/WILTING PT INP RAWLS METHOD DYNAMIC.
      !          = 2 FIELD CAP/WILTING PT EST RAWLS METHOD STATIC.
      !          = 3 FIELD CAP/WILTING PT INP STATIC.
      !          = 4 FIELD CAP/WILTING PT NEAREST NEIGHBOR DYNAMIC
      !          = 5 FIELD CAP/WILTING PT NEAREST NEIGHBOR STATIC
      !          = 6 FIELD CAP/WILTING PT BEHRMAN-NORFLEET-WILLIAMS (BNW) DYNAMIC
      !          = 7 FIELD CAP/WILTING PT BEHRMAN-NORFLEET-WILLIAMS (BNW) STATIC
      ! 29  IGMX = # TIMES GENERATOR SEEDS ARE INITIALIZED FOR A SITE.
      ! 30  IDIR = 0 FOR READING DATA FROM WORKING DIRECTORY
      !          > 0 FOR READING FROM WEATDATA DIRECTORY
      ! 31  IMW0 = MIN INTERVAL BETWEEN AUTO MOW
      ! 32  IOX  = 0 FOR ORIGINAL EPIC OXYGEN/DEPTH FUNCTION
      !          > 0 FOR ARMEN KEMANIAN CARBON/CLAY FUNCTION
      ! 33  IDNT = 1 FOR ORIGINAL EPIC DENITRIFICATION SUBPROGRAM
      !          = 2 FOR ARMEN KEMANIAN DENITRIFICATION SUBPROGRAM
      !          = 3 FOR CESAR IZAURRALDE DENITRIFICATION SUBPROGRAM (ORIGINAL DW)
      !          = 4 FOR CESAR IZAURRALDE DENITRIFICATION SUBPROGRAM (NEW DW)
      ! 34  IAZM = 0 FOR USING INPUT LATITUDES FOR SUBAREAS
      !          > 0 FOR COMPUTING EQUIVALENT LATITUDE BASED ON AZIMUTH
      !            ORIENTATION OF LAND SLOPE.
      ! 35  IPAT = 0 TURNS OFF AUTO P APPLICATION
      !          > 0 FOR AUTO P APPLICATION
      ! 36  IHRD = 0 FOR LEVEL 0(MANUAL) GRAZING MODE(NO HERD FILE REQUIRED)
      !          = 1 FOR LEVEL 1(HYBRID) GRAZING MODE(HERD FILE REQUIRED)
      !          = 2 FOR LEVEL 2(AUTOMATIC) GRAZING MODE(HERD FILE REQUIRED)
      ! 37  IWTB = DURATION OF ANTEDEDENT PERIOD FOR RAINFALL AND PET
      !            ACCUMULATION TO DRIVE WATER TABLE.
      ! 38  IKAT = 0 TURNS OFF AUTO K APPLICATION
      !          > 0 FOR AUTO K APPLICATION
      ! 39  NSTP = REAL TIME DAY OF YEAR
      ! 40  IPRK = 0 FOR HPERC
      !          > 0 FOR HPERC1 (4MM SLUG FLOW)
      ! 41  ICP  = 0 FOR NCNMI_PHOENIX
      !          > 0 FOR NCNMI_CENTURY
      ! 42  NTV  = 0 FOR ORIGINAL APEX NITVOL EQS
      !          > 0 FOR IZAURRALDE REVISED NITVOL EQS
      ! 43  ISAP = NBSA TO PRINT MONTHLY .OUT FOR 1 SUBAREA
      !     LINE 1/2
      !!READ(KR(20),*)NBY0,IYR0,IMO,IDA0,IPD,NGN0,IGN,IGSD,LPYR,IET,&
      !!!ISCN,ITYP,ISTA,IHUS,NVCN0,INFL0,MASP,IERT,LBP,NUPC,MNUL,LPD,MSCP,&
      !!!ISLF,NAQ,IHY,ICO2,ISW,IGMX,IDIR,IMW0,IOX,IDNT,IAZM,IPAT,IHRD,IWTB,&
      !!!IKAT,NSTP,IPRK,ICP,NTV,ISAP


      CALL FROMINIT (p)

      NGN=NGN0

      IF(IWTB==0)IWTB=15
      IF(ISW==4.OR.ISW==5)THEN
          filename = foldername//'/SOIL35K.DAT'
          CALL OPENV(KR(28),filename,0)
          READ(KR(28),140)XAV,XDV,XRG,BRNG,NSX
          ALLOCATE(XSP(NSX,5))
          NSNN=.655*NSX**.493
          EXNN=.767*NSX**.049
          DO I=1,NSX
              READ(KR(28),140)(XSP(I,J),J=1,5)
          END DO
          CLOSE(KR(28))
      END IF

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!CALL OPENV(KR(23),FSITE,IDIR)
      !!!CALL OPENV(KR(24),FSUBA,IDIR)
      !!!CALL OPENV(KR(13),FSOIL,IDIR)

      !!!MODIF HISAFE 2 = MODIFY READING FILE PATH

      filename = foldername//'/PARMS.DAT'
      CALL OPENV(KR(2),filename,0)

      filename = foldername//'/PRINT.DAT'
      CALL OPENV(KR(17),filename,0)

      !!!filename = foldername//'/'//FMLRN
      !!!CALL OPENV(KR(6),filename,0)

      !!!filename = foldername//'/'//FWPM
      !!!CALL OPENV(KR(18),filename,0)

      !!!filename = foldername//'/'//FWIND
      !!!CALL OPENV(KR(19),filename,0)

      filename = foldername//'/CROPCOM.DAT'
      CALL OPENV(KR(4),filename,0)

      filename = foldername//'/TILLCOM.DAT'
      CALL OPENV(KR(3),filename,0)

      filename = foldername//'/PEST.DAT'
      CALL OPENV(KR(8),filename,0)

      filename = foldername//'/FERTCOM.DAT'
      CALL OPENV(KR(9),filename,0)

      filename = foldername//'/TR55COM.DAT'
      CALL OPENV(KR(10),filename,0)

      !!!filename = foldername//'/'//FOPSC
      !!!CALL OPENV(KR(15),filename,0)

      filename = foldername//'/'//HERDFILE
      IF(IHRD>0)CALL OPENV(KR(21),filename,0)

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!filename = foldername//'/WDLSTCOM.DAT'
      !!!CALL OPENV(KR(25),filename,0)

      filename = foldername//'/PSOCOM.DAT'
      CALL OPENV(KR(27),filename,0)

      IRUN=0
      IDAY=0
      IMON=0
      IT1=0
      IT2=0
      IT3=0
      IYER=0
      NMC=0
      ! SCRP = S CURVE SHAPE PARAMETERS(CONSTANTS EXCEPT FOR
      !        EXPERIMENTAL PURPOSES)
      ! LINE 1/30
      READ(KR(2),2510)((SCRP(I,J),J=1,2),I=1,30)
      ! MISCELLANEOUS PARAMETERS (CONSTANTS EXCEPT FOR EXPERIMENTAL PURPO
      ! LINE 31/41
      READ(KR(2),3120)PRMT
      IF(PRMT(96)==0.)PRMT(96)=1.
      ! READ ECONOMIC DATA
      ! 1  COIR = COST OF IRRIGATION WATER ($/mm)
      ! 2  COL  = COST OF LIME ($/t)
      ! 3  FULP = COST OF FUEL ($/l)
      ! 4  WAGE = LABOR COST ($/h)
      ! LINE 42
      READ(KR(2),3120)COIR,COL,FULP,WAGE
      ! LINE 43
      READ(KR(2),3120)XKN5,XKN3,XKN1,CBVT
      CLOSE(KR(2))

      ! CQRB  = COEFS OF 7TH DEG POLY IN TR55 QRB EST
      ! LINE 1/68
      READ(KR(10),396)CQRB
      ! COCH = COEFS FOR CHANNEL GEOMETRY X=COCH(N)*WSA**COCH(N+1)
      ! X=WIDTH FOR COCH(1) & COCH(2)
      ! X=DEPTH FOR COCH(3) & COCH(4)
      ! X=LENGTH FOR COCH(5) & COCH(6)
      ! LINE 69
      READ(KR(10),3120)COCH
      IF(COCH(1)<1.E-10)COCH(1)=.0814
      IF(COCH(2)<1.E-10)COCH(2)=.6
      IF(COCH(3)<1.E-10)COCH(3)=.0208
      IF(COCH(4)<1.E-10)COCH(4)=.4
      IF(COCH(5)<1.E-10)COCH(5)=.0803
      IF(COCH(6)<1.E-10)COCH(6)=.6
      CLOSE(KR(10))
      !     KA   = OUTPUT VARIABLE ID NO(ACCUMULATED AND AVERAGE VALUES)
      !     LINE 1/5
      READ(KR(17),3100)(KDC1(I),I=1,NKA)
      DO I=1,NKA
          IF(KDC1(I)<=0)EXIT
          KA(I)=KDC1(I)
      END DO
      NKA=I-1
      ! JC = OUTPUT VARIABLE ID NO(CONCENTRATION VARIABLES)
      ! LINE 6
      READ(KR(17),3100)(KDC1(I),I=1,NJC)
      DO I=1,NJC
          IF(KDC1(I)<=0)EXIT
          JC(I)=KDC1(I)
      END DO
      NJC=I-1
      ! KS = OUTPUT VARIABLE ID NO(STATE VARIABLES)
      ! LINE 7
      READ(KR(17),3100)(KDC1(I),I=1,NKS)
      DO I=1,NKS
          IF(KDC1(I)<=0)EXIT
          KS(I)=KDC1(I)
      END DO
      NKS=I-1
      ! KD = DAILY OUTPUT VARIABLE ID NO
      ! LINE 8/9
      READ(KR(17),3100)(KDC1(I),I=1,NKD)
      DO I=1,NKD
          IF(KDC1(I)<=0)EXIT
          KD(I)=KDC1(I)
      END DO
      NKD=I-1
      ! KY = ANNUAL OUTPUT--VARIABLE ID NOS(ACCUMULATED AND AVERAGE
      ! LINE 10/11
      READ(KR(17),3100)(KDC1(I),I=1,NKY)
      DO I=1,NKY
          IF(KDC1(I)<=0)EXIT
          KY(I)=KDC1(I)
      END DO
      NKY=I-1
      ! SELECT OUTPUT FILES--KFL=0(NO OUTPUT); KFL>0(GIVES OUTPUT FOR
      ! SELECTED FILE)
      ! 1  OUT=STANDARD OUTPUT FILE
      ! 2  MAN=SPECIAL MANURE MANAGEMENT SUMMARY FILE
      ! 3  SUS=SUBAREA SUMMARY FILE
      ! 4  ASA=ANNUAL SUBAREA FILE
      ! 5  SWT=WATERSHED OUTPUT TO SWAT
      ! 6  DPS=DAILY SUBAREA PESTICIDE FILE
      ! 7  MSA=MONTHLY SUBAREA FILE
      ! 8  AWP=ANNUAL CEAP FILE
      ! 9  DHY=DAILY SUBAREA HYDROLOGY FILE
      !10  WSS=WATERSHED SUMMARY FILE
      !11  SAD=DAILY SUBAREA FILE
      !12  HYC=CONTINUOUS HYDROGRAPHS(DTHY) AT WATERSHED OUTLET
      !13  DRS=DAILY RESERVOIR FILE
      !14  APEXBUF.OUT SPECIAL FILE FOR BUFFER STRIPS
      !15  MWS=MONTHLY WATERSHED FILE
      !16  DWS=DAILY WATERSHED OUTLET FILE
      !17  AWS=ANNUAL WATERSHED OUTLET FILE
      !18  DGZ=DAILY GRAZING
      !19  DUX=DAILY MANURE APPLICATION
      !20  DDD=DAILY DUST DISTRIBUTION
      !21  ACN=ANNUAL SOIL ORGANIC C & N TABLE
      !22  DCN=DAILY SOIL ORGANIC C & N TABLE
      !23  SCX=SUMMARY SOIL ORGANIC C & N TABLE
      !24  ACY=ANNUAL SUBAREA CROP YIELD
      !25  EFR=RUNOFF EVENT FLOOD ROUTING
      !26  EHY=RUNOFF EVENT HYDROGRAPHS
      !27  APS=ANNUAL SUBAREA/WATERSHED PESTICIDE
      !28  MSW=MONTHLY OUTPUT TO SWAT.
      !29  DPW=DAILY WATERSHED PESTICIDE FILE
      !30  SPS=PESTICIDE SUBAREA SUMMARY
      !31  ACO=ANNUAL COST
      !32  SWN=SPECIAL WATERSHED SUMMARY FOR NRCS FARM PLANNING
      !33  FSA=ANNUAL SUBAREA SPECIAL FSA (VB)
      !34  SAO=SPECIAL SUBAREA FILE FOR GIS
      !35  RCH=SPECIAL REACH FILE FOR GIS
      !36  ERX=ERROR FILE
      !37  DMR=DAILY WATERSHED NUTRIENT & SEDIMENT CONC NRCS MRBI
      !38  STR=SUMMARY OF SUBARES & WATERSHED FOR STAR
      !39  MRH=MONTHLY REACH FILE ANNUAL GIS REACH FILE FOR SELECTED COMMAND #'S ICMO(FROM .SIT)
      !40  MGZ=MONTHLY GRAZING FILE
      !41  DNC=DAILY NITROGEN/CARBON CESAR IZAURRALDE
      !42  DHS=DAILY HYDROLOGY/SOIL
      !43  SW4=DAILY OUTPUT FOR SELECTED COMMAND #'S ICMO(FROM .SIT)
      !44  DGN=DAILY GENERAL OUTPUT (VAR AFTER COMMAND LOOP IN BSIM)
      !    MSO
      !    +1/ SOT=SUBAREA FINAL SOIL TABLE FOR USE IN OTHER RUNS
      !    MSA
      !     LINE 12/14
      READ(KR(17),3100)KFL0
      CLOSE(KR(17))
!  1  RFN0 = AVE CONC OF N IN RAINFALL(ppm)
!  2  CO20 = CO2 CONCENTRATION IN ATMOSPHERE(ppm)
!  3  CQN0 = CONC OF N IN IRRIGATION WATER(ppm)
!  4  PSTX = PEST DAMAGE SCALING FACTOR (0.-10.)--0. SHUTS OFF PEST
!            DAMAGE FUNCTION. PEST DAMAGE FUNCTION CAN BE REGULATED FROM
!            VERY MILD(0.05-0.1) TO VERY SEVERE(1.-10.)
!  5  YWI  = NO Y RECORD MAX .5H RAIN(BLANK IF WI IS NOT
!            INPUT)
!  6  BTA  = COEF(0-1)GOVERNING WET-DRY PROBABILITIES GIVEN DAYS
!            OF RAIN(BLANK IF UNKNOWN OR IF W|D PROBS ARE
!            INPUT)
!  7  EXPK = PARAMETER USED TO MODIFY EXPONENTIAL RAINFALL AMOUNT
!            DISTRIBUTION(BLANK IF UNKNOWN OR IF ST DEV & SK CF ARE
!            INPUT)
!  8  QG   = 2 YEAR FREQ 24-H RAINFALL (mm)--ESTIMATES REACH CH GEOMETRY
!            IF UNKNOWN(BLANK IF CH GEO IS INPUT)
!  9  QCF  = EXPONENT IN WATERSHED AREA FLOW RATE EQ
! 10  CHS0 = AVE UPLAND SLOPE (m/m) IN WATERSHED
! 11  BWD  = CHANNEL BOTTOM WIDTH/DEPTH(QG>0)
! 12  FCW  = FLOODPLAIN WIDTH/CHANNEL WIDTH
! 13  FPS0 = FLOODPLAIN SAT COND ADJUSTMENT FACTOR(.0001_10.)
! 14  GWS0 = MAXIMUM GROUNDWATER STORAGE(mm)
! 15  RFT0 = GROUNDWATER RESIDENCE TIME(d)
! 16  RFP0 = RETURN FLOW / (RETURN FLOW + DEEP PERCOLATION)
! 17  SAT0 = SATURARTED CONDUCTIVITY ADJUSTMENT FACTOR(.1_10.)
! 18  FL0  = FIELD LENGTH(km)(BLANK IF UNKNOWN)
! 19  FW0  = FIELD WIDTH(km)(BLANK IF UNKNOWN)
! 20  ANG0 = CLOCKWISE ANGLE OF FIELD LENGTH FROM NORTH(deg)(BLANK IF
!            UNKNOWN)
! 21  UXP  = POWER PARAMETER OF MODIFIED EXP DIST OF WIND SPEED(BLANK
!            IF UNKNOWN)
! 22  DIAM = SOIL PARTICLE DIAMETER(UM)(BLANK IF UNKNOWN)
! 23  ACW  = WIND EROSION CONTROL FACTOR
!            = 0.0 NO WIND EROSION
!            = 1.0 FOR NORMAL SIMULATION
!            > 1.0 ACCELERATES WIND EROSION(CONDENSES TIME)
! 24  GZL0 = GRAZING LIMIT--MINIMUM PLANT MATERIAL(t/ha)
! 25  RTN0 = NUMBER YEARS OF CULTIVATION AT START OF SIMULATION
! 26  BXCT = LINEAR COEF OF CHANGE IN RAINFALL FROM E TO W(PI/P0/KM)
! 27  BYCT = LINEAR COEF OF CHANGE IN RAINFALL FROM S TO N(PI/P0/KM)
! 28  DTHY = TIME INTERVAL FOR FLOOD ROUTING(h)
! 29  QTH  = ROUTING THRESHOLD(mm)--VSC ROUTING USED ON QVOL>QTH
! 30  STND = VSC ROUTING USED WHEN REACH STORAGE >STND
! 31  DRV  = SPECIFIES WATER EROSION DRIVING EQ.
!            (0=MUST;  1=AOF;  2=USLE;  3=MUSS;  4=MUSL;  5=MUSI;
!             6=RUSL;  7=RUSL2)
!            (MUSS=SMALL WS MUSLE;  MUSI=MUSLE WITH INPUT PARMS)
! 32  PCO0 = FRACTION OF SUBAREAS CONTROLLED BY PONDS.
! 33  RCC0 = REACH CHANNEL USLE C FACTOR
! 34  CSLT = SALT CONC IN IRRIGATION WATER (ppm)
! 35  CPV0 = FRACTION INFLOW PARTITIONED TO VERTICLE CRACK OR PIPE FLOW
! 36  CPH0 = FRACTION INFLOW PARTITIONED TO HORIZONTAL CRACK OR PIPE FLOW
! 37  DZDN = LAYER THICKNESS FOR DIFFERENTIAL EQ SOLN TO GAS DIFF EQS(m)
! 38  DTG  = TIME INTERVAL FOR GAS DIFF EQS (h)
! 39  BUS  = INPUT PARMS FOR MUSI
!            YSD(6)=BUS(1)*QVOL(ISA)**BUS(2)*QRB**BUS(3)*WSA**BUS(4)*KCPLS
!     LINES 3/6

!!!     READ(KR(20),3120)RFN0,CO20,CQN0,PSTX,YWI,BTA,EXPK,QG,QCF,CHS0,&
!!!     BWD,FCW,FPS0,GWS0,RFT0,RFP0,SAT0,FL0,FW0,ANG0,UXP,DIAM,ACW,GZL0,&
!!!      RTN0,BXCT,BYCT,DTHY,QTH,STND,DRV,PCO0,RCC0,CSLT,CPV0,CPH0,DZDN,DTG !,BUS
      IF(IHY>0)NPD=24./DTHY+1.
      IF(BTA<1.E-10)BTA=.75
      DO I=1,NSZ
          PSZX(I)=.411*PSZ(I)*PSZ(I)
          PSZY(I)=SQRT(PSZ(I))
      END DO

!!!      CLOSE(KR(20))
!  1  ASTN = RUN #
!  2  ISIT = SITE #
!  3  IWPM = WEATHER STATION # FROM KR(18)
!  4  IWND = WIND STATION # FROM KR(19)
!  5  ISUB = SUBAREA # FROM KR(24)
!  6  ISOL = 0 FOR NORMAL RUN
!          > 0 FOR RUNS USING .SOT FILES
!  7  IRFT = WITHIN STORM RAINFALL STATION # FROM KR(29)


  !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
  !!!    READ(KR(11),*,IOSTAT=NFL)ASTN,ISIT,IWPM(1),IWND,ISUB,ISOL,IRFT
      ISIT=1
      IWPM(1)=109

  !!!    IF(NFL/=0)EXIT
  !!!    IF(ISIT==0)EXIT
  !!!    ASTN=ADJUSTR(ASTN)

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!I2=-1
      !!!DO WHILE(I2/=ISUB)
      !!!    READ(KR(24),*,IOSTAT=NFL)I2,SAFILE
      !!!    IF(NFL/=0)THEN
      !!!        WRITE(*,*)'SUBAREA NO = ',ISUB,' NOT IN SUBAREA LIST FILE'
      !!!        STOP
      !!!    END IF
      !!!END DO
      !!!REWIND KR(24)

      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!I2=-1
      !!!DO WHILE(I2/=ISIT)
      !!!    READ(KR(23),*,IOSTAT=NFL)I2,SITEFILE
      !!!    IF(NFL/=0)THEN
      !!!        WRITE(*,*)'SITE NO = ',ISIT,' NOT IN SITE LIST FILE'
      !!!        STOP
      !!!    END IF
      !!!END DO
      !!!REWIND KR(23)

      !!!CALL OPENV(KR(1),SITEFILE,IDIR)
      !!!CALL OPENV(KR(5),SAFILE,IDIR)
      WRITE(*,2143)IRUN,SAFILE

      I=0
      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!DO
      !!!    I=I+1
      !!!    READ(KR(5),'(2I8)',IOSTAT=NFL)N1,ISA
      !!!    IF(NFL/=0.OR.N1==0)EXIT
      !!!    READ(KR(5),*)INPS,IOPS,IOW,I1,I2,I3,I4,I5,I6
      !!!    IF(IOW>MOW)MOW=IOW
      !!!    IF(N1>NBMX)NBMX=N1
      !!!    DO J=1,10
      !!!        READ(KR(5),'()')
      !!!    END DO
      !!!END DO

      !!!MSA=I-1
      !!!REWIND KR(5)


      I=1
      DO
          READ(KR(27),'(A80)',IOSTAT=NFL)TITWN
          IF(NFL/=0.OR.TITWN=='')EXIT
          I=I+1
      END DO
      MPO=I-1
      REWIND KR(27)

!!!          CALL ALLOCATE_PARMS

      IF(IRUN==0)NBMX0=NBMX
      HED=(/" TMX"," TMN","SRAD","PRCP","SNOF","SNOM","WSPD","RHUM",&
      " VPD"," PET","  ET","  EP","   Q","  CN"," SSF"," PRK"," QDR",&
      "IRGA"," QIN","TLGE","TLGW","TLGQ","TLGF","  EI","   C","USLE",&
      "MUSL"," AOF","MUSS","MUST","RUS2"," WK1","RHTT","RRUF","RGRF",&
      "YWND","  YN","  QN","SSFN","PRKN"," GMN","  DN","NFIX"," NMN",&
      "NITR","AVOL","QDRN","  YP","  QP"," MNP","PRKP","  ER"," FNO",&
      "FNMN","FNMA"," FPO"," FPL","LIME"," TMP","SW10","LGMI","LGMO",&
      " EPP","RSQI","RSQO","RSEV","RSLK","RSYI","RSYO","RSYD","DPRK",&
      "RSSF","RSDC","RSPC","PRKC","  QC","  YC","RSDA"," QFP","RSFN",&
      " MAP","BUNL"," QRF","QRFN","RFIC","RSBK","CPVH","YMNU","SNOU",&
      "SPOU","DNMO","DPMO","DEMR","P10D","SSFI","DPKN","CPVV"," FPF",&
      " FOC"," RFV","SCOU","DEPC","DECR","PSOQ","PSON","PSOP","RUSL",&
      " QPU","FALF","IRDL"," QRP"," YRP","YNRP","YPRP","QNRP","QPRP",&
      "WYLD"," YPM"," YPO","  SW","PSOY","PQPS","PYPS","MUSI","  QI",&
      "QARS","RFRA"," DN2","SLTI","SLTQ","SLTS","SLTF","SLTV","YNWN",&
      "YPWN","YCWN","PSO3","PSSP","YWKS","CBUR","GRZD","QRFP","QDRP",&
      "YTHS","YWTH","IRRS","EVRT"," FSK","YEFK"," QSK"," SSK"," VSK",&
      "SKOU","DN2O"/)
      HEDH=(/"  QI","  QO","  ET"," FPF","  YI","  YO","  CY","YONI",&
      "YONO","YOPI","YOPO","NO3I","NO3O","NH4I","NH4O","NO2I","NO2O",&
      " QPI"," QPO","ALGI","ALGO","BODI","BODO","DO2I","DO2O","QPSI",&
      "QPSO","YPSI","YPSO","RPST","VPST","DPST","WYLI","WYLO"," RFV"/)
      DO I=1,MHX
          IHX(I)=I
      END DO
      J=101
      J1=2*MSA+MSO
      DO I=1,J1
          KW(I)=J
          J=J+1
      END DO
      KFL=KFL0

      filename = foldername//'/APEXBUF.OUT'
      IF(KFL(14)>0)OPEN(KW(14),FILE=filename)

      ASTN = foldername//'/W1'
WRITE(*,*) 'output=',ASTN
      CALL OPENF(ASTN)


      DO I=1,60
          TITLE(I)='    '
      END DO
     !!! WRITE(KW(1),508)'FSITE',FSITE,'FSUBA',FSUBA,'FWPM',FWPM,'FWIND',&
     !!! FWIND,'FCROP',FCROP,'FTILL',FTILL,'FPEST',FPEST,'FFERT',FFERT,&
     !!! 'FSOIL',FSOIL,'FOPSC',FOPSC,'FTR55',FTR55,'FPARM',FPARM,'FMLRN',&
     !!! FMLRN,'FPRNT',FPRNT,'FHERD',FHERD,'FWLST',FWLST,'FPSOD',FPSOD,&
     !!! 'FRFDT',FRFDT
      KGN=0
      CALL AINLZ
      CALL AINIX
      DO J=1,12
          IDG(J)=J
      END DO
      IRUN=IRUN+1
      IF(IRUN==1)THEN
!             CALL ATIMER(0)
          CALL APAGE(0)
          WRITE(KW(1),2570)
          DO I=1,2
              DO J=1,30
                  SCRX(J,I)=SCRP(J,I)
              END DO
          END DO
          DO I=1,29
              IF(SCRP(I,1)<1.E-10)CYCLE
              X1=ASPLT(SCRP(I,1))
              X2=ASPLT(SCRP(I,2))
              CALL ASCRV(SCRP(I,1),SCRP(I,2),X1,X2)
          END DO
          DO J=1,30
              WRITE(KW(1),2540)J,PRMT(J),(SCRX(J,I),I=1,2),(SCRP(J,I),I=1,2)
          END DO
          DO J=26,SIZE(PRMT)
              WRITE(KW(1),2540)J,PRMT(J)
          END DO
          LGRZ=PRMT(60)
      END IF
      RHS=PRMT(100)
      RHP=PRMT(101)
      CRLNC=PRMT(102)
      CRUNC=PRMT(103)
      WKA=PRMT(104)
      WNCMIN=PRMT(105)
      WNCMAX=PRMT(106)
      VMU=PRMT(107)
      WKMNH3=PRMT(108)
      WKMNO2=PRMT(109)
      WKMNO3=PRMT(110)
!     TITLE = PROBLEM DESCRIPTION( 3 LINES)
!     LINES 1/3

!!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
!!!      READ(KR(1),3090)TITLE

!  1  YLAT = LATITUDE(deg)
!  2  XLOG = LONGITUDE(deg)
!  3  ELEV = ELEVATION OF WATERSHED (m)
!  4  APM  = PEAK RATE - EI ADJUSTMENT FACTOR (BLANK IF UNKNOWN)
!  5  CO2X = CO2 CONCENTRATION IN ATMOSPHERE (ppm)--NON ZERO VALUE
!            OVERRIDES CO2 INPUT IN APEXCONT.DAT
!  6  CQNX = CONC OF NO3 IN IRRIGATION WATER (ppm)--NON ZERO VALUE
!            OVERRIDES CNO30 INPUT IN APEXCONT.DAT
!  7  RFNX = AVE CONC OF N IN RAINFALL (ppm)
!  8  UPR  = MANURE APPL RATE TO SUPPLY P UPTAKE RATE (kg/ha/y)
!  9  UNR  = MANURE APPL RATE TO SUPPLY N UPTAKE RATE (kg/ha/y)
! 10  FIR0 = FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)
!     LINE 4
!!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
!!!      READ(KR(1),3120)YLAT,XLOG,ELEV,APM,CO2X,CQNX,RFNX,UPR,UNR,FIR0
! 1/8 X1/X8= DUMMY
!  9  BCHL = SWAT BASIN CHANNEL LENGTH(km)
! 10  BCHS = SWAT BASIN CHANNEL SLOPE(m/m)
!     LINE 5
!!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
!!!      READ(KR(1),3120)X1,X2,X3,X4,X5,X6,X7,X8,BCHL,BCHS
!     LINE 6
!!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
!!!      READ(KR(1),'()')
!!!      CO2=CO20
      IF(CO2X>0.)CO2=CO2X
!!!          CQNI=CQN0
      IF(CQNX>0.)CQNI=CQNX
!!!          RFNC=RFN0
      IF(RFNX>0.)RFNC=RFNX
      YLTR=YLAT/CLT
      SIN1=SIN(YLTR)
      COS1=COS(YLTR)
      TAN1=TAN(YLTR)
      IF(DTG<1.E-10)DTG=1.
      NBDT=24./DTG+.9
      CH=.4349*ABS(TAN1)
      IF(CH>=1.)THEN
          H=0.
      ELSE
          H=ACOS(CH)
      END IF
      CH=-CH
      IF(CH>=1.)THEN
          H1=0.
      ELSE
          IF(CH<=-1.)THEN
              H1=3.1416
          ELSE
              H1=ACOS(CH)
          END IF
      END IF
      HLMX=7.72*H1
      DO ISA=1,MSA
          YTN(ISA)=TAN1
          YLS(ISA)=SIN1
          YLC(ISA)=COS1
          HLMN(ISA)=7.72*H
          DHL=.1*(HLMX-HLMN(ISA))
          JT1=1
          IF(YLAT<0.)JT1=6
          JDHU=400
          IF(HLMN(ISA)<=11.)CALL ADAJ(NC,JDHU,JT1,15,1)
          WDRM(ISA)=PRMT(6)+HLMN(ISA)
          HLMN(ISA)=HLMN(ISA)+MAX(DHL,PRMT(6))
      END DO

      !!!IF(IWND>0)THEN
      !!!    I2=-1
      !!!    DO WHILE(I2/=IWND)
      !!!        READ(KR(19),*,IOSTAT=NFL)I2,WINDFILE
      !!!        write(*,*) 'KR19=',KR(19),' I2=',I2,' WINDFILE=',WINDFILE
      !!!        IF(NFL/=0)THEN
      !!!            WRITE(*,*)'WIND NO = ',IWND,' NOT IN WIND LIST FILE'
      !!!            STOP
      !!!        END IF
      !!!    END DO
      !!!ELSE
      !!!    D0=1.E20
      !!!    DO
      !!!        READ(KR(19),*,IOSTAT=NFL)I2,OPSCFILE,Y,X
      !!!        IF(NFL/=0)EXIT
      !!!        RY=Y/CLT
      !!!        XX=SIN1*SIN(RY)+COS1*COS(RY)*COS((X-XLOG)/CLT)
      !!!        D=6378.8*ACOS(XX)
      !!!        IF(D>D0)CYCLE
      !!!        D0=D
      !!!        WINDFILE=OPSCFILE
      !!!    END DO
      !!!END IF
      !!!REWIND KR(19)


      !!!MODIF HISAFE 2 = MODIFY READING FILE PATH
      filename = foldername//'/'//WINDFILE
      CALL OPENV(KR(22),filename,0)

      TITWN=WINDFILE
      READ(KR(22),'()')
      READ(KR(22),'()')
!!!          INFL=INFL0+1
      IYR=IYR0
!!!          IDA=IDA0
      IBDT=IDA+100*IMO+10000*IYR
      CALL AISPL(IPD,INP)
      IF(INP>0)THEN
          NOP=0
      ELSE
          NOP=1
          INP=1
      END IF
      IF(IPD<=5)IPYI=INP
      CALL APAGE(0)
      WRITE(KW(1),3540)
      WRITE(KW(1),'(/1X,A)')'-----VARIABLE NAMES'
      WRITE(KW(1),2410)
      WRITE(KW(1),'(20(1X,A4))')HED
      !!!NDRV=DRV+1.1
      IF(YWI<1.E-10)YWI=10.
      IF(GWS0<1.E-5)GWS0=50.
      IF(RFT0<1.E-5)RFT0=10.
      IF(RFP0<1.E-5)RFP0=.5
      CALL APAGE(0)
      WRITE(KW(1),3540)
      WRITE(KW(1),3110)NBYR,IYR,IMO,IDA
      IF(LPYR>0)THEN
          WRITE(KW(1),'(T10,A)')'LEAP YEAR IGNORED'
      ELSE
          WRITE(KW(1),'(T10,A)')'LEAP YEAR CONSIDERED'
      END IF
      WRITE(KW(1),3730)YLAT,XLOG,ELEV
      SELECT CASE(NDRV)
          CASE(1)
              NDVSS=30
          CASE(2)
              NDVSS=28
          CASE(3)
              NDVSS=26
          CASE(4)
              NDVSS=29
          CASE(5)
              NDVSS=27
          CASE(6)
              NDVSS=124
          CASE(7)
              NDVSS=107
          CASE(8)
              NDVSS=31
      END SELECT
      WRITE(KW(1),'(T10,A,A4)')'WATER EROSION FACTORS--DRIVING EQ = ',&
      HED(NDVSS)
      IF(NDRV==6)WRITE(KW(1),'(T15,A,4E13.5)')'MUSI COEFS = ',BUS
      WRITE(KW(1),'(T10,A)')'DAILY RUNOFF ESTIMATION'
      SELECT CASE(INFL)
          CASE(1)
              WRITE(KW(1),'(T15,A)')'NRCS CURVE NUMBER EQ'
          CASE(2)
              WRITE(KW(1),'(T15,A/T15,A)')'GREEN & AMPT EQ','RF EXP DST&
              --PEAK RF RATE SIM'
          CASE(3)
              WRITE(KW(1),'(T15,A/T15,A)')'GREEN & AMPT EQ','RF EXP DST&
              --PEAK RF RATE INPUT'
          CASE(4)
              WRITE(KW(1),'(T15,A/T15,A)')'GREEN & AMPT EQ','RF UNIF DST--&
              PEAK RF RATE INP'
          CASE(5)
              WRITE(KW(1),'(T15,A/T15,A,F6.3,A)')'GREEN & AMPT EQ','RF INPUT AT &
              INTERVAL = ',DTHY,' h'
      END SELECT
      IF(ISCN==0)THEN
          WRITE(KW(1),'(T15,A)')'DAILY CN--STOCHASTIC'
      ELSE
          WRITE(KW(1),'(T15,A)')'DAILY CN--DETERMINISTIC'
      END IF
      IF(ITYP>0)THEN
          WRITE(KW(1),'(T10,A,A2)')'PEAK RATE EST WITH TR55--RF TYPE =',&
          RFPT(ITYP)
      ELSE
          IF(ITYP<0)THEN
              WRITE(KW(1),'(T10,A)')'PEAK RATE MOD RATIONAL EQ - RIGID'
          ELSE
              WRITE(KW(1),'(T10,A)')'PEAK RATE MOD RATIONAL EQ - &
              STOCHASTIC'
          END IF
      END IF
      IF(QG>0.)THEN
          X2=(QG-8.96)**2/(QG+35.86)
          X1=.1732
          TCX=.0663*X1**.77/CHS0**.385
          QG0=.1*X2/TCX
          WRITE(KW(1),401)QG,X2,QCF,X1,CHS0,TCX,QG0,BWD,FCW,FPS0,GWS0,&
          RFT0,RFP0,PCO0,RCC0

      END IF
      SELECT CASE(IHY)
          CASE(1)
              WRITE(KW(1),'(T15,A)')'VSC METHOD'
              WRITE(KW(12),'(T15,A)')'VSC METHOD'
              WRITE(KW(26),'(T15,A)')'VSC METHOD'
          CASE(2)
              WRITE(KW(1),'(T15,A)')'SVS METHOD'
              WRITE(KW(12),'(T15,A)')'SVS METHOD'
              WRITE(KW(26),'(T15,A)')'SVS METHOD'
          CASE(3)
              WRITE(KW(1),'(T15,A)')'M_CVC METHOD'
              WRITE(KW(12),'(T15,A)')'M_CVC METHOD'
              WRITE(KW(26),'(T15,A)')'M_CVC METHOD'
          CASE(4)
              WRITE(KW(1),'(T15,A)')'M_CVC4 METHOD'
              WRITE(KW(12),'(T15,A)')'M_CVC4 METHOD'
              WRITE(KW(26),'(T15,A)')'M_CVC4 METHOD'
          CASE DEFAULT
              WRITE(KW(1),'(T10,A)')'RUNOFF VOLUME ROUTING'
      END SELECT
      IF(IPRK==0)THEN
          WRITE(KW(1),'(T10,A)')'PERCOLATION--HPERC'
      ELSE
          WRITE(KW(1),'(T10,A)')'PERCOLATION--HPERC1 (4mm SLUG FLOW)'
      END IF
      IF(IERT>0)THEN
          WRITE(KW(1),'(T10,A)')'GLEAMS ENRICHMENT RATIO'
      ELSE
          WRITE(KW(1),'(T10,A)')'EPIC ENRICHMENT RATIO'
      END IF
      IF(LBP==0)THEN
          WRITE(KW(1),'(T10,A)')'GLEAMS PESTICIDE EQ SOL P RUNOFF'
      ELSE
          WRITE(KW(1),'(T10,A)')'LANGMUIR EQ SOL P RUNOFF'
      END IF
      IF(NUPC>0)THEN
          WRITE(KW(1),'(T10,A)')'N & P UPTAKE CONC S CURVE'
      ELSE
          WRITE(KW(1),'(T10,A)')'N & P UPTAKE CONC SMITH CURVE'
      END IF
      IF(ICP==0)THEN
          WRITE(KW(1),'(T10,A)')'PHOENIX N-C MODEL'
      ELSE
          WRITE(KW(1),'(T10,A)')'CENTURY N-C MODEL'
      END IF
      IF(IOX==0)THEN
          WRITE(KW(1),'(T10,A)')'EPIC O2=F(Z)'
      ELSE
          WRITE(KW(1),'(T10,A)')'O2=F(C/CLA)'
      END IF
      IF(NTV==0)THEN
          WRITE(KW(1),'(T10,A)')'ORIGINAL APEX NITVOL EQS'
      ELSE
          WRITE(KW(1),'(T10,A)')'IZAURRALDE REVISED NITVOL EQS'
      END IF
      SELECT CASE(IDNT)
          CASE(1)
              WRITE(KW(1),'(T10,A)')'EPIC DNIT'
          CASE(2)
              WRITE(KW(1),'(T10,A)')'KEMANIAN DNIT'
          CASE(3)
              WRITE(KW(1),'(T10,A,F5.2,A)')'IZAURRALDE DNIT DZDN=',DZDN,' m'
              WRITE(KW(1),'(T15,3(A,E16.6)A)')'XKN1=',XKN1,' XKN3=',XKN3,&
              ' XKN5=',XKN5,' ORIGINAL DW'
              IF(JRRS==0.)THEN
                  WRITE(KW(1),'(T10,A)')'ROOT RESPIRATION CALCULATED IN NDNITCI'
              ELSE
                  WRITE(KW(1),'(T10,A)')'ROOT RESPIRATION NOT CONSIDERED IN NDNITCI'
              END IF
          CASE(4)
              WRITE(KW(1),'(T10,A,F5.2,A)')'IZAURRALDE DNIT DZDN=',DZDN,' m'
              WRITE(KW(1),'(T15,3(A,E16.6)A)')'XKN1=',XKN1,' XKN3=',XKN3,&
              ' XKN5=',XKN5,' NEW DW'
              IF(JRRS==0.)THEN
                  WRITE(KW(1),'(T10,A)')'ROOT RESPIRATION CALCULATED IN NDNITCI'
              ELSE
                  WRITE(KW(1),'(T10,A)')'ROOT RESPIRATION NOT CONSIDERED IN NDNITCI'
              END IF
          CASE DEFAULT
              WRITE(KW(1),'(T10,A)')'KEMANIAN DNIT'
              IDNT=2
      END SELECT
      IF(ISLF>0)THEN
          WRITE(KW(1),'(T10,A)')'MUSLE SLOPE/LENGTH FACTOR'
      ELSE
          WRITE(KW(1),'(T10,A)')'RUSLE SLOPE/LENGTH FACTOR'
      END IF
      IF(PRMT(81)>0)THEN
          WRITE(KW(1),'(T10,A)')'DYNAMIC TECHNOLOGY'
      ELSE
          WRITE(KW(1),'(T10,A)')'STATIC TECHNOLOGY'
      END IF
      WRITE(KW(1),412)LPD,MSCP
      WRITE(KW(1),2450)APM,RFNC,CQNI,UPR,UNR,MNUL
      WRITE(KW(1),330)COL,COIR,FULP,WAGE
      WRITE(KW(1),12)COCH
      RFNC=RFNC/100.
      CQNI=CQNI*.01
      CALL APAGE(0)
      WRITE(KW(1),'(//1X,A/)')'____________________WEATHER DATA_________&
      ______________'
      WRITE(KW(1),3750)CO2
      SELECT CASE(ICO2)
          CASE(1)
              WRITE(KW(1),'(T10,A)')'DYNAMIC ATMOSPHERIC CO2'
          CASE(2)
              WRITE(KW(1),'(T10,A)')'ATMOSPHERIC CO2 INPUT'
          CASE DEFAULT
              WRITE(KW(1),'(T10,A)')'STATIC ATMOSPHERIC CO2'
      END SELECT
      WRITE(KW(1),2520)YWI
      XY2=.5/YWI
      SUM=0.
      IWPX=IWPM(1)
      ! WEATHER PARM # (FROM WPM1US.DAT) FOR SPATIAL WEATHER GENERATION
      ! LINE 7
      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!READ(KR(1),811)(IWPM(J),J=1,10)
      !!!DO J=1,10
      !!!    IF(IWPM(J)==0)EXIT
      !!!END DO
      !!!NWP=J-1
      ! FRACTION OF WSA REPRESENTED BY IWPM. FOR SPATIAL WEATHER GENERATION
      ! LINE 8
      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!READ(KR(1),3120)(FWXP(J),J=1,NWP)
      !!! IF(NWP>1)THEN
      !!!    DO J=1,NWP
      !!!        SUM=SUM+FWXP(J)
      !!!    END DO
      !!!    XX=0.
      !!!    DO J=1,NWP
      !!!        FWXP(J)=FWXP(J)/SUM
      !!!        AWXP(J)=FWXP(J)+XX
      !!!        XX=AWXP(J)
      !!!    END DO
      !!!ELSE
      !!!    FWXP(1)=1.
      !!!END IF
      NWP=1
      FWXP(1)=1.

      !!!MODIF HISAFE 3 : REMOVE WEATHER FILE READING
      IF(IWPM(1)==0)IWPM(1)=IWPX
      K=35
      NWP=MAX(1,NWP)
      DO IWI=1,NWP
      !!!    IF(IWI>1.OR.IWPM(1)>0)THEN
      !!!        I2=-1
      !!!            READ(KR(18),*,IOSTAT=NFL)I2,WPMFILE
      !!!            IF(NFL/=0)THEN
      !!!                WRITE(*,*)'WPM1 NO = ',IWPM(IWI),' NOT IN MO WEATHER LIST FILE'
      !!!                STOP
      !!!            END IF
      !!!        END DO
      !!!    ELSE
      !!!        D0=1.E20
      !!!        DO
      !!!           READ(KR(18),*,IOSTAT=NFL)I2,OPSCFILE,Y,X
      !!!            IF(NFL/=0.OR.I2==0)EXIT
      !!!            RY=Y/CLT
      !!!            XX=SIN1*SIN(RY)+COS1*COS(RY)*COS((X-XLOG)/CLT)
      !!!            D=6378.8*ACOS(XX)
       !!!           IF(D>D0)CYCLE
       !!!           D0=D
       !!!           WPMFILE=OPSCFILE
       !!!       END DO
       !!!   END IF
       !!!   REWIND KR(18)

          filename = foldername//'/'//WPMFILE
          CALL OPENV(KR(K),filename,0)

          TITWP(IWI)=WPMFILE
          !     LINES 1/2
          READ(KR(K),'()')
          READ(KR(K),'()')
          !  3  OBMX   = AV MO MAX TEMP (c)
          !  4  OBMN   = AV MO MIN TEMP (c)
          !  5  SDTMX  = MO STANDARD DEV MAX TEMP (c)OR EXTREME MAXIMUM TEMP (c)
          !              IF STANDARD DEV IS NOT AVAILABLE (BLANK IF TEMP IS INPUT
          !              DAILY)
          !  6  SDTMN  = MO STANDARD DEV MIN TEMP (c)OR EXTREME MIN TEMP (c)
          !              IF STANDARD DEV IS NOT AVAILABLE (BLANK IF TEMP IS INPUT
          !              DAILY)
          !  7  RMO    = AV MO PRECIPITATION (mm)
          !  8  RST(2) = MONTHLY ST DEV OF DAILY RAINFALL (mm)(BLANK IF UNKNOWN
          !              OR IF DAILY PRECIPITATION IS INPUT)
          !  9  RST(3) = MONTHLY SKEW COEF OF DAILY RAINFALL (BLANK IF UNKNOWN OR
          !              DAILY PRECIPITATION IS INPUT)
          ! 10  PRW(1) = MONTHLY PROBABILITY OF WET DAY AFTER DRY DAY (BLANK IF
          !              UNKNOWN OR IF DAILY PRECIPITATION IS INPUT)
          ! 11  PRW(2) = MONTHLY PROBABILITY OF WET DAY AFTER WET DAY (BLANK IF
          !              UNKNOWN OR IF DAILY PRECIPITATION IS INPUT)
          ! 12  UAVM   = AV NO DAYS OF PRECIPITATION/MO (BLANK IF PRECIP IS
          !              GENERATED AND IF PRW 1&2 ARE INPUT)
          ! 13  WI     = 3 OPTIONS--(1)MO MAX .5 H RAIN FOR PERIOD = YWI (mm)
          !                         (2)ALPHA (MEAN .5 H RAIN/MEAN STORM
          !                             AMOUNT)
          !                         (3)BLANK IF UNKNOWN
          ! 14  OBSL   = AV MO SOL RAD (MJ/m2 OR LY)(BLANK IF UNKNOWN)
          ! 15  RH     = 3 OPTIONS--(1)AV MO RELATIVE HUMIDITY (FRACTION)
          !                         (2)AV MO DEW POINT TEMP deg C
          !                         (3)BLANK IF UNKNOWN
          !              USED IN PENMAN OR PENMAN-MONTEITH EQS
          ! 16  UAV0   = AV MO WIND SPEED(m/s)
          !     LINES 3/15
          READ(KR(K),3190)(OBMX(IWI,I),I=1,12)
          READ(KR(K),3190)(OBMN(IWI,I),I=1,12)
          READ(KR(K),3190)(SDTMX(IWI,I),I=1,12)
          READ(KR(K),3190)(SDTMN(IWI,I),I=1,12)
          READ(KR(K),3190)(RMO(IWI,I),I=1,12)
          READ(KR(K),3190)(RST(2,IWI,I),I=1,12)
          READ(KR(K),3190)(RST(3,IWI,I),I=1,12)
          READ(KR(K),3190)(PRW(1,IWI,I),I=1,12)
          READ(KR(K),3190)(PRW(2,IWI,I),I=1,12)
         READ(KR(K),3190)(UAVM(I),I=1,12)
          READ(KR(K),3190)(WI(IWI,I),I=1,12)
          READ(KR(K),3190)(OBSL(IWI,I),I=1,12)
          READ(KR(K),3190)(RH(IWI,I),I=1,12)
          READ(KR(K),3190)(UAV0(I),I=1,12)
          REWIND KR(K)
          K=K+1
          IF(IWI==1)THEN
              TAV(1)=.25*(OBMX(IWI,12)+OBMN(IWI,12)+OBMX(IWI,1)+OBMN(IWI,1))
              BAV=TAV(1)
              SVA=BAV
              JT1=1
              IF(OBMN(IWI,1)>OBMN(IWI,12))JT1=12
              TMN(1)=OBMN(IWI,JT1)
              DO I=2,12
                  I1=I-1
                  TAV(I)=.25*(OBMX(IWI,I)+OBMN(IWI,I)+OBMX(IWI,I1)+OBMN(IWI,I1))
                  IF(TAV(I)>BAV)THEN
                      BAV=TAV(I)
                  ELSE
                      IF(TAV(I)<SVA)SVA=TAV(I)
                  END IF
                  IF(OBMN(IWI,I)>TMN(1))CYCLE
                  JT1=I
                  TMN(1)=OBMN(IWI,I)
              END DO
          END IF
          RHCF=1.
          AMPX=BAV-SVA
          DO I=1,12
              IF(RST(2,IWI,I)<1.E-5.OR.RST(3,IWI,I)<1.E-5)EXIT
          END DO
          IF(I>12)THEN
              ICDP=0
          ELSE
              ICDP=1
              SUM=0.
              DO I=1,10000
                  XX=AUNIF(IDG(3))
                  SUM=SUM+(-LOG(XX))**EXPK
              END DO
              REXP=10100./SUM
          END IF
          ISA=1
          DO I=1,12
              I1=I+1
              XM=NC(I1)-NC(I)
              JDA=(NC(I1)+NC(I))*.5
              CALL WHLRMX(JDA)
              SRMX(I,1)=RAMX
              THRL(I,1)=HRLT
              XYP(I)=0.
              XX=SDTMX(IWI,I)-SDTMN(IWI,I)
              IF(XX>10.)THEN
                  SDTMX(IWI,I)=(SDTMX(IWI,I)-OBMX(IWI,I))*.25
                  SDTMN(IWI,I)=(OBMN(IWI,I)-SDTMN(IWI,I))*.25
              END IF
              IF(PRW(1,IWI,I)>0.)THEN
                  UAVM(I)=XM*PRW(1,IWI,I)/(1.-PRW(2,IWI,I)+PRW(1,IWI,I))
              ELSE
                  PRW(1,IWI,I)=BTA*(UAVM(I)+.0001)/XM
                  PRW(2,IWI,I)=1.-BTA+PRW(1,IWI,I)
              END IF
              RST(1,IWI,I)=RMO(IWI,I)/(UAVM(I)+.01)
              IF(OBSL(IWI,I)<=0.)THEN
                  X1=MAX(.8,.21*SQRT(OBMX(IWI,I)-OBMN(IWI,I)))
                  OBSL(IWI,I)=X1*RAMX
              END IF
              V3=AUNIF(IDG(3))
              IF(ICDP>0)THEN
                  RST(1,IWI,I)=RST(1,IWI,I)*REXP
                  PCF(IWI,I)=1.
                  CYCLE
              END IF
              SUM=0.
              R6=RST(3,IWI,I)/6.
              DO J=1,1000
                  V4=AUNIF(IDG(3))
                  XX=ADSTN(V3,V4)
                  V3=V4
                  R1=WRAIN(R6,XX,RST,IWI,I)
                  SUM=SUM+R1
              END DO
              PCF(IWI,I)=1010.*RST(1,IWI,I)/SUM
          END DO
          XYP(1)=OBMX(IWI,1)
          BIG(1)=OBSL(IWI,1)
          UPLM=RH(IWI,1)
          BLM=RH(IWI,1)
          RFMX=RMO(IWI,1)
          EXTM=WI(IWI,1)
          RHCF=1.
          DO I=2,12
              TX=.5*(OBMX(IWI,I)+OBMN(IWI,I))
              RTO=RH(IWI,I)/TX
              IF(RTO>1.)RHCF=100.
              IF(OBSL(IWI,I)>BIG(1))BIG(1)=OBSL(IWI,I)
              IF(RMO(IWI,I)>RFMX)RFMX=RMO(IWI,I)
              IF(RH(IWI,I)>UPLM)THEN
                  UPLM=RH(IWI,I)
              ELSE
                  IF(RH(IWI,I)<BLM)BLM=RH(IWI,I)
              END IF
              IF(WI(IWI,I)>EXTM)EXTM=WI(IWI,I)
              XYP(1)=XYP(1)+OBMX(IWI,I)
          END DO
          RUNT=1.
          IF(BIG(1)>100.)RUNT=.04184
          XYP(1)=XYP(1)/12.
          X3=.3725/(XYP(1)+20.)
          DO I=1,12
              XM=NC(I+1)-NC(I)
              WFT(IWI,I)=UAVM(I)/XM
              XYP(2)=XYP(2)+OBMN(IWI,I)
              XYP(3)=XYP(3)+RMO(IWI,I)
              XYP(4)=XYP(4)+UAVM(I)
              OBSL(IWI,I)=RUNT*OBSL(IWI,I)
              XYP(5)=XYP(5)+OBSL(IWI,I)
              X1=MAX(RMO(IWI,I),12.7)
              TX=.5*(OBMX(IWI,I)+OBMN(IWI,I))
              IF(UPLM>1.)THEN
                  IF(BLM<0..OR.RHCF<1.1)THEN
                      RH(IWI,I)=ASVP(RH(IWI,I)+273.)/ASVP(TX+273.)
                  ELSE
                      RH(IWI,I)=RH(IWI,I)/RHCF
                  END IF
              ELSE
                  IF(RH(IWI,I)<1.E-10)THEN
                      XX=OBMX(IWI,I)-OBMN(IWI,I)
                      RH(IWI,I)=.9-.8*XX/(XX+EXP(5.122-.1269*XX))
                  END IF
              END IF
              X2=MAX(TX,-1.7)
              XYP(6)=XYP(6)+((X1/25.4)/(1.8*X2+22.))**1.111
              X1=RMO(IWI,I)/(UAVM(I)+1.E-10)
              IF(EXTM>1.)THEN
                  F=XY2/(UAVM(I)+.01)
                  XTP(I)=WI(IWI,I)
                  WI(IWI,I)=-XTP(I)/LOG(F)
                  WI(IWI,I)=APM*WI(IWI,I)/(X1+1.)
                  IF(WI(IWI,I)<.1)WI(IWI,I)=.1
                  IF(WI(IWI,I)>.95)WI(IWI,I)=.95
              ELSE
                  IF(EXTM<1.E-10)WI(IWI,I)=APM*X3*(OBMX(IWI,I)+20.)
                  XTP(I)=5.3*X1*WI(IWI,I)
              END IF
          END DO
          XYP(2)=XYP(2)/12.
          XYP(5)=XYP(5)/12.
          XYP(6)=115.*XYP(6)
          WRITE(KW(1),3050)
          WRITE(KW(1),602)TITWP(IWI),FWXP(IWI)
          WRITE(KW(1),3300)HED(1),(OBMX(IWI,I),I=1,12),XYP(1),HED(1)
          WRITE(KW(1),3300)HED(2),(OBMN(IWI,I),I=1,12),XYP(2),HED(2)
          WRITE(KW(1),3010)'SDMX',(SDTMX(IWI,I),I=1,12),'SDMX'
          WRITE(KW(1),3010)'SDMN',(SDTMN(IWI,I),I=1,12),'SDMN'
          WRITE(KW(1),2550)HED(4),(RMO(IWI,I),I=1,12),XYP(3),HED(4)
          WRITE(KW(1),3440)'SDRF',(RST(2,IWI,I),I=1,12),'SDRF'
          WRITE(KW(1),3010)'SKRF',(RST(3,IWI,I),I=1,12),'SKRF'
          WRITE(KW(1),3460)'PW/D',(PRW(1,IWI,I),I=1,12),'PW/D'
          WRITE(KW(1),3460)'PW/W',(PRW(2,IWI,I),I=1,12),'PW/W'
          WRITE(KW(1),3300)'DAYP',(UAVM(I),I=1,12),XYP(4),'DAYP'
          WRITE(KW(1),3440)'P5MX',(XTP(I),I=1,12),'P5MX'
          WRITE(KW(1),2550)HED(3),(OBSL(IWI,I),I=1,12),XYP(5),HED(3)
          WRITE(KW(1),3440)'RAMX',(SRMX(I,1),I=1,12),'RAMX'
          WRITE(KW(1),3010)'HRLT',(THRL(I,1),I=1,12),'HRLT'
          WRITE(KW(1),3010)'RHUM',(RH(IWI,I),I=1,12),'RHUM'
          WRITE(KW(1),3010)'ALPH',(WI(IWI,I),I=1,12),'ALPH'
          WRITE(KW(1),3010)' PCF',(PCF(IWI,I),I=1,12),' PCF'
      END DO            !end loop NWP

      KND=K-1
      IWI=NWP

      IF(NGN<=0)THEN
          WRITE(KW(1),'(/T10,A)')'__________RAIN, TEMP, RAD, WIND &
          SPEED, & REL HUM ARE GENERATED__________'
          IF(NGN<0)THEN
              WRITE(KW(1),'(T10,A)')'RAINFALL IS SAME FOR ALL SUBAREAS'
          ELSE
              WRITE(KW(1),'(T10,A)')'RAINFALL IS SPATIALLY DISTRIBUTED'
          END IF
      ELSE
          L=1
          N1=NGN
          DO J=4,1,-1
              CALL AISPL(N1,N2)
              IF(N1==0)EXIT
              KGN(N1)=1
              SELECT CASE(N1)
                  CASE(1)
                      N1=N2
                      CYCLE
                  CASE(2)
                      KDT2(L)=59
                  CASE(3)
                      KDT2(L)=3
                  CASE(4)
                      KDT2(L)=7
                  CASE(5)
                      KDT2(L)=8
                  CASE DEFAULT
              END SELECT
              L=L+1
              N1=N2
          END DO
          SELECT CASE(L)
              CASE(1)
                  WRITE(KW(1),'(/T10,A)')'__________RAIN IS INPUT__________'
              CASE(2)
                  WRITE(KW(1),'(/T10,A,1X,A4,A)')'__________RAIN,',HED&
                  (KDT2(1)),' ARE INPUT__________'
              CASE(3)
                  WRITE(KW(1),3650)(HED(KDT2(J)),J=1,2)
              CASE(4)
                  WRITE(KW(1),3660)(HED(KDT2(J)),J=1,3)
              CASE(5)
                  WRITE(KW(1),3670)(HED(KDT2(J)),J=1,4)
          END SELECT
      END IF


      IF(INFL==5)THEN

          !!!MODIF HISAFE 2 = MODIFY READING FILE PATH
          !!!filename = foldername//'/'//FRFDT
          !!! write(*,*) 'FRFDT=',filename
          !!!CALL OPENV(KR(29),filename,0)

          !!!I2=-1
          !!!DO WHILE(I2/=IRFT)
          !!!    READ(KR(29),*,IOSTAT=NFL)I2,RFTFILE
          !!!    IF(NFL/=0)THEN
          !!!        WRITE(*,*)'RAINDT NO = ',IRFT,' NOT IN RFTFILE LIST FILE'
          !!!        STOP
          !!!    END IF
          !!!END DO
          !!!REWIND KR(29)

          !!!MODIF HISAFE 2 = MODIFY READING FILE PATH
          filename = foldername//'/'//RFTFILE
           write(*,*) 'RFTFILE=',filename
          CALL OPENV(KR(30),filename,0)


          WRITE(KW(1),'(/T10,A,A80)')'WITHIN STORM RAINFALL READ FROM ',RFTFILE
      END IF
      ! ICMO=COMMAND NUMBERS OF WATERSHED OUTLETS
      ! LINE 9
      !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
      !!!READ(KR(1),811)ICMO
      DO I=1,10
          IF(ICMO(I)==0)EXIT
      END DO
      NCMO=I-1
      WRITE(KW(1),'(/T10,A,F6.3)')'WET-DRY PROB COEF = ',BTA
      XTP(2)=XTP(2)/12.
      AAP=XYP(3)
      RFAD=AAP/365.25
      AVT=(XYP(1)+XYP(2))*.5
      CLF=RFAD/AVT
      X1=MAX(1.,AVT)
      CLF0=SQRT(AAP/X1)
      IF(UXP<1.E-10)UXP=.5
      !!!IF(DIAM<1.E-10)DIAM=500.
      !!!USTRT=.0161*SQRT(DIAM)
      USTT=USTRT*USTRT
      ! UAVM = AV MO WIND SPEED(m/s)(REQUIRED TO SIMULATE WIND
      ! EROSION--ACW>0 LINE 23  AND POTENTIAL ET IF PENMAN OR
      ! PENMAN-MONTEITH EQS ARE USED--LINE 4)
      ! LINE 7
      READ(KR(22),3190)UAVM
      AWV=0.
      WB=0.
      XTP=0.
      DO I=1,12
          IF(UAVM(I)<1.E-5)UAVM(I)=UAV0(I)
          AWV=AWV+UAVM(I)
          DO J=1,100
              RN2=AUNIF(IDG(5))
              WV=UAVM(I)*(-LOG(RN2))**UXP
              IF(WV>6.)THEN
                  EV=193.*EXP(1.103*(WV-30.)/(WV+1.))
                  XTP(I)=XTP(I)+EV
              END IF
          END DO
          WB=WB+XTP(I)
      END DO
      AWV=AWV/12.
      WCF=(3.86*AWV**3/XYP(6)**2)**.3484
      WRITE(KW(1),3300)HED(7),UAVM,AWV,HED(7)
      IF(IET==4.AND.PRMT(34)>0.)THEN
          HGX=PRMT(34)
      ELSE
          IF(WCF<.5)THEN
              HGXW=.5
          ELSE
              HGXW=MIN(.6,WCF)
          END IF
          IF(CLF0>7.)THEN
              HGX0=.5
          ELSE
              HGX0=MIN(.6,1.2-.1*CLF0)
          END IF
          HGX=.5*(HGXW+HGX0)
      END IF
      ! DIR  = AV MO FRACTION OF WIND FROM 16 DIRECTIONS(BLANK UNLESS
      ! WIND EROSION IS SIMULATED--ACW>0 LINE 23).
      DO J=1,16
          ! LINES 25/40
          READ(KR(22),3190)(DIR(I,J),I=1,12)
          IF(DIR(1,J)>0.)CYCLE
          DO I=1,12
              DIR(I,J)=1.
          END DO
      END DO
      REWIND KR(22)
      WRITE(KW(1),'(/T10,A)')'WIND DIRECTION DISTRIBUTION'
      WRITE(KW(1),'(T20,A,A80)')'WIND = ',TITWN
      WRITE(KW(1),3280)NBYR
      XTP=0.
      DO I=1,12
          XTP(1)=XTP(1)+DIR(I,1)
          IF(UAVM(1)>0.)THEN
              CALL AEXINT(UXP,SUM)
              UAVM(I)=UAVM(I)/SUM
          END IF
          DO J=2,16
              XTP(J)=XTP(J)+DIR(I,J)
              DIR(I,J)=DIR(I,J)+DIR(I,J-1)
          END DO
          DO J=1,16
              DIR(I,J)=DIR(I,J)/DIR(I,16)
          END DO
      END DO
      SUM=0.
      DO J=1,16
          SUM=SUM+XTP(J)
      END DO
      DO J=1,16
          XTP(J)=XTP(J)/SUM
          WRITE(KW(1),3300)HEDW(J),(DIR(I,J),I=1,12),XTP(J),HEDW(J)
      END DO
      WRITE(KW(1),'(T10,A,F7.3)')'WIND EROS CLIMATIC FACTOR = ',WCF
      WRITE(KW(1),'(T10,A,F7.2)')'CLIMATIC FACTOR = ',CLF0
      SELECT CASE(IET)
          CASE(1)
              WRITE(KW(1),'(/T10,A)')'___________PENMAN-MONTEITH  EQ &
              USED TO EST POT ET___________'
          CASE(2)
              WRITE(KW(1),'(/T10,A)')'___________PENMAN EQ USED TO EST &
              POT ET___________'
          CASE(3)
              WRITE(KW(1),'(/T10,A)')'___________PRIESTLEY-TAYLOR EQ &
              USED TO EST POT ET___________'
          CASE(4)
              WRITE(KW(1),'(/T10,A,F8.4,A,F5.2)')'___________HARGREAVES EQ USED TO &
              EST POT ET ___________ PARM(23)=',PRMT(23),' PARM(34)=',HGX
          CASE(5)
              WRITE(KW(1),'(/T10,A)')'__________ BAIER-ROBERTSON EQ &
              USED TO EST POT ET __________'
          CASE DEFAULT
              WRITE(KW(1),'(/T10,A)')'___________HARGREAVES EQ USED TO &
              EST POT ET___________ PARM(23)=',PRMT(23),' PARM(34)=',HGX
      END SELECT
      CALL ALPYR(IYR,NYD,LPYR)
      CALL ADAJ(NC,IBD,IMO,IDA,NYD)
      JDA=IBD
      MO=1
      CALL AXMON
      MO1=MO
      TX=(OBMX(1,MO)+OBMN(1,MO))/2.
      ST0=OBSL(1,MO)
      DST0=TX
      DO I=1,100
          KDC1(I)=0
!!!          NX(I)=I
      END DO
 2140 LC=0
      NDT=0
      NDP=0
      NDF=0
      ISV=0
      X1=IWTB*RFAD
      DO I=1,MSA
          TITSO(I)=''
          TITOP(I)=''
          SMRF(I)=X1
          SMEO(I)=X1
          DO J=1,MSL
              LID(J,I)=J
              LORG(J,I)=J
          END DO
          LID(ML1,I)=ML1
      END DO
      CALL AINLZ
      CALL AINIX
      DO J=1,12
          IDG(J)=J
      END DO
      IYX=IYR0-1880
!     RANDOM NUMBER GENERATOR ID NUMBERS
!     IDG = 1 DETERMINES WET AND DRY DAYS
!         = 2 RELATES WEATHER VARIABLES TO RAIN
!         = 3 RAINFALL AMOUNT
!         = 4 RAINFALL ENERGY(EI)- PEAK RUNOFF RATE(QRB)
!         = 5 WIND SPEED
!         = 6 WIND DIRECTION
!         = 7 RELATIVE HUMIDITY
!         = 8 RUNOFF CURVE NUMBER
!         = 9 WITHIN DAY WIND SPEED DIST
!         =10 X COORDINATE OF SPATIAL RAINFALL GENERATOR
!         =11 Y COORDINATE OF SPATIAL RAINFALL GENERATOR
!         =12 MULTIPLE WEATHER GEN PARM SELECTOR
      IF(IGN>0)THEN
          DO KK=1,IGN
              DO J=1,12
                  XX=AUNIF(13)
                  IX(J)=IX(13)
              END DO
          END DO
          CALL AISHFL
      END IF
      DO J=1,12
          IX0(J)=IX(J)
      END DO
      WRITE(KW(1),3070)IGN,(IX(IDG(I)),I=1,12),(IDG(I),I=1,12)
      IF(KFL(1)>0)WRITE(KW(1),714)
      V3=AUNIF(IDG(3))
      V1=AUNIF(IDG(2))
      IF(IHRD>0)THEN
          IOW1=1
          DO
              IHD=IHD+1
              ! INITIAL HERD DATA
              ! IDON = OWNER ID#
              ! NCOW = NUMBER OF COWS PER HERD BY OWNER(HD)
              ! IDMU = MANURE ID # (FERTCOM.DAT)
              ! FFED = MINIMUM FRACTION OF DAY HERD IN FEEDING AREA.
              ! GZRT = GRAZING RATE FOR EACH HERD (kg/hd/d)
              ! DUMP = DAILY UNIT MANURE PROD(kg/hd/d)
              ! VURN = VOLUME OF URINE (l/hd/d)
              READ(KR(21),2320,IOSTAT=NFL)IOW,(XTP(J),J=1,6)
              IF(NFL/=0)EXIT
              IF(IOW==0.OR.IOW>MOW)EXIT
              IF(IOW1/=IOW)THEN
                  IOW1=IOW
                  IHD=1
              END IF
              NHRD(IOW)=NHRD(IOW)+1
              NCOW(IHD,IOW)=XTP(1)
              IDMU(IHD,IOW)=XTP(2)
              FFED(IHD,IOW)=XTP(3)
              GZRT(IHD,IOW)=XTP(4)
              DUMP(IHD,IOW)=XTP(5)
              VURN(IHD,IOW)=XTP(6)
              NMC=NMC+NCOW(IHD,IOW)
              IF(KFL(1)>0)WRITE(KW(1),646)IOW,IHD,NCOW(IHD,IOW),IDMU&
              (IHD,IOW),(XTP(J),J=3,6)
          END DO
      END IF
      IF(IHRD<2)THEN
          IHDM=1
          NHRD=1
      END IF
      WRITE(KW(1),101)NMC
      IHBS=0
      NYHO=0
      !IF(NMC>0)THEN
          !IF(KFL(1)>0)WRITE(KW(1),713)
          !IYHO=1
          ! HERD MANAGEMENT DATA
          ! READ OPERATION SCHEDULE
          ! 1    IOW  = OWNER NUMBER
          ! 2    IHD  = HERD NUMBER
          ! 3    I1   = YR OF BUY/SELL
          ! 4    I2   = MO OF BUY/SELL
          ! 5    I3   = DAY OF BUY/SELL
          ! 6    I4   = NUMBER OF ANIMALS IN HERD AFTER BUY/SELL
          !DO
              !READ(KR(21),3100)IOW,IHD,I1,I2,I3,I4
              !IF(IOW==0)EXIT
              !IHBS(IHD,IOW)=IHBS(IHD,IOW)+1
              !NHBS(IHD,IOW)=IHBS(IHD,IOW)
              !NBSX(IHBS(IHD,IOW),IHD,IOW)=I4
              !IF(I1>IYHO(IHD,IOW))IYHO(IHD,IOW)=I1
              !NYHO(IHD,IOW)=IYHO(IHD,IOW)
              !IHDT(IHBS(IHD,IOW),IHD,IOW)=I1*10000+I2*100+I3
              !IF(KFL(1)>0)WRITE(KW(1),848)I1,I2,I3,IOW,IHD,I4
          !END DO
      !END IF
      IYHO=1
      REWIND KR(21)
      IF(KFL(36)>0)THEN
          WRITE(KW(36),3381)IYER,IMON,IDAY,IT1,IT2,IT3
          WRITE(KW(36),'(T10,A,I4,1X,A,1X,A80)')'RUN # ',IRUN,'NAME',ASTN
      END IF
      K1=1
      SUMA=0.
      TOT=0.
      NFED=0
      XCU=0.
      YCU=0.
      XCS=1.E10
      YCS=1.E10
      XZP=0.
      TWMB=0.
      NBON=0
      TBTN=0.
      NCP=1

      DO ISA=1,MSA  !SUBAREA LOOP
          IBSA(ISA)=ISA
          XX=0.
          SUM=0.
          BIG(ISA)=.15
          RZ(ISA)=3.
          PAW(ISA)=0.
          RZSW(ISA)=0.
          PMX(ISA)=PRMT(43)
          ! NBSA=SUBAREA
          ! LINE 1
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),525)NBSA(ISA)

          NBSA(ISA)=1
          IF(NBSA(ISA)==0)EXIT
          IF(NBSA(ISA)>NBMX0)THEN
              NBMX0=NBSA(ISA)
              DEALLOCATE(NISA,FPSO)
              ALLOCATE(NISA(NBMX),FPSO(NBMX))
          END IF
          ! SUBAREA DATA
          !  1  INPS = SOIL # FROM TABLE KR(13)
          !  2  IOPS = OP SCHED # FROM TABLE KR(15)
          !  3  IOW  = OWNER ID #
          !  4  II   = 0 FOR NON FEEDING AREAS
          !          = HERD # FOR FEEDING AREAS
          !  5  IAPL = 0 FOR NON MANURE APPL AREAS
          !          = - FEED AREA ID # FOR LIQUID MANURE APPL AREAS
          !          =   FEED AREA ID # FOR SOLID MANURE APPL AREAS
          !  6  NOT USED
          !  7  NVCN = 0 VARIABLE DAILY CN NONLINEAR CN/SW WITH DEPTH SOIL WATER
          !              WEIGHTING
          !          = 1 VARIABLE DAILY CN NONLINEAR CN/SW NO DEPTH WEIGHTING
          !          = 2 VARIABLE DAILY CN LINEAR CN/SW NO DEPTH WEIGHTING
          !          = 3 NON-VARYING CN--CN2 USED FOR ALL STORMS
          !          = 4 VARIABLE DAILY CN SMI(SOIL MOISTURE INDEX)
          !  8  IWTH = INPUT DAILY WEATHER STATION NUMBER
          !  9  IPTS = POINT SOURCE NUMBER
          ! 10  ISAO = 0 FOR NORMAL RES PRINCIPAL SPILLWAY RELEASE
          !          = ID OF SUBAREA RECEIVING OUTFLOW FROM BURRIED PIPE OUTLET
          ! 11  LUNS = LAND USE NUMBER FROM NRCS LAND USE-HYDROLOGIC SOIL GROUP
          !            TABLE.  OVERRIDES LUN IN .OPC FILE.
          ! 12  IMW  = MIN INTERVAL BETWEEN AUTO MOW
          !     LINE 2
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)INPS,IOPS,IOW,II,IAPL(ISA),I1,NVCN(ISA),IWTH(ISA),&
          !!!IPTS(ISA),ISAO(ISA),LUNS(ISA),IMW(ISA)
          !!!IF(IMW(ISA)==0)IMW(ISA)=IMW0
          ! INITIAL CONDITIONS
          !  1  SNO  = WATER CONTENT OF SNOW COVER(mm)
          !  2  STDO = STANDING DEAD CROP RESIDUE(t/ha)
          !  3  YCT  = LATITUDE OF SUBAREA CENTROID
          !  4  XCT  = LONGITUDE OF SUBAREA CENTROID
          !  5  AZM  = AZIMUTH ORIENTATION OF LAND SLOPE (DEGREES CLOCKWISE FROM NORTH)
          !  6  FL   = FIELD LENGTH(km)(BLANK IF UNKNOWN)
          !  7  FW   = FIELD WIDTH(km)(BLANK IF UNKNOWN)
          !  8  ANGL = CLOCKWISE ANGLE OF FIELD LENGTH FROM NORTH(deg)(BLANK IF
          !            UNKNOWN)
          !     LINE 3
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)SNO(ISA),STDO(ISA),YCT(ISA),XCT(ISA),AZM,FL,FW,ANGL
          XCU=MAX(ABS(XCT(ISA)),XCU)
          XCS=MIN(ABS(XCT(ISA)),XCS)
          YCU=MAX(ABS(YCT(ISA)),YCU)
          YCS=MIN(ABS(YCT(ISA)),YCS)
          !!! IF(FL<1.E-10)FL=FL0
          !!!IF(FW<1.E-10)FW=FW0
          !!!IF(ANGL<1.E-10)ANGL=ANG0
          IF(FL<1.E-10)FL=.632
          IF(FW<1.E-10)FW=.316
          ANG=ANGL/CLT
          IF(ABS(XCT(ISA))>0..OR.ABS(YCT(ISA))>0.)THEN
              YLAZ=YCT(ISA)
          ELSE
              YLAZ=YLAT
          END IF

          IF(IOW>NBON)NBON=IOW
          IDON(ISA)=IOW
          NSAO(IOW)=NSAO(IOW)+1
          IDOW(NSAO(IOW),IOW)=ISA
          IDFH(ISA)=II
          IF(II>0)THEN
              IFED(II,IOW)=ISA
              NFED(IOW)=NFED(IOW)+1
              IDFD(NFED(IOW),IOW)=NBSA(ISA)
              IDFA(NFED(IOW),IOW)=ISA
          END IF



          IF(NVCN(ISA)==0)NVCN(ISA)=NVCN0
          WCHS=0.
          ! CATCHMENT CHARACTERISTICS
          !  1  WSA  = DRAINAGE AREA(ha)
          !  2  CHL  = CHANNEL LENGTH(km)(BLANK IF UNKNOWN)
          !  3  CHD  = CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
          !  4  CHS  = CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
          !  5  CHN  = MANNINGS N FOR CHANNEL(BLANK IF UNKNOWN)
          !  6  STP  = AVE UPLAND SLOPE(m/m)
          !  7  SPLG = AVE UPLAND SLOPE LENGTH(m)
          !  8  UPN  = MANNINGS N FOR UPLAND(BLANK IF UNKNOWN)
          !  9  FFPQ = FRACTION FLOODPLAIN FLOW--PARTITIONS FLOW THRU FILTER STRIPS
          ! 10  URBF = URBAN FRACTION OF SUBAREA
          !     LINE 4
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)WSA(ISA),CHL(ISA),CHD,CHS(ISA),CHN(ISA),STP(ISA),&
          !!!SPLG(ISA),UPN,FFPQ(ISA),URBF(ISA)
          IF(IAZM>0)THEN
              X1=ASIN(STP(ISA))
              YLAZ=YLAZ/CLT
              AZR=AZM/CLT
              YLAZ=CLT*ASIN(STP(ISA)*COS(AZR)*COS(YLAZ)+COS(X1)*SIN(YLAZ))
              write(*,*) 'LOOKING...',HSG
			  WRITE(KW(1),'(T10,A,F8.3)')'AZIMUTH ORIENTATION OF LAND SLOPE (DEGREES CLOCKWISE FROM NORTH)',AZM
              write(*,*) '...PA NUB'
			  WRITE(KW(1),'(T10,A,F8.3)')'EQUIVALENT LATITUDE = ',YLAZ
          END IF

          XX=YLAZ/CLT
          YLS(ISA)=SIN(XX)
          YLC(ISA)=COS(XX)
          YTN(ISA)=TAN(XX)
          PB=101.3-ELEV*(.01152-5.44E-7*ELEV)
          GMA(ISA)=6.595E-4*PB
          IRF(ISA)=ISA

          IF(NGN>0)CALL WDLYSTA
		  
          AHSM=CAHU(1,365,0.,1)
          Z1=ABS(WSA(ISA))
          GRDL(ISA)=SQRT(Z1*1.E4)
          TOT=TOT+Z1
          X3=1.+Z1
          IF(STP(ISA)<1.E-10)STP(ISA)=.001
          ISCH=1
          IF(WSA(ISA)<0.)ISCH=0
          IF(CHD<1.E-10)CHD=COCH(3)*Z1**COCH(4)
          IF(CHL(ISA)<1.E-10)CHL(ISA)=COCH(5)*Z1**COCH(6)
          IF(CHN(ISA)<1.E-10)CHN(ISA)=.05
          IF(UPN<1.E-10)UPN=.15
          X8=SQRT(STP(ISA))
          X1=100.*STP(ISA)
          CNSX(ISA)=1.1-X1/(X1+EXP(SCRP(18,1)-SCRP(18,2)*X1))
          IF(PRMT(92)>0.)THEN
              SCNX(ISA)=PRMT(92)
          ELSE
              SCNX(ISA)=MIN(1.7,2.-X1/(X1+EXP(SCRP(28,1)-SCRP(28,2)*X1)))
              SCNX(ISA)=MAX(1.,SCNX(ISA))
          END IF
          IF(CHS(ISA)<1.E-10)CHS(ISA)=STP(ISA)*X3**(-.3)
          UPSX(ISA)=SPLG(ISA)/22.127
          XM=.3*STP(ISA)/(STP(ISA)+EXP(-1.47-61.09*STP(ISA)))+.2
          SLF(ISA)=UPSX(ISA)**XM*(STP(ISA)*(65.41*STP(ISA)+4.56)+.065)
          X1=3.*STP(ISA)**.8+.56
          BETA=STP(ISA)/(.0896*X1)
          RXM=BETA/(1.+BETA)
          RLF(ISA)=UPSX(ISA)**RXM
          IF(SPLG(ISA)>4.57)THEN
              IF(STP(ISA)>.09)THEN
                  RSF(ISA)=16.8*STP(ISA)-.5
              ELSE
                  RSF(ISA)=10.8*STP(ISA)+.03
              END IF
          ELSE
              RSF(ISA)=X1
          END IF
          ACET(1,ISA)=Z1
          ACET(2,ISA)=CHL(ISA)
          ACET(3,ISA)=CHD
          ACET(4,ISA)=CHS(ISA)
          ACET(5,ISA)=CHN(ISA)
          ACET(6,ISA)=STP(ISA)
          ACET(7,ISA)=SPLG(ISA)
          ACET(8,ISA)=UPN
          X1=MIN(SPLG(ISA),SQRT(10000.*Z1))
          IF(ITYP>0)THEN
              IF(CHL(ISA)>.1)THEN
                  SFL=50.
              ELSE
                  IF(CHL(ISA)>.05)THEN
                      SFL=100.*(CHL(ISA)-.05)
                  ELSE
                      SFL=0.
                  END IF
              END IF
              TSF=SFL/MIN(2160.,17712.*X8)
              X1=MAX(CHL(ISA)-(SPLG(ISA)+SFL)*.001,0.)
              TCC(ISA)=X1/(3.6*CHD**.66667*SQRT(CHS(ISA))/CHN(ISA))
              TCS(ISA)=.0913*(SPLG(ISA)*UPN)**.8/STP(ISA)**.4
              TCC(ISA)=TCC(ISA)+TSF
              TC(ISA)=TCC(ISA)+TCS(ISA)
          ELSE
              TCS(ISA)=.0216*(SPLG(ISA)*UPN)**.75/STP(ISA)**.375
              TCC(ISA)=1.75*CHL(ISA)*CHN(ISA)**.75/(Z1**.125*CHS(ISA)**.375)
              X4=MIN(SPLG(ISA)/360.,TCS(ISA))
              TC(ISA)=X4+TCC(ISA)
          END IF
          ! CHANNEL GEOMETRY OF ROUTING REACH THRU SUBAREA
          !  1  RCHL = CHANNEL LENGTH OF ROUTING REACH(km)
          !  2  RCHD = CHANNEL DEPTH(m)(BLANK IF UNKNOWN)
          !  3  RCBW = BOTTOM WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
          !  4  RCTW = TOP WIDTH OF CHANNEL(m)(BLANK IF UNKNOWN)
          !  5  RCHS = CHANNEL SLOPE(m/m)(BLANK IF UNKNOWN)
          !  6  RCHN = MANNINGS N VALUE OF CHANNEL(BLANK IF UNKNOWN)
          !  7  RCHC = USLE C FOR CHANNEL
          !  8  RCHK = USLE K FOR CHANNEL
          !  9  RFPW = FLOODPLAIN WIDTH(m)(BLANK IF UNKNOWN)
          ! 10  RFPL = FLOODPLAIN LENGTH(km)(BLANK IF UNKNOWN)
          ! 11  SAT1 = SATURARTED CONDUCTIVITY(GREEN & AMPT) ADJUSTMENT FACTOR(.01_10.)
          ! 12  FPS1 = FLOODPLAIN SATURARTED CONDUCTIVITY ADJUSTMENT FACTOR(.0001_10.)
          SAT1=0.
          FPS1=0.
          ! LINE 5
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)RCHL(ISA),RCHD(ISA),RCBW(ISA),RCTW(ISA),RCHS(ISA),&
          !!!RCHN(ISA),RCHC(ISA),RCHK(ISA),RFPW(ISA),RFPL(ISA),SAT1,FPS1
          IF(RCHC(ISA)<1.E-10)RCHC(ISA)=RCC0
          ! RESERVOIR DATA
          !  1  RSEE = ELEV AT EMERGENCY SPILLWAY ELEV(m)
          !  2  RSAE = SURFACE AREA AT EMERGENCY SPILLWAY ELEV(ha)
          !  3  RVE0 = VOLUME AT EMERGENCY SPILLWAY ELEV(mm)
          !  4  RSEP = ELEV AT PRINCIPAL SPILLWAY ELEV(m)
          !  5  RSAP = SURFACE AREA AT PRINCIPAL SPILLWAY ELEV(ha)
          !  6  RVP0 = VOLUME AT PRINCIPAL SPILLWAY ELEV(mm)
          !  7  RSV  = INITIAL VOLUME(mm)
          !  8  RSRR = TIME TO RELEASE FLOOD STORAGE(d)
          !  9  RSYS = INITIAL SEDIMENT CONCENTRATION(ppm)
          ! 10  RSYN = NORMAL SEDIMENT CONC(ppm)
          ! 11  RSHC = BOTTOM HYDRAULIC CONDUCTIVITY(mm/h)
          ! 12  RSDP = TIME REQUIRED TO RETURN TO NORMAL SED CONC AFTER RUNOFF
          !            EVENT(d)
          ! 13  RSBD = BULK DENSITY OF SEDIMENT IN RESERVOIR(t/m^3)
          ! 14  PCOF = FRACTION OF SUBAREA CONTROLLED BY PONDS
          ! 15  BCOF = FRACTION OF SUBAREA CONTROLLED BY BUFFERS
          ! 16  BFFL = BUFFER FLOW LENGTH (m)
          ! LINE 6/7
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)RSEE(ISA),RSAE(ISA),RVE0(ISA),RSEP(ISA),RSAP(ISA),&
          !!!RVP0(ISA),RSV(ISA),RSRR(ISA),RSYS(ISA),RSYN(ISA),RSHC(ISA),RSDP&
          !!!(ISA),RSBD(ISA),PCOF(ISA),BCOF(ISA),BFFL(ISA)
          SVX=0.
          IF(RCHL(ISA)<1.E-10)RCHL(ISA)=CHL(ISA)
          IF(RFPL(ISA)<1.E-10)RFPL(ISA)=.95*RCHL(ISA)
          IF(RSBD(ISA)<1.E-10)RSBD(ISA)=.8
          IF(ABS(RCHL(ISA)-CHL(ISA))<1.E-10)THEN
              ! SUBAREA
              IEXT(ISA)=1
              ISV=ISV+1
              SAV(ISV)=SUMA
              SUMA=Z1
              ICDT(K1)=1
              IDOT(K1)=K1
              IDN1T(K1)=ISA
              IDN2T(K1)=0
              IDOS(ISV)=K1-1
              TC(K1)=TC(ISA)
          ELSE
              ! ROUTE
              SUMA=SUMA+Z1
              ICDT(K1)=2
              IDOT(K1)=K1
              IDN1T(K1)=IDOT(K1-1)
              IDN2T(K1)=ISA
              TC(K1)=TC(IDN1T(K1))
              K1=K1+1
              ! SUBAREA
              ICDT(K1)=1
              IDOT(K1)=K1
              IDN1T(K1)=ISA
              IDN2T(K1)=0
              TC(K1)=TC(ISA)
              K1=K1+1
              ! ADD
              ICDT(K1)=3
              IDOT(K1)=K1
              IDN1T(K1)=IDOT(K1-1)
              IDN2T(K1)=IDOT(K1-2)
              TC(K1)=TC(IDN1T(K1))+TC(IDN2T(K1))
          END IF
          K1=K1+1
          IF(PCOF(ISA)<1.E-20)PCOF(ISA)=PCO0
          X1=ABS(RSAE(ISA))
          ! RESERVOIR
          IF(X1>0.)THEN
              ICDT(K1)=4
              IDOT(K1)=K1
              IDN1T(K1)=IDOT(K1-1)
              IDN2T(K1)=ISA
              K1=K1+1
          ELSE
              IF(PCOF(ISA)>0.)THEN
                  ! GENERIC PONDS
                  ICDT(K1)=5
                  IDOT(K1)=K1
                  IDN1T(K1)=IDOT(K1-1)
                  IDN2T(K1)=ISA
                  K1=K1+1
                  RVP0(ISA)=50.
                  RVE0(ISA)=55.
                  RSV(ISA)=RVP0(ISA)
                  XX=1000.*Z1*PCOF(ISA)
                  IF(XX<260.)THEN
                      RSAP(ISA)=3.E-5*XX
                  ELSE
                      XX=XX-256.
                      TW=.5*(16.+SQRT(XX))
                      RSAP(ISA)=.0001*TW*TW
                  END IF
                  RSAE(ISA)=1.01*RSAP(ISA)
                  RSYS(ISA)=300.
                  RSYN(ISA)=100.
                  RSHC(ISA)=.00001
                  RSDP(ISA)=5.
                  RSBD(ISA)=.8
                  RSRR(ISA)=20.
              END IF
          END IF
          IF(ISCH==0)THEN
              ! ADD
              WSA(ISA)=Z1
              SUMA=SUMA+SAV(ISV)
              ICDT(K1)=3
              IDOT(K1)=K1
              IDN1T(K1)=IDOT(K1-1)
              IDN2T(K1)=IDOS(ISV)
              TC(K1)=TC(IDN1T(K1))+TC(IDN2T(K1))
              SVX=SAV(ISV)
              K1=K1+1
              ISV=ISV-1
          END IF
          RWSA(ISA)=SUMA-SVX
          X3=RWSA(ISA)
          X1=X3
          IF(RCHN(ISA)<1.E-10)RCHN(ISA)=.05
          IF(RCHL(ISA)<1.E-10)RCHL(ISA)=.001*GRDL(ISA)
          GRDL(ISA)=1.414*GRDL(ISA)
          X3=X3+1.
          IF(RCHS(ISA)<1.E-10)RCHS(ISA)=STP(ISA)*X3**(-.3)
          WCHS=WCHS+RCHS(ISA)*Z1
          RFPS(ISA)=RCHS(ISA)*RCHL(ISA)/RFPL(ISA)
          IF(QG>0.)THEN
              QX=.002778*X1*QG0*(1./RWSA(ISA))**QCF
              X1=BWD+2.
              X1=(QX*RCHN(ISA)/(X1*(X1/(BWD+4.472))**.6667*SQRT(RCHS(ISA))))**&
              .375
              IF(RCBW(ISA)<1.E-10)RCBW(ISA)=BWD*X1
              IF(RCTW(ISA)<1.E-10)RCTW(ISA)=RCBW(ISA)+4.*X1
              IF(RCHD(ISA)<1.E-10)RCHD(ISA)=X1
              IF(RFPW(ISA)<1.E-10)RFPW(ISA)=FCW*RCTW(ISA)
          ELSE
              IF(RCTW(ISA)<1.E-10)RCTW(ISA)=COCH(1)*X3**COCH(2)
              IF(RFPW(ISA)<1.E-10)RFPW(ISA)=10.*RCTW(ISA)
              IF(RCHD(ISA)<1.E-10)RCHD(ISA)=COCH(3)*X3**COCH(4)
              IF(RCBW(ISA)<1.E-10)RCBW(ISA)=MAX(RCTW(ISA)-4.*RCHD(ISA),.1*&
              RCTW(ISA))
          END IF
          IF(RCBW(ISA)>RCTW(ISA))RCBW(ISA)=.75*RCTW(ISA)
          RFPX(ISA)=SQRT(RFPS(ISA))*RFPW(ISA)/UPN
          BFSN(ISA)=X8/UPN
          ZCH=RCHD(ISA)
          CBW=RCBW(ISA)
          RCSS(ISA)=.5*(RCTW(ISA)-CBW)/ZCH
          X3=SQRT(RCSS(ISA)*RCSS(ISA)+1.)
          RCHX(ISA)=SQRT(RCHS(ISA))/RCHN(ISA)
          CHXA(ISA)=ZCH*(CBW+ZCH*RCSS(ISA))
          CHXP(ISA)=CBW+2.*ZCH*X3
          QCAP(ISA)=CHXA(ISA)**1.66667*RCHX(ISA)/CHXP(ISA)**.66667
          WCHS=WCHS/TOT
          IF(IHY==3.AND.IEXT(ISA)==0)THEN
              !XL=.001*SQRT(3.E4*RWSA(ISA))
              !TCX=.0663*XL**.77/RCHS(ISA)**.385
              !QPX=.9*RWSA(ISA)/TCX
              !QPX=13.*SQRT(RWSA(ISA))
              QPX=3591.
              SSS=SQRT(RCSS(ISA)*RCSS(ISA)+1.)
              !XCTW=RCTW(ISA)
              !XFPW=RFPW(ISA)
              CALL HQDAV(AO2,CBW,QPX,SSS,ZCH,ZI2,RCTW(ISA),RFPW(ISA),ISA)
              !DZRT=ZI2/NPRC
              DZRT=.3333333
              CALL RATECVM_CM(CBW,DZRT,SSS,ZCH)
          END IF
          IF(KFL(28)>0.OR.KFL(5)>0)THEN
              IF(BCHL>0..AND.BCHS>0.)THEN
                  WCHL=.3*SQRT(TOT/3.)
                  TCB=.0663*BCHL**.77/BCHS**.385
                  TCW=.0663*WCHL**.77/WCHS**.385
                  DRSW=MIN(.95,(TCW/TCB)**PRMT(37))
                  BS2=LOG10(DRSW)/2.699
                  BS1=1./.1**BS2
              ELSE
                  BS1=0.
                  BS2=1.
                  DRSW=1.
              END IF
          END IF
          WRITE(KW(1),'(T10,A,F8.4)')'DELIVERY RATIO TO SWAT = ',DRSW

          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!IF(ISOL==0)THEN
          !!!    I2=-1
          !!!    DO WHILE(I2/=INPS)
          !!!        READ(KR(13),*,IOSTAT=NFL)I2,SOILFILE
          !!!        IF(NFL/=0)THEN
          !!!           WRITE(*,*)'SOIL NO = ',INPS,' NOT IN SOIL LIST FILE &
          !!!            SAID = ',NBSA(ISA)
          !!!            STOP
          !!!        END IF
          !!!    END DO
          !!!    CALL OPENV(KR(14),SOILFILE,IDIR)
          !!!    REWIND KR(13)
          !!!ELSE
          !!!    WRITE(ASOL,'(I8.8)')NBSA(ISA)
          !!!    SOILFILE=ASOL//".SOT"
          !!!    CALL OPENV(KR(14),SOILFILE,0)
          !!!END IF


          !!!TITSO(ISA)=SOILFILE

          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(14),'()')

          ! LINE 1
          ! SOIL PROPERTIES
          !  1  SALB = SOIL ALBEDO
          !  2  HSG  = HYDROLOGIC SOIL GROUP--1.=A; 2.=B; 3.=C; 4.=D
          !  3  FFC  = FRACTION OF FIELD CAP FOR INITAL WATER STORAGE(BLANK IF
          !            UNKNOWN)
          !  4  WTMN = MIN DEPTH TO WATER TABLE(m)(BLANK IF UNKNOWN)
          !  5  WTMX = MAX DEPTH TO WATER TABLE(m)(BLANK IF UNKNOWN)
          !  6  WTBL = INITIAL WATER TABLE HEIGHT(m)(BLANK IF UNKNOWN)
          !  7  GWST = GROUNDWATER STORAGE (mm)
          !  8  GWMX = MAXIMUM GROUNDWATER STORAGE (mm)
          !  9  RFTT = GROUNDWATER RESIDENCE TIME(d)(BLANK IF UNKNOWN)
          ! 10  RFPK = RETURN FLOW / (RETURN FLOW + DEEP PERCOLATION)
          ! 11  TSLA = MAXIMUM NUMBER OF SOIL LAYERS(3-30)
          ! 12  XIDS = 0. FOR CALCAREOUS SOILS AND NON CALCAREOUS
          !                  WITHOUT WEATHERING INFORMATION
          !          = 1. FOR NON CACO3 SLIGHTLY WEATHERED
          !          = 2. NON CACO3 MODERATELY WEATHERED
          !          = 3. NON CACO3 HIGHLY WEATHERED
          !          = 4. INPUT PSP

            ! 13  RTN1 = NUMBER YEARS OF CULTIVATION AT START OF SIMULATION. BLANK
          !            DEFAULTS TO RTN0.
          ! 14  XIDK = 1 FOR KAOLINITIC SOIL GROUP
          !          = 2 FOR MIXED SOIL GROUP
          !          = 3 FOR SMECTITIC SOIL GROUP
          ! 15  ZQT  = MINIMUM THICKNESS OF MAXIMUM LAYER(m)(SPLITTING
          !            STOPS WHEN ZQT IS REACHED)
          ! 16  ZF   = MINIMUM PROFILE THICKNESS(m)--STOPS SIMULATION.
          ! 17  ZTK  = MINIMUM LAYER THICKNESS FOR BEGINNING SIMULATION LAYER
          !            SPLITTING--MODEL SPLITS FIRST LAYER WITH THICKNESS GREATER
          !            THAN ZTK(m); IF NONE EXIST THE THICKEST LAYER IS SPLIT.
          ! 18  FBM  = FRACTION OF ORG C IN BIOMASS POOL(.03-.05)
          ! 19  FHP  = FRACTION OF HUMUS IN PASSIVE POOL(.3-.7)
          ! 20  XCC  = CODE WRITTEN AUTOMATICALLY BY .SOT (NOT USER INPUT)
          !     LINE 2/3

          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(14),3120)SALB(ISA),HSG,FFC(ISA),WTMN(ISA),WTMX(ISA),WTBL&
          !!!(ISA),GWST(ISA),GWMX(ISA),RFTT(ISA),RFPK(ISA),TSLA(ISA),XIDS(ISA),&
          !!!RTN1,XIDK(ISA),ZQT,ZF,ZTK,FBM(ISA),FHP(ISA),XCC

          SALB(ISA)=p%HI_SALB(1)
          HSG=p%HI_HSG
          FFC(ISA)=p%HI_FFC(1)
          WTMN(ISA)=p%HI_WTMN(1)
          WTMX(ISA)=p%HI_WTMX(1)
          WTBL(ISA)=p%HI_WTBL(1)
          GWST(ISA)=p%HI_GWST(1)
          GWMX(ISA)=p%HI_GWMX(1)
          RFTT(ISA)=p%HI_RFTT(1)
          RFPK(ISA)=p%HI_RFPK(1)
          TSLA(ISA)=p%HI_TSLA(1)
          XIDS(ISA)=p%HI_XIDS(1)
          RTN1=p%HI_RTN1
          XIDK(ISA)=p%HI_XIDK(1)
          ZQT=p%HI_ZQT
          ZF=p%HI_ZF
          ZTK=p%HI_ZTK
          FBM(ISA)=p%HI_FBM(1)
          FHP(ISA)=p%HI_FHP(1)
	
		  HSG = 2 !!! Testing MB 8.16.19

          NCC=XCC
          IF(HSG<1.E-10.OR.HSG>4.)THEN
              WRITE(*,*)'HYDROLOGIC SOIL GROUP NO MISSING SOIL'
              STOP
          END IF
          GWSN(ISA)=0.
          IF(WTMX(ISA)<1.E-10)THEN
              WTMN(ISA)=50.
              WTMX(ISA)=100.
              WTBL(ISA)=75.
          END IF
          IDS(ISA)=XIDS(ISA)+1.1
          !!!IF(RTN1<1.E-5)RTN1=RTN0
          IF(FBM(ISA)<1.E-10)FBM(ISA)=.04
          IF(FHP(ISA)<1.E-10)FHP(ISA)=.7-.3*EXP(-.0277*RTN1)
          IF(GWST(ISA)<1.E-10)GWST(ISA)=.001*GWS0
          IF(GWMX(ISA)<1.E-10)GWMX(ISA)=GWS0
          IF(RFPK(ISA)<1.E-10)RFPK(ISA)=RFP0
          IF(FFC(ISA)<1.E-10)FFC(ISA)=AAP/(AAP+EXP(9.043-.002135*AAP))
          IDSK=MAX(XIDK(ISA),1.)
          MXLA=TSLA(ISA)
          IF(ZQT<1.E-10)ZQT=.1
          IF(ZF<1.E-10)ZF=.1
          IF(ZTK<1.E-10)ZTK=.15
          IF(RFTT(ISA)<1.E-10)RFTT(ISA)=RFT0
          ZNMA(ISA)=0.
          ZFOP(ISA)=0.
          ZLS(ISA)=0.
          ZLM(ISA)=0.
          ZLSL(ISA)=0.
          ZLSC(ISA)=0.
          ZLMC(ISA)=0.
          ZLSLC(ISA)=0.
          ZLSLNC(ISA)=0.
          ZBMC(ISA)=0.
          ZHSC(ISA)=0.
          ZHPC(ISA)=0.
          ZLSN(ISA)=0.
          ZLMN(ISA)=0.
          ZBMN(ISA)=0.
          ZHSN(ISA)=0.
          ZHPN(ISA)=0.
          !     READ SOIL DATA
          !     THE SOIL IS DIVIDED VERTICALLY INTO LAYERS(MAX OF 30 LAYERS
          !     OF USER SPECIFIED THICKNESS).  DATA ARE INPUT 10 LAYERS AT A TIME.
          !     THUS 10 VALUES OF THE FOLLOWING DATA ARE INPUT ON SPECIFIED LINES.
          !     LINES 9/29 CONTAIN DATA FOR LAYERS 1/10
          !  4  Z    = DEPTH TO BOTTOM OF LAYERS(m)
          !  5  BD   = BULK DENSITY(t/m3)
          !  6  UW   = SOIL WATER CONTENT AT WILTING POINT(1500 KPA)(m/m)
          !            (BLANK IF UNKNOWN)
          !  7  FC   = WATER CONTENT AT FIELD CAPACITY(33KPA)(m/m)
          !            (BLANK IF UNKNOWN)
          !  8  SAN  = % SAND
          !  9  SIL  = % SILT
          ! 10  WN   = INITIAL ORGANIC N CONC(g/t)       (BLANK IF UNKNOWN)
          ! 11  PH   = SOIL PH
          ! 12  SMB  = SUM OF BASES(cmol/kg)              (BLANK IF UNKNOWN)
          ! 13  WOC  = ORGANIC CARBON CONC(%)
          ! 14  CAC  = CALCIUM CARBONATE(%)
          ! 15  CEC  = CATION EXCHANGE CAPACITY(cmol/kg)(BLANK IF UNKNOWN)
          ! 16  ROK  = COARSE FRAGMENTS(% VOL)              (BLANK IF UNKNOWN)
          ! 17  CNDS = INITIAL SOL N CONC(g/t)            (BLANK IF UNKNOWN)
          ! 18  SSF  = INITIAL SOL P CONC(g/t)       (BLANK IF UNKNOWN)
          ! 19  RSD  = CROP RESIDUE(t/ha)                (BLANK IF UNKNOWN)
          ! 20  BDD  = BULK DENSITY(OVEN DRY)(t/m3)   (BLANK IF UNKNOWN)
          ! 21  PSP  = P SORPTION RATIO                   (BLANK IF UNKNOWN)
          ! 22  SATC = SATURATED CONDUCTIVITY(mm/h)     (BLANK IF UNKNOWN)
          ! 23  HCL  = LATERAL HYDRAULIC CONDUCTIVITY(mm/h)
          ! 24  WPO  = INITIAL ORGANIC P CONC(g/t)      (BLANK IF UNKNOWN)
          ! 25  DHN  = EXCHANGEABLE K CONC (g/t)
          ! 26  ECND = ELECTRICAL COND (mmho/cm)
          ! 27  STFR = FRACTION OF STORAGE INTERACTING WITH NO3 LEACHING
          !                                               (BLANK IF UNKNOWN)
          ! 28  SWST = INITIAL SOIL WATER STORAGE (m/m)
          ! 29  CPRV = FRACTION INFLOW PARTITIONED TO VERTICLE CRACK OR PIPE FLOW
          ! 30  CPRH = FRACTION INFLOW PARTITIONED TO HORIZONTAL CRACK OR PIPE
          !            FLOW
          ! 31  WLS  = STRUCTURAL LITTER(kg/ha)           (BLANK IF UNKNOWN)
          ! 32  WLM  = METABOLIC LITTER(kg/ha)            (BLANK IF UNKNOWN)
          ! 33  WLSL = LIGNIN CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)
          ! 34  WLSC = CARBON CONTENT OF STRUCTURAL LITTER(kg/ha)(B I U)
          ! 35  WLMC = C CONTENT OF METABOLIC LITTER(kg/ha)(B I U)
          ! 36  WLSLC= C CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(B I U)
          ! 37  WLSLNC=N CONTENT OF LIGNIN OF STRUCTURAL LITTER(kg/ha)(BIU)
          ! 38  WBMC = C CONTENT OF BIOMASS(kg/ha)(BIU)
          ! 39  WHSC = C CONTENT OF SLOW HUMUS(kg/ha)(BIU)
          ! 40  WHPC = C CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)
          ! 41  WLSN = N CONTENT OF STRUCTURAL LITTER(kg/ha)(BIU)
          ! 42  WLMN = N CONTENT OF METABOLIC LITTER(kg/ha)(BIU)
          ! 43  WBMN = N CONTENT OF BIOMASS(kg/ha)(BIU)
          ! 44  WHSN = N CONTENT OF SLOW HUMUS(kg/ha)(BIU)
          ! 45  WHPN = N CONTENT OF PASSIVE HUMUS(kg/ha)(BIU)
          ! 46  FE26 = IRON CONTENT(%)
          ! 47  SULF = SULFUR CONTENT(%)
          ! 48  ASHZ = SOIL HORIZON(A,B,C)
          ! 49  CGO2 = O2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)
          ! 50  CGCO2= CO2 CONC IN GAS PHASE (g/m3 OF SOIL AIR)
          ! 51  CGN2O= N2O CONC IN GAS PHASE (g/m3 OF SOIL AIR)
          !     LINES 4/47

          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(14),3111)(Z(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(BD(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(UW(I),I=1,MSL)
          !!!READ(KR(14),3111)(FC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SAN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SIL(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WON(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(PH(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SMB(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WOC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(CAC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(CEC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(ROK(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(CNDS(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SSF(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(RSD(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(BDD(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(PSP(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SATC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(HCL(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WPO(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(DHN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(ECND(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(STFR(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SWST(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(CPRV(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(CPRH(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLS(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLM(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLSL(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLSC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLMC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLSLC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLSLNC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WBMC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WHSC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WHPC(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLSN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WLMN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WBMN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WHSN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(WHPN(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(FE26(I,ISA),I=1,MSL)
          !!!READ(KR(14),3111)(SULF(I,ISA),I=1,MSL)
          ! LINE 48
          !!!READ(KR(14),'(15A8)')ASHZ
          ! LINES 49/51

          DO I=1,MSL !SOIL LOOP
            Z(I,ISA)  = p%HI_Z(I,ISA);
            BD(I,ISA)= p%HI_BD(I,ISA);
            UW(I)= p%HI_UW(I);
            FC(I,ISA)= p%HI_FC(I,ISA);
            SAN(I,ISA)= p%HI_SAN(I,ISA);
            SIL(I,ISA)= p%HI_SIL(I,ISA);
            WON(I,ISA)= p%HI_WON(I,ISA);
            PH(I,ISA)= p%HI_PH(I,ISA);
            SMB(I,ISA)= p%HI_SMB(I,ISA);
            WOC(I,ISA)= p%HI_WOC(I,ISA);
            CAC(I,ISA)= p%HI_CAC(I,ISA);
            CEC(I,ISA)= p%HI_CEC(I,ISA);
            ROK(I,ISA)= p%HI_ROK(I,ISA);
            CNDS(I,ISA)= p%HI_CNDS(I,ISA);
            SSF(I,ISA)= p%HI_SSF(I,ISA);
            RSD(I,ISA)= p%HI_RSD(I,ISA);
            BDD(I,ISA)= p%HI_BDD(I,ISA);
            PSP(I,ISA)= p%HI_PSP(I,ISA);
            SATC(I,ISA)= p%HI_SATC(I,ISA);
            HCL(I,ISA)= p%HI_HCL(I,ISA);
            WPO(I,ISA)= p%HI_WPO(I,ISA);
            DHN(I,ISA)= p%HI_DHN(I,ISA);
            ECND(I,ISA)= p%HI_ECND(I,ISA);
            STFR(I,ISA)= p%HI_STFR(I,ISA);
            SWST(I,ISA)= p%HI_SWST(I,ISA);
            CPRV(I,ISA)= p%HI_CPRV(I,ISA);
            CPRH(I,ISA)= p%HI_CPRH(I,ISA);
            WLS(I,ISA)= p%HI_WLS(I,ISA);
            WLM(I,ISA)= p%HI_WLM(I,ISA);
            WLSL(I,ISA)= p%HI_WLSL(I,ISA);
            WLSC(I,ISA)= p%HI_WLSC(I,ISA);
            WLMC(I,ISA)= p%HI_WLMC(I,ISA);
            WLSLC(I,ISA)= p%HI_WLSLC(I,ISA);
            WLSLNC(I,ISA)= p%HI_WLSLNC(I,ISA);
            WBMC(I,ISA)= p%HI_WBMC(I,ISA);
            WHSC(I,ISA)= p%HI_WHSC(I,ISA);
            WHPC(I,ISA)= p%HI_WHPC(I,ISA);
            WLSN(I,ISA)= p%HI_WLSN(I,ISA);
            WLMN(I,ISA)= p%HI_WLMN(I,ISA);
            WBMN(I,ISA)= p%HI_WBMN(I,ISA);
            WHSN(I,ISA)= p%HI_WHSN(I,ISA);
            WHPN(I,ISA)= p%HI_WHPN(I,ISA);
            FE26(I,ISA)= p%HI_FE26(I,ISA);
            SULF(I,ISA)= p%HI_SULF(I,ISA);

          END DO !END SOIL LOOP

          IF(IDNT>2)THEN
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!    READ(KR(14),3111)(CGO2(I,ISA),I=1,MSL)
          !!!    READ(KR(14),3111)(CGCO2(I,ISA),I=1,MSL)
          !!!    READ(KR(14),3111)(CGN2O(I,ISA),I=1,MSL)
          ELSE
              CGO2=0.
              CGCO2=0.
              CGN2O=0.
          END IF
          L=1
          LZ=0
          XX=0.
          XCB=.2
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!CLOSE(KR(14))
          DO I=1,MSL !SOIL LOOP
              IF(Z(I,ISA)<1.E-10)EXIT
              IF(SAN(I,ISA)<1.E-5)THEN
                  WRITE(KW(36),*)'SUBAREA ',ISA,' SOIL LAYER ',I,' SAN=0.0'
                  IF(I==1)THEN
                      SAN(I,ISA)=.33
                  ELSE
                      SAN(I,ISA)=SAN(I-1,ISA)
                  END IF
              END IF
              IF(SIL(I,ISA)<1.E-5)THEN
                  WRITE(KW(36),*)'SUBAREA ',ISA,' SOIL LAYER ',I,' SIL=0.0'
                  IF(I==1)THEN
                      SIL(I,ISA)=.33
                  ELSE
                      SIL(I,ISA)=SIL(I-1,ISA)
                  END IF
              END IF
              CLA(I,ISA)=100.-SAN(I,ISA)-SIL(I,ISA)
              IF(BD(I,ISA)<1.E-5)THEN
                  WRITE(KW(36),*)'SUBAREA ',ISA,' SOIL LAYER ',I,' BD=0.0'
                  BD(I,ISA)=1.25+.005*SAN(I,ISA)
              END IF
              X1=BD(I,ISA)
              DG=1000.*(Z(I,ISA)-XX)
              CALL SBDSC(BD(I,ISA),PRMT(2),F,I,1)
              CALL SDST(RSD,DG,DG1,.01,.01,I,ISA,MSL)
              CALL SDST(SSF,DG,DG,20.,.001,I,ISA,MSL)
              CALL SDST(CNDS,DG,DG,10.,.001,I,ISA,MSL)
              CALL SDST(DHN,DG,DG,100.,.001,I,ISA,MSL)
              TRSD(ISA)=TRSD(ISA)+RSD(I,ISA)
              ZD=.25*(XX+Z(I,ISA))
              F=ZD/(ZD+EXP(-.8669-2.0775*ZD))
              STMP(I,ISA)=F*(AVT-TX)+TX
              IF(WOC(I,ISA)<=0.)WOC(I,ISA)=XCB*EXP(-.001*DG)
              XCB=WOC(I,ISA)
              XZ=WOC(I,ISA)*.0172
              ZZ=1.-XZ
              WT(I,ISA)=BD(I,ISA)*DG*10.
              DG1=DG
              WT1=WT(I,ISA)/1000.
              X1=10.*WOC(I,ISA)*WT(I,ISA)
              WOC(I,ISA)=X1
              IF(WON(I,ISA)>0.)THEN
                  WON(I,ISA)=WT1*WON(I,ISA)
                  KK=0
              ELSE
                  WON(I,ISA)=.1*WOC(I,ISA)
                  KK=1
              END IF
              IF(NCC==0)THEN
                  WBM=FBM(ISA)*X1
                  WBMC(I,ISA)=WBM
                  IF(KK>0)THEN
                      RTO=.1
                  ELSE
                      RTO=WON(I,ISA)/WOC(I,ISA)
                  END IF
                  WBMN(I,ISA)=RTO*WBMC(I,ISA)
                  WHP=FHP(ISA)*(X1-WBM)
                  WHS=X1-WBM-WHP
                  WHSC(I,ISA)=WHS
                  WHSN(I,ISA)=RTO*WHSC(I,ISA)
                  WHPC(I,ISA)=WHP
                  WHPN(I,ISA)=RTO*WHPC(I,ISA)
                  X1=RSD(I,ISA)
                  IF(I==1)X1=X1+STDO(ISA)
                  WLM(I,ISA)=500.*X1
                  WLS(I,ISA)=WLM(I,ISA)
                  WLSL(I,ISA)=.8*WLS(I,ISA)
                  WLMC(I,ISA)=.42*WLM(I,ISA)
                  WLMN(I,ISA)=.1*WLMC(I,ISA)
                  WLSC(I,ISA)=.42*WLS(I,ISA)
                  WLSLC(I,ISA)=.8*WLSC(I,ISA)
                  WLSLNC(I,ISA)=.2*WLSC(I,ISA)
                  WLSN(I,ISA)=WLSC(I,ISA)/150.
                  WOC(I,ISA)=WOC(I,ISA)+WLSC(I,ISA)+WLMC(I,ISA)
                  WON(I,ISA)=WON(I,ISA)+WLSN(I,ISA)+WLMN(I,ISA)
              END IF
              FOP(I,ISA)=RSD(I,ISA)*1.1
              WPMA(I,ISA)=0.
              IF(WPO(I,ISA)>0.)THEN
                  WPO(I,ISA)=WT1*WPO(I,ISA)
              ELSE
                  WPO(I,ISA)=.125*WON(I,ISA)
              END IF
              PO(I,ISA)=1.-BD(I,ISA)/2.65
              X2=.1*WOC(I,ISA)/WT(I,ISA)
              SELECT CASE(ISW+1)
              CASE(1,3)
                  CALL SWRTNR(CLA(I,ISA),SAN(I,ISA),X2,UW(I),FC(I,ISA))
              CASE(2,4)
                  IF(UW(I)<1.E-10.OR.FC(I,ISA)<1.E-10)CALL SWRTNNW(CLA(I,ISA),&
                  SAN(I,ISA),X2,BD(I,ISA),UW(I),FC(I,ISA))
              CASE(5,6)
                  CALL SWNN(CLA(I,ISA),SAN(I,ISA),X2,UW(I),FC(I,ISA))
              CASE(7,8)
                  CALL SWRTNNW(CLA(I,ISA),SAN(I,ISA),X2,BD(I,ISA),UW(I),FC(I,ISA))
              CASE DEFAULT
                  CALL SWRTNNW(CLA(I,ISA),SAN(I,ISA),X2,BD(I,ISA),UW(I),FC(I,ISA))
                  ISW=6
              END SELECT
              IF(ROK(I,ISA)>99.)ROK(I,ISA)=90.
              XY=1.-ROK(I,ISA)*.01
              UW(I)=UW(I)*XY
              XY=XY*DG
              FC(I,ISA)=FC(I,ISA)*XY
              S15(I,ISA)=UW(I)*DG
              PO(I,ISA)=PO(I,ISA)*XY
              CALL SPOFC(I)
              IF(NCC==0)THEN
                  IF(SWST(I,ISA)<1.E-10)SWST(I,ISA)=FFC(ISA)
                  SWST(I,ISA)=SWST(I,ISA)*(FC(I,ISA)-S15(I,ISA))+S15(I,ISA)
              END IF
              SEV(1,ISA)=SEV(1,ISA)+XY
              SEV(3,ISA)=SEV(3,ISA)+WT(I,ISA)
              XX=Z(I,ISA)
              IF(HCL(I,ISA)<1.E-10)HCL(I,ISA)=STP(ISA)*SATC(I,ISA)
              IF(CEC(I,ISA)>0.)THEN
                  IF(CAC(I,ISA)>0.)SMB(I,ISA)=CEC(I,ISA)
                  IF(SMB(I,ISA)>CEC(I,ISA))SMB(I,ISA)=CEC(I,ISA)
                  BSA=SMB(I,ISA)*100./(CEC(I,ISA)+1.E-20)
                  IF(PH(I,ISA)>5.6)THEN
                      ALS(I,ISA)=0.
                  ELSE
                      X1=.1*WOC(I,ISA)/WT(I,ISA)
                      ALS(I,ISA)=154.2-1.017*BSA-3.173*X1-14.23*PH(I,ISA)
                      IF(ALS(I,ISA)<0.)THEN
                          ALS(I,ISA)=0.
                      ELSE
                          IF(ALS(I,ISA)>95.)ALS(I,ISA)=95.
                      END IF
                  END IF
              ELSE
                  CEC(I,ISA)=PH(I,ISA)
                  SMB(I,ISA)=CEC(I,ISA)
                  ALS(I,ISA)=0.
              END IF
              SELECT CASE(IDS(ISA))
              CASE(1)
                  IF(CAC(I,ISA)>0.)THEN
                      PSP(I,ISA)=.58-.0061*CAC(I,ISA)
                      BPT(I,ISA)=7.6E-4
                  ELSE
                      PSP(I,ISA)=.5
                      BPT(I,ISA)=EXP(-1.77*PSP(I,ISA)-7.05)
                  END IF
              CASE(2)
                  PSP(I,ISA)=.02+.0104*SSF(I,ISA)
                  BPT(I,ISA)=EXP(-1.77*PSP(I,ISA)-7.05)
              CASE(3)
                  PSP(I,ISA)=.0054*BSA+.116*PH(I,ISA)-.73
                  BPT(I,ISA)=EXP(-1.77*PSP(I,ISA)-7.05)
              CASE(4)
                  PSP(I,ISA)=.46-.0916*LOG(CLA(I,ISA))
                  BPT(I,ISA)=EXP(-1.77*PSP(I,ISA)-7.05)
              CASE(5)
                  IF(CAC(I,ISA)>0.)THEN
                      BPT(I,ISA)=7.6E-4
                  ELSE
                      BPT(I,ISA)=EXP(-1.77*PSP(I,ISA)-7.05)
                  END IF
              END SELECT
              IF(PSP(I,ISA)<.05)PSP(I,ISA)=.05
              IF(PSP(I,ISA)>.75)PSP(I,ISA)=.75
              BPT(I,ISA)=EXP(-1.77*PSP(I,ISA)-7.05)
              SELECT CASE(IDSK)
              CASE(1)
                  SOLK(I,ISA)=MAX(.05*DHN(I,ISA),.052*DHN(I,ISA)-.12)
                  FIXK(I,ISA)=374.+236.*CLA(I,ISA)
              CASE(2)
                  SOLK(I,ISA)=.026*DHN(I,ISA)+.5
                  FIXK(I,ISA)=1781.+316.*CLA(I,ISA)
              CASE(3)
                  SOLK(I,ISA)=.026*DHN(I,ISA)+.5
                  FIXK(I,ISA)=1781.+316.*CLA(I,ISA)
              END SELECT
              EQKS(I,ISA)=SOLK(I,ISA)/DHN(I,ISA)
              EQKE(I,ISA)=DHN(I,ISA)/FIXK(I,ISA)
              EXCK(I,ISA)=DHN(I,ISA)*WT1
              SOLK(I,ISA)=SOLK(I,ISA)*WT1
              FIXK(I,ISA)=FIXK(I,ISA)*WT1
              ZSK(ISA)=ZSK(ISA)+SOLK(I,ISA)
              ZEK(ISA)=ZEK(ISA)+EXCK(I,ISA)
              ZFK(ISA)=ZFK(ISA)+FIXK(I,ISA)
              WPMA(I,ISA)=SSF(I,ISA)*(1.-PSP(I,ISA))/PSP(I,ISA)
              WPMS(I,ISA)=4.*WPMA(I,ISA)
              WSLT(I,ISA)=6.4*ECND(I,ISA)*SWST(I,ISA)
              ZSLT(ISA)=ZSLT(ISA)+WSLT(I,ISA)
              WPMA(I,ISA)=WPMA(I,ISA)*WT1
              WPMS(I,ISA)=WPMS(I,ISA)*WT1
              WPML(I,ISA)=SSF(I,ISA)*WT1
              ZPML(ISA)=ZPML(ISA)+WPML(I,ISA)
              ZPMA(ISA)=ZPMA(ISA)+WPMA(I,ISA)
              ZFOP(ISA)=ZFOP(ISA)+FOP(I,ISA)
              ZPMU(ISA)=ZPMU(ISA)+WPMU(I,ISA)
              ZPOU(ISA)=ZPOU(ISA)+WPOU(I,ISA)
              ZLSC(ISA)=ZLSC(ISA)+WLSC(I,ISA)
              ZLMC(ISA)=ZLMC(ISA)+WLMC(I,ISA)
              ZLSLC(ISA)=ZLSLC(ISA)+WLSLC(I,ISA)
              ZLSLNC(ISA)=ZLSLNC(ISA)+WLSLNC(I,ISA)
              ZBMC(ISA)=ZBMC(ISA)+WBMC(I,ISA)
              ZHSC(ISA)=ZHSC(ISA)+WHSC(I,ISA)
              ZHPC(ISA)=ZHPC(ISA)+WHPC(I,ISA)
              ZLSN(ISA)=ZLSN(ISA)+WLSN(I,ISA)
              ZLMN(ISA)=ZLMN(ISA)+WLMN(I,ISA)
              ZBMN(ISA)=ZBMN(ISA)+WBMN(I,ISA)
              ZHSN(ISA)=ZHSN(ISA)+WHSN(I,ISA)
              ZHPN(ISA)=ZHPN(ISA)+WHPN(I,ISA)
              IF(Z(I,ISA)<=PMX(ISA))THEN
                  SUM=SUM+WT(I,ISA)
                  PDPL(ISA)=PDPL(ISA)+WPML(I,ISA)+WPMU(I,ISA)
                  OCPD(ISA)=OCPD(ISA)+WOC(I,ISA)
                  PDSKC(ISA)=PDSKC(ISA)+SOLK(I,ISA)
                  PDSW(ISA)=PDSW(ISA)+SWST(I,ISA)-S15(I,ISA)
                  PDAW(ISA)=PDAW(ISA)+FC(I,ISA)-S15(I,ISA)
                  L=I
              END IF
              WNO3(I,ISA)=CNDS(I,ISA)*WT1
              ZNMN(ISA)=ZNMN(ISA)+WNO3(I,ISA)
              IF(Z(I,ISA)<=RZ(ISA))THEN
                  RZSW(ISA)=RZSW(ISA)+SWST(I,ISA)-S15(I,ISA)
                  PAW(ISA)=PAW(ISA)+FC(I,ISA)-S15(I,ISA)
                  LZ=I
              END IF
              IF(BDD(I,ISA)<1.E-10)BDD(I,ISA)=BD(I,ISA)
              BDP(I,ISA)=BD(I,ISA)
              BDD(I,ISA)=BDD(I,ISA)/BD(I,ISA)
              ZPMS(ISA)=ZPMS(ISA)+WPMS(I,ISA)
              ZPO(ISA)=ZPO(ISA)+WPO(I,ISA)
          END DO  !END SOIL LOOP
          IF(I>MSL)THEN
              NBSL(ISA)=MSL
          ELSE
              L1=LZ+1
              NBSL(ISA)=I-1
              IF(L1/=I)THEN
                  ZZ=RZ(ISA)-Z(LZ,ISA)
                  RTO=ZZ/(Z(L1,ISA)-Z(LZ,ISA))
                  RZSW(ISA)=RZSW(ISA)+(SWST(L1,ISA)-S15(L1,ISA))*RTO
                  PAW(ISA)=PAW(ISA)+RTO*(FC(L1,ISA)-S15(L1,ISA))
              END IF
          END IF
          LRD(ISA)=NBSL(ISA)
          IF(MXLA<NBSL(ISA))MXLA=NBSL(ISA)
          IF(Z(1,ISA)>.01)THEN
              NBSL(ISA)=NBSL(ISA)+1
              DO I=NBSL(ISA),2,-1
                  LID(I,ISA)=LID(I-1,ISA)
              END DO
              LID(1,ISA)=NBSL(ISA)
              LORG(NBSL(ISA),ISA)=1
              RTO=.01/Z(1,ISA)
              CALL SPLA(1,1,NBSL(ISA),RTO,1)
              Z(NBSL(ISA),ISA)=.01
          ELSE
              IF(Z(1,ISA)<.01)Z(1,ISA)=.01
          END IF
          IF(L/=NBSL(ISA))THEN
              L1=LID(L+1,ISA)
              X1=0.
              IF(L>0)X1=Z(LID(L,ISA),ISA)
              RTO=(PMX(ISA)-X1)/(Z(L1,ISA)-X1)
              SUM=SUM+WT(L1,ISA)*RTO
              OCPD(ISA)=OCPD(ISA)+RTO*WOC(L1,ISA)
              PDPLX(ISA)=PDPL(ISA)+(WPML(L1,ISA)+WPMU(L1,ISA))*RTO
              PDPL(ISA)=1000.*PDPLX(ISA)/SUM
              PDPL0(ISA)=PDPL(ISA)
              PDPLC(ISA)=PDPL(ISA)
              PDSKC(ISA)=PDSKC(ISA)+RTO*SOLK(L1,ISA)
              PDSKC(ISA)=1000.*PDSKC(ISA)/SUM
              PDSW(ISA)=PDSW(ISA)+RTO*(SWST(L1,ISA)-S15(L1,ISA))
              PDAW(ISA)=PDAW(ISA)+RTO*(FC(L1,ISA)-S15(L1,ISA))
          ELSE
              PMX(ISA)=Z(NBSL(ISA),ISA)
          END IF
          OCPD(ISA)=.1*OCPD(ISA)/SUM
          SUM=1.E-4*SUM/PMX(ISA)
          ABD(ISA)=1.E-4*SEV(3,ISA)/XX
          DO WHILE(NBSL(ISA)<MXLA)
              L1=LID(1,ISA)
              ZMX=0.
              MXZ=2
              DO I=2,NBSL(ISA)
                  ISL=LID(I,ISA)
                  ZZ=Z(ISL,ISA)-Z(L1,ISA)
                  IF(ZZ>=ZTK)THEN
                      MXZ=I
                      EXIT
                  END IF
                  IF(ZZ>ZMX+.01)THEN
                      ZMX=ZZ
                      MXZ=I
                  END IF
                  L1=ISL
              END DO
              IF(I>NBSL(ISA))THEN
                  ISL=LID(MXZ,ISA)
                  L1=LID(MXZ-1,ISA)
              END IF
              NBSL(ISA)=NBSL(ISA)+1
              CALL SPLA(ISL,L1,NBSL(ISA),.5,0)
              DO K=NBSL(ISA),MXZ+1,-1
                  LID(K,ISA)=LID(K-1,ISA)
              END DO
              LID(MXZ,ISA)=NBSL(ISA)
              LORG(NBSL(ISA),ISA)=LORG(ISL,ISA)
          END DO
          DO J=1,NBSL(ISA)
              L=LID(J,ISA)
              XGO2(L)=CGO2(L,ISA)
              XGCO2(L)=CGCO2(L,ISA)
              XGN2O(L)=CGN2O(L,ISA)
              IF(NCC>0)THEN
                  WOC(L,ISA)=WLSC(L,ISA)+WLMC(L,ISA)+WBMC(L,ISA)+WHSC(L,ISA)+WHPC(L,ISA)
                  WON(L,ISA)=WLSN(L,ISA)+WLMN(L,ISA)+WBMN(L,ISA)+WHSN(L,ISA)+WHPN(L,ISA)
              ELSE
                  WLSC(L,ISA)=.42*WLS(L,ISA)
                  WLMC(L,ISA)=.42*WLM(L,ISA)
                  WLSLC(L,ISA)=.42*WLSL(L,ISA)
                  WLSLNC(L,ISA)=WLSC(L,ISA)-WLSLC(L,ISA)
              END IF
              SOL(1,L,ISA)=WHSC(L,ISA)
              SOL(2,L,ISA)=WHPC(L,ISA)
              SOL(3,L,ISA)=WLSC(L,ISA)
              SOL(4,L,ISA)=WLMC(L,ISA)
              SOL(5,L,ISA)=WBMC(L,ISA)
              SOL(6,L,ISA)=WOC(L,ISA)
              SOL(7,L,ISA)=WHSN(L,ISA)
              SOL(8,L,ISA)=WHPN(L,ISA)
              SOL(9,L,ISA)=WLSN(L,ISA)
              SOL(10,L,ISA)=WLMN(L,ISA)
              SOL(11,L,ISA)=WBMN(L,ISA)
              SOL(12,L,ISA)=WON(L,ISA)
              SOL(13,L,ISA)=WPMA(L,ISA)
              SOL(14,L,ISA)=WPMS(L,ISA)
              SOL(15,L,ISA)=WPO(L,ISA)
              SOL(16,L,ISA)=EXCK(L,ISA)
              SOL(17,L,ISA)=FIXK(L,ISA)
              SOL(18,L,ISA)=SWST(L,ISA)
              SOL(19,L,ISA)=WLS(L,ISA)
              SOL(20,L,ISA)=WLM(L,ISA)
              SOL(21,L,ISA)=WLSL(L,ISA)
              SOL(22,L,ISA)=WLSLC(L,ISA)
              SOL(23,L,ISA)=WLSLNC(L,ISA)
              XZP(1,L,ISA)=WHSC(L,ISA)
              XZP(2,L,ISA)=WHPC(L,ISA)
              XZP(3,L,ISA)=WLSC(L,ISA)
              XZP(4,L,ISA)=WLMC(L,ISA)
              XZP(5,L,ISA)=WBMC(L,ISA)
              XZP(6,L,ISA)=WOC(L,ISA)
              XZP(7,L,ISA)=WHSN(L,ISA)
              XZP(8,L,ISA)=WHPN(L,ISA)
              XZP(9,L,ISA)=WLSN(L,ISA)
              XZP(10,L,ISA)=WLMN(L,ISA)
              XZP(11,L,ISA)=WBMN(L,ISA)
              XZP(12,L,ISA)=WON(L,ISA)
              XZP(13,L,ISA)=WOC(L,ISA)/WON(L,ISA)
          END DO
          ZON(ISA)=ZLSN(ISA)+ZLMN(ISA)+ZBMN(ISA)+ZHSN(ISA)+ZHPN(ISA)
          ZOC(ISA)=ZLSC(ISA)+ZLMC(ISA)+ZBMC(ISA)+ZHSC(ISA)+ZHPC(ISA)
          BTC(ISA)=ZOC(ISA)
          BTCX(ISA)=BTC(ISA)
          BTCZ(ISA)=BTC(ISA)
          SLT0(ISA)=ZSLT(ISA)
          SLTX(ISA)=ZSLT(ISA)
          XZP(1,11,ISA)=ZHSC(ISA)
          XZP(2,11,ISA)=ZHPC(ISA)
          XZP(3,11,ISA)=ZLSC(ISA)
          XZP(4,11,ISA)=ZLMC(ISA)
          XZP(5,11,ISA)=ZBMC(ISA)
          XZP(6,11,ISA)=ZOC(ISA)
          XZP(7,11,ISA)=ZHSN(ISA)
          XZP(8,11,ISA)=ZHPN(ISA)
          XZP(9,11,ISA)=ZLSN(ISA)
          XZP(10,11,ISA)=ZLMN(ISA)
          XZP(11,11,ISA)=ZBMN(ISA)
          XZP(12,11,ISA)=ZON(ISA)
          XZP(13,11,ISA)=ZOC(ISA)/ZON(ISA)
          IF(IDNT>2)THEN
              NBCL=Z(LID(NBSL(ISA),ISA),ISA)/DZDN+.999
              IF(NBCL>30)THEN
                  NBCL=30
                  DZDN=Z(LID(NBSL(ISA),ISA),ISA)/30.
              ELSE
                  IF(NBCL<NBSL(ISA))THEN
                      NBCL=NBSL(ISA)
                      X1=NBCL
                      DZDN=Z(LID(NBSL(ISA),ISA),ISA)/X1
                  END IF
              END IF
              DZ10=10.*DZDN
              TOT=0.
              DO I=1,NBCL
                  TOT=TOT+DZDN
                  ZC(I,ISA)=TOT
              END DO
              CALL AINTRIC(XGO2,CGO2,NBSL(ISA),NBCL)
              CALL AINTRIC(XGCO2,CGCO2,NBSL(ISA),NBCL)
              CALL AINTRIC(XGN2O,CGN2O,NBSL(ISA),NBCL)
              IUN=NBCL-1
          END IF
          IF(LBP>0)THEN
              X1=CLA(LID(2,ISA),ISA)
              CPMX(ISA)=1000.*X1/(X1+EXP(3.519-.027*X1))
          END IF
          CALL SPRNT
          IF(KFL(1)>0)THEN
              WRITE(KW(1),2950)
              WRITE(KW(1),2960)FL,FW,ANG0,UXP,ACW
              WRITE(KW(1),'(/T10,A,F8.0,A)')'ANNUAL HEAT UNITS = ',AHSM,' C'
              CALL APAGE(1)
              WRITE(KW(1),'(//1X,A/)')'____________________SOIL DATA____________&
              ________'
              WRITE(KW(1),3000)SALB(ISA),MXLA,ZQT,ZF,ZTK,FBM(ISA),FHP(ISA),XIDS&
              (ISA),OCPD(ISA),RTN1
              WRITE(KW(1),3001)IWTB,WTMN(ISA),WTMX(ISA),WTBL(ISA)
              WRITE(KW(1),1301)GWST(ISA),GWMX(ISA),RFTT(ISA),RFPK(ISA)
              I1=ISW+1
              SELECT CASE(I1)
              CASE(1)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT EST RAWLS &
                  METHOD DYNAMIC'
              CASE(2)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT INP RAWLS &
                  METHOD DYNAMIC'
              CASE(3)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT EST RAWLS &
                  METHOD STATIC'
              CASE(4)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT INP STATIC '
              CASE(5)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT EST NEAREST &
                  NEIGHBOR METHOD DYNAMIC'
              CASE(6)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT EST NEAREST &
                  NEIGHBOR METHOD STATIC'
              CASE(7)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT EST BNW &
                  METHOD DYNAMIC'
              CASE(8)
                  WRITE(KW(1),'(T10,A)')'FIELD CAP/WILTING PT EST BNW &
                  METHOD STATIC'
              END SELECT
          END IF
          RFTT(ISA)=1.-EXP(-1./RFTT(ISA))
          IF(ISTA>0)WRITE(KW(1),'(T10,A)')'STATIC SOIL PROFILE'
          !!!IF(SAT1>0.)THEN
          !!!    SATZ=SAT1
          !!!ELSE
          !!!    IF(SAT0>0.)THEN
          !!!        SATZ=SAT0
          !!!    ELSE
          !!!        SATZ=1.
          !!!    END IF
          !!!END IF
          SATK(ISA)=SATC(LID(2,ISA),ISA)*SATZ

          IF(FPS1>0.)THEN
              FPSZ=FPS1
          ELSE
              IF(FPS0>0.)THEN
                  FPSZ=FPS0
              ELSE
                  FPSZ=1.
              END IF
          END IF

          FPSC(ISA)=SATC(LID(2,ISA),ISA)*FPSZ
          SW(ISA)=UW(2)*XX*1000.
          SWB(ISA)=SW(ISA)+SNO(ISA)
          ZCOB(ISA)=ZCO(ISA)

          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!I2=-1
          !!!DO WHILE(I2/=IOPS)
          !!!    READ(KR(15),*,IOSTAT=NFL)I2,OPSCFILE
          !!!    IF(NFL/=0)THEN
          !!!        WRITE(*,*)'OPS NO = ',IOPS,' NOT IN OPSC LIST FILE &
          !!!        SAID = ',NBSA(ISA)
          !!!        STOP
          !!!    END IF
          !!!END DO
          !!!REWIND KR(15)

          !!!MODIF HISAFE 2 = MODIFY READING FILE PATH
          filename = foldername//'/'//OPSCFILE
           write(*,*) 'OPSCFILE=',filename
          CALL OPENV(KR(16),filename,0)

          TITOP(ISA)=OPSCFILE
          ! LINE 1
          READ(KR(16),'()')
          ! 1 LUN  = LAND USE NUMBER FROM NRCS LAND USE-HYDROLOGIC SOIL GROUP
          !          TABLE
          ! 2 AUTO APPLICATION EQUIPMENT FROM TILLCOM.DAT
          ! 3 IAUI = AUTO IRRIGATION
          ! 4 IAUF = AUTO N FERT
          ! 5 IAMF = AUTO MANURE FROM GRAZING ANIMALS
          ! 6 ISPF = AUTO MANURE APPLICATION FROM FEEDYARD STOCKPILE
          ! 7 ILQF = AUTO LIQUID MANURE APPLICATION FROM LAGOONS
          ! 8 IAUL = AUTO LIME APPLICATION
          !     LINE 2
          READ(KR(16),3100)LUN(ISA),IAUI(ISA),IAUF(ISA),IAMF(ISA),ISPF(ISA),&
          ILQF(ISA),IAUL(ISA)
          IF(IAUI(ISA)==0)IAUI(ISA)=500
          IF(IAUF(ISA)==0)IAUF(ISA)=261
          IF(IAMF(ISA)==0)IAMF(ISA)=268
          IF(ISPF(ISA)==0)ISPF(ISA)=266
          IF(ILQF(ISA)==0)ILQF(ISA)=265
          IF(IAUL(ISA)==0)IAUL(ISA)=267
          IF(LUNS(ISA)/=0)THEN
              I1=LUNS(ISA)
              LUNS(ISA)=LUNS(ISA)-LUN(ISA)
              LUN(ISA)=I1
          END IF
          !     READ MANAGEMENT INFORMATION
          !  1  IRR  = N0 FOR DRYLAND AREAS          | N = 0 APPLIES MINIMUM OF
          !          = N1 FROM SPRINKLER IRRIGATION  | VOLUME INPUT, ARMX, & FC-SW
          !          = N2 FOR FURROW IRRIGATION      | N = 1 APPLIES INPUT VOLUME
          !          = N3 FOR IRR WITH FERT ADDED    | OR ARMX
          !          = N4 FOR IRRIGATION FROM LAGOON |
          !          = N5 FOR DRIP IRR               |
          !  2  IRI  = N DAY APPLICATION INTERVAL FOR AUTOMATIC IRRIGATION
          !  3  IFA  = MIN FERT APPL INTERVAL(BLANK FOR USER SPECIFIED)
          !  4  LM   = 0 APPLIES LIME
          !          = 1 DOES NOT APPLY LIME
          !  5  IFD  = 0 WITHOUT FURROW DIKES
          !            1 WITH FURROW DIKES
          !  6  IDR  = 0 NO DRAINAGE
          !          = DEPTH OF DRAINAGE SYSTEM(mm)
          !     IDF0 = FERT #
          !  7         1 FOR FERTIGATION FROM LAGOON
          !  8         2 FOR AUTOMATIC SOLID MANURE APPL FROM FEEDING AREA STOCK
          !              PILE.
          !  9         3 AUTO COMERCIAL P FERT APPL (DEFAULTS TO ELEM P)
          !  10        4 FOR AUTOMATIC COMERCIAL FERT APPL(DEFALTS TO ELEM N)
          !  11        5 FOR AUTOMATIC SOLID MANURE APPLICATION.
          !  12        6 AUTO COMERCIAL K FERT APPL (DEFAULTS TO ELEM K)
          !  13 IRRS = ID OF SA SUPPLYING IRRIGATION WATER FROM A RESERVOIR
          !            0 NO RESERVOIR SUPPLY OR NO IRRIGATION
          !     LINE 8
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)IRR(ISA),IRI(ISA),IFA(ISA),LM(ISA),IFD(ISA),IDR&
          !!!(ISA),(IDF0(I,ISA),I=1,6),IRRS(ISA)
          IF(IDR(ISA)>0.AND.HSG>2)HSG=2
          ISG(ISA)=HSG
          CALL HSGCN
          CALL HCNSLP(CN2(ISA),X3)
          SCI(ISA)=MAX(3.,SMX(ISA)*(1.-RZSW(ISA)/PAW(ISA)))
          IF(KFL(1)>0)THEN
              SELECT CASE(NVCN(ISA)+1)
              CASE(1)
                  WRITE(KW(1),'(T10,A)')'VARIABLE CN NONLINEAR DEPTH/SW &
                  WEIGHTING'
              CASE(2)
                  WRITE(KW(1),'(T10,A)')'VARIABLE CN NONLINEAR NO DEPTH/SW &
                  WEIGHTING'
              CASE(3)
                  WRITE(KW(1),'(T10,A)')'VARIABLE CN LINEAR NO DEPTH/SW &
                  WEIGHTING'
              CASE(4)
                  WRITE(KW(1),'(T10,A)')'CONSTANT CN'
              CASE(5)
                  WRITE(KW(1),'(T10,A)')'VARIABLE CN SOIL MOIST INDEX NO &
                  DEPTH/SW WEIGHTING'
              END SELECT
              WRITE(KW(1),3970)ASG(ISG(ISA)),LUN(ISA),CN2(ISA),X3,&
              SCNX(ISA),SCRP(30,1),SCRP(30,2),CNSC(1,ISA),CNSC(2,ISA)
          END IF
          CN2(ISA)=X3
          CN0(ISA)=X3
          IF(KFL(1)>0)THEN
              CALL APAGE(1)
              WRITE(KW(1),'(//1X,A/)')'____________________SOIL PHYSICAL DATA___&
              _________________'
              CALL SOLIOP
              CALL APAGE(1)
              WRITE(KW(1),'(//1X,A/)')'____________________SOIL CHEMICAL DATA___&
              _________________'
              CALL SOLIOC
          END IF
          !  1  BIR  = IRRIGATION TRIGGER--3 OPTIONS
          !            1. PLANT WATER STRESS FACTOR (0-1)
          !            2. SOIL WATER TENSION IN TOP 200 MM(> 1 KPA)
          !            3. PLANT AVAILABLE WATER DEFICIT IN ROOT ZONE (-mm)
          !  2  EFI  = RUNOFF VOL / VOL IRR WATER APPLIED(BLANK IF IRR=0)
          !  3  VIMX = MAXIMUM ANNUAL IRRIGATION VOLUME ALLOWED FOR EACH CROP (mm)
          !  4  ARMN = MINIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)
          !  5  ARMX = MAXIMUM SINGLE APPLICATION VOLUME ALLOWED (mm)
          !  6  BFT  = AUTO FERTILIZER TRIGGER--2 OPTIONS
          !            1. PLANT N STRESS FACTOR (0-1)
          !            2. SOIL N CONC IN ROOT ZONE (g/t)
          !  7  FNP4 = AUTO FERT FIXED APPLICATION RATE (kg/ha)
          !  8  FMX  = MAXIMUM ANNUAL N FERTILIZER APPLICATION FOR A CROP (kg/ha)
          !  9  DRT  = TIME REQUIRED FOR DRAINAGE SYSTEM TO REDUCE PLANT STRESS(d)
          !            (BLANK IF DRAINAGE NOT USED)
          ! 10  FDSF = FURROW DIKE SAFETY FACTOR(0-1.)
          ! 11  PEC  = CONSERVATION PRACTICE FACTOR(=0.0 ELIMINATES WATER EROSION)
          ! 12  DALG = FRACTION OF SUBAREA CONTROLLED BY LAGOON.
          ! 13  VLGN = LAGOON VOLUME RATIO--NORMAL / MAXIMUM
          ! 14  COWW = LAGOON INPUT FROM WASH WATER (m3/hd/d)
          ! 15  DDLG = TIME TO REDUCE LAGOON STORAGE FROM MAX TO NORM (d)
          ! 16  SOLQ = RATIO LIQUID/TOTAL MANURE PRODUCED.
          ! 17  SFLG = SAFETY FACTOR FOR LAGOON DESIGN (VLG=VLG0/(1.-SFLG)
          ! 18  FNP2 = FEEDING AREA STOCK PILE AUTO SOLID MANURE APPL RATE (kg/ha)
          ! 19  FNP5 = AUTOMATIC MANURE APPLICATION RATE (kg/ha)
          ! 20  FIRG = FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)
          !     LINE 9/10
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)BIR(ISA),EFI(ISA),VIMX(ISA),ARMN(ISA),ARMX(ISA),&
          !!!BFT(ISA),FNP(4,ISA),FMX,DRT(ISA),FDSF(ISA),PEC(ISA),DALG(ISA),VLGN&
          !!!(ISA),COWW(ISA),DDLG(ISA),SOLQ(ISA),SFLG,FNP(2,ISA),FNP(5,ISA),&
          !!!FIRG(ISA)
          !!!IF(FIRG(ISA)<1.E-10)THEN
          !!!    IF(FIR0<1.E-10)THEN
          !!!        FIRG(ISA)=1.
          !!!    ELSE
          !!!        FIRG(ISA)=FIR0
          !!!    END IF
          !!!END IF
          NZ=MAX(1,NHRD(IOW))
          !     NY   = 0 FOR NON GRAZING AREA
          !          = HERD NUMBERS FOR GRAZING AREA
          !     LINE 11
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)(NY(J),J=1,NZ)
          !     XTP  = GRAZING LIMIT FOR EACH HERD--MINIMUM PLANT MATERIAL(t/ha)
          !     LINE 12
          !!!MODIF HISAFE 1 = REMOVE INPUT FILES READING
          !!!READ(KR(5),*)(XTP(J),J=1,NZ)
          IF(IHRD==2)THEN
              DO J=1,NZ
                  J1=NY(J)
                  IF(J1==0)CYCLE
                  NGZ(J1,ISA)=J1
                  GZLM(J1,ISA)=XTP(J)
              END DO
              IHDM(ISA)=NY(1)
          END IF
          IF(DRT(ISA)<1.E-5)DRT(ISA)=1.
          IF(KFL(1)>0)THEN
              CALL APAGE(1)
              WRITE(KW(1),'(//1X,A/)')'____________________MANAGEMENT DATA&
              ____________________'
              WRITE(KW(1),'(T10,A,I4)')'OWNER ID=',IOW
              IF(II>0)WRITE(KW(1),'(T10,A/T15,A,I3)')'FEEDING AREA','HERD ID=',II
          END IF
          DO IHD=1,NZ
              IF(NGZ(IHD,ISA)>0)EXIT
          END DO
          IF(IHD<=NZ)THEN
              WRITE(KW(1),'(T10,A/T15,A)')'GRAZING AREA','GRAZING MODE'
              SELECT CASE(IHRD+1)
              CASE(1)
                  WRITE(KW(1),'(T15,A)')'LEVEL 0 MANUAL_NO HERD FILE REQUIRED'
              CASE(2)
                  WRITE(KW(1),'(T15,A)')'LEVEL 1 HYBRID_HERD FILE REQUIRED'
              CASE(3)
                  WRITE(KW(1),'(T15,A)')'LEVEL 2 AUTOMATIC_HERD FILE REQUIRED'
              END SELECT
          END IF
          DO IHD=1,NZ
              IF(NGZ(IHD,ISA)==0)CYCLE
         !!!     IF(GZLM(IHD,ISA)<1.E-5)GZLM(IHD,ISA)=GZL0
              X1=24.*FFED(IHD,IOW)
              IF(KFL(1)>0)WRITE(KW(1),3536)IHD,NCOW(IHD,IOW),X1,GZLM(IHD,ISA)
          END DO
          IFA(ISA)=MAX(IFA(ISA),1)
          CALL AISPL(IRR(ISA),IAC(ISA))
          IF(ARMX(ISA)<1.E-10)ARMX(ISA)=1000.
          IF(FMX<1.E-10)FMX=200.
          IF(KFL(1)>0)THEN
              IF(IAPL(ISA)<0)WRITE(KW(1),'(T10,A)')'LIQUID MANURE APPL AREA'
              IF(IAPL(ISA)>0)WRITE(KW(1),'(T10,A)')'SOLID MANURE APPL AREA'
              IF(FFPQ(ISA)>0)WRITE(KW(1),'(T10,A)')'FILTER STRIP'
          END IF
          IF(IRR(ISA)==0)THEN
              IF(DALG(ISA)>0.)THEN
                  X3=COWW(ISA)*NCOW(IDFH(ISA),IOW)
                  RFM0=2.*RFMX
                  X1=RFM0-5.64
                  QLG=X1*X1/(RFM0+22.6)
                  DALG(ISA)=DALG(ISA)*WSA(ISA)
                  X1=10.*DALG(ISA)
                  QWW=30.*X3/X1
                  VLGM(ISA)=(QLG+QWW)/(1.-VLGN(ISA))
                  VLGN(ISA)=VLGN(ISA)*VLGM(ISA)
                  VLGM(ISA)=VLGM(ISA)/(1.-SFLG)
                  IF(KFL(1)>0)WRITE(KW(1),39)DALG(ISA),VLGN(ISA),VLGM(ISA),DDLG(ISA)&
                  ,COWW(ISA),SFLG
                  COWW(ISA)=X3
                  VLGN(ISA)=X1*VLGN(ISA)
                  VLGB(ISA)=VLGN(ISA)
                  VLGM(ISA)=X1*VLGM(ISA)
                  VLG(ISA)=VLGN(ISA)
                  CFNP(ISA)=0.
                  WTMU(ISA)=CFNP(ISA)*VLG(ISA)
                  WTMB(ISA)=WTMU(ISA)
                  TWMB=TWMB+WTMU(ISA)
                  VLGI(ISA)=(VLGM(ISA)-VLGN(ISA))/(DDLG(ISA)+1.E-5)
              ELSE
                  IF(KFL(1)>0)WRITE(KW(1),'(T10,A)')'DRYLAND AGRICULTURE'
              END IF
          ELSE
              IF(VIMX(ISA)<1.E-10)VIMX(ISA)=2000.
              IF(KFL(1)>0)THEN
                  IF(BIR(ISA)<0.)THEN
                      WRITE(KW(1),'(T10,A)')'AUTOMATIC IRRIGATION'
                      WRITE(KW(1),4080)BIR(ISA),IRI(ISA)
                  ELSE
                      IF(BIR(ISA)>0.)THEN
                          WRITE(KW(1),'(T10,A)')'AUTOMATIC IRRIGATION'
                          IF(BIR(ISA)<1.)THEN
                              WRITE(KW(1),3680)BIR(ISA),IRI(ISA)
                          ELSE
                              WRITE(KW(1),3630)BIR(ISA),IRI(ISA)
                          END IF
                      ELSE
                          WRITE(KW(1),'(T10,A)')'USER SPECIFIED IRRIGATION'
                      END IF
                  END IF
                  WRITE(KW(1),3620)VIMX(ISA),ARMN(ISA),ARMX(ISA)
                  IF(IAC(ISA)==0)THEN
                      WRITE(KW(1),'(T15,A)')'FLEXIBLE APPL VOLUMES'
                  ELSE
                      WRITE(KW(1),'(T15,A)')'RIGID APPL VOLUMES'
                  END IF
                  SELECT CASE(IRR(ISA))
                  CASE(1)
                      WRITE(KW(1),'(T15,A)')'SPRINKLER IRRIGATION'
                      WRITE(KW(1),3140)EFI(ISA)
                  CASE(2)
                      WRITE(KW(1),'(T15,A)')'FURROW IRRIGATION'
                      WRITE(KW(1),3140)EFI(ISA)
                  CASE(3)
                      WRITE(KW(1),'(T15,A)')'IRRIGATION WITH FERT ADDED'
                      WRITE(KW(1),3140)EFI(ISA)
                  CASE(4)
                      WRITE(KW(1),'(T15,A)')'IRRIGATION FROM LAGOON'
                  CASE(5)
                      WRITE(KW(1),'(T15,A)')'DRIP IRRIGATION'
                  END SELECT
                  WRITE(KW(1),'(T15,A,F6.3)')'FRACTION FC TO CALCULATE AUTO IRR VOL =',&
                  FIRG(ISA)
              END IF
          END IF
          IF(KFL(1)>0)THEN
              IF(BFT(ISA)>0.)THEN
                  WRITE(KW(1),'(T10,A/T15,A,I3,A)')'AUTO SCHEDULED FERT','MIN APPL &
                  INTERVAL = ',IFA(ISA),' d'
                  IF(BFT(ISA)>1.)THEN
                      WRITE(KW(1),'(T15,A,F4.0,A)')'SOIL SOL N CONC TRIGGER = ',BFT(ISA)&
                      ,' g/t'
                  ELSE
                      WRITE(KW(1),'(T15,A,F5.2)')'PLANT STRESS TRIGGER = ',BFT(ISA)
                  END IF
                  WRITE(KW(1),'(T15,A,F8.1,A)')'FIXED RATE, SURFACE APPLIED = ',FNP&
                  (4,ISA),' kg/ha/APP'
              ELSE
                  WRITE(KW(1),'(T10,A)')'USER SPECIFIED FERT'
              END IF
              IF(IDF0(5,ISA)>0.AND.FNP(5,ISA)>0.)WRITE(KW(1),'(T15,A)')'AUTO MANURE APPL'
              WRITE(KW(1),'(T10,A,F8.0,A)')'MAX N FERT/CROP = ',FMX,' kg/ha'
              IF(IPAT>0)THEN
                  WRITE(KW(1),'(T10,A)')'AUTO P FERT'
              ELSE
                  WRITE(KW(1),'(T10,A)')'MANUAL P FERT'
              END IF
              IF(IKAT>0)THEN
                  WRITE(KW(1),'(T10,A)')'AUTO K FERT'
              ELSE
                  WRITE(KW(1),'(T10,A)')'MANUAL K FERT'
              END IF
          END IF
          NII(ISA)=IRI(ISA)
          IF(IFD(ISA)>0)THEN
              IF(FDSF(ISA)<1.E-10)FDSF(ISA)=.9
              IF(KFL(1)>0)WRITE(KW(1),2560)FDSF(ISA)
              FDSF(ISA)=FDSF(ISA)*1000.
          END IF
          IF(KFL(1)>0)THEN
              IF(LM(ISA)==0)THEN
                  WRITE(KW(1),'(T10,A)')'LIME APPLIED AS NEEDED'
              ELSE
                  WRITE(KW(1),'(T10,A)')'NO LIME APPLICATIONS'
              END IF
              WRITE(KW(1),'(T10,A,F10.3)')'USLE P FACTOR = ',PEC(ISA)
          END IF
          IF(IDR(ISA)>0)THEN
              X1=IDR(ISA)
              X1=.001*IDR(ISA)
              DO I=1,NBSL(ISA)
                  L=LID(I,ISA)
                  IF(Z(L,ISA)>X1)EXIT
              END DO
              IDR(ISA)=L
              HCLN(ISA)=HCL(L,ISA)
              HCL(L,ISA)=MAX(PRMT(83)*SATC(L,ISA),(PO(L,ISA)-S15(L,ISA))/(24.*DRT(ISA)))
              HCLD(ISA)=HCL(L,ISA)
              IF(KFL(1)>0)WRITE(KW(1),3360)X1,DRT(ISA),HCL(L,ISA)
          END IF
          IF(IRRS(ISA)>0)WRITE(KW(1),'(T10,A,I8)')'IRR SUPPLIED FROM RES IN SA',IRRS(ISA)
          HU(1,ISA)=0.
          IBGN=1
          JJK=1
          IPL=0
          I=1
          IY1=1
          IF(KFL(1)>0)WRITE(KW(1),'(/1X,A)')'-----OPERATION SCHEDULE'
          DO !OPSC LOOP
              NCRP=IGO(ISA)
              K=1
              IF(KFL(1)>0)THEN
                  WRITE(KW(1),'(/T10,A,I2)')'YR',I
                  WRITE(KW(1),316)
              END IF
              I1=I-1
              FNMX(I,ISA)=FMX
              KI=0
              KF=0
              KP=0
              HU0=0.
              IF(JDHU<366)HU(JJK,ISA)=0.
              IF(IGO(ISA)>0)THEN
                  DO J=1,MNC
                      IF(NHU(J,ISA)==0)CYCLE
                      LY(I,K,ISA)=NHU(J,ISA)
                      K=K+1
                  END DO
              END IF
              J=0
              DO
                  J=J+1
                  ! READ OPERATION SCHEDULE
                  !  1  JX(1)= YR OF OPERATION
                  !  2  JX(2)= MO OF OPERATION
                  !  3  JX(3)= DAY OF OPERATION
                  !  4  JX(4)= EQUIPMENT ID NO
                  !  5  JX(5)= TRACTOR ID NO
                  !  6  JX(6)= CROP ID NO
                  !  7  JX(7)= XMTU--TIME FROM PLANTING TO MATURITY (Y)(FOR TREE
                  !            CROPS AT PLANTING ONLY).
                  !          = LYR--TIME FROM PLANTING TO HARVEST (Y)(HARVEST ONLY)
                  !          = PESTICIDE ID NO (FOR PESTICIDE APPLICATION ONLY)
                  !          = FERTILIZER ID NO (FOR FERTILIZER APPLICATION ONLY)
                  !  8  OPV1 = POTENTIAL HEAT UNITS FOR PLANTING (BLANK IF UNKNOWN)
                  !          = APPLICATION VOLUME (mm)FOR IRRIGATION
                  !          = FERTILIZER APPLICATION RATE (kg/ha) = 0 FOR VARIABLE RATE
                  !          = PESTICIDE APPLICATION RATE (kg/ha)
                  !          = STOCKING RATE FOR GRAZE (ha/hd)
                  !  9  OPV2 = 2 CONDITION SCS RUNOFF CURVE NUMBER (OPTIONAL)
                  !          = PEST CONTROL FACTOR FOR PEST APPLICATION (FRACTION OF PESTS
                  !            CONTROLLED)
                  ! 10  OPV3 = PLANT WATER STRESS FACTOR(0-1); SOIL WATER TENSION(>1KPA);
                  !            OR PLANT AVAILABLE WATER DEFICIT IN ROOT ZONE(-MM)TO
                  !            TRIGGER AUTO IRR. (0. OR BLANK DOES NOT CHANGE TRIGGER)
                  ! 11  OPV4 = RUNOFF VOL/VOL IRRIGATION WATER APPLIED
                  ! 12  OPV5 = PLANT POPULATION (PLANTS/M**2 OR PLANTS/ha IF P/m2<1.)
                  !            (FOR PLANTING ONLY)
                  !          = FACTOR TO ADJUST AUTO IRRIGATION VOLUME (FIRG*FC)
                  ! 13  OPV6 = MAX ANNUAL N FERTILIZER APPLIED TO A CROP (0. OR BLANK
                  !            DOES NOT CHANGE FMX; > 0 SETS NEW FMX)(FOR PLANTING ONLY)
                  ! 14  OPV7 = TIME OF OPERATION AS FRACTION OF GROWING SEASON (ENTER
                  !            EARLIEST POSSIBLE MO & DAY -- JX(2) & JX(3))
                  !     LINE 3/L
                  IF(I==1.OR.J>1)READ(KR(16),2470,IOSTAT=NFL)JX,(OPV(L),L=1,7)
                  IF(NFL/=0)EXIT
                  IF(JX(1)/=IY1)EXIT
                  CALL TILTBL
                  LT(I,J,ISA)=NDT
                  JH(I,J,ISA)=JX(6)
                  IJ=LT(I,J,ISA)
                  CALL ADAJ(NC,ITL(I,J,ISA),JX(2),JX(3),NYD)
                  X4=TLD(IJ)*1000.
                  I3=IHC(IJ)
                  IF(IBGN<ITL(I,J,ISA))THEN
                      IF(IGO(ISA)>0)HU(JJK,ISA)=HU(JJK,ISA)+CAHU(IBGN,ITL(I,J,ISA),&
                      BASE,0)/(PHU(JJK,IHU(JJK,ISA),ISA)+1.)
                      HU0=HU0+CAHU(IBGN,ITL(I,J,ISA),0.,1)/AHSM
                      IBGN=ITL(I,J,ISA)
                  ELSE
                      IF(IBGN/=ITL(I,J,ISA))THEN
                          IF(IGO(ISA)>0)THEN
                              HU(JJK,ISA)=HU(JJK,ISA)+CAHU(IBGN,365,BASE,0)/&
                              (PHU(JJK,IHU(JJK,ISA),ISA)+1.)
                              IBGN=1
                              HU(JJK,ISA)=HU(JJK,ISA)+CAHU(IBGN,ITL(I,J,ISA),&
                              BASE,0)/(PHU(JJK,IHU(JJK,ISA),ISA)+1.)
                              HU0=HU0+CAHU(IBGN,ITL(I,J,ISA),0.,1)/AHSM
                              IBGN=ITL(I,J,ISA)
                          END IF
                      END IF
                  END IF
                  IF(OPV(7)>0..OR.IHUS==0)THEN
                      HUSC(I,J,ISA)=OPV(7)
                  ELSE
                      IF(IGO(ISA)==0)THEN
                          HUSC(I,J,ISA)=HU0
                      ELSE
                          IF(IDC(JJK)==NDC(1).OR.IDC(JJK)==NDC(2).OR.&
                          IDC(JJK)==NDC(4).OR.IDC(JJK)==NDC(5).OR.&
                          IDC(JJK)==NDC(9))HUSC(I,J,ISA)=HU(JJK,ISA)
                      END IF
                  END IF
                  CALL INIFP(I3,I,J,JRT)
                  ! PRINTOUT OPERATION SCHEDULE
                  IF(KFL(1)>0)WRITE(KW(1),317)I,JX(2),JX(3),TIL(IJ),I3,COTL(IJ),&
                  EMX(IJ),RR(IJ),X4,FRCP(IJ),RHT(IJ),RIN(IJ),DKH(IJ),DKI(IJ),HE&
                  (IJ),ORHI(IJ),CN2(ISA),BIR(ISA),EFI(ISA),HUSC(I,J,ISA)
                  IF(TLD(IJ)>BIG(ISA))BIG(ISA)=TLD(IJ)
                  IF(I3==NHC(5).OR.I3==NHC(6))THEN
                      NCRP=NCRP+1
                      IGO(ISA)=IGO(ISA)+1
                      X3=OPV(5)
                      CALL CPTBL
                      IF(OPV(6)>0.)FMX=OPV(6)
                      FNMX(I,ISA)=FMX
                      BASE=TBSC(JJK)
                      IPL=ITL(I,J,ISA)+365*I1
                      LY(I,K,ISA)=JJK
                      NHU(JJK,ISA)=JJK
                      K=K+1
                      IF(KFL(1)>0)WRITE(KW(1),2480)CPNM(JJK)
                      CYCLE
                  END IF
                  IF(I3/=NHC(1).AND.I3/=NHC(2).AND.I3/=NHC(3))CYCLE
                  IF(KDC1(JX(6))==0)CYCLE
                  JJK=KDC1(JX(6))
                  IF(I3==NHC(1))THEN
                      IHV=ITL(I,J,ISA)+365*I1
                      NHU(JJK,ISA)=0
                      IGO(ISA)=MAX(0,IGO(ISA)-1)
                  END IF
                  HU(JJK,ISA)=0.
                  IF(IDC(JJK)==NDC(7).OR.IDC(JJK)==NDC(8).OR.IDC(JJK)==NDC(10))LYR&
                  (I,J,ISA)=MAX(1,JX(7))
                  IF(KFL(1)>0)WRITE(KW(1),2480)CPNM(JJK)
              END DO
              ITL(I,J,ISA)=367
              HUSC(I,J,ISA)=10.
              NCP(I,ISA)=MAX(NCRP,1)
              NTP=0
              N2=0
              DO J3=1,NCP(I,ISA)
                  J4=LY(I,J3,ISA)
                  IF(NTP(J4)>0)N2=N2+1
                  NTP(J4)=1
              END DO
              NCP(I,ISA)=NCP(I,ISA)-N2
              NTL(I,ISA)=J-1
              NPST(I,ISA)=KP
              NFRT(I,ISA)=KF
              LT(I,J,ISA)=1
              JH(I,J,ISA)=0
              CND(I,J,ISA)=CN2(ISA)
              QIR(I,J,ISA )=EFI(ISA)
              TIR(I,J,ISA)=BIR(ISA)
              FIRX(I,J,ISA)=FIRG(ISA)
              RSTK(I,J,ISA)=RST0(ISA)
              IF(KFL(1)>0)THEN
                  IF(KI>0)THEN
                      WRITE(KW(1),2590)
                      DO L=1,KI
                          N1=KIR(L)
                          ! PRINTOUT IRRIGATION SCHEDULE
                          WRITE(KW(1),2420)I,NIR(L),IIR(L),VIRR(I,N1,ISA),HUSC(I,N1,ISA)
                      END DO
                  END IF
                  IF(KF>0)THEN
                      WRITE(KW(1),328)
                      MO=1
                      JJ=367
                      KK=0
                      DO L=1,NTL(I,ISA)
                          J2=LT(I,L,ISA)
                          IF(IHC(J2)/=NHC(9))CYCLE
                          X1=MAX(0.,COTL(J2))
                          JDA=ITL(I,L,ISA)
                          IF(NYD==0)JDA=JDA+1
                          IF(JDA==JJ.AND.NBT(J2)==0.AND.NBE(J2)==KK)X1=0.
                          JJ=JDA
                          KK=NBE(J2)
                          CALL AXMON
                          CALL AICL
                          M=LFT(I,L,ISA)
                          XZ=FCST(M)*WFA(I,L,ISA)
                          XY=X1+XZ
                          X4=TLD(J2)*1000.
                          ! PRINTOUT FERTILIZER SCHEDULE
                          WRITE(KW(1),329)I,MO,KDA,FTNM(M),KDF(M),NBE(J2),NBT(J2),XY,WFA&
                          (I,L,ISA),X4,FN(M),FNMA(M),FNO(M),FP(M),FPO(M),HUSC(I,L,ISA)
                      END DO
                  END IF
                  IF(KP>0)THEN
                      IF(MASP==1)THEN
                          AUNT='(g/ha)'
                      ELSE
                          AUNT='(kg/ha)'
                      END IF
                      WRITE(KW(1),3850)AUNT
                      DO L=1,KP
                          N1=NPC(L)
                          M=LPC(I,L,ISA)
                          ! PRINTOUT PESTICIDE SCHEDULE
                          WRITE(KW(1),3860)I,KPC(L),JPC(L),PSTN(M),PSTR(I,L,ISA),PSTE&
                          (I,L,ISA),PCST(M),HUSC(I,N1,ISA)
                      END DO
                  END IF
              END IF
              IF(NFL==0.AND.JX(1)>0)THEN
                  I=JX(1)
                  IY1=I
              ELSE
                  EXIT
              END IF
          END DO !END OPSC LOOP
          NRO(ISA)=IY1
          JX(4)=IAUI(ISA)
          JX(5)=0
          CALL TILTBL
          IAUI(ISA)=NDT
          IF(KFL(1)>0)WRITE(KW(1),677)TIL(NDT),TLD(NDT)
          JX(4)=IAUF(ISA)
          JX(5)=12
          CALL TILTBL
          IAUF(ISA)=NDT
          JX(4)=IAMF(ISA)
          JX(5)=0
          CALL TILTBL
          IAMF(ISA)=NDT
          JX(4)=ISPF(ISA)
          JX(5)=12
          CALL TILTBL
          ISPF(ISA)=NDT
          JX(4)=ILQF(ISA)
          JX(5)=12
          CALL TILTBL
          ILQF(ISA)=NDT
          JX(4)=IAUL(ISA)
          JX(5)=0
          CALL TILTBL
          IAUL(ISA)=NDT
          K=1
          IF(IDF0(1,ISA)==0)IDF0(1,ISA)=69
          IF(IDF0(2,ISA)==0)IDF0(2,ISA)=69
          IF(IDF0(3,ISA)==0)IDF0(3,ISA)=53
          IF(IDF0(4,ISA)==0)IDF0(4,ISA)=52
          IF(IDF0(5,ISA)==0.AND.FNP(5,ISA)>0.)IDF0(5,ISA)=69
          IF(IDF0(6,ISA)==0)IDF0(6,ISA)=54
          DO K2=1,6
              IF(IDF0(K2,ISA)>0)THEN
                  JX(7)=IDF0(K2,ISA)
                  CALL NFTBL(K)
                  IDF0(K2,ISA)=K
              END IF
          END DO
          IF(KFL(1)>0)THEN
              WRITE(KW(1),716)TIL(IAUF(ISA)),TLD(IAUF(ISA)),FTNM(IDF0(4,ISA))
              WRITE(KW(1),689)TIL(IAMF(ISA)),TLD(IAMF(ISA)),FTNM(IDF0(2,ISA))
              WRITE(KW(1),690)TIL(ISPF(ISA)),TLD(ISPF(ISA)),FTNM(IDF0(2,ISA))
              WRITE(KW(1),691)TIL(ILQF(ISA)),TLD(ILQF(ISA)),FTNM(IDF0(1,ISA))
          END IF
          DO I=1,NRO(ISA)
              I1=I-1
              IF(I1==0)I1=NRO(ISA)
              ANA(I,ISA)=0.
              IF(LY(I,1,ISA)>0)CYCLE
              IF(LY(I1,NCP(I1,ISA),ISA)>0)THEN
                  LY(I,1,ISA)=LY(I1,NCP(I1,ISA),ISA)
              ELSE
                  I2=I1-1
                  LY(I,1,ISA)=LY(I2,NCP(I2,ISA),ISA)
              END IF
          END DO
          IF(IGO(ISA)>0)THEN
              DO J=1,LC
                  IF(NHU(J,ISA)==0)CYCLE
                  DO I=1,NCP(1,ISA)
                      IF(LY(1,I,ISA)==J)EXIT
                  END DO
                  IF(I<=NCP(1,ISA))CYCLE
                  NCP(1,ISA)=NCP(1,ISA)+1
                  L=NCP(1,ISA)
                  L1=1000
                  DO WHILE(L1>1)
                      L1=L-1
                      LY(1,L,ISA)=LY(1,L1,ISA)
                      L=L1
                  END DO
                  LY(1,1,ISA)=NHU(J,ISA)
              END DO
          END IF
          I=NRO(ISA)
          JD(ISA)=MAX(1,LY(I,NCP(I,ISA),ISA))
          IF(RZ(ISA)>XX)RZ(ISA)=XX
          IF(BIG(ISA)>XX)BIG(ISA)=XX
          TNOR(ISA)=0.
          STDN(JD(ISA),ISA)=8.29*STDO(ISA)
          STDL(JD(ISA),ISA)=.1*STDO(ISA)
          BTN(ISA)=ZNMN(ISA)+ZON(ISA)+STDN(JD(ISA),ISA)
          BTNX(ISA)=BTN(ISA)
          BTNZ(ISA)=BTN(ISA)
          TBTN=TBTN+BTN(ISA)*WSA(ISA)
          STDP(JD(ISA),ISA)=1.04*STDO(ISA)
          BTP(ISA)=ZPML(ISA)+ZPMA(ISA)+ZPMS(ISA)+ZPO(ISA)+ZFOP(ISA)+STDP&
          (JD(ISA),ISA)
          BTPX(ISA)=BTP(ISA)
          BTPZ(ISA)=BTP(ISA)
          STDK(JD(ISA),ISA)=8.29*STDO(ISA)
          BTK(ISA)=ZSK(ISA)+ZEK(ISA)+ZFK(ISA)+STDK(JD(ISA),ISA)
          KK=NTL(1,ISA)
          KP1(ISA)=1
          DO KT2=1,KK
              IF(ITL(1,KT2,ISA)>=IBD)EXIT
              II=IHC(LT(1,KT2,ISA))
              IF(II==NHC(7))KP1(ISA)=KP1(ISA)+1
          END DO
          IF(KT2>KK)KT2=KK
          KT(ISA)=KT2
          JT2=LT(1,KT(ISA),ISA)
          UB1(ISA)=RZ(ISA)*5.
          UOB(ISA)=1.-EXP(-UB1(ISA))
          IGO(ISA)=0
          JJK=LY(1,1,ISA)
          AWC(JJK,ISA)=0.
          IRO(ISA)=0
          JP(JJK,ISA)=0
          KC(ISA)=0
          MO=MO1
          CLOSE(KR(16))
          DO K=1,6
              IDFT(K,ISA)=IDF0(K,ISA)
          END  DO
      END DO   ! END SUBAREA LOOP
      XSL=333.6*(XCU-XCS)*COS1
      YSL=333.6*(YCU-YCS)
      XCS=111.2*(2.*XCS-XCU)*COS1
      YCS=111.2*(2.*YCS-YCU)
      SEV=0.
      !DO I=1,NWTH
          !L=I+KND
          !CALL WREAD(L,2)
      !END DO
      IF(NGN<0.OR.INFL==5)IRF=1
      XSA=MSA
      TWMB=.001*TWMB
      DO IOW=1,NBON
          OSAA(IOW)=0.
          NSAS(IOW)=0
          NSAL(IOW)=0
          OWSA(IOW)=0.
          DO ISA=1,MSA
              IF(IDON(ISA)/=IOW)CYCLE
              IF(IAPL(ISA)==0)CYCLE
              OWSA(IOW)=OWSA(IOW)+WSA(ISA)
              IF(IAPL(ISA)<0)THEN
                  I1=-1
                  NSAL(IOW)=NSAL(IOW)+1
                  IDSL(NSAL(IOW),IOW)=ISA
              ELSE
                  OSAA(IOW)=OSAA(IOW)+WSA(ISA)
                  NSAS(IOW)=NSAS(IOW)+1
                  IDSS(NSAS(IOW),IOW)=ISA
                  I1=1
              END IF
              IF(NFED(IOW)==0)CYCLE
              DO J=1,NFED(IOW)
                  IF(IDFD(J,IOW)==I1*IAPL(ISA))EXIT
              END DO
              IAPL(ISA)=I1*IDFA(J,IOW)
          END DO
          ISAS(IOW)=IDSS(1,IOW)
      END DO
      NY=0
      DO IOW=1,NBON
          NGIX(1,1,IOW)=1
          IF(NHRD(IOW)==0)CYCLE
          DO IHD=1,NHRD(IOW)
              JX(7)=IDMU(IHD,IOW)
              CALL NFTBL(K)
              IDMU(IHD,IOW)=K
              IGZO(IHD,IOW)=0
              GZRT(IHD,IOW)=.001*GZRT(IHD,IOW)
              DO ISA=1,MSA
                  IF(IDON(ISA)/=IOW)CYCLE
                  IF(IFED(IHD,IOW)==ISA)THEN
                      GCOW(IHD,ISA)=NCOW(IHD,IOW)*FFED(IHD,IOW)
                  ELSE
                      IF(NGZ(IHD,ISA)==0)CYCLE
                      GCOW(IHD,ISA)=NCOW(IHD,IOW)*(1.-FFED(IHD,IOW))
                      IGZO(IHD,IOW)=IGZO(IHD,IOW)+1
                      NGIX(IGZO(IHD,IOW),IHD,IOW)=ISA
                      IGZ(ISA)=0
                  END IF
              END DO
              ISA=MSA
              NGZA(IHD,IOW)=IGZO(IHD,IOW)
              I2=NGZA(IHD,IOW)
              IF(I2==0)CYCLE
              IGZX(IHD,IOW)=NGIX(I2,IHD,IOW)
              IF(IHD>1)THEN
                  DO J=1,IHD
                      J1=IGZO(IHD,IOW)
                      DO WHILE(IGZX(IHD,IOW)==NY(J))
                          J1=J1-1
                          IGZX(IHD,IOW)=NGIX(J1,IHD,IOW)
                      END DO
                      IGZO(IHD,IOW)=J1
                  END DO
              END IF
              NY(IHD)=IGZX(IHD,IOW)
          END DO
          IHD=NHRD(IOW)
      END DO
      IF(NDP>0)THEN
          IF(KFL(1)/=0)THEN
              WRITE(KW(1),'(//1X,A/)')'____________________PESTICIDE &
              DATA____________________'
              WRITE(KW(1),3900)
          END IF
          DO I=1,NDP
              ! PRINTOUT PESTICIDE DATA
              IF(KFL(1)>0)WRITE(KW(1),3880)PSTN(I),PSOL(I),PHLS(I),PHLF(I)&
              ,PWOF(I),PKOC(I),PCST(I)
              PSOL(I)=PSOL(I)*10.
              PHLS(I)=1.-EXP(-.693/PHLS(I))
              PHLF(I)=1.-EXP(-.693/PHLF(I))
          END DO
      END IF
      CALL CRPIO
      DO I=2,MSO-1
          IF(KFL(I)==0.OR.(I>33.AND.I<37))CYCLE
          WRITE(KW(I),3381)IYER,IMON,IDAY,IT1,IT2,IT3
          WRITE(KW(I),'(T10,A,I4)')'RUN # ',IRUN
          WRITE(KW(I),'(10X,20A4)')TITLE
          WRITE(KW(I),5031)SITEFILE
          WRITE(KW(I),5031)SAFILE
      END DO
      CALL ASORTI(NBSA,IBSA,MSA)
      NPSO=1
      L=2
      MXW=1
      LND=KND+NWTH
      DO ISA=1,MSA
          IF(IPTS(ISA)>0)THEN
          ! DAILY POINT SOURCE FILE NAME
              JJ=-1
              DO WHILE(JJ/=IPTS(ISA))
                  READ(KR(27),*,IOSTAT=NFL)JJ,FPSO(JJ)
                  IF(NFL/=0)THEN
                      WRITE(*,*)'POINT SOURCE NO = ',IPTS(ISA),' NOT IN PT SO &
                      LIST FILE     SAID = ',NBSA(ISA)
                      STOP
                  END IF
              END DO
              REWIND KR(27)
              IF(NPSO>1)THEN
                  DO L=1,MXW
                      IF(NBW(L)==IPTS(ISA))EXIT
                  END DO
              END IF
              IF(L>MXW)THEN
                  MXW=NPSO
                  L=MXW+LND
                  NBW(MXW)=IPTS(ISA)
                  IPSO(ISA)=NPSO
                  NPSO=NPSO+1

                  !!!MODIF HISAFE 2 = MODIFY READING FILE PATH
                  filename = foldername//'/'//FPSO(JJ)
                   write(*,*) 'FPSO=',filename
                  CALL OPENV(KR(L),filename,0)

                  DO J=1,6
                      READ(KR(L),'()')
                  END DO
                  CALL WREAD(L,3)
              ELSE
                  IPSO(ISA)=L
              END IF
          END IF
          LRG=0
    !     IF(KFL(21)>0)CALL SOCIOA(1)
          IF(KFL(22)>0)CALL SOCIOD(1)
          DO J=1,LC
              STD(J,ISA)=0.
              NHU(J,ISA)=IHU(J,ISA)
              IF(NHU(J,ISA)>LRG)LRG=NHU(J,ISA)
              IF(RDMX(J)>RZ(ISA))RZ(ISA)=RDMX(J)
              IHU(J,ISA)=1
              UNA(J,ISA)=625.*BN(3,J)*WA(J)
          END DO
      END DO
      NPSO=NPSO-1
      SMMC=0.
      WRITE(KW(1),2122)'POP',(POPX(J),J=1,LC)
      WRITE(KW(1),2122)'MXLA',(PLAX(J),J=1,LC)
      WRITE(KW(1),2123)'PHU',(PHUX(J),J=1,LC)
      CALL APAGE(0)
      WRITE(KW(1),'(//1X,A/)')'________________SUBAREA HYDROLOGIC DATA__&
      _______________________'
      WRITE(KW(1),2111)
      SMWD=0.
      DO ISA=1,MSA
          AWTH=' '
          IF(NGN>0)THEN
              AWTH=FWTH(IRF(ISA))
              SMWD(IRF(ISA))=SMWD(IRF(ISA))+WSA(ISA)
          END IF
          IF(ISLF==0)THEN
              X1=RLF(ISA)*RSF(ISA)
          ELSE
              X1=SLF(ISA)
          END IF
          WRITE(KW(1),3121)ISA,NBSA(ISA),ACET(1,ISA),XCT(ISA),YCT(ISA),&
          (ACET(I,ISA),I=2,8),X1,TC(ISA),SNO(ISA),STDO(ISA),URBF&
          (ISA),BCOF(ISA),BFFL(ISA),CN2(ISA),TITSO(ISA),TITOP(ISA),&
          NVCN(ISA),SATK(ISA),AWTH
      END DO
      WRITE(KW(1),'(T5,A,3E20.10)')'SUM WSA = ',TOT,SUMA,RWSA(MSA)
      IF(NGN>0)THEN
          DO I=1,NWTH
              SMWD(I)=SMWD(I)/TOT
              WRITE(KW(1),2124)FWTH(I),SMWD(I)
          END DO
      END IF
      CALL APAGE(0)
      WRITE(KW(1),'(//1X,A/)')'___________________ROUTING REACH DATA____&
      _______________________'
      WRITE(KW(1),2126)
      DO ISA=1,MSA
          ! PRINTOUT REACH DATA
          IF(ABS(ACET(2,ISA)-RCHL(ISA))>1.E-5)WRITE(KW(1),3122)ISA,NBSA&
          (ISA),WSA(ISA),RWSA(ISA),RCHL(ISA),RCHD(ISA),RCHS(ISA),RCBW(ISA)&
          ,RCTW(ISA),RCHN(ISA),RCHC(ISA),RCHK(ISA),RFPW(ISA),RFPL(ISA),&
          RFPS(ISA)
          RCHK(ISA)=RCHK(ISA)*RCHC(ISA)
      END DO
      CALL APAGE(0)
      WRITE(KW(1),'(//1X,A/)')'___________________RESERVOIR DATA________&
      ___________________'
      WRITE(KW(1),2128)
      SRYB=0.
      SRVA=0.
      SPDA=0.
      SWBB=0.
      JDA=IBD-1
      IF(JDA<=0)JDA=365
      DO ISA=1,MSA
          X1=RWSA(ISA)
          IF(IEXT(ISA)>0)X1=WSA(ISA)
          WSAX1=10.*WSA(ISA)
          BSNO(ISA)=WSAX1*SNO(ISA)
          BRSV(ISA)=WSAX1*RSV(ISA)
          BGWS(ISA)=WSAX1*GWST(ISA)
          SAET=0.
          CALL WHLRMX(JDA)
          HR0(ISA)=HRLT
          SALA(ISA)=WSA(ISA)
          IF(RSAE(ISA)>0.)THEN
              IF(PCOF(ISA)>0..AND.PCOF(ISA)<1.)THEN
                  X1=WSA(ISA)*PCOF(ISA)
                  SPDA=SPDA+X1
              ELSE
                  SRVA=SRVA+X1
              END IF
              ! PRINTOUT RESERVOIR DATA
              WRITE(KW(1),3123)ISA,NBSA(ISA),RWSA(ISA),RSAE(ISA),RVE0(ISA),RSAP&
              (ISA),RVP0(ISA),RSRR(ISA),RSV(ISA),RSYS(ISA),RSYN(ISA),RSHC(ISA),&
              RSDP(ISA)
              A10=10.*X1
              ! SET INITIAL RESERVOIR PARAMETERS
              RSYS(ISA)=RSYS(ISA)*1.E-6
              RSYN(ISA)=RSYN(ISA)*1.E-6
              RVE0(ISA)=RVE0(ISA)*A10
              RVP0(ISA)=RVP0(ISA)*A10
              RSVP(ISA)=RVP0(ISA)
              RSVE(ISA)=RVE0(ISA)
              RSV(ISA)=RSV(ISA)*A10
              RSVB(ISA)=RSV(ISA)
        !     SWST(LID(1,ISA),ISA)=SWST(LID(1,ISA),ISA)+.1*RSV(ISA)/WSA(ISA)
              RSRR(ISA)=(RSVE(ISA)-RSVP(ISA))/RSRR(ISA)
              RSDP(ISA)=EXP(-4.605/RSDP(ISA))
              RSO3(ISA)=0.
              RSSP(ISA)=.0001*RSV(ISA)
              X1=LOG10(RSAE(ISA))-LOG10(RSAP(ISA))
              X2=LOG10(RSVE(ISA))-LOG10(RSVP(ISA))
              !BV2(ISA)=X2/X1
              !BV1(ISA)=RSVE(ISA)/RSAE(ISA)**BV2(ISA)
              !BA2(ISA)=(LOG10(RSEE(ISA))-LOG10(RSEP(ISA)))/X1
              !BA1(ISA)=RSEE(ISA)/RSAE(ISA)**BA2(ISA)
              BR2(ISA)=X1/X2
              BR1(ISA)=RSAE(ISA)/RSVE(ISA)**BR2(ISA)
              RSSA(ISA)=BR1(ISA)*RSV(ISA)**BR2(ISA)
              SALA(ISA)=WSA(ISA)-RSSA(ISA)
              X1=WSAX1*SWB(ISA)+RSV(ISA)
              IF(KFL(13)>0)WRITE(KW(13),4094)ISA,X1
              RSYS(ISA)=RSYS(ISA)*RSV(ISA)
              SRYB=SRYB+RSYS(ISA)
              RSON(ISA)=1.5*RSYS(ISA)
              RSOP(ISA)=RSYS(ISA)
              RSOC(ISA)=15.*RSYS(ISA)
              RSYB(ISA)=RSYS(ISA)
          END IF
          SWBB=SWBB+WSAX1*(SWB(ISA)+GWST(ISA))+RSV(ISA)
          SWBD(ISA)=SWB(ISA)+.1*RSV(ISA)/WSA(ISA)+GWST(ISA)
          SWBX(ISA)=WSAX1*SW(ISA)
          BSALA(ISA)=SALA(ISA)
      END DO
      SRYX=SRYB
      RTO=SRVA/RWSA(MSA)
      WRITE(KW(1),'(/T10,A,F8.4)')'FRACTION OF WATERSHED CONTROLLED BY &
      RESERVOIRS = ',RTO
      NCMD=K1-1
      RWSA(NCMD)=SUMA
      CALL APAGE(0)
      IF(KFL(1)>0)THEN
          WRITE(KW(1),'(//1X,A/)')'____________________ROUTING SCHEME&
          ______________'
          WRITE(KW(1),16)
      END IF
      ! PRINTOUT ROUTING COMMAND TABLE
      DO I=1,NCMD
          IF(ICDT(I)>2)THEN
              IF(KFL(1)>0)WRITE(KW(1),17)RCMD(ICDT(I)),ICDT(I),IDOT(I),&
              IDN1T(I),IDN2T(I)
          ELSE
              IDO=IDOT(I)
              IF(ICDT(I)==2)THEN
                  ISA=IDN2T(I)
                  I1=NBSA(ISA)
                  IF(KFL(1)>0)WRITE(KW(1),17)RCMD(ICDT(I)),ICDT(I),IDOT(I),&
                  IDN1T(I),IDN2T(I),I1
              ELSE
                  ISA=IDN1T(I)
                  I1=NBSA(ISA)
                  IF(KFL(1)>0)WRITE(KW(1),2151)RCMD(ICDT(I)),ICDT(I),IDOT(I),&
                  IDN1T(I),I1,IDN2T(I)
              END IF
              IDOA(ISA)=IDO
          END IF
      END DO



 !!!     DO    ! OUTPUT LOOP
          IF(KFL(2)>0)WRITE(KW(2),2284)
          IF(KFL(3)>0)WRITE(KW(3),4085)(HED(KY(J1)),J1=1,NKY),HED(NDVSS)
          IF(KFL(4)>0)WRITE(KW(4),4081)(HED(KY(J1)),J1=1,NKY)
          IF(KFL(5)>0)THEN
              WRITE(KW(5),935)SUMA,(PSTN(K),K=1,NDP)
              WRITE(KW(5),937)
          END IF
          IF(KFL(37)>0)THEN
              WRITE(KW(37),935)SUMA
              WRITE(KW(37),939)
          END IF
          IF(KFL(8)>0)WRITE(KW(8),1001)
          IF(KFL(9)>0)WRITE(KW(9),2112)
          !IF(KFL(11)>0)WRITE(KW(11),4082)HEDC,(HED(KD(J1)),J1=1,NKD),&
          !(HEDS(KS(J1)),J1=1,NKS)
          IF(KFL(11)>0)WRITE(KW(11),4082)(HED(KD(J1)),J1=1,NKD),&
          (HEDS(KS(J1)),J1=1,NKS),HEDC
          IF(KFL(44)>0)WRITE(KW(44),4082)(HED(KD(J1)),J1=1,NKD)
          IF(KFL(13)>0)WRITE(KW(13),4084)
          IF(KFL(14)>0)WRITE(KW(14),2313)
          IF(KFL(15)>0)WRITE(KW(15),603)
          IF(KFL(16)>0)WRITE(KW(16),4083)' RFV',(HED(KD(J1)),J1=1,NKD)
          IF(KFL(29)>0)WRITE(KW(29),2072)
          IF(KFL(17)>0)WRITE(KW(17),3284)HED(4),(HEDR(J),HEDR(J+10),J=1,10)
          IF(KFL(18)>0)WRITE(KW(18),3285)
          IF(KFL(19)>0)WRITE(KW(19),3286)
          IF(KFL(20)>0)WRITE(KW(20),3287)
          IF(KFL(24)>0)WRITE(KW(24),4091)
          IF(KFL(25)>0)WRITE(KW(25),3288)
          IF(KFL(27)>0)WRITE(KW(27),729)
          IF(KFL(28)>0)THEN
              WRITE(KW(28),934)SUMA,(PSTN(K),K=1,NDP)
              WRITE(KW(28),938)
          END IF
          IF(KFL(30)>0)WRITE(KW(30),'(/1X,A)')'-----AVE ANNUAL VALUES(g/ha)'
          IF(KFL(31)>0)WRITE(KW(31),583)
          IF(KFL(32)>0)WRITE(KW(32),584)
          IF(KFL(38)>0)WRITE(KW(38),585)
          IF(IPD>0.AND.KFL(34)>0)THEN
              WRITE(KW(34),2073)IYER,IMON,IDAY,IT1,IT2,IT3
              WRITE(KW(34),854)ASTN
              WRITE(KW(34),856)SITEFILE
              WRITE(KW(34),856)SAFILE
              WRITE(KW(34),2142)HED(4),'mm  ',HED(5),'mm  ',HED(6),'mm  ',HED&
              (18),'mm  ',HED(10),'mm  ',HED(11),'mm  ',HEDS(8),'mm  ',HED(16),&
              'mm  ',HED(71),'mm  ','QSUR','mm  ',HED(15),'mm  ',HED(72),'mm  ',&
              HED(117),'mm  ',HED(14),'-   ',HED(1),'c   ',HED(2),'c   ',HED(59)&
              ,'c   ',HED(3),'mjm2',HED(27),'t/ha',HED(31),'t/ha',HED(53),'kgha'&
              ,HED(54),'kgha',HED(55),'kgha',HED(56),'kgha',HED(57),'kgha',HED&
              (43),'kgha',HED(42),'kgha',HED(37),'kgha',HED(119),'kgha',HED(38),&
              'kgha',HED(49),'kgha',HED(118),'kgha',HED(39),'kgha',HED(80),&
              'kgha',(HEDC(1),'-   ',HEDC(2),'-   ',HEDC(3),'m   ',HEDC(4),&
              't/ha',HEDC(5),'t/ha',HEDC(6),'t/ha',HEDC(7),'m   ',HEDC(8),&
              't/ha',HEDC(9),'t/ha',HEDC(10),'d   ',HEDC(11),'d   ',HEDC(12),&
              'd   ',HEDC(13),'d   ',HEDC(14),'d   ',HEDC(15),'d   ',HEDC(16),&
              'd   ',HEDC(17),'d   ',J=1,5)
          END IF
          DO I1=35,39,4
              IF(KFL(I1)>0)THEN
                  WRITE(KW(I1),2073)IYER,IMON,IDAY,IT1,IT2,IT3
                  WRITE(KW(I1),854)ASTN
                  WRITE(KW(I1),856)SITEFILE
                  WRITE(KW(I1),856)SAFILE
                  WRITE(KW(I1),2162)HEDH(1),'m3/s',HEDH(2),'m3/s',HEDH(33),'m3/s',&
                  HEDH(34),'m3/s',HEDH(3),'m3/s',HEDH(4),'m3/s',HEDH(5),'t   ',&
                  HEDH(6),'t   ',HEDH(7),'ppm ',HEDH(8),'kg  ',HEDH(9),'kg  ',&
                  HEDH(10),'kg  ',HEDH(11),'kg  ',HEDH(12),'kg  ',HEDH(13),'kg  ',&
                  HEDH(14),'kg  ',HEDH(15),'kg  ',HEDH(16),'kg  ',HEDH(17),'kg  ',&
                  HEDH(18),'kg  ',HEDH(19),'kg  ',HEDH(20),'-   ',HEDH(21),'-   ',&
                  HEDH(22),'-   ',HEDH(23),'-   ',HEDH(24),'-   ',HEDH(25),'-   ',&
                  HEDH(26),'g   ',HEDH(27),'g   ',HEDH(28),'g   ',HEDH(29),'g   ',&
                  HEDH(30),'g   ',HEDH(31),'g   ',HEDH(32),'g   '
              END IF
          END DO
          IF(IPD>0.AND.KFL(40)>0)THEN
              WRITE(KW(40),2073)IYER,IMON,IDAY,IT1,IT2,IT3
              WRITE(KW(40),854)ASTN
              WRITE(KW(40),856)SITEFILE
              WRITE(KW(40),856)SAFILE
              WRITE(KW(40),2129)HED(4),'mm  ',HED(13),'mm  ',HED(117),'mm  ',&
              HED(16),'mm  ','RSTKha/au ',('CPNM-   ',HEDC(1),'-   ',HEDC(2),&
              '-   ',HEDC(5),'t/ha',HEDC(6),'t/ha',HEDC(8),'t/ha',HEDC(10),&
              'd   ',HEDC(11),'d   ',HEDC(12),'d   ',HEDC(13),'d   ',HEDC(14),&
              'd   ',HEDC(15),'d   ','CNSLg/g','CNSDg/g','YLDkg/ha','GRZDd',J=1,5)
          END IF
          IF(KFL(33)>0)WRITE(KW(33),5034)HED(4),HED(10),HED(11),HED(13),&
          HED(15),HED(16),HED(17),HED(18),HED(19),HED(25),HED(26),HED(27),&
          HED(28),HED(29),HED(30),HED(31),HED(36),HED(37),HED(38),HED(39),&
          HED(40),HED(49),HED(42),HED(43),HED(44),HED(45),HED(46),HED(47),&
          HED(48),HED(51),HED(53),HED(54),HED(55),HED(56),HED(57),HED(58),&
          HED(78),HED(66)
          IFSA=1
          IF(KFL(7)>0)WRITE(KW(7),3282)
          IF(KFL(6)>0)WRITE(KW(6),3283)HEDP
          IHBS=1


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! BEGIN ANNUAL SIMULATION LOOP
!!!             CALL BSIM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



      write(*,*) 'END INIT'

      CALL TOHISAFE (p)


      CLOSE(KR(4))      !!!cropcom
      CLOSE(KR(3))      !!!tillcom
      CLOSE(KR(8))      !!!pest
      CLOSE(KR(9))      !!!fert

      IF(IHRD>0)CLOSE(KR(21))   !!!herd
      CLOSE(KR(27))     !!!PSOCOM.DAT
      CLOSE (KR(22))    !!!WINDFILE


    return

   12 FORMAT(T10,'CHANNEL GEOMETRY PARMS'/T15,'WIDTH  = ',2F8.4/T15,&
      'DEPTH  = ',2F8.4/T15,'LENGTH = ',2F8.4)
   16 FORMAT(T23,'--------ID NUMBERS---------'/T10,'COMMAND',6X,'CMD',&
      5X,'OUT',5X,'IN1',5X,'SA#',5X,'IN2',5X,'SA#')
   17 FORMAT(T10,A8,3I8,8X,2I8)
   19 FORMAT(11F10.0)
   33 FORMAT(8X,A2,I8,19X,F12.2,5F8.1,20F8.2)
   39 FORMAT(T10,'SUBAREA CONTAINS LAGOON'/T15,'DRAINAGE AREA = ',F7.2,&
      ' ha'/T15,'NORMAL VOL = ',E12.4,' mm'/T15,'MAX VOL = ',E12.4,' mm'&
      /T15,'DRAW DOWN TIME = ',F6.2,' d'/T15,'WASH WATER = ',F6.3,&
      ' m3/hd/d'/T15,'DESIGN SAFETY FACTOR =',F6.3)
  101 FORMAT(13X,I10)
  140 FORMAT(10F10.0,I10)
  316 FORMAT(/T10,'TILLAGE OPERATIONS'/6X,'DATE',T21,'OP',3X,'COST',6X,'MX',&
      6X,'RR',6X,'DP',6X,'FR',5X,'RHT',5X,'RIN',5X,'DKH',5X,'DKI',6X,'HV',&
      6X,'HV',10X,'NRCS',5X,'IRR',6X,'Q/'/6X,'Y M D',3X,'NAME',2X,'CD',&
      2X,'($/ha)',5X,'EF',5X,'(mm)',4X,'(mm)',4X,'COMP',4X,'(mm)',5X,'(m)'&
      4X,'(mm)',5X,'(m)',5X,'EF',5X,'IDX',4X,'CROP',3X,'CN',4X,'TRGR',4X,&
      'VIRR',4X,'HUSC')
  317 FORMAT(5X,3I2,1X,A8,I2,2F8.2,2F8.0,F8.3,F8.0,F8.2,F8.0,2F8.2,F8.3&
      ,5X,F8.1,2F8.2,F8.3)
  328 FORMAT(/T10,'FERTILIZER APPLIED'/T11,'DATE',T31,'FT',4X,'EQ',4X,&
      'TR',4X,'COST',6X,'WT',4X,'DPTH',2X,'|------------FRACTION OF WT--&
      ----------|'/T9,'Y   M   D',2X,'NAME',7X,'NO',4X,'NO',4X,'NO',4X,&
      '$/ha',3X,'kg/ha',6X,'mm'6X,'MN',5X,'NH3',6X,'ON',6X,'MP',6X,'OP',&
      4X,'HUSC')
  329 FORMAT(5X,3I4,1X,A8,3I6,F8.2,2F8.0,6F8.3)
  330 FORMAT(T10,'COSTS'/T15,'LIME = ',F7.2,' $/t'/T15,'IRR WATER = ',&
      F7.2,' $/mm'/T15,'FUEL PRICE = ',F7.2,' $/l'/T15,'WAGE PRICE =',&
      F7.2,' $/h')
  396 FORMAT(8F10.6)
  401 FORMAT(T10,'AUTO HYDRAULICS DESIGN'/T15,'2 Y FREQ 24 H RAINFALL ='&
      ,F6.0,' mm'/T15,'RUNOFF VOL = ',F5.1,' mm'/T15,'CH CAP-WSA EXP = '&
      ,F6.3,/T15,'BASE CH LENGTH = ',F6.2,' km'/T15,'BASE CH SLOPE = ',&
      F8.5,' m/m'/T15,'BASE TC = ',F6.3,' h'/T15,'BASE PEAK FLOW = ',&
      F6.2,' mm/h'/T15,'CH BW/D = ',F4.1/T15,'FP WIDTH/CH WIDTH = ',F6.1&
      /T10,'FLOODPLAIN SAT COND = ',F7.4,' mm/h'/T10,'MAX GROUNDWATER ST&
      ORAGE = ',F5.0,' mm'/T10,'GROUND WATER RESIDENCE TIME = ',F5.0,&
      ' d'/T10,'RF/(RF+DPRK) = ',F6.3/T10,'FRACTION SUBAREA ABOVE PONDS = '&
      ,F6.3/T10,'REACH CH C FACTOR = ',F6.3)
  412 FORMAT(T10,'LAGOON PUMP DATE = ',I4/T10,'SOLID MANURE SCRAPE &
      INTERVAL = ',I4,' d')
  470 FORMAT(5X,A4,10E12.4)
  508 FORMAT(1X,A5,4X,A80)
  509 FORMAT(10X,A80)
  525 FORMAT(I8,A80)
  583 FORMAT(T74,'COTL',6X,'COOP',6X,'MTCO',6X,'MASS',6X,'FUEL'/6X,'SA#'&
      ,6X,'ID',4X,'Y M D',5X,'OP',14X,'CROP',2X,'MT#  HC',2X,'EQ  TR',2X&
      ,'|----------($/ha)-----------|',2X,'(kg/ha)',4X,'(l/ha)')
  584 FORMAT(6X,'QS',9X,'Y',8X,'QN',6X,'SSQN',8X,'YN',6X,'DWOC'/5X,&
      '(mm)',6X,'(t/ha)',2X,'|----------(kg/ha)----------|',3X,'(t/ha)')
  585 FORMAT(6X,'SA#',4X,'SAID',6x,'RFmm'7X,'Qmm',4X,'WYLDmm',2X,'RUS2t/ha',&
      5X,'Yt/ha',2X,'YWNDt/ha',2X,'YLDGt/ha',2X,'YLDFt/ha',7X,'WSd',7X,'NSd',&
      7X,'PSd',7X,'KSd',7X,'TSd',7X,'ASd',7X,'SSd',3X,'FNkg/ha',3x,&
      'FPkg/ha',4X,'IRGAmm',6X,'STIR',2X,'FULUl/ha',2X,'DWOCt/ha',3X,&
      'QNkg/ha',1X,'SSFNkg/ha',1X,'QRFNkg/ha',1X,'QDRNkg/ha',1X,&
      'RTFNkg/ha',1X,'DPKNkg/ha',3X,'YNkg/ha',1X,'YNWNkg/ha',1X,&
      'NVOLkg/ha',1X,'DNITkg/ha',1X,'NFIXkg/ha',3X,'QPkg/ha',1X,&
      'SSFPkg/ha',1X,'QDRPkg/ha',1X,'PRKPkg/ha',3X,'YPkg/ha',1X,&
      'YPWNkg/ha',2X,'QPSTg/ha',2X,'LPSTg/ha',2X,'YPSTg/ha',7X,'Qmm',&
      4X,'WYLDmm',5X,'Yt/ha',2X,'TQNkg/ha',3X,'YNkg/ha',3X,'QPkg/ha',&
      3X,'YPkg/ha',2X,'QPSTg/ha',2X,'YPSTg/ha')
  602 FORMAT(19X,'WPM1 = ',A20,2X,'FRACT WSA = ',F6.3/T11,'JAN',6X,'FEB'&
      ,6X,'MAR',6X,'APR',6X,'MAY',6X,'JUN',6X,'JUL',6X,'AUG',6X,'SEP',6X&
      ,'OCT',6X,'NOV',6X,'DEC',6X,' YR')
  603 FORMAT(T11,'JAN',6X,'FEB',6X,'MAR',6X,'APR',6X,'MAY',6X,'JUN',6X,&
      'JUL',6X,'AUG',6X,'SEP',6X,'OCT',6X,'NOV',6X,'DEC',6X,' YR')
  646 FORMAT(5X,2I4,2I10,4F10.3)
  677 FORMAT(/T10,'AUTO IRR EQUIP  = ',A8,2X,'DEPTH = ',F6.3,' m')
  689 FORMAT(T10,'ANIMAL FERT DUMP = ',A8,2X,'DEPTH = ',F6.3,' m',2X,&
      'FERT = ',A8)
  690 FORMAT(T10,'AUTO STOCK PILE MANURE = ',A8,2X,'DEPTH = ',F6.3,' m',&
      2X,'FERT = ',A8)
  691 FORMAT(T10,'AUTO LIQUID MANURE = ',A8,2X,'DEPTH = ',F6.3,' m',&
      2X,'FERT = ',A8/)
  713 FORMAT(/1X,'-----LIVESTOCK BUY SELL DATA'/T27,'HERD'/T12,'OWNER',&
      1X,'HERD',5X,'SIZE'/6X,'Y M D',3X,'ID  ID',5X,'(HEAD)')
  714 FORMAT(///1X,'____________________LIVESTOCK MANAGEMENT DATA_______&
      _____________'//T20,'HERD',13X,'FRACTION',3X,'GRAZE',4X,'MANURE',&
      5X,'URINE'/4X,'OWNER',1X,'HERD',5X,'SIZE',5X,'MANURE',3X,'IN FEED'&
      ,4X,'RATE',6X,'PROD',6X,'PROD',/7X,'ID  ID',5X,'(HEAD)',7X,'ID',5X&
      ,'AREA',T46,'(kg/hd/d)',1X,'(kg/hd/d)',1X,'(l/hd/d)')
  716 FORMAT(T10,'AUTO FERT EQUIP = ',A8,2X,'DEPTH = ',F6.3,' m',2X,&
      'FERT = ',A8)
  729 FORMAT(3X,'SA# SAID   YR  YR#',5X,'Q',5X,'SSF',5X,'PRK',4X,'QDRN',&
      7X,'Y',5X,'YOC',5X,'PSTN',14X,'PAPL',9X,'PSRO',9X,'PLCH',9X,'PSSF'&
      ,9X,'PSED',9X,'PDGF',9X,'PDGS',9X,'PDRN',9X,'PRSF'/23X,'|---------&
      ---(mm)------------|  (t/ha)',1X,'(kg/ha)',17X,'|-----------------&
      --------------------------------(g/ha)----------------------------&
      --------------------|')
  811 FORMAT(10I8)
  848 FORMAT(5X,3I2,1X,2I4,I10)
  854 FORMAT(/10X,A80)
  856 FORMAT(7X,A20,2X,A4)
  934 FORMAT(10X,'WATERSHED AREA = ',F10.2,' ha',T84,20(A16,6X))
  935 FORMAT(10X,'WATERSHED AREA = ',F10.2,' ha',T126,20(A16,18X))
  937 FORMAT(2X,'JDA   YR',T19,'WYLDmm',11X,'Yt/ha',11X,'YNkg/ha',10X,&
      'YPkg/ha',10X,'QNkg/ha',10X,'QPkg/ha',1X,20(9X,'QPSTg/ha',9X,&
      'YPSTg/ha'))
  938 FORMAT(3X,'YR',3X,'MO',6X,'WYLDmm',6X,'Yt/ha',4X,'YNkg/ha',4X,&
      'YPkg/ha',4X,'QNkg/ha',4X,'QPkg/ha',20(3X,'QPSTg/ha',3X,'YPSTg/ha'))
  939 FORMAT(2X,'JDA   YR',T19,'WYLDmm',11X,'Yppm',12X,'YNppm',12X,&
      'YPppm',12X,'QNppm',12X,'QPppm')
 1001 FORMAT(15X,'1',9X,'2',9X,'3',9X,'4',9X,'5',9X,'6',9X,'7',9X,'8',9X,&
      '9',8X,'10',8X,'11',8X,'12',8X,'13',8X,'14',8X,'15',8X,'16',8X,'17',&
      8X,'18',8X,'19',8X,'20',8X,'21',8X,'22',8X,'23',8X,'24',8X,'25',8X,&
      '26',8X,'27',8X,'28',8X,'29',8X,'30',8X,'31',8X,'32',8X,'33',8X,'34',&
      8X,'35',8X,'36',8X,'37',8X,'38',8X,'39',8X,'40',8X,'41',8X,'42',8X,&
      '43',8X,'44',8X,'45',8X,'46',8X,'47',8X,'48',8X,'49',8X,'50',8X,'51',&
      8X,'52',8X,'53',8X,'54'/7X,'YR',4X,'PRCPmm',6X,'ETmm',7X,'Qmm',5X,&
      'SSFmm',4X,'RSSFmm',5X,'QRFmm',5X,'QDRmm',5X,'PRKmm',4X,'IRGAmm',&
      6X,'WYmm',5X,'Yt/ha',2X,'YWNDt/ha',3X,'QNkg/ha',1X,'SSFNkg/ha',1X,&
      'QRFNkg/ha',1X,'RSFNkg/ha',3X,'YNkg/ha',1X,'YNWNkg/ha',1X,&
      'QDRNkg/ha',1X,'PRKNkg/ha',3X,'DNkg/ha',1X,'AVOLkg/ha',1X,&
      'NFIXkg/ha',2X,'FNOkg/ha',1X,'FNMNkg/ha',1X,'FNMAkg/ha',3X,&
      'QPkg/ha',3X,'YPkg/ha',1X,'YPWNkg/ha',1X,'PRKPkg/ha',2X,'FPOkg/ha',&
      2X,'FPLkg/ha',3X,'QCkg/ha',3X,'YCkg/ha',1X,'YCWNkg/ha',&
      2X,'RFNkg/ha',2X,'YLNkg/ha',2X,'YLPkg/ha',2X,'BTNkg/ha',2X,'BTPkg/ha'&
      ,2X,'FTNkg/ha',2X,'FTPkg/ha',2X,'BTCkg/ha',2X,'FTCkg/ha',1X,&
      'BPDPkg/ha',1X,'FPDPkg/ha',1X,'BSLTkg/ha',1X,'FSLTkg/ha',1X,&
      'BTC1kg/ha',1X,'FTC1kg/ha',1X,'RUS2A1t/ha',4X,'YTHSd',5X,'YWTHd',1X,&
      'QDRPkg/ha')
 1301 FORMAT(T10,'GROUNDWATER STORAGE = ',F5.0,' mm'/T10,'MAX GROUNDWATE&
      R STORE = ',F5.0,' mm'/T10,'GROUNDWATER RES TIME = ',F7.2,' d'/T10&
      ,'RETURN FLOW / DEEP PERC = ',F6.3)
 2072 FORMAT(T31,'RFV',7X,'Q',5X,'SSF',5X,'YSD',10(23X,'PSRO',8X,'PSSF',&
      8X,'PSED',4X)/6X'SA#',6X,'ID',4X,'Y M D',2X,'|----------(mm)------&
      --|',1X,'(t/ha) ',15(3X,'PSTN',11X,'|--------------(g/ha)---------&
      -----|',1X))
 2073 FORMAT(/T5,'APEX1501',2X,3I4,2X,2(I2,':'),I2)
 2111 FORMAT(/T52,'_____________CHANNEL_____________   ________UPLAND___&
      ______',T135,'INITIAL COND'/14X,'SA',9X,'WSA',6X,'XCT',6X,'YCT',6X&
      ,'L',8X,'d',8X,'S',8X,'N',8X,'S',8X,'SL',7X,'N',8X,'SL',7X,'TC',&
      7X,'SNO',6X,'STD'/11X,'#',7X,'ID',4X,'(ha)',5X,'(km)',5X,'(km)',5X&
      ,'(km)',5X,'(m)',5X,'(m/m)',13X,'(m/m)',5X,'(m)',T116,'FACT',5X,&
      '(h)',7X,'(mm)',5X,'(t)',5X,'URBF',5X,'BCOF',5X,'BFFL',6X,'CN2',&
      T186,'SOIL',T207,'OPSC',T228,'NVCN',3X,'SATK',T244,'FWTH')
 2112 FORMAT(5X,'ISA',4X,'NBSA',4X,'Y   M   D',8X,'CN',7X,'SCI',5X,'RFVmm',&
      4X,'STMP2c',5X,'SMLmm',7X,'Qmm',5X,'SSFmm',5X,'QRFmm',4X,'RSSFmm',&
      4X,'WYLDmm',3X,'QRBmm/h',7X,'TCh',6X,'DURh',6X,'ALTC',7X,'AL5',3X,&
      'REPmm/h',4X,'RZSWmm',4X,'GWSTmm')
 2122 FORMAT(T7,A4,100F10.2)
 2123 FORMAT(T7,A4,100F10.0)
 2124 FORMAT(T10,A80,F8.4)
 2126 FORMAT(/T43,'________________________________CHANNEL______________&
      ________________    ______FLOODPLAIN_______'/14X,'SA',9X,'WSA',6X,&
      'RWSA',7X,'L',8X,'d',7X,'S',8X,'BW',7X,'TW',8X,'N',7X,'C',9X,'K',&
      8X,'W',8X,'L',7X,'S'/11X,'#',7X,'ID ',3X,'(ha)',5X,'(ha)',5X,&
      '(km)',6X,'(m)',4X,'(m/m)',6X,'(m)',6X,'(m)',33X,'(m)',5X,'(km)',&
      4X,'(m/m)')
 2128 FORMAT(/T35,'_EMERG SPLWAY_     _____PRINC SPLWAY_____'/T36,'SURF'&
      ,T54,'SURF',T71,'FLOOD',4X,'_____INIT_____',4X,'NORM',5X,'HYD',6X,&
      'SETTL'/17X,'SA',7X,'WSA',6X,'AREA',6X,'VOL',5X,'AREA',6X,'VOL',3X,&
      'ST REL',6X,'VOL',4X,'SED C    SED C',3X,'COND',7X,'TIME'/10X,'#',8X&
      ,'ID',5X,'(ha)',5X,'(ha)',5X,'(mm)',5X,'(ha)',5X,'(mm)',5X,&
      '(d)',6X,'(mm)',4X,'____(g/m3)____',2X,'(mm/h)',7X,'(d)')
 2129 FORMAT(//6X,'SAID',2X,'YR',2X,'MO',4X,4(1X,2A4,1X),A10,&
      5(1X,A8,1X,11(1X,2A4,1X),4(A8,2X)))
 2142 FORMAT(//6X,'SAID',5X,'GIS',2X,'TIME',2X,'WSAha',4X,34(1X,2A4,1X),&
      ' WOCt/ha  ','PCTI200um',1X,'PCTI10um',2X,'PCTI2um',3X,'PCTO200um',1X,&
      'PCTO10um',2X,'PCTO2um',2X,5(2X,'YLDGt/ha',2X,'YLDFt/ha',17&
      (2X,2A4),5X,'CPNM-'))
 2143 FORMAT(5X,'RUN # = ',I4,2X,'SUBAREA FILE = ',A80)
 2151 FORMAT(T10,A8,5I8)
 2162 FORMAT(//6X,'RCID',6X,'GIS',2X,'TIME',3X,'WSAha',5X,35(1X,2A4,3X),&
      1X,'PCTI200um',3X,'PCTI10um',4X,'PCTI2um',5X,'PCTO200um',3X,&
      'PCTO10um',4X,'PCTO2um')
 2232 FORMAT(//T10,'SA#=',I8,1X,'ID=',I8)
 2281 FORMAT(10X,3F10.2)
 2284 FORMAT(/10X,'AVE ANNUAL VALUES'/11X,'SA',6X,'OWN',5X,'YLD1',1X,&
      'YLD2',1X,'YLN',2X,'YLP',2X,'COW',5X,'WSA',5X,'Q',7X,'Y',6X,'QP',&
      6X,'YP',6X,'QN',4X,'SSFN',4X,'RSFN',4X,'PRKN',6X,'YN',6X,'FP',4X,&
      'FN',3X,'MAP',3X,'AP0',3X,'APF',3X,'CSP'/8X,'#',6X,'ID',3X,&
      '# CROP',1X,'|--t/ha-| |-kg/ha-|',2X,'HD',6X,'HA',6X,'mm',4X,&
      't/ha',3X,'|-----------------------------kg/ha--------------------&
      ----------|',2X,'t/ha',1X,'|---g/t---|',2X,'g/m3')
 2309 FORMAT(1X,4F10.4,6F10.3)
 2313 FORMAT(3X,'WSA(ha)   CHL(km)  CHS(m/m)   FPL(km)     Q(mm)',5X,&
      'Y(t/ha) YN(kg/ha) YP(kg/ha) QN(kg/ha) QP(kg/ha)')
 2320 FORMAT(I4,6F8.0)
 2410 FORMAT(3X,'1',4X,'2',4X,'3',4X,'4',4X,'5',4X,'6',4X,'7',4X,'8',&
      4X,'9',3X,'10',3X,'11',3X,'12',3X,'13',3X,'14',3X,'15',3X,'16',3X,&
      '17',3X,'18',3X,'19',3X,'20')
 2420 FORMAT(5X,3I2,F8.1,F8.2)
 2450 FORMAT(T10,'PEAK RATE-EI ADJ FACTOR = ',F6.3/T10,'AVE N CONC IN RA&
      INFALL = ',F5.2,' ppm'/T10,'CONC OF N IN IRRIGATION WATER = ',&
      F6.1,' ppm'/T10,'MANURE APP FOR P UPTAKE RATE = ',F6.0,' kg/ha/y'/&
      T10,'MANURE APP FOR N UPTAKE RATE = ',F6.0,' kg/ha/y'/T10,&
      'MNUL = ',I3)
 2470 FORMAT(3I3,4I5,7F8.0)
 2480 FORMAT('+',T114,A4)
 2510 FORMAT(2F8.3)
 2520 FORMAT(T10,'PERIOD OF RECORD FOR P5MX =',F4.0,' Y')
 2540 FORMAT(I5,E13.5,2F10.3,2E13.5)
 2550 FORMAT(1X,A4,13F9.1,2X,A4)
 2560 FORMAT(T10,'FURROW DIKE SYSTEM SAFETY FACTOR = ',F5.2)
 2570 FORMAT(/1X,'-----MISCELLANEOUS PARAMETERS'//T10,'PARM',9X,'SCRP1I'&
      ,4X,'SCRP2I',4X,'SCRP1C',7X,'SCRP2C')
 2590 FORMAT(/T10,'IRRIGATION WATER APPLIED'/6X,'Y M D',2X,'VOL(mm)',&
      3X,'HUSC')
 2950 FORMAT(//1X,'-----WIND EROSION DATA')
 2960 FORMAT(T10,'FIELD LENGTH = ',F6.2,' km'/T10,'FIELD WIDTH = ',F6.2,&
      ' km'/T10,'FIELD ANGLE = ',F4.0,' deg'/T10,'WIND SPEED MOD EXP P&
      OWER PARM = ',F5.2/T10,'ACCELERATED WIND EROSION FACTOR = ',F7.3)
 3000 FORMAT(T10,'SOIL ALBEDO = ',F5.2/T10,'MAX NUMBER SOIL LAYERS = ',&
      I3/T10,'MIN THICKNESS FOR LAYER SPLITTING = ',F5.2,' m'/T10,&
      'MIN PROFILE THICKNESS--STOPS SIMULATION = ',F5.2,' m'/T10,&
      'SPLITTING PRIORITY THICKNESS = ',F5.2,' m'/T10,'BIOMASS/ORG C = '&
      ,F6.3/T10,'PASSIVE HUMUS/TOTAL HUMUS = ',F6.3/T10,'WEATHERING CODE&
       = ',F4.0/T10,'ORG C IN TOP .2 M = ',F6.3,' %'/T10,'CULT HISTORY =&
       ',F5.0,' Y')
 3001 FORMAT(T10,'WATER TABLE'/T15,'ANTECEDENT PERIOD FOR RF & PET &
      ACCOUNTING = ',I4,' d'/T15,'DEPTH(m)'/T15,'MIN= ',F6.2/T15,'MAX = ',&
      F6.2,/T15,'INITIAL = ',F6.2)
 3010 FORMAT(1X,A4,12F9.2,11X,A4)
 3050 FORMAT(/1X,'-----AVE MO VALUES')
 3070 FORMAT(/1X,'-----GENERATOR SEEDS AFTER',I3,' CYCLES'/(5X,12I12))
 3090 FORMAT(20A4)
 3100 FORMAT(20I4)
 3110 FORMAT(T10,'SIMULATION DURATION = ',I4,' Y'/T10,'BEGINNING DATE =&
      ',I4,2I2)
 3112 FORMAT(10F12.0)
 3120 FORMAT(10F8.0)
 3121 FORMAT(4X,I8,1X,I8,5F9.2,F9.4,F9.3,F9.4,F9.1,3F9.3,F9.1,F9.2,2F9.3,&
      F9.2,F9.1,1X,A20,1X,A20,1X,I4,F9.3,1X,A80)
 3122 FORMAT(4X,I8,1X,I8,F9.2,F9.0,2F9.2,F9.4,2F9.2,F9.3,F9.4,F9.3,F9.1,&
      F9.2,F9.4)
 3123 FORMAT(4X,I8,1X,I8,2F9.1,F9.0,F9.1,F9.0,F9.2,3F9.0,F9.3,F9.0)
 3140 FORMAT(T15,'RUNOFF RATIO = ',F6.3)
 3190 FORMAT(12F6.2,8X)
 3280 FORMAT(35X,'SIM DUR=',I4,' YR'/T11,'JAN',6X,'FEB',6X,'MAR',6X,&
      'APR',6X,'MAY',6X,'JUN',6X,'JUL',6X,'AUG',6X,'SEP',6X,'OCT',6X,&
      'NOV',6X,'DEC',6X,' YR')
 3282 FORMAT(9X,'SUBAREA'/8X,'#',6X,'ID',3X,'YR',1X,'YR#',T35,'JAN',10X,&
      'FEB',10X,'MAR',10X,'APR',10X,'MAY',10X,'JUN',10X,'JUL',10X,'AUG',&
      10X,'SEP',10X,'OCT',10X,'NOV',10X,'DEC',10X,'YR')
 3283 FORMAT(T34,'RFV',9X,'Q',7X,'SSF',7X,'YSD',17X,12(6X,A4)&
      /6X,'SA#',6X,'ID',3X,'Y',3X,'M',2X,'D',4X,'|------------(mm)------&
      ------|',2X,'(t/ha)',4X,'PSTN',8X,'|---------------------------&
      ----------------------------(g/ha)--------------------------------&
      --------------------------|')
 3284 FORMAT(3X,'YR ',21(4X,A4,2X))
 3285 FORMAT(/6X,'SA#',6X,'ID',4X,'Y   M   D  Y# ON# HD#',3X,'OPER',3X,&
      'CROP',2X,'YLDkg/ha',2X,'YSDkg/ha',2X,'AGPMt/ha',3X,'STLt/ha',3X,&
      'STDt/ha',3X,'CNLVg/g',3X,'CNDDg/g')
 3286 FORMAT(T52,'AP RATE',3X,'MN',5X,'NH3',6X,'ON',6X,'MP',6X,'OP'/6X,&
      'SA#',6X,'ID',4X,'Y M D  Y# ON# HD#',4X,'FERT',5X,'|--------------&
      ----(kg/ha)--------------------|')
 3287 FORMAT(/5X,'ORDER',1X,'|--SA--|',3X,'DP10'/8X,'#',4X,'#',2X,'ID',&
      3X,'(kg/ha)',5X,'FRACT',5X,'ACCUM')
 3288 FORMAT(4X,'CMD',5X,'IDO',5X,'ID#',3X,'Y   M   D',3X,'QPm3/s',7X,&
      'TPh',7X,'Qmm',5X,'SMQmm',5X,'SMHmm')
 3300 FORMAT(1X,A4,13F9.2,2X,A4)
 3360 FORMAT(T10,'TILE DRAIN DEPTH = ',F5.2,' m'/T10,'DRAIN TIME = ',F5.&
      2,' d'/T10,'DRAINAGE RATE = ',F6.1,' mm/h')
 3370 FORMAT(/T10,'FERTILIZER APPLIED'/T7,'DATE   ID',T32,'WT',3X,'DPTH'&
      ,4X,'|-----------FRACTION OF WT------------|'/6X,'Y M D',2X,'NO',&
      3X,'NAME',6X,'(kg/ha)',2X,'(m)',5X,'MIN N',3X,'NH3',5X,'ORG N',3X,&
      'MIN P',3X,'ORG P',3X,'HUSC')
 3380 FORMAT(3X,I4,2I2,I4,2X,A8,1X,F8.0,7F8.3)
 3381 FORMAT('1'/T5,'APEX1501',2X,I4,2I2,2X,2(I2,':'),I2)
 3390 FORMAT(T10,'COSTS'/T15,'N FERT = ',F5.2,' $/KG'/T15,'P FERT = ',&
      F5.2,' $/KG'/T15,'LIME = ',F5.2,' $/t',/T15,'IRR WATER = ',F5.2,&
      ' $/mm')
 3440 FORMAT(T2,A4,12F9.1,11X,A4)
 3460 FORMAT(T2,A4,12F9.3,11X,A4)
 3536 FORMAT(T15,'HERD ID=',I3,2X,'NUM=',I15,' HD',2X,'FEED AREA TIME=',&
      F6.2,' H/D',2X,'GRAZE LIMIT=',F5.2,' t/ha')
 3540 FORMAT(//1X,'____________________GENERAL INFORMATION______________&
      _______'/)
 3620 FORMAT(T15,'MAX ANNUAL VOL APPL TO A CROP = ',F6.0,' mm'/T15,'MIN &
      SINGLE APPL VOL = ',F6.0,' mm'/T15,'MAX SINGLE APPL VOL = ',F6.0,&
      ' mm')
 3630 FORMAT(T15,'SOIL-WATER TENSION TRIGGER = ',F5.0,' KPA'/T15,'MIN AP&
      PL INTERVAL = ',I3,' d')
 3650 FORMAT(/T10,'__________RAIN,',2(1X,A4,','),' ARE INPUT__________')
 3660 FORMAT(/T10,'__________RAIN,',3(1X,A4,','),' ARE INPUT__________')
 3670 FORMAT(/T10,'__________RAIN,',4(1X,A4,','),' ARE INPUT__________')
 3680 FORMAT(T15,'PLANT WATER STRESS TRIGGER = ',F5.2/T15,'MIN APPL INT&
      ERVAL = ',I3,' d')
 3730 FORMAT(T10,'LATITUDE = ',F7.2,' deg'/T10,'LONGITUDE = ',F7.2,&
      ' deg'/T10,'ELEVATION = ',F7.1,' m')
 3750 FORMAT(T10,'CO2 CONC IN ATMOSPHERE = ',F6.0,' ppm')
 3850 FORMAT(/T10,'PESTICIDES APPLIED'/T26,'RATE',4X,'KILL',4X,'COST'/&
      6X,'Y M D',2X,'NAME',6X,A7,3X,'EFF',4X,'($/KG)',3X,'HUSC')
 3860 FORMAT(5X,3I2,2X,A8,4F8.2)
 3880 FORMAT(/10X,A16,3F10.0,F10.2,F10.0,F10.2)
 3900 FORMAT(T43,'HALF LIFE(DAYS) WASH OFF',T82,'COST'/T13,'NAME',10X,&
      'SOLUBILITY',6X,'SOIL',3X,'FOLIAGE',2X,'FRACTION',6X,'KOC',5X,'($/&
      kg)')
 3910 FORMAT(/11X,10(2X,A8,2X))
 3920 FORMAT(5X,A4,10F10.0)
 3950 FORMAT(5X,A4,10F10.4)
 3970 FORMAT(T10,'HYDROLOGIC SOIL GROUP = ',A1/T10,'LAND USE NUMBER = ',I3&
      /T10,'RUNOFF CN2 = ',F4.1/T10,'SLP ADJ CN2 = ',F4.1/T10,&
      'PARM(92)_ADJ = ',F4.1/T10,'CN SCRV SCRP(30)= ',2F6.0/T10,&
      'CN CNSC(4)= ',2E13.5)
 4080 FORMAT(T15,'PAW DEFICIT TRIGGER = ',F5.0,' mm'/T15,'MIN APPL INTE'&
      ,'RVAL = ',I3,' d')
 4081  FORMAT(6X,'SA#',6X,'ID',3X,'YR YR#',40(4X,A4,2X))
 !4082 FORMAT(11X,'SA'/8X,'#',6X,'ID',4X,'Y   M   D ',5X,'CPNM',100(6X,A4))
 4082 FORMAT(11X,'SA'/8X,'#',6X,'ID',4X,'Y   M   D ',5X,100(6X,A4))
 4083 FORMAT(4X,'Y   M   D',100(3X,A4,3X))
 4084 FORMAT(7X,'SA',T31,'RFRA',7X,'QSA',8X,'QI',8X,'EV',8X,'SP',8X,&
      'QO',7X,'RSV',6X,'RSVP',6X,'RSVE',8X,'YI',8X,'YO',7X,'DEP',6X,'RSSA',&
      T220,'SW BY LAYER'/4X,'#',2X,'ID',4X,'Y   M   D',3X,'|----------------&
      --------------------------(M3)------------------------------------------|',&
      1X,'|-----------(t/ha)----------|',4X,'(ha)')
 4085 FORMAT(9X,'SA#',7X,'ID',5X,'WSAha',7X,'CN2',7X,'YW0',2X,'OCPDt/ha',&
      6X,'FSFN',6X,'FSFP',3X,'PRBmm/h',2X,'PRAVmm/h',5X,'TCMNh',3X,&
      'CYAVppm',3X,'CYMXppm',40(5X,A4,1X))
 4091 FORMAT(6X,'SA#',6X,'ID',3X,'YR',2X,'YR#',1X,'CPNM',4X,'YLDG',6X,&
      'YLDF',6X,'BIOM',8X,'WS',8X,'NS',8X,'PS',8X,'KS',8X,'TS',8X,'AS',&
      8X,'SS',6X,'ZNMN',7X,'ZQP',6X,'AP15',7X,'ZOC',6X,'OCPD',6X,'RSDP',&
      6X,'ARSD',6X,'IRGA',8X,'FN',8X,'FP',6X,'FNMN',6X,'FNMA',7X,'FNO',&
      7X,'FPL',7X,'FPO',6X,'YTHS',6X,'YWTH')
 4094 FORMAT(5X,'ISA = ',I4,2X,'BEGINNING RZSW = ',F10.1,' M3')
 5031 FORMAT(10X,A80)
 5034 FORMAT(1X,'RUN NAME  ',' SITE FILE  ','SOIL FILE   ',&
      'MANAGEMENT  ','RUN#IRO# WS#',' YR  RT#',38(4X,A4),4X,'OCPD',4X,&
      ' TOC',4X,'ITOC',4X,'APBC',4X,' TAP',4X,'TNO3',2X,'CROP',4X,&
      ' STD',4X,' STL',4X,' LAI',4X,'YLDG',4X,'YLDF',4X,'BIOM',4X,&
      'YLDN',4X,'YLDP',2X,'CROP',4X,' STD',4X,' STL',4X,' LAI',&
      4X,'YLDG',4X,'YLDF',4X,'BIOM',4X,'YLDN',4X,'YLDP')
END FUNCTION

!! ******************************************************************************************
!! simulationEnd
!! All MAIN PROGRAM instructions AFTER CALL BSIM
!! ******************************************************************************************
FUNCTION simulationEnd (p) BIND(C, name='simulationEnd')

      USE PARM
      USE HISAFE

      TYPE(Hisafe_),  intent(INOUT) :: p

      DIMENSION YTP(16)
      DIMENSION TWB(13)
      DIMENSION NX(100)
      CHARACTER(8)::ASOL
      CHARACTER(80)::ASOT

      CALL FROMHISAFE (p)

      DO I=1,100
          NX(I)=I
      END DO


      ADHY=360.*ADHY*DTHY/SUMA
      WRITE(KW(12),'(25X,A,F10.2,A)')'OUTFLOW = ',ADHY,' mm'
      SM1=0.
      SM2=0.
      SM3=0.
      SM4=0.
      SM5=0.
      SM6=0.
      SM7=0.
      SM8=0.
      SM9=0.
      SM11=0.
      SM19=0.
      SM71=0.
      SM18=0.
      SM42=0.
      SM43=0.
      SM46=0.
      SM66=0.
      SM68=0.
      SM69=0.
      SMP68=0.
      SMP69=0.
      SM81=0.
      SM82=0.
      SM104=0.
      SM105=0.
      SM95=0.
      SM96=0.
      SM134=0.
      SM147=0.
      IY=IY-1
      XYR=IY
      RR=0.
      KSO=MSO
      WRITE(KW(28),4993)SMSW
      SMOC=0.
      SRYF=0.
      SFTN=0.
      SRQN=0.
      TRMN=0.
      TRON=0.
      SMWS=0.
      SMNS=0.
      SMPS=0.
      SMKS=0.
      SMTS=0.
      SMAS=0.
      SMSS=0.
      SMPL=0.
      SMPQ=0.
      SMPY=0.
      SMY1=0.
      SMY2=0.
      SWFB=0.

      DO ISA=1,MSA !SUBAREA LOOP OUTPUT
          IDX=IDOA(ISA)
          WSAX=WSA(ISA)
          WSAX1=WSAX*10.
          IF(KFL(1)>0)CALL APAGE(1)
          CALL SPRNT
          DO I=1,12
              X1=MAX(1,IHRL(I,ISA))
              THRL(I,ISA)=THRL(I,ISA)/X1
              SRMX(I,ISA)=SRMX(I,ISA)/X1
          END DO
          SW(ISA)=1000.*Z(LID(NBSL(ISA),ISA),ISA)*UW(2)
          IF(KFL(MSO+1)>0)THEN
              I2=NBSL(ISA)
              KSO=KSO+1
              XCC=1.
              X1=0.
              X2=ISG(ISA)
              WRITE(ASOL,'(I8.8)')NBSA(ISA)
              ASOT=ASOL//".SOT"
              OPEN(KW(KSO),FILE=ASOT)
              TITSO(ISA)=ASOT
              WRITE(KW(KSO),526)ASOT,IYER,IMON,IDAY
              WRITE(KW(KSO),3114)SALB(ISA),X2,FFC(ISA),WTMN(ISA),WTMX(ISA),&
              WTBL(ISA),GWST(ISA),GWMX(ISA),RFT0,RFPK(ISA),TSLA(ISA),XIDS&
              (ISA),X1,XIDK(ISA),ZQT,ZF,ZTK,FBM(ISA),FHP(ISA),XCC
              WRITE(KW(KSO),3113)(Z(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(BDP(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SSF(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(9,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SAN(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SIL(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(SOIL(6,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(PH(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SMB(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(7,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(CAC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(CEC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(ROK(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(5,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(SOIL(1,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(RSD(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(13,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(PSP(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SATC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(HCL(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(SOIL(4,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(14,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(ECND(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(STFR(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(12,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(CPRV(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(CPRH(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLS(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLM(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLSL(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLSC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLMC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLSLC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WLSLNC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WBMC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WHSC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WHPC(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(WLSN(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(WLMN(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(WBMN(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WHSN(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3111)(WHPN(LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(16,LID(I,ISA),ISA),I=1,I2)
              WRITE(KW(KSO),3113)(SOIL(17,LID(I,ISA),ISA),I=1,I2)
          END IF
          IF(KFL(1)>0)THEN
              WRITE(KW(1),'(//1X,A/)')'____________________FINAL SOIL &
              PHYSICAL DATA____________________'
              CALL SOLIOP
              CALL APAGE(1)
              WRITE(KW(1),'(//1X,A/)')'____________________FINAL SOIL &
              CHEMICAL DATA____________________'
              CALL SOLIOC
              WRITE(KW(1),'(/T10,A,F7.1,A)')'ERODED SOIL THICKNESS = ',&
              THK(ISA),' mm'
              WRITE(KW(1),'(/T10,A,F7.2,A)')'FINAL WATER CONTENT OF &
              SNOW = ',SNO(ISA),' mm'
              SRSD(ISA)=SRSD(ISA)/XYR
              WRITE(KW(1),'(/T10,A,F6.1,A)')'AVE ANNUAL CROP RESIDUE = ',&
              SRSD(ISA),' T'
          END IF
          XTP(1)=SM(4,ISA)*WSAX1
          XTP(2)=SM(155,ISA)
          XTP(3)=SM(71,ISA)*WSAX1
          !II=MAX(IDOA(ISA),IDRO(ISA))
          !XTP(4)=SMH(35,II)*86400.
          XTP(5)=SM(18,ISA)*WSAX1
          XTP(6)=SM(110,ISA)*WSAX1
          XTP(7)=SM(19,ISA)*WSAX1
          FSNO=SNO(ISA)*WSAX1
          FSW=SW(ISA)*WSAX1
          FGWS=GWST(ISA)*WSAX1
          FSWL=SWLT(ISA)*WSAX1
          IPR=2
          IF(RSAE(ISA)>0.)THEN
             X5=SM(65,ISA)
             IPR=1
          ELSE
              X5=SM(117,IDOA(ISA))
          END IF
          IF(IDNF(ISA)>0)THEN
              X2=SMIO(IDNF(ISA))
          ELSE
              X2=0.
          END IF
          X1=SM(65,ISA)
          X3=SM(64,ISA)
          X4=SM(111,ISA)
          IF(PCOF(ISA)>0.)IPR=0
          IF(IPR<2)THEN
              SMP68=SMP68+SM(68,ISA)
              SMP69=SMP69+SM(69,ISA)
              CALL RESPQB(X3,SM(66,ISA),X1,SM(67,ISA),X4,RSVF(ISA),RSVB&
              (ISA),SM(146,ISA),ISA,KFL,KW,NBSA,MSO,IPR)
              CALL RESYB(SM(68,ISA),SM(69,ISA),SM(112,ISA),SM(70,ISA),&
              RSYF(ISA),RSYB(ISA),ISA,KFL,KW,NBSA,MSO,IPR)
              SRYF=SRYF+RSYF(ISA)
              TRMN=TRMN+RSO3(ISA)
              TRON=TRON+RSON(ISA)
          END IF
          ! PRINTOUT SA WATER BALANCE
          CALL HSWBL(XTP(1),X2,X5,XTP(2),SM(66,ISA),XTP(3),&
          XTP(5),XTP(6),XTP(7),SM(67,ISA),BSNO(ISA),FSNO,&
          SWBX(ISA),FSW,BRSV(ISA),RSV(ISA),BGWS(ISA),FGWS,FSWL,&
          ISA,KFL,KW,NBSA,MSO)
          SRYF=SRYF+RSYF(ISA)
          SWFB=SWFB+10.*WSAX*(SW(ISA)+GWST(ISA)+SNO(ISA))
          SFNT=ZNMN(ISA)+ZON(ISA)+STDN(JD(ISA),ISA)
          IF(DALG(ISA)>0.)THEN
              CALL HLGB(SM(22,ISA),SM(20,ISA),SM(23,ISA),SM(52,ISA),VLG&
              (ISA),VLGB(ISA),SM(21,ISA),ISA,KW,NBSA,MSO)
              II=IFED(IDFH(ISA),IDON(ISA))
              !CALL NLGB(SM(61,ISA),SM(62,II),SOFU,WTMB(ISA),WTMU(ISA),&
              !ISA,KW,NBSA,MSO)
              SM6=SM6+SM(62,II)
          END IF
          SM7=SM7+FCMP(ISA)*WSAX
          SM8=SM8+FCMN(ISA)*WSAX
          SM9=SM9+SM(4,ISA)*WSAX
          SM42=SM42+SM(42,ISA)*WSAX
          SM46=SM46+SM(46,ISA)*WSAX
          SM43=SM43+SM(43,ISA)*WSAX
          SM82=SM82+SM(82,ISA)*WSAX
          SM105=SM105+SM(105,ISA)*WSAX
          RFQN=SM(4,ISA)*RFNC
          SRQN=SRQN+RFQN*WSAX
          SM134=SM134+SM(134,ISA)*WSAX
          AD1=0.
          AD2=0.
          AD3=0.
          ADD=0.
          SUM=0.
          TOT=0.
          DO J=1,LC
              AD1=AD1+STDP(J,ISA)
              AD2=AD2+STDK(J,ISA)
              ADD=ADD+STDN(J,ISA)
              TOT=TOT+UP1(J,ISA)
              SUM=SUM+UN1(J,ISA)
              AD3=AD3+UK1(J,ISA)
          END DO
          FTN=ZNMN(ISA)+ZNMA(ISA)+ZON(ISA)+ADD+STDON(ISA)+SUM+ZNOU(ISA)
          SFTN=SFTN+FTN*WSA(ISA)
          ! PRINTOUT SA N BALANCE
          CALL NBL(BTN(ISA),RFQN,SM(37,ISA),SM(134,ISA),SM(38,ISA),SM&
          (39,ISA),SM(40,ISA),SM(42,ISA),SM(53,ISA),TYN(ISA),SM(46,ISA),&
          SM(54,ISA),SM(55,ISA),SM(43,ISA),FTN,SSIN(ISA),SM(47,ISA),SM&
          (82,ISA),SM(84,ISA),SM(89,ISA),SM(91,ISA),SM(105,ISA),ISA,1,&
          KFL,KW,NBSA,MSO,JRT)
          IF(JRT>0.AND.KFL(1)>0)WRITE(KW(1),4088)ZNMN(ISA),ZNMA(ISA),&
          ZON(ISA),ADD,STDON(ISA),SUM,ZNMU(ISA),ZNOU(ISA)
          CALL NCBL(BTC(ISA),SM(77,ISA),SM(136,ISA),SM(75,ISA),SM(76,ISA),&
          SM(74,ISA),SM(99,ISA),SM(73,ISA),SM(140,ISA),SM(101,ISA),SM(102,&
          ISA),ZOC(ISA),ISA,KW,NBSA,MSO,JRT)
          IF(JRT>0.AND.KFL(1)>0)WRITE(KW(1),637)ZLSC(ISA),ZLMC(ISA),&
          ZBMC(ISA),ZHSC(ISA),ZHPC(ISA)
          FTP=ZPML(ISA)+ZPMU(ISA)+ZPMS(ISA)+ZPMA(ISA)+ZPO(ISA)+ZFOP(ISA)+&
          ZPOU(ISA)+AD1+STDOP(ISA)+TOT
          ! PRINTOUT SA P BALANCE
          CALL NBL(BTP(ISA),0.,SM(48,ISA),SM(135,ISA),SM(49,ISA),0.,SM&
          (51,ISA),0.,SM(56,ISA),TYP(ISA),0.,SM(57,ISA),0.,0.,FTP,0.,0.,&
          0.,0.,SM(90,ISA),SM(92,ISA),SM(106,ISA),ISA,2,KFL,KW,NBSA,MSO,JRT)
          IF(JRT>0.AND.KFL(1)>0)WRITE(KW(1),4089)ZPML(ISA),ZPMA(ISA),&
          ZPMS(ISA),ZPO(ISA),ZFOP(ISA),AD1,STDOP(ISA),TOT,ZPMU(ISA),&
          ZPOU(ISA)
          FTK=ZSK(ISA)+ZEK(ISA)+ZFK(ISA)+AD2+STDOK(ISA)+AD3
          CALL NBL(BTK(ISA),0.,SM(149,ISA),SM(150,ISA),SM(151,ISA),0.,&
          SM(152,ISA),0.,0.,TYK(ISA),0.,SM(148,ISA),0.,0.,FTK,0.,0.,0.,&
          0.,0.,0.,0.,ISA,3,KFL,KW,NBSA,MSO,JRT)
          IF(JRT>0.AND.KFL(1)>0)WRITE(KW(1),639)ZSK(ISA),ZEK(ISA),&
          ZFK(ISA),AD2,STDOK(ISA),AD3
          CALL SLTB(SM(129,ISA),SM(132,ISA),SM(133,ISA),SM(131,ISA),SM&
          (130,ISA),SLT0(ISA),ZSLT(ISA),ISA,NBSA,KW,MSO)
          XQRB=NQRB(IDX)
          XCN=JCN(ISA)
          XX=XQRB+.01
          PRAX=PRAV(IDX)/XX
          PRSD(ISA)=PRSD(ISA)-PRAV(IDX)*PRAX
          IF(PRSD(ISA)>0.)PRSD(ISA)=SQRT(PRSD(ISA)/XX)
          CYSD(ISA)=CYSD(ISA)-CYAV(ISA)*CYAV(ISA)/XX
          CYAV(ISA)=CYAV(ISA)/XX
          IF(CYSD(ISA)>0.)CYSD(ISA)=SQRT(CYSD(ISA)/XX)
          QRBQ(ISA)=QRBQ(ISA)/XX
          X5=ERAV(IDX)/XX
          TCAX=TCAV(IDX)/XX
          ! DETERMINE AVE ANNUAL VALUES
          SMY(13,ISA)=0.
          DO I=1,7
              VAR(I,ISA)=0.
          END DO
          !!!XGCO2(ISA)=0.
          YTX(ISA)=0.
          DO I=1,12
              TR(I,ISA)=TR(I,ISA)/XYR
              RR(I)=RR(I)+TR(I,ISA)*WSA(ISA)
              TSN(I,ISA)=TSN(I,ISA)/XYR
              TSY(I,ISA)=TSY(I,ISA)/XYR
              TYW(I,ISA)=TYW(I,ISA)/XYR
              TQ(I,ISA)=TQ(I,ISA)/XYR
              TCN(I,ISA)=TCN(I,ISA)/XYR
              TYON(I,ISA)=TYON(I,ISA)/XYR
              TYTP(I,ISA)=TYTP(I,ISA)/XYR
              TQP(I,ISA)=TQP(I,ISA)/XYR
              TQPU(I,ISA)=TQPU(I,ISA)/XYR
              TQN(I,ISA)=TQN(I,ISA)/XYR
              VAR(4,ISA)=VAR(4,ISA)+TYTP(I,ISA)
              VAR(6,ISA)=VAR(6,ISA)+TQP(I,ISA)
              VAR(8,ISA)=VAR(8,ISA)+TQP(I,ISA)
              TXMX(I,ISA)=TXMX(I,ISA)/XYR
              TXMN(I,ISA)=TXMN(I,ISA)/XYR
              TSR(I,ISA)=TSR(I,ISA)/XYR
              TCVF(I,ISA)=TCVF(I,ISA)/(TEI(I,ISA)+1.E-20)
              CX(I,ISA)=CX(I,ISA)/XYR
              VAR(3,ISA)=VAR(3,ISA)+CX(I,ISA)
              TEI(I,ISA)=TEI(I,ISA)/XYR
              SMY(I,ISA)=SRD(I,ISA)/XYR
              YTX(ISA)=YTX(ISA)+SRD(I,ISA)
              SET(I,ISA)=SET(I,ISA)/XYR
              TET(I,ISA)=TET(I,ISA)/XYR
              ASW(I,ISA)=ASW(I,ISA)/XYR
              QIN(I,ISA)=QIN(I,ISA)/XYR
              TRHT(I,ISA)=TRHT(I,ISA)/XYR
              TAMX(I,ISA)=TAMX(I,ISA)/XYR
              VAR(7,ISA)=VAR(7,ISA)+QIN(I,ISA)
              VAR(2,ISA)=VAR(2,ISA)+TAMX(I,ISA)
              VAR(1,ISA)=VAR(1,ISA)+ASW(I,ISA)
              SMY(13,ISA)=SMY(13,ISA)+SMY(I,ISA)
          END DO
          SM(14,ISA)=SM(14,ISA)/(XCN+1.E-10)
          SM(25,ISA)=SM(25,ISA)/(SM(24,ISA)+1.E-20)
          VAR(1,ISA)=VAR(1,ISA)/12.
          DO K=1,13
              SM(K,ISA)=SM(K,ISA)/XYR
          END DO
          DO K=15,24
              SM(K,ISA)=SM(K,ISA)/XYR
          END DO
          DO K=26,NSM
              SM(K,ISA)=SM(K,ISA)/XYR
          END DO
          X1=RWSA(IDRO(ISA))
          SM(64,ISA)=.1*SM(64,ISA)/X1
          SM(65,ISA)=.1*SM(65,ISA)/X1
          SM(68,ISA)=SM(68,ISA)/X1
          SM(69,ISA)=SM(69,ISA)/X1
          SM(70,ISA)=SM(70,ISA)/X1
          SM(117,ISA)=SM(117,ISA)/WSAX1
          IF(NDP>0)THEN
              IF(KFL(1)>0)THEN
                  CALL APAGE(1)
                  WRITE(KW(1),'(//1X,A/)')'______________PESTICIDE SUMMARY &
                  TABLE________________'
                  WRITE(KW(1),460)
              END IF
              CALL PSTSUM(1.,XYR,NX,ISA)
              DO K=1,NDP
                  SMPQ(ISA)=SMPQ(ISA)+SMAP(2,K,IDX)
                  SMPY(ISA)=SMPY(ISA)+SMAP(5,K,IDX)
                  SMPL(ISA)=SMPL(ISA)+GWPS(K,ISA)
              END DO
          END IF
          PPX(1,ISA)=SM(38,ISA)
          PPX(2,ISA)=SM(39,ISA)
          PPX(3,ISA)=SM(40,ISA)
          PPX(4,ISA)=SM(49,ISA)
          X1=CST1(ISA)/XYR
          X2=VALF1(ISA)/XYR
          IF(KFL(1)>0)THEN
              CALL APAGE(1)
              WRITE(KW(1),'(//1X,A/)')'____________________SUMMARY TABLE&
              ____________________'
              WRITE(KW(1),3320)PRB(IDX),PRAX,PRSD(ISA),QRQB(ISA),QRBQ(ISA),&
              NQRB(IDX)
              WRITE(KW(1),417)TCAX,TCMN(IDX),TCMX(IDX)
              WRITE(KW(1),448)CYAV(ISA),CYMX(ISA),CYSD(ISA)
              AD1=0.
              DO K=1,10
                  AD1=AD1+CNDS(K,ISA)
              END DO
              DO K=1,10
                  CNDS(K,ISA)=CNDS(K,ISA)/AD1
              END DO
              WRITE(KW(1),2460)(CNDS(K,ISA),K=1,10)
          END IF
          IF(LUN(ISA)==35)THEN
              DWOC(ISA)=0.
          ELSE
              IF(KFL(23)>0)THEN
                  DO J=1,6
                      XTP(J)=0.
                      DO I=1,NBSL(ISA)
                          ISL=LID(I,ISA)
                          SMS(J,ISL,ISA)=SMS(J,ISL,ISA)/(SMS(11,ISL,ISA)&
                          +1.E-5)
                          XTP(J)=XTP(J)+SMS(J,ISL,ISA)
                      END DO
                  END DO
                  DO J=7,10
                      XTP(J)=0.
                      DO I=1,NBSL(ISA)
                          ISL=LID(I,ISA)
                          SMS(J,ISL,ISA)=SMS(J,ISL,ISA)/XYR
                          XTP(J)=XTP(J)+SMS(J,ISL,ISA)
                      END DO
                  END DO
                  DO I=1,NBSL(ISA)
                      ISL=LID(I,ISA)
                      XYP(ISL)=WOC(ISL,ISA)-XZP(6,ISL,ISA)
                      YTP(ISL)=WON(ISL,ISA)-XZP(12,ISL,ISA)
                  END DO
                  DWOC(ISA)=ZOC(ISA)-XZP(6,11,ISA)
                  YTP(11)=ZON(ISA)-XZP(12,11,ISA)
                  SMOC=SMOC+.001*WSA(ISA)*DWOC(ISA)
                  WRITE(KW(23),635)ISA,NBSA(ISA),(SID(LORG(LID(J,ISA),&
                  ISA)),J=1,10),SID(11)
                  XNS(ISA)=NBSL(ISA)
                  DO J=1,6
                      XTP(J)=XTP(J)/XNS(ISA)
                  END DO
                  WRITE(KW(23),649)'   Z',(Z(LID(I,ISA),ISA),I=1,10),Z(LID(10,ISA),ISA),' Z   '
                  WRITE(KW(23),649)' SWF',(SMS(1,LID(I,ISA),ISA),I=1,10),XTP(1),' SWF '
                  WRITE(KW(23),649)'TEMP',(SMS(2,LID(I,ISA),ISA),I=1,10),XTP(2),' TEMP'
                  WRITE(KW(23),649)'SWTF',(SMS(3,LID(I,ISA),ISA),I=1,10),XTP(3),' SWTF'
                  WRITE(KW(23),649)'TLEF',(SMS(4,LID(I,ISA),ISA),I=1,10),XTP(4),' TLEF'
                  WRITE(KW(23),649)'SPDM',(SMS(5,LID(I,ISA),ISA),I=1,10),XTP(5),' SPDM'
                  WRITE(KW(23),576)'RSDC',(SMS(7,LID(I,ISA),ISA),I=1,10),XTP(7),' RSDC'
                  WRITE(KW(23),576)'RSPC',(SMS(8,LID(I,ISA),ISA),I=1,10),XTP(8),' RSPC'
                  WRITE(KW(23),576)'RNMN',(SMS(9,LID(I,ISA),ISA),I=1,10),XTP(9),' RNMN'
                  WRITE(KW(23),576)'DNO3',(SMS(10,LID(I,ISA),ISA),I=1,10),XTP(10),' DNO3'
                  WRITE(KW(23),576)'HSC0',(XZP(1,LID(I,ISA),ISA),I=1,10),XZP(1,11,ISA),' HSC0'
                  WRITE(KW(23),576)'HSCF',(WHSC(LID(I,ISA),ISA),I=1,10),ZHSC(ISA),' HSCF'
                  WRITE(KW(23),576)'HPC0',(XZP(2,LID(I,ISA),ISA),I=1,10),XZP(2,11,ISA),' HPC0'
                  WRITE(KW(23),576)'HPCF',(WHPC(LID(I,ISA),ISA),I=1,10),ZHPC(ISA),' HPCF'
                  WRITE(KW(23),576)'LSC0',(XZP(3,LID(I,ISA),ISA),I=1,10),XZP(3,11,ISA),' LSC0'
                  WRITE(KW(23),576)'LSCF',(WLSC(LID(I,ISA),ISA),I=1,10),ZLSC(ISA),' LSCF'
                  WRITE(KW(23),576)'LMC0',(XZP(4,LID(I,ISA),ISA),I=1,10),XZP(4,11,ISA),' LMC0'
                  WRITE(KW(23),576)'LMCF',(WLMC(LID(I,ISA),ISA),I=1,10),ZLMC(ISA),' LMCF'
                  WRITE(KW(23),576)'BMC0',(XZP(5,LID(I,ISA),ISA),I=1,10),XZP(5,11,ISA),' BMC0'
                  WRITE(KW(23),576)'BMCF',(WBMC(LID(I,ISA),ISA),I=1,10),ZBMC(ISA),' BMCF'
                  WRITE(KW(23),576)'WOC0',(XZP(6,LID(I,ISA),ISA),I=1,10),XZP(6,11,ISA),' WOC0'
                  WRITE(KW(23),576)'WOCF',(WOC(LID(I,ISA),ISA),I=1,10),ZOC(ISA),' WOCF'
                  WRITE(KW(23),576)'DWOC',(XYP(LID(I,ISA)),I=1,10),DWOC(ISA),' DWOC'
                  WRITE(KW(23),576)'HSN0',(XZP(7,LID(I,ISA),ISA),I=1,10),XZP(7,11,ISA),' HSN0'
                  WRITE(KW(23),576)'HSNF',(WHSN(LID(I,ISA),ISA),I=1,10),ZHSN(ISA),' HSNF'
                  WRITE(KW(23),576)'HPN0',(XZP(8,LID(I,ISA),ISA),I=1,10),XZP(8,11,ISA),' HPN0'
                  WRITE(KW(23),576)'HPNF',(WHPN(LID(I,ISA),ISA),I=1,10),ZHPN(ISA),' HPNF'
                  WRITE(KW(23),576)'LSN0',(XZP(9,LID(I,ISA),ISA),I=1,10),XZP(9,11,ISA),' LSN0'
                  WRITE(KW(23),576)'LSNF',(WLSN(LID(I,ISA),ISA),I=1,10),ZLSN(ISA),' LSNF'
                  WRITE(KW(23),576)'LMN0',(XZP(10,LID(I,ISA),ISA),I=1,10),XZP(10,11,ISA),' LMN0'
                  WRITE(KW(23),576)'LMNF',(WLMN(LID(I,ISA),ISA),I=1,10),ZLMN(ISA),' LMNF'
                  WRITE(KW(23),576)'BMN0',(XZP(11,LID(I,ISA),ISA),I=1,10),XZP(11,11,ISA),' BMN0'
                  WRITE(KW(23),576)'BMNF',(WBMN(LID(I,ISA),ISA),I=1,10),ZBMN(ISA),' BMNF'
                  WRITE(KW(23),576)'WON0',(XZP(12,LID(I,ISA),ISA),I=1,10),XZP(12,11,ISA),' WON0'
                  WRITE(KW(23),576)'WONF',(WON(LID(I,ISA),ISA),I=1,10),ZON(ISA),' WONF'
                  WRITE(KW(23),576)'DWON',(YTP(LID(I,ISA)),I=1,10),YTP(11),' DWON'
                  WRITE(KW(23),649)'C/N0',(XZP(13,LID(I,ISA),ISA),I=1,10),XZP(13,11,ISA),' C/N0'
                  DO I=1,100
                      XTP(I)=0.
                  END DO
                  DO I=1,NBSL(ISA)
                      ISL=LID(I,ISA)
                      XTP(ISL)=WOC(ISL,ISA)/WON(ISL,ISA)
                  END DO
                  XTP(11)=ZOC(ISA)/ZON(ISA)
                  WRITE(KW(23),649)'C/NF',(XTP(LID(I,ISA)),I=1,10),XTP(11),' C/NF'
              END IF
          END IF
          IF(KFL(1)>0)THEN
              WRITE(KW(1),6050)
              ! PRINTOUT SUMMARY MONTHLY
              WRITE(KW(1),6280)IY
              WRITE(KW(1),6300)HED(1),(TXMX(I,ISA),I=1,12),SM(1,ISA),HED(1)
              WRITE(KW(1),6300)HED(2),(TXMN(I,ISA),I=1,12),SM(2,ISA),HED(2)
              WRITE(KW(1),6550)HED(4),(TR(I,ISA),I=1,12),SM(4,ISA),HED(4)
              WRITE(KW(1),6300)'DAYP',(SMY(I,ISA),I=1,13),'DAYP'
              WRITE(KW(1),6550)HED(16),(TSN(I,ISA),I=1,12),SM(16,ISA),HED(16)
              WRITE(KW(1),6550)HED(13),(TQ(I,ISA),I=1,12),SM(13,ISA),HED(13)
              WRITE(KW(1),6550)HED(14),(TCN(I,ISA),I=1,12),SM(14,ISA),HED(14)
              WRITE(KW(1),6550)'DAYQ',(CX(I,ISA),I=1,12),VAR(3,ISA),'DAYQ'
              WRITE(KW(1),6300)'RZSW',(ASW(I,ISA),I=1,12),VAR(1,ISA),'RZSW'
              WRITE(KW(1),3200)HED(24),(TEI(I,ISA),I=1,12),SM(24,ISA),HED(24)
              WRITE(KW(1),3301)HED(25),(TCVF(I,ISA),I=1,12),SM(25,ISA),HED(25)
              WRITE(KW(1),6300)HED(NDVSS),(TSY(I,ISA),I=1,12),SM(NDVSS,ISA),HED(NDVSS)
              WRITE(KW(1),6300)HED(37),(TYON(I,ISA),I=1,12),SM(37,ISA),HED(37)
              WRITE(KW(1),6300)HED(48),(TYTP(I,ISA),I=1,12),SM(48,ISA),HED(48)
              WRITE(KW(1),6300)HED(38),(TQN(I,ISA),I=1,12),SM(38,ISA),HED(38)
              WRITE(KW(1),6300)HED(49),(TQP(I,ISA),I=1,12),SM(49,ISA),HED(49)
              WRITE(KW(1),6300)HED(11),(TET(I,ISA),I=1,12),SM(11,ISA),HED(11)
        !     WRITE(KW(1),2550)'DAYW',(TAMX(I,ISA),I=1,12),VAR(2,ISA),'DAYW'
              WRITE(KW(1),6550)HED(33),(TRHT(I,ISA),I=1,12),SM(33,ISA),HED(33)
              WRITE(KW(1),6300)HED(36),(TYW(I,ISA),I=1,12),SM(36,ISA),HED(36)
              WRITE(KW(1),6300)HED(19),(QIN(I,ISA),I=1,12),VAR(7,ISA),HED(19)
              WRITE(KW(1),3200)HED(10),(SET(I,ISA),I=1,12),SM(10,ISA),HED(10)
              WRITE(KW(1),3200)HED(3),(TSR(I,ISA),I=1,12),SM(3,ISA),HED(3)
              WRITE(KW(1),3)'RAMX',(SRMX(I,ISA),I=1,12),'RAMX'
              WRITE(KW(1),6010)'HRLT',(THRL(I,ISA),I=1,12),'HRLT'
              WRITE(KW(1),'(/1X,A)')'-----AVE ANNUAL VALUES'
              WRITE(KW(1),3030)IY,(HED(KA(K)),SM(KA(K),ISA),K=5,NKA),'COST',X1,&
              'RTRN',X2
              WRITE(KW(1),3770)(HED(JC(K)),PPX(K,ISA),K=1,NJC)
          END IF
          X4=SM(53,ISA)+SM(54,ISA)+SM(55,ISA)
          X1=SM(56,ISA)+SM(57,ISA)
          FSFN(ISA)=FSFN(ISA)/(X4*XYR+1.E-5)
          FSFP(ISA)=FSFP(ISA)/(X1*XYR+1.E-5)
          X5=SM(40,ISA)
          SM81=SM81+SM(81,ISA)*WSAX
          SM(81,ISA)=.001*SM(81,ISA)
          LD1=LID(1,ISA)
          X2=1000.*WPML(LD1,ISA)/WT(LD1,ISA)
          X3=100.*SM(49,ISA)/(SM(13,ISA)+.1)
          XYRD=XYR*365.25
          STKR(ISA)=STKR(ISA)/XYRD
          PSTM(ISA)=PSTM(ISA)/XYR
          K1=0
          DO K=1,LC
              !IF(NCR(K,ISA)==0)CYCLE
        !     K=LY(IRO(ISA),J,ISA)
              XX=MIN(NCR(K,ISA),IY)+1.E-10
              TETG(K,ISA)=1000.*TYL1(K,ISA)/(TETG(K,ISA)+1.E-10)
              SMY1(ISA)=SMY1(ISA)+TYL1(K,ISA)
              SMY2(ISA)=SMY2(ISA)+TYL2(K,ISA)
              TYL1(K,ISA)=TYL1(K,ISA)/XX
              TYL2(K,ISA)=TYL2(K,ISA)/XX
              TYLN(K,ISA)=TYLN(K,ISA)/XX
              TYLP(K,ISA)=TYLP(K,ISA)/XX
              TYLK(K,ISA)=TYLK(K,ISA)/XX
              TDM(K,ISA)=TDM(K,ISA)/XX
              THU(K,ISA)=THU(K,ISA)/XX
              XX=IY
              TRA(K,ISA)=TRA(K,ISA)/XX
              TRD(K,ISA)=TRD(K,ISA)/XX
              TCAW(K,ISA)=TCAW(K,ISA)/XX
              TVIR(K,ISA)=TVIR(K,ISA)/XX
              TFTN(K,ISA)=TFTN(K,ISA)/XX
              TFTP(K,ISA)=TFTP(K,ISA)/XX
              TFTK(K,ISA)=TFTK(K,ISA)/XX
              SMWS(ISA)=SMWS(ISA)+TSFC(1,K,ISA)
              SMNS(ISA)=SMNS(ISA)+TSFC(2,K,ISA)
              SMPS(ISA)=SMPS(ISA)+TSFC(3,K,ISA)
              SMKS(ISA)=SMKS(ISA)+TSFC(4,K,ISA)
              SMTS(ISA)=SMTS(ISA)+TSFC(5,K,ISA)
              SMAS(ISA)=SMAS(ISA)+TSFC(6,K,ISA)
              SMSS(ISA)=SMSS(ISA)+TSFC(7,K,ISA)
              DO L=1,7
                  TSFC(L,K,ISA)=TSFC(L,K,ISA)/XX
              END DO
              DO L=1,3
                  STDA(L,K,ISA)=STDA(L,K,ISA)/XX
              END DO
              IF(PSTM(ISA)<1.E-10)THEN
                  X6=1.
              ELSE
                  X6=PSTM(ISA)
              END IF
              ! PRINTOUT CROP SUMMARY
              IF(KFL(1)>0)WRITE(KW(1),326)CPNM(K),TYL1(K,ISA),TYL2(K,ISA),&
              TDM(K,ISA),TYLN(K,ISA),TYLP(K,ISA),TYLK(K,ISA),TFTN(K,ISA),&
              TFTP(K,ISA),TFTK(K,ISA),TVIR(K,ISA),TCAW(K,ISA),TETG(K,ISA),&
              TRA(K,ISA),THU(K,ISA),X6
              WRITE(KW(1),577)(TSFC(L,K,ISA),L=1,7),(STDA(L,K,ISA),L=1,3)
              IF(K1>0)THEN
                  IF(KFL(2)>0.AND.SM(81,ISA)>0.)WRITE(KW(2),2282)ISA,NBSA(ISA),&
                  IDON(ISA),CPNM(K),TYL1(K,ISA),TYL2(K,ISA),TYLN(K,ISA),TYLP(K,ISA)
              ELSE
                  IF(KFL(2)>0.AND.SM(81,ISA)>0.)WRITE(KW(2),2282)ISA,NBSA(ISA),&
                  IDON(ISA),CPNM(K),TYL1(K,ISA),TYL2(K,ISA),TYLN(K,ISA),TYLP&
                  (K,ISA),STKR(ISA),WSAX,SM(13,ISA),SM(29,ISA),SM(49,ISA),&
                  SM(48,ISA),SM(38,ISA),SM(39,ISA),SM(80,ISA),X5,SM(37,ISA),&
                  X1,X4,SM(81,ISA),PDPL0(ISA),PDPLC(ISA),X3
                  K1=1
              END IF
              SM2=SM2+TYLP(K,ISA)*WSAX
              SM3=SM3+TYLN(K,ISA)*WSAX
          END DO
          X2=NWDA(ISA)
          YW0=100.*WCF*TVGF(ISA)/(X2+1.E-5)
          ! PRINTOUT SUBAREA SUMMARY
          IF(KFL(3)>0)WRITE(KW(3),498)ISA,NBSA(ISA),WSA(ISA),CN2(ISA),YW0,&
          OCPD(ISA),FSFN(ISA),FSFP(ISA),PRB(IDX),PRAX,TCAX,CYAV(ISA),&
          CYMX(ISA),(SM(KY(K),ISA),K=1,NKY),SM(NDVSS,ISA)
          SM1=SM1+X1*WSAX
          SM4=SM4+X4*WSAX
          SM5=SM5+X5*WSAX
          SM71=SM71+SM(71,ISA)*WSAX
          SM104=SM104+SM(104,ISA)*WSAX
          SM11=SM11+SM(11,ISA)*WSAX
          SM18=SM18+SM(18,ISA)*WSAX
          SM19=SM19+SM(19,ISA)*WSAX
          SM66=SM66+SM(66,ISA)
          SM95=SM95+SM(95,ISA)*WSAX
          SM96=SM96+SM(96,ISA)*WSAX
          SM147=SM147+SM(147,ISA)
      END DO !!!END LOOP



      SM96=XYR*SM96
      WRITE(KW(1),461)
      IF(NDP>0)THEN
          WRITE(KW(1),460)
          IF(MSA>1)CALL PSTSUM(SUMA,XYR,NX,NCMD)
      END IF
      AVRF=SM9/(SUMA*XYR)
      DO I=1,12
          RR(I)=RR(I)/SUMA
          RR(13)=RR(13)+RR(I)
      END DO
      SM9=10.*SM9
      X1=YTX(1)-1.
      X2=XYR*SM(100,1)
      SX2=SDRF-X2*X2/YTX(1)
      SDX=SQRT(SX2/(X1+1.E-10))
      X3=X2/YTX(1)
      IF(KFL(35)>0)THEN
          PCTH=0.
          PCT=0.
          NTX=0
          DO IDO=1,NCMD
              SMH(7,IDO)=1.E5*SMH(6,IDO)/(SMH(2,IDO)*RWSA(IDO)+1.E-10)
              DO K=1,NSH
                  SMH(K,IDO)=SMH(K,IDO)/XYR
                  IF(K<5.OR.K>32)THEN
                      X1=366-NYD
                      SMH(K,IDO)=SMH(K,IDO)/X1
                  END IF
              END DO
          END DO
      END IF
      AD5=0.
      AD1=0.
      AD2=0.
      DO ISA=1,MSA
          IF(SM(141,ISA)>0.)THEN
              AD1=AD1+SM(141,ISA)*WSA(ISA)
              AD2=AD2+WSA(ISA)
          END IF
          AD5=AD5+TYN(ISA)*WSA(ISA)
          X2=XYR*SM(4,ISA)
          SX2=SDVR(ISA)-X2*X2/(YTX(ISA)+1.E-10)
          SDX=SQRT(SX2/X1)
          X3=X2/YTX(ISA)
          IF(KFL(34)>0)THEN
              DO I=1,MSA
                  I1=NBSA(IBSA(I))
                  I2=NISA(I1)
                  II=IDOA(I2)
                  X1=.001*ZOC(I2)
                  WRITE(KW(34),859)I1,NBYR,IGC,WSA(I2),SM(4,I2),SM(5,I2),&
                  SM(6,I2),SM(18,I2),SM(10,I2),SM(11,I2),RZSW(I2),&
                  SM(16,I2),SM(71,I2),SM(13,I2),SM(15,I2),SM(72,I2),&
                  SM(117,I2),SM(14,I2),SM(1,I2),SM(2,I2),SM(59,I2),&
                  SM(3,I2),SM(27,I2),SM(31,I2),SM(53,I2),SM(54,I2),&
                  SM(55,I2),SM(56,I2),SM(57,I2),SM(43,I2),SM(42,I2),&
                  SM(37,I2),SM(119,I2),SM(38,I2),SM(49,I2),SM(118,I2),&
                  SM(39,I2),SM(80,I2),X1,(TYL1(LY(IRO(I2),J,I2),I2),&
                  TYL2(LY(IRO(I2),J,I2),I2),(TSFC(L,J,I2),L=1,7),CPNM&
                  (LY(IRO(I2),J,I2)),J=1,NCP(IRO(I2),I2))
              END DO
          END IF
          IF(KFL(40)>0)THEN
              DO J=1,NCP(IRO(ISA),ISA)
                  YTP(J)=1000.*TYL2(LY(IRO(ISA),J,ISA),ISA)
              END DO
              WRITE(KW(40),857)NBSA(ISA),SM(4,ISA),SM(13,ISA),SM(117,ISA),&
              SM(16,ISA),(CPNM(LY(IRO(ISA),J,ISA)),(TSFC(L,J,ISA),L=1,7),&
              YTP(J),SM(141,ISA),J=1,NCP(IRO(ISA),ISA))
          END IF
          IF(KFL(35)==0.OR.MSA==1)CYCLE
          I1=NBSA(IBSA(ISA))
          I2=NISA(I1)
          IF(IEXT(I2)>0)THEN
              II=IDOA(I2)
              X2=WSA(I2)
              I3=II
          ELSE
              II=IDOA(I2)-1
              X2=RWSA(II)+WSA(I2)
              I3=II+2
          END IF
          IF(NTX(II)>0)CYCLE
          WRITE(KW(35),5005)I1,II,NBYR,X2,SMH(1,II),SMH(2,I3),SMH(33,II),&
          SMH(35,I3),(SMH(K,II),K=3,NSH-3),(PCTH(J,II),J=1,NSZ),(PCT(J,II),&
          J=1,NSZ)
          NTX(II)=1
      END DO
      AD1=AD1/(AD2+1.E-10)
      IF(KFL(39)>0)THEN
          DO I=1,NCMO
              II=ICMO(I)
              WRITE(KW(39),472)II,IYR,MO,RWSA(II),SMH(1,II),SMH(2,II),&
              SMH(33,II),SMH(34,II),(SMH(K,II),K=3,NSH-2)
          END DO
      END IF
      DO IWI=1,NWP
          X1=NWPD(IWI)
          RTO=X1/XYRD
      END DO
      IF(NDP>0.AND.(KFL(1)>0.OR.KFL(38)>0))THEN
          CALL APAGE(0)
          WRITE(KW(1),18)
          WRITE(KW(1),3281)NBYR
          YTP=0.
          DO K=1,NDP
              WRITE(KW(1),3060)PSTN(K)
              SUM=0.
              DO I=1,12
                  SMRP(5,K,I)=SMRP(5,K,I)/XYR
                  SUM=SUM+SMRP(5,K,I)
              END DO
              WRITE(KW(1),3302)HEDP(1),(SMRP(5,K,I),I=1,12),SUM,HEDP(1)
              DO J=1,2
                  J1=J+2
                  XTP(J)=0.
                  XTP(J1)=0.
                  DO I=1,12
                      SMRP(J,K,I)=SMRP(J,K,I)/XYR
                      SMRP(J1,K,I)=SMRP(J1,K,I)/XYR
                      XTP(J1)=XTP(J1)+SMRP(J1,K,I)
                      XTP(J)=XTP(J)+SMRP(J,K,I)
                  END DO
                  YTP(J1)=YTP(J1)+XTP(J1)
                  YTP(J)=YTP(J)+XTP(J)
                  ! PRINTOUT REACH PESTICIDE SUMMARY MONTHLY
                  WRITE(KW(1),3302)HDRP(J),(SMRP(J,K,I),I=1,12),XTP(J),HDRP(J)
                  WRITE(KW(1),3302)HDRP(J1),(SMRP(J1,K,I),I=1,12),XTP(J1),HDRP(J1)
              END DO
          END DO
          CALL APAGE(0)
      END IF
      SUM=0.
      DO I=1,LC
          TCPY(I)=TCPY(I)/(TCPA(I)+1.E-10)
          TCPA(I)=TCPA(I)/XYR
          SUM=SUM+TCPA(I)
      END DO
      WRITE(KW(1),5007)
      IF(KFL(10)>0)WRITE(KW(10),5007)
      DO I=1,LC
          X1=TCPA(I)/(SUM+1.E-10)
          WRITE(KW(1),5008)CPNM(I),TCPA(I),X1,TCPY(I)
          IF(KFL(10)>0)WRITE(KW(10),5008)CPNM(I),TCPA(I),X1,TCPY(I)
      END DO
      WRITE(KW(1),'(/T10,A,F10.0/T10,A,F10.2,A)')'AREA WEIGHTED GRAZING DAYS = ',&
      AD1,'GRAZING AREA = ',AD2,' ha'
      IF(NGN==0)THEN
          NAD=0
          DO IWI=1,NWP
              NAD=NAD+IAD(IWI)
          END DO
          IF(NAD>0)THEN
              AD1=0.
              DO IWI=1,NWP
                  XTP(IWI)=REAL(IAD(IWI))/REAL(NAD)
                  RFSG(IWI)=RFSG(IWI)/XYR
                  AD1=AD1+RFSG(IWI)
              END DO
              WRITE(KW(1),'(/T10,A,10(1X,I4,F10.4))')'FRACTION WPM1 USED IN SPATIAL &
              GENERATOR = ',(IWI,XTP(IWI),IWI=1,NWP)
              WRITE(KW(1),'(/T10,A,10(1X,I4,F10.0))')'PCP GENERATED BY &
              WPM1 = ',(IWI,RFSG(IWI),IWI=1,NWP)
              WRITE(KW(1),'(T10,A,F10.0)')' TOT = ',AD1
          END IF
      END IF
      IF(KFL(10)>0)THEN
          WRITE(KW(10),'(/T42,A)')'AVE ANNUAL DATA'
          WRITE(KW(10),18)
          WRITE(KW(10),3281)NBYR
          WRITE(KW(10),6550)HED(4),(RR(I),I=1,12),RR(13),HED(4)
      END IF
      IF(NAQ>0.AND.KFL(1)>0)THEN
          SUM=0.
          DO I=1,16
              XTP(I)=NWDR(I)
              SUM=SUM+XTP(I)
          END DO
          DO I=1,16
              XTP(I)=XTP(I)/SUM
          END DO
          WRITE(KW(1),5012)(XTP(I),I=1,16)
          WRITE(KW(1),5016)
          TOT=0.
          ADD=0.
          DO I=1,MSA
              TOT=TOT+PM10(I)
              ADD=ADD+EM10(I)
          END DO
          CALL ASORT1(PM10,NX,MSA)
          SUM=0.
          DO I=1,MSA
              I1=NX(I)
              X1=PM10(I1)/TOT
              SUM=SUM+X1
              X2=PM10(I1)/WSA(I1)
              WRITE(KW(1),5017)I1,NBSA(I1),X2,X1,SUM
          END DO
          WRITE(KW(1),5018)TOT,ADD
      END IF
      WRITE(KW(1),18)
      WRITE(KW(1),6280)NBYR
      WRITE(KW(1),6550)HED(4),(RR(I),I=1,12),RR(13),HED(4)
      DO J=1,10
          J1=J+10
          XTP(J)=0.
          XTP(J1)=0.
          DO I=1,12
              SMR(J,I)=SMR(J,I)/XYR
              SMR(J1,I)=SMR(J1,I)/XYR
              IF(J1==2)SMR(J1,I)=.1*SMR(J1,I)
              XTP(J1)=XTP(J1)+SMR(J1,I)
              XTP(J)=XTP(J)+SMR(J,I)
          END DO
          ! PRINTOUT REACH SUMMARY MONTHLY
          WRITE(KW(1),6300)HEDR(J),(SMR(J,I),I=1,12),XTP(J),HEDR(J)
          WRITE(KW(1),6300)HEDR(J1),(SMR(J1,I),I=1,12),XTP(J1),HEDR(J1)
          IF(KFL(10)==0)CYCLE
          WRITE(KW(10),3301)HEDR(J),(SMR(J,I),I=1,12),XTP(J),HEDR(J)
          WRITE(KW(10),3301)HEDR(J1),(SMR(J1,I),I=1,12),XTP(J1),HEDR(J1)
      END DO
      XTP(21)=0.
      DO I=1,12
          SMR(21,I)=SMR(21,I)/XYR
          XTP(21)=XTP(21)+SMR(21,I)
      END DO
      IF(KFL(32)>0)THEN
          X1=XTP(6)-XTP(21)
          SMOC=SMOC/SUMA
          WRITE(KW(32),2157)XTP(11),XTP(13),XTP(21),X1,XTP(14),SMOC
      END IF
      CALL APAGE(0)
      WRITE(KW(1),'(//1X,A/)')'______________ROUTING REACH SUMMARY &
      TABLE_____________'
      WRITE(KW(1),'(T24,A)')'INDIVIDUAL STORM DATA'
      WRITE(KW(1),35)
      K=0
      DO J=1,NCMD
          IF(NQRB(J)==0)CYCLE
          XX=NQRB(J)
          PRAV(J)=PRAV(J)/XX
          TCAV(J)=TCAV(J)/XX
          DRAV(J)=DRAV(J)/XX
          ERAV(J)=ERAV(J)/XX
          J1=NQRB(J)/NBYR
          X1=SRCH(7,J)/XX
          IF(ICDT(J)/=1)THEN
              ! PRINTOUT REACH STORM SUMMARY
              WRITE(KW(1),24)CMDX(ICDT(J)),J,RWSA(J),J1,TCAV(J),DRAV(J),&
              ERAV(J),X1,PRAV(J),PRB(J)
          ELSE
              K=K+1
              X2=MAX(NBCT(K),NBCF(K))
              X3=MAX(NBFT(K),NBFF(K))
              VCHA(K)=VCHA(K)/(X2+1.E-10)
              VFPA(K)=VFPA(K)/(X3+1.E-10)
              WRITE(KW(1),4087)CMDX(ICDT(J)),J,K,NBSA(K),RWSA(J),J1,TCAV(J),&
              DRAV(J),ERAV(J),X1,PRAV(J),PRB(J),NBCF(K),VCHA(K),VCHB(K)&
              ,NBFF(K),VFPA(K),VFPB(K)
          END IF
      END DO
      WRITE(KW(1),'(///T42,A)')'AVE ANNUAL DATA'
      WRITE(KW(1),36)
      IF(KFL(10)>0)WRITE(KW(10),36)
      K=0
      SDEP=0.
      SDEG=0.
      DO J=1,NCMD
          DO I=7,25
              SRCH(I,J)=SRCH(I,J)/XYR
          END DO
          SDEP=SDEP+SRCH(13,J)*RWSA(J)
          SDEG=SDEG+SRCH(14,J)*RWSA(J)
          IF(ICDT(J)==1)THEN
              K=K+1
              I1=NISA(NBSA(K))
              WRITE(KW(1),2302)CMDX(ICDT(J)),J,K,NBSA(K),RWSA(J),SRCH&
              (7,J),SRCH(15,J),SRCH(19,J),SRCH(20,J),SRCH(16,J),SRCH(23,J),&
              SRCH(8,J),(SRCH(I,J),I=13,14),SRCH(24,J),SRCH(25,J),&
              SRCH(9,J),SRCH(11,J),SRCH(10,J),SRCH(12,J),SRCH(17,J),&
              SRCH(21,J),SRCH(22,J),SRCH(18,J)
              IF(KFL(10)>0)WRITE(KW(10),2302)CMDX(ICDT(J)),J,K,NBSA(K),&
              RWSA(J),SRCH(7,J),SRCH(15,J),SRCH(19,J),SRCH(20,J),SRCH(16,&
              J),SRCH(23,J),SRCH(8,J),(SRCH(I,J),I=13,14),SRCH(24,J),&
              SRCH(25,J),SRCH(9,J),SRCH(11,J),SRCH(10,J),SRCH(12,J),&
              SRCH(17,J),SRCH(21,J),SRCH(22,J),SRCH(18,J)
              CYCLE
          END IF
          IF(ICDT(J)==4)THEN
              X1=.1/RWSA(J)
              X2=X1*RSVP(I1)
              X3=X1*RSVE(I1)
              J1=I1
              J2=NBSA(K)
          ELSE
              X2=0.
              X3=0.
              J1=0
              J2=0
          END IF
          ! PRINTOUT REACH SUMMARY
          WRITE(KW(1),2302)CMDX(ICDT(J)),J,J1,J2,RWSA(J),SRCH(7,J),&
          SRCH(15,J),SRCH(19,J),SRCH(20,J),SRCH(16,J),SRCH(23,J),&
          SRCH(8,J),(SRCH(I,J),I=13,14),SRCH(24,J),SRCH(25,J),SRCH(9,J),&
          SRCH(11,J),SRCH(10,J),SRCH(12,J),SRCH(17,J),SRCH(21,J),&
          SRCH(22,J),SRCH(18,J),X2,X3
          IF(KFL(10)>0)WRITE(KW(10),2302)CMDX(ICDT(J)),J,J1,J2,RWSA(J),&
          SRCH(7,J),SRCH(15,J),SRCH(19,J),SRCH(20,J),SRCH(16,J),&
          SRCH(23,J),SRCH(8,J),(SRCH(I,J),I=13,14),SRCH(24,J),SRCH(25,J),&
          SRCH(9,J),SRCH(11,J),SRCH(10,J),SRCH(12,J),SRCH(17,J),&
          SRCH(21,J),SRCH(22,J),SRCH(18,J),X2,X3
      END DO
      IF(KFL(38)>0)THEN
          ADRF=0.
          ADY2=0.
          ADR2=0.
          ADYW=0.
          ADST=0.
          ADDC=0.
          ADWS=0.
          ADKS=0.
          ADNS=0.
          ADPS=0.
          ADTS=0.
          ADAS=0.
          ADSS=0.
          ADLN=0.
          ADLP=0.
          ADPL=0.
          ADY1=0.
          ADRC=0.
          ADFU=0.
          ADFN=0.
          ADFP=0.
          ARFP=0.
          ADRP=0.
          AYWP=0.
          ADPQ=0.
          ADPY=0.
          NTX=0
          DO ISA=1,MSA
              WSAX=WSA(ISA)
              ADRF=ADRF+SM(4,ISA)*WSAX
              ADR2=ADR2+SM(31,ISA)*WSAX
              ADYW=ADYW+SM(36,ISA)*WSAX
              ADLN=ADLN+SM(40,ISA)*WSAX
              ADLP=ADLP+SM(51,ISA)*WSAX
              ADRC=ADRC+SM(25,ISA)*WSAX
              ARFP=ARFP+SM(142,ISA)*WSAX
              ADRP=ADRP+SM(143,ISA)*WSAX
              AYWP=AYWP+SM(135,ISA)*WSAX
              SMWS(ISA)=SMWS(ISA)/XYR
              ADWS=ADWS+SMWS(ISA)*WSAX
              SMNS(ISA)=SMNS(ISA)/XYR
              ADNS=ADNS+SMNS(ISA)*WSAX
              SMPS(ISA)=SMPS(ISA)/XYR
              ADPS=ADPS+SMPS(ISA)*WSAX
              SMKS(ISA)=SMKS(ISA)/XYR
              ADKS=ADKS+SMKS(ISA)*WSAX
              SMTS(ISA)=SMTS(ISA)/XYR
              ADTS=ADTS+SMTS(ISA)*WSAX
              SMAS(ISA)=SMAS(ISA)/XYR
              ADAS=ADAS+SMAS(ISA)*WSAX
              SMSS(ISA)=SMSS(ISA)/XYR
              ADSS=ADSS+SMSS(ISA)*WSAX
              SMY1(ISA)=SMY1(ISA)/XYR
              ADY1=ADY1+SMY1(ISA)*WSAX
              SMY2(ISA)=SMY2(ISA)/XYR
              ADY2=ADY2+SMY2(ISA)*WSAX
              SMPL(ISA)=SMPL(ISA)/XYR
              ADPL=ADPL+SMPL(ISA)*WSAX
              SMPQ(ISA)=SMPQ(ISA)/XYR
              ADPQ=ADPQ+SMPQ(ISA)*WSAX
              SMPY(ISA)=SMPY(ISA)/XYR
              ADPY=ADPY+SMPY(ISA)*WSAX
              SMFU(ISA)=SMFU(ISA)/XYR
              ADFU=ADFU+SMFU(ISA)*WSAX
              SMST(ISA)=SMST(ISA)/XYR
              ADST=ADST+SMST(ISA)*WSAX
              DWOC(ISA)=.001*DWOC(ISA)
              ADDC=ADDC+DWOC(ISA)*WSAX
              X4=SM(53,ISA)+SM(54,ISA)+SM(55,ISA)
              ADFN=ADFN+X4*WSAX
              X1=SM(56,ISA)+SM(57,ISA)
              ADFP=ADFP+X1*WSAX
              I1=NBSA(IBSA(ISA))
              I2=NISA(I1)
              IF(IEXT(I2)>0)THEN
                  II=IDOA(I2)
                  X2=WSA(I2)
                  I3=II
              ELSE
                  II=IDOA(I2)-1
                  X2=RWSA(II)+WSA(I2)
                  I3=II+2
              END IF
              IF(NTX(II)>0)CYCLE
              CM3MM=3155760./X2
              SMH(2,I3)=SMH(2,I3)*CM3MM
              SMH(35,I3)=SMH(35,I3)*CM3MM
              SMH(6,I3)=SMH(6,I3)/X2
              SMH(13,I3)=SMH(13,I3)/X2
              SMH(9,I3)=SMH(9,I3)/X2
              SMH(19,I3)=SMH(19,I3)/X2
              SMH(11,I3)=SMH(11,I3)/X2
              SMH(27,I3)=SMH(27,I3)/X2
              SMH(29,I3)=SMH(29,I3)/X2
              WRITE(KW(38),586)ISA,NBSA(ISA),SM(4,ISA),SM(13,ISA),SM(117,ISA),&
              SM(31,ISA),SM(NDVSS,ISA),SM(36,ISA),SMY1(ISA),SMY2(ISA),SMWS(ISA),&
              SMNS(ISA),SMPS(ISA),SMKS(ISA),SMTS(ISA),SMAS(ISA),SMSS(ISA),X4,X1,&
              SM(18,ISA),SMST(ISA),SMFU(ISA),DWOC(ISA),SM(38,ISA),SM(39,ISA),&
              SM(84,ISA),SM(47,ISA),SM(80,ISA),SM(96,ISA),SM(37,ISA),&
              SM(134,ISA),SM(46,ISA),SM(42,ISA),SM(43,ISA),SM(49,ISA),&
              SM(142,ISA),SM(143,ISA),SM(51,ISA),SM(48,ISA),SM(135,ISA),&
              SMPQ(ISA),SMPL(ISA),SMPY(ISA),SMH(2,I3),SMH(35,I3),SMH(6,I3),&
              SMH(13,I3),SMH(9,I3),SMH(19,I3),SMH(11,I3),SMH(27,I3),SMH(29,I3)
              NTX(II)=1
          END DO
          IF(MSA>1)THEN
              ADRF=ADRF/SUMA
              ADY2=ADY2/SUMA
              ADY1=ADY1/SUMA
              ADR2=ADR2/SUMA
              ADYW=ADYW/SUMA
              ADST=ADST/SUMA
              ADDC=ADDC/SUMA
              ADWS=ADWS/SUMA
              ADNS=ADNS/SUMA
              ADPS=ADPS/SUMA
              ADKS=ADKS/SUMA
              ADTS=ADTS/SUMA
              ADAS=ADAS/SUMA
              ADSS=ADSS/SUMA
              ADLN=ADLN/SUMA
              ADLP=ADLP/SUMA
              ADPL=ADPL/SUMA
              ADRC=ADRC/SUMA
              ADFU=ADFU/SUMA
              ADFN=ADFN/SUMA
              ADFP=ADFP/SUMA
              ARFP=ARFP/SUMA
              ADRP=ADRP/SUMA
              AYWP=AYWP/SUMA
              XX=SUMA*XYR
              ADIR=SM18/XX
              ADDP=SM96/XX
              ADWN=SM134/XX
              ADVO=SM46/XX
              ADDN=SM42/XX
              ADFX=SM43/XX
              ADPQ=ADPQ/XX
              WRITE(KW(38),587)ADRF,SRCH(7,NCMD),XTP(12),ADR2,SRCH(8,NCMD),&
              ADYW,ADY1,ADY2,ADWS,ADNS,ADPS,ADKS,ADTS,ADAS,ADSS,ADFN,ADFP,&
              ADIR,ADST,ADFU,ADDC,SRCH(11,NCMD),SRCH(17,NCMD),SRCH(21,NCMD),&
              SRCH(22,NCMD),SRCH(18,NCMD),ADDP,SRCH(9,NCMD),ADWN,ADVO,ADDN,&
              ADFX,SRCH(12,NCMD),ARFP,ADRP,ADLP,SRCH(10,NCMD),AYWP,ADPQ,&
              ADPL,ADPY
          END IF
      END IF
      IF(KFL(14)>0)THEN
          WRITE(KW(14),373)RWSA(1),RCHL(1),RCHS(1),RFPL(1),(SRCH(I,1)&
          ,I=7,12)
          WRITE(KW(14),373)SUMA,RCHL(MSA),RCHS(MSA),RFPL(MSA)&
          ,(SRCH(I,NCMD),I=7,12)
      END IF
      X11=10.*SUMA
      SM1=SM1/SUMA
      SM2=SM2/SUMA
      SM3=SM3/SUMA
      SM4=SM4/SUMA
      SM5=SM5/SUMA
      SM81=.001*SM81/SUMA
      X2=100.*SRCH(12,NCMD)/(SRCH(7,NCMD)+.1)
      TMAF=.001*TMAF
      TMPD=.001*TMPD
      ! PRINTOUT MANURE FILE
      XX=X11*XYR
      XX1=SUMA*XYR
      AD4=0.
      TSMU=0.
      TSMN=0.
      TLMN=0.
      IF(TMAF>0..OR.TMPD>0.)THEN
          WRITE(KW(2),2303)'TOTAL',SM3,SM2,NMC,SUMA,SRCH(7,NCMD),SRCH(8,NCMD),&
          SRCH(12,NCMD),SRCH(10,NCMD),SRCH(11,NCMD),SRCH(17,NCMD),SRCH(18,&
          NCMD),SM5,SRCH(9,NCMD),SM1,SM4,SM81,X2
          WRITE(KW(2),'(//T6,A)')'OW ID #  AREA(ha)  MAP(t/ha/y)'
          DO IOW=1,NBON
              IF(OWSA(IOW)<1.E-10)CYCLE
              OMAP(IOW)=.001*OMAP(IOW)/(XYR*OWSA(IOW))
              WRITE(KW(2),2308)IOW,OWSA(IOW),OMAP(IOW)
              TSMU=TSMU+SMNU(IOW)
              IF(IDFA(1,IOW)>0)THEN
                  ISA=IDFA(1,IOW)
                  KF=IDFT(2,ISA)
                  TSMN=TSMN+SMNU(IOW)*(FN(KF)+FNO(KF))
                  DO J=1,NBSL(ISA)
                      ISL=LID(J,ISA)
                      AD4=AD4+RSDM(ISL,ISA)*(FN(KF)+FNO(KF))*WSA(ISA)
                  END DO
                  KF=IDFT(1,ISA)
                  TLMN=TLMN+WTMU(ISA)*(FN(KF)+FNO(KF))
              END IF
          END DO
          TSMN=1000.*TSMN
          TOT=0.
          AD1=0.
          TWMP=0.
          AD2=0.
          AD3=0.
          DO ISA=1,MSA
              SUM=0.
              DO J=1,NBSL(ISA)
                  ISL=LID(J,ISA)
                  SUM=SUM+RSDM(ISL,ISA)
              END DO
              X2=SUM*WSA(ISA)
              TOT=TOT+X2
              AD1=AD1+SM(103,ISA)*WSA(ISA)
              TWMP=TWMP+WTMU(ISA)
              IF(IDFH(ISA)>0)THEN
                  AD2=AD2+X2
                  SMMU(ISA)=SMMU(ISA)*WSA(ISA)
                  AD3=AD3+SMMU(ISA)
              END IF
          END DO
          AD1=AD1*XYR
          X1=SUMA*XYR*SRCH(24,NCMD)
          TWMP=.001*TWMP
          SM6=.001*SM6
          SM7=.001*SM7
          SM8=.001*SM8
          DDF1=TMPD+TWMB-TWMP-TSMU-TOT-X1-AD1
          PER=100.*DDF1/(TMPD+1.E-10)
          WRITE(KW(2),2304)PER,DDF1,TMPD,TWMB,TWMP,TSMU,TOT,X1,AD1
          DF=TMPD-TMAF+TWMB-TWMP-TSMU-SYMU-SOFU-AD3-AD2
          PER=100.*DF/(TMPD+1.E-5)
          WRITE(KW(2),102)PER,DF,TMPD,TMAF,TWMB,TWMP,TSMU,SYMU,SOFU,AD3,AD2
          WRITE(KW(2),103)SM6,SM7,SM8
      END IF
      AD4=1000.*AD4
      TWB(1)=XX1*SRCH(9,NCMD)
      TWB(2)=XX1*SRCH(11,NCMD)
      TWB(3)=XX1*SRCH(17,NCMD)
      TWB(4)=XX1*SRCH(18,NCMD)
      TWB(5)=XX1*SRCH(21,NCMD)
      TWB(6)=XX1*SRCH(22,NCMD)
      DF=TBTN-SM134+SRQN-SM42+SM43-SM46+TFNO+TFMN+TFMA-SM82-SM96+SM105-TWB(1)&
      -TWB(2)-TWB(3)-TWB(4)-TWB(5)-TWB(6)-AD5-SFTN-TLMN-TSMN-TRMN-TRON-AD4
      PER=100.*DF/SFTN
      WRITE(KW(1),'(//T10,A/)')'TOTAL N BALANCE'
      WRITE(KW(1),2314)PER,DF,TBTN,SRQN,SM42,SM43,SM46,TFNO,TFMN,TFMA,SM82,&
      SM96,SM105,SM134,(TWB(I),I=1,6),AD5,SFTN,TLMN,TSMN,TRMN,TRON,AD4
      IF(IHY>0)WRITE(KW(1),2299)SQVL(NCMD),SHYD(NCMD)
      TWB(1)=SM9
      TWB(2)=XX*SRCH(7,NCMD)
      XY1=10.*XYR
      TWB(3)=XY1*SM71
      TWB(4)=XY1*SM11
      TWB(6)=XY1*SM18
      TWB(11)=XY1*SM19
      TWB(12)=XY1*SM104
      TWB(5)=XY1*WSA(MSA)*SM(15,MSA)
      TWB(7)=XX*SRCH(16,NCMD)
      TWB(8)=XX*SRCH(19,NCMD)
      TWB(9)=XX*SRCH(20,NCMD)
      TWB(10)=XX*SRCH(23,NCMD)
      TWB(13)=SM147*XYR
      DF=SWBB+TWB(1)-TWB(4)-TWB(3)-TWB(5)+TWB(6)-TWB(7)-TWB(2)-SWFB-TWB&
      (8)-TWB(9)-TWB(10)+TWB(11)+TWB(12)-TWB(13)
      PER=100.*DF/SWFB
      WRITE(KW(1),'(//T10,A/)')'TOTAL WATER BALANCE'
      WRITE(KW(1),2312)PER,DF,SWBB,TWB,SWFB,SMSQ
      SWBB=SWFB
      SWFB=0.
      TWB(1)=.1*XX*XTP(3)
      TWB(2)=.1*XX*XTP(13)
      SDEP=XYR*SDEP
      SDEG=XYR*SDEG
      DF=SRYB+SDEG-SDEP+TWB(1)-TWB(2)-SRYF
      PER=100.*DF/(TWB(1)+1.E-10)
      WRITE(KW(1),'(//T10,A/)')'TOTAL SEDIMENT BALANCE'
      WRITE(KW(1),2315)PER,DF,SRYB,TWB(1),TWB(2),SDEP,SDEG,SRYF

      write(*,*) 'END SIMULATION'

      CALL TOHISAFE (p)

      return

      3 FORMAT(1X,A4,12F9.0,11X,A4)
     18 FORMAT(//1X,'______________WATERSHED SUMMARY TABLE________________&
        _'/T10,'AVE ANNUAL SUM OF SUBAREA OUTFLOWS/TOTAL WATERSHED OUTFLOW'/)
     24 FORMAT(8X,A2,I8,19X,F12.2,I4,F8.2,F8.3,F8.2,3F8.1)
     35 FORMAT(T89,'_____QRB______'/T16,'OUT',12X,'SA',11X,'WSA',3X,&
        '# FLOWS',2X,'TC',5X,'DR',7X,'ER',6X,'Q',6X,'MEAN',4X,'MAX',5X,&
        '# CH',3X,'VCHA',4X,'VCHB',5X,'# FP',3X,'VFPA',4X,'VFPB'/T8,'CMD',&
        5X,'ID#',9X,'#',7X,'ID',6X,'(ha)',4X,'/y',3X,'(h)',T82,'(mm)',3X,&
        '|---(mm/h)---|',3X,'FLOWS',2X,'|----(m/s)---|',3X,'FLOWS',2X,&
        '|----(m/s)---|')
     36 FORMAT(T16,'OUT',12X,'SA',12X,'WSA',6X,'Q',6X,'SSF',5X,'QRF',5X,&
        'QDR',5X,'RTF',4X,'PIPE',6X,'Y',6X,'DEP',5X,'DEG',4X,'YMNU',6X,&
        'YC',6X,'YN',6X,'QN',6X,'YP',6X,'QP',4X,'SSFN',4X,'QRFN',4X,'QDRN',&
        4X,'RTFN'/T8,'CMD',5X,'ID#',9X,'#',7X,'ID',7X,'(ha)',4X,'|--------&
        ------------(mm)-------------------|',2X,'|----------------(t/ha)-&
        --------------|',1X,'|------------------------(kg/ha)-------------&
        ----------------|')
    102 FORMAT(/5X,'MANURE APPLICATION BALANCE (T)'/5X,'PER =',E13.6,2X,&
        'DF  =',E13.6,2X,'TWMP=',E13.6,2X,'TMAP=',E13.6,2X,'TWMB=',E13.6/&
        5X,'TWMF=',E13.6,2X,'TSMU=',E13.6,2X,'YMFA=',E13.6,2X,'LGOF=',E13.6,&
        2X,'MNFA=',E13.6/5X,'RSFA=',E13.6)
    103 FORMAT(/5X,'LIQUID MANURE APPLIED (T)=',E13.6//5X,'COMMERCIAL FERT &
        APPLIED (T)'/10X,'P=',E13.6/10X,'N=',E13.6)
    326 FORMAT(/2X,A4,1X,'YLD=',F5.1,'/',F5.1,2X,'BIOM=',F5.1,'t/ha',2X,&
        'YLN=',F5.0,2X,'YLP=',F5.0,2X,'YLK=',F5.0,2X,'FN=',F5.0,2X,'FP=',&
        F5.0,2X,'FK=',F5.0,'kg/ha'/T7,'IRGA=',F5.0,2X,'CAW=',F6.0,'mm',&
        2X,'WUEF=',F5.2,'kg/mm',2X,'RAD=',F7.0,'Mj/m2',2X,'HU=',F7.0,2X,&
        'PSTF=',F5.2)
    373 FORMAT(10E13.5)
    417 FORMAT(/1X,'-----TIME OF CONCENTRATION STATS(h)'/T10,'MEAN = ',&
        F6.2,5X,'MIN = ',F6.2,5X,'MAX = ',F6.2)
    448 FORMAT(/1X,'-----SEDIMENT OF CONCENTRATION STATS(g/m3)'/T10,'MEAN&
        = ',F10.0,5X,'MAX = ',F10.0,5X,'STDV = ',F10.0)
    460 FORMAT(/1X,'-----FREQUENCY & DURATION OF PESTICIDE LOSS(g/ha)'/T35&
        ,'DURATION(d)'/20X,'1',12X,'4',11X,'21',11X,'60',11X,'90')
    461 FORMAT(///1X,'______________WATERSHED SUMMARY TABLE_____________')
    472 FORMAT('REACH',I5,I9,I6,50E12.4)
    498 FORMAT(4X,I8,1X,I8,51F10.2)
    526 FORMAT(T10,A8,2X,3I4)
    576 FORMAT(1X,A4,11F10.0,A5)
    577 FORMAT(T7,'STRESS (BIOM) WATER=',F5.1,2X,'N=',F5.1,2X,'P=',F5.1,2X&
        'K=',F5.1,2X,'TEMP=',F5.1,2X,'AIR=',F5.1,2X,'SALT=',F5.1,5X,&
        '(ROOT) BD=',F5.1,2X,'ALSAT=',F5.1,2X,'TEMP=',F5.1,'D')
    586 FORMAT(1X,2I8,100F10.3)
    587 FORMAT(8X,'WATERSHED',100F10.3)
    635 FORMAT(/10X,'SA#= ',I8,1X,'ID= ',I8/T35,'SOIL LAYER NO'/2X,11(6X,&
        A4))
    637 FORMAT(5X,'ELSC=',E13.6,2X,'ELMC=',E13.6,2X,'EBMC=',E13.6,2X,&
        'EHSC=',E13.6,2X,'EHPC=',E13.6)
    639 FORMAT(5X,'ESK =',E13.6,2X,'EEK =',E13.6,2X,'EFK =',E13.6,2X,&
        'ESDK=',E13.6/5X,'ESOK=',E13.6,2X,'EUK1=',E13.6)
    649 FORMAT(1X,A4,11F10.3,A5)
    857 FORMAT(I9,1X,'AVEAN',4X,4F10.2,10X,5(A10,50X,7F10.2,20X,2F10.2))
    859 FORMAT(1X,'AVEAN',I4,I9,I5,1X,E9.3,6F10.2,F10.0,13F10.2,5F10.1,&
        9F10.2,F10.1,60X,6(2F10.2,90X,7F10.2,A10))
   2157 FORMAT(1X,6F10.3)
   2282 FORMAT(1X,2I8,I4,1X,A4,2F5.1,3F5.0,F10.3,F6.0,8F8.3,2F6.0,F6.1,&
        2F6.0,F6.2)
   2299 FORMAT(//T10,'FLOOD ROUTING SUMMARY WATERSHED OUTLET'/T10,&
        'SUM QVOL = ',E16.6,' mm',2X,'SUM HVOL = ',E16.6,' mm')
   2302 FORMAT(8X,A2,I8,2X,I8,1X,I8,F12.2,6F8.1,20F8.2)
   2304 FORMAT(//5X,'MANURE BALANCE (T)'/5X,'PER =',E13.6,2X,'DF  =',E13.6,&
        2X,'TMPD=',E13.6,2X,'TWMB=',E13.6,2X,'TWMF=',E13.6/5X,'TSMU=',E13.6,&
        2X,'RSDM=',E13.6,2X,'YMNU=',E13.6,2X,'MNMU=',E13.6)
   2303 FORMAT(4X,A5,27X,2F5.0,I5,F10.3,F6.0,8F8.3,2F6.0,F6.1,12X,3F6.2)
   2308 FORMAT(7X,I4,2F10.2)
   2312 FORMAT(5X,'PER =',D13.6,2X,'DF  =',D13.6,2X,'BSW =',D13.6,2X,&
        'PCP =',D13.6,2X,'Q   =',D13.6,2X,'DPRK=',D13.6/5X,'ET  =',D13.6,&
        2X,'SSF =',D13.6,2X,'IRG =',D13.6,2X,'RSSF=',D13.6,2X,'QRF =',&
        D13.6,2X,'QDR =',D13.6/5X,'CPVH=',D13.6,2X,'QIN =',D13.6,2X,&
        'PSOQ=',D13.6,2X,'EVRT',D13.6/5X,'FSW =',D13.6,2X,E16.6)
   2314 FORMAT(5X,'PER =',D13.6,2X,'DF  =',D13.6,2X,'BSN =',D13.6,2X,&
        'PCP =',D13.6,2X,'DN  =',D13.6,2X,'NFIX=',D13.6/5X,'VOL =',D13.6,2X,&
        'FNO =',D13.6,2X,'FNMN=',D13.6,2X,'FNMA=',D13.6,2X,'BURN=',D13.6,2X,&
        'DPKN=',D13.6/5X,'PSON=',D13.6,2X,'YNWN=',D13.6,2X,'YN  =',D13.6,2X,&
        'QN  =',D13.6,2X,'TSFN=',D13.6,2X,'RSFN=',D13.6/5X,'QRFN=',D13.6,2X,&
        'QDRN=',D13.6,2X,'YLN =',D13.6,2X,'FSN =',D13.6,2X,'TLMN=',D13.6,2X,&
        'TSMN=',D13.6/5X,'TRMN=',D13.6,2X,'TRON=',D13.6,2X,'RSDN=',D13.6)
   2315 FORMAT(5X,'PER =',D13.6,2X,'DF  =',D13.6,2X,'BRSY=',D13.6,2X,&
        'YS  =',D13.6,2X,'YW  =',D13.6,2X,'DEP =',D13.6/5X,'DEG =',D13.6,&
      2X,'RSYF=',D13.6/)
   2460 FORMAT(/1X,'-----CURVE NUMBER DISTRIBUTION'/T10,'>95=',F5.2,3X,'>&
        90=',F5.2,3X,'>85=',F5.2,3X,'>80=',F5.2,3X,'>75=',F5.2,3X,'>70=',&
        F5.2,3X,'>65=',F5.2,3X,'>60=',F5.2,3X,'>55=',F5.2,3X,'<55=',F5.2)
   3030 FORMAT(//I5,6(2X,A4,E12.4)/(5X,6(2X,A4,E12.4)))
   3060 FORMAT(8X,A8,8F8.2/(10F8.3))
   3111 FORMAT(20F8.0)
   3113 FORMAT(20F8.2)
   3114 FORMAT(10F8.2)
   3200 FORMAT(1X,A4,13F9.0,2X,A4)
   3281 FORMAT(35X,'SIM DUR=',I4,' YR'/T11,'JAN',9X,'FEB',9X,'MAR',9X,&
        'APR',9X,'MAY',9X,'JUN',9X,'JUL',9X,'AUG',9X,'SEP',9X,'OCT',9X,&
        'NOV',9X,'DEC',9X,' YR')
   3301 FORMAT(1X,A4,13F9.3,2X,A4)
   3302 FORMAT(1X,A4,13E12.4,2X,A4)
   3320 FORMAT(/1X,'-----PEAK FLOW RATE STATS(mm/h)',T70,'UNIT PEAKS(1/h)&
        '/T10,'MAX = ',F9.2,5X,'MEAN = ',F6.2,5X,'ST DV = ',F6.2,5X,'MAX =&
        ',F10.4,5X,'MEAN = ',F9.4,5X,'NO PKS = ',I6)
   3770 FORMAT(6X,9(1X,A4,1X,E12.4))
   4087 FORMAT(8X,A2,I8,2X,I8,1X,I8,F12.2,I4,F8.2,F8.3,F8.2,3F8.1,I8,2F8.3&
        ,I8,2F8.3)
   4088 FORMAT(5X,'ENMN=',E13.6,2X,'ENMA=',E13.6,2X,'EON =',E13.6,2X,&
        'ESDN=',E13.6,2X,'ESON=',E13.6,2X,'EUNM=',E13.6/5X,'ENMU=',&
        E13.6,2X,'ENOU=',E13.6)
   4089 FORMAT(5X,'EPML=',E13.6,2X,'EPMA=',E13.6,2X,'EPMS=',E13.6,2X,&
        'EPO =',E13.6,2X,'EFOP=',E13.6,2X,'ESDP=',E13.6/5X,'ESOP=',E13.6,&
        2X,'EUPM=',E13.6,2X,'EPMU=',E13.6,2X,'EPOU=',E13.6)
   4993 FORMAT(12X,6F11.0)
   5005 FORMAT('AVEAN',I5,I9,I6,50E12.4)
   5007 FORMAT(/T10,'LAND USE SUMMARY'/T25,'AREA'/10X,'CROP',5X,'(ha)',4X,&
        'FRACTION',2X,'YLDt/ha')
   5008 FORMAT(10X,A4,F10.1,2F10.3)
   5012 FORMAT(/T10,'WIND DIRECTION SUMMARY'/T15,'N= ',F6.3,2X,'NNE= ',&
        F6.3,2X,'NE= ',F6.3,2X,'ENE= ',F6.3,2X,'E= ',F6.3,2X,'ESE= ',F6.3,&
        2X,'SE= ',F6.3,2X,'SSE= ',F6.3,2X,'S= ',F6.3,2X,'SSW= ',F6.3,2X,&
        'SW= ',F6.3,2X,'WSW= ',F6.3,2X,'W= ',F6.3,2X,'WNW= ',F6.3,2X,&
        'NW= ',F6.3,2X,'NNW= ',F6.3)
   5016 FORMAT(/T10,'DUST DISTRIBUTION SUMMARY'/T15,'SA(#  ID)',2X,&
        'PM10(kg/ha)   FRACTION     ACCUM')
   5017 FORMAT(15X,2I8,3E13.5)
   5018 FORMAT(11X,'TOTAL DP10=',E13.5,' KG',2X,'EM10=',E13.5,' KG')
   6010 FORMAT(1X,A4,12F9.2,11X,A4)
   6050 FORMAT(/1X,'-----AVE MO VALUES')
   6280 FORMAT(35X,'SIM DUR=',I4,' YR'/T11,'JAN',6X,'FEB',6X,'MAR',6X,&
        'APR',6X,'MAY',6X,'JUN',6X,'JUL',6X,'AUG',6X,'SEP',6X,'OCT',6X,&
        'NOV',6X,'DEC',6X,' YR')
   6300 FORMAT(1X,A4,13F9.2,2X,A4)
   6550 FORMAT(1X,A4,13F9.1,2X,A4)

END FUNCTION



!! ******************************************************************************************
!! yearLoopStart
!! In this new function, copy all instructions of BSIM called BEFORE the DAILY LOOP of BSIM
!! ******************************************************************************************

FUNCTION yearLoopStart (p) BIND(C, name='yearLoopStart')


    USE PARM
    USE HISAFE

    TYPE(Hisafe_),  intent(INOUT) :: p
 
    write(*,*) 'yearLoopStart'

    CALL FROMHISAFE (p)
    DATA MNST/1,2,3,4,5,6,7/,IIP/1/
    DATA YTP/13*0./
    DATA HD28/'  Z1','  Z2','  Z3','  Z4','  Z5','  Z6','  Z7','  Z8',&            
    '  Z9',' Z10',' Z11',' Z12',' Z13',' Z14',' Z15',' SW1',' SW2',&               
    ' SW3',' SW4',' SW5',' SW6',' SW7',' SW8',' SW9','SW10','SW11',&               
    'SW12','SW13','SW14','SW15',' WU1',' WU2',' WU3',' WU4',' WU5',&               
    ' WU6',' WU7',' WU8',' WU9','WU10','WU11','WU12','WU13','WU14',&               
    'WU15',' EV1',' EV2',' EV3',' EV4',' EV5',' EV6',' EV7',' EV8',&               
    ' EV9','EV10','EV11','EV12','EV13','EV14','EV15',' PK1',' PK2',&               
    ' PK3',' PK4',' PK5',' PK6',' PK7',' PK8',' PK9','PK10','PK11',&               
    'PK12','PK13','PK14','PK15',' SF1',' SF2',' SF3',' SF4',' SF5',&               
    ' SF6',' SF7',' SF8',' SF9','SF10','SF11','SF12','SF13','SF14',&               
    'SF15',' N31',' N32',' N33',' N34',' N35',' N36',' N37',' N38',&               
    ' N39','N310','N311','N312','N313','N314','N315',' UN1',' UN2',&               
    ' UN3',' UN4',' UN5',' UN6',' UN7',' UN8',' UN9','UN10','UN11',&               
    'UN12','UN13','UN14','UN15',' LN1',' LN2',' LN3',' LN4',' LN5',&               
    ' LN6',' LN7',' LN8',' LN9','LN10','LN11','LN12','LN13','LN14',&               
    'LN15','  T1','  T2','  T3','  T4','  T5','  T6','  T7','  T8',&               
    '  T9',' T10',' T11',' T12',' T13',' T14',' T15'/
    DATA HDG/'   GFO2','  GFCO2','  GFN2O','  DFO2S',' DBFO2B','  DFO2T',&
    '    QO2',' DFCO2S',' DFCO2B',' DFCO2T','   QCO2',' DFN2OS',' DFN2OB',&
    ' DFN2OT','   QN2O'/
    DATA HD30/'     ZC','    VWC','    AFP','   HKPO','   DPRO','   HKPC',&
    '   DPRC','   HKPN','   DPRN','   SMEA','   SMES','   WNH3','   WNO3',&
    '   WNO2','   WO2L','   WO2G','DO2CONS','  SSFO2','    VO2','  WCO2L',&
    '  WCO2G','DCO2GEN',' SSFCO2','   VCO2','  WN2OL','  WN2OG',' SSFN2O',&
    '   VN2O','  DN2OG','   DN2G'/
    DATA HDN/'1 ','2 ','3 ','4 ','5 ','6 ','7 ','8 ','9 ','10','11',&
    '12','13','14','15','16','17','18','19','20','21','22','23','24',&
    '25','26','27','28','29','30'/ 
    CMDN=(/'HYDV','ROUT','ADD ','RSRT','PDRT'/)
    RWSX=RWSA(NCMD)
    IF(NPSO>0)THEN
        DO I=1,NPSO
            II=I+LND
            DO J=1,6
                READ(KR(II),'()')
            END DO
        END DO
    END IF
    IF(KFL(42)>0)THEN
        DO ISA=1,MSA
            WRITE(KW(42),731)HED(4),HED(10),HED(11),(HED(I),&                 
            I=13,20),(HEDS(I),I=6,8),((HD28(I,J),I=1,NBSL(ISA)),J=1,10)
        END DO
    END IF    
    IF(KFL(41)>0)THEN
        WRITE(KW(41),'(T15,3(A,E16.6))')'XKN1=',XKN1,' XKN3=',XKN3,&
        ' XKN5=',XKN5                                            
        WRITE(KW(41),730)HED(4),((HD30(J),HDN(I),I=1,NBCL),&
        J=2,3),((HD30(J),HDN(I),I=1,NBCL),J=12,17),(HDG(I),'  ',I=4,7),&
        ((HD30(J),HDN(I),I=1,NBCL),J=18,22),(HDG(I),'  ',I=8,11),((HD30(J),&
        HDN(I),I=1,NBCL),J=23,26),(HDG(I),'  ',I=12,15),((HD30(J),HDN(I),&
        I=1,NBCL),J=27,30)
    END IF           
    IPSF=0.
    T2=0.
    DO IY=1,NBYR ! ANNUAL LOOP                                                               
        JDA=IBD
        JJ=IBD-1 
        IPF=0                                                                      
        IF(ICO2==1)THEN                                                                 
            IF(IYX<25)THEN                                                             
                CO2=280.33                                                
            ELSE                                                                       
                X1=IYX                                                                 
                CO2=280.33-X1*(.1879-X1*.0077)                                         
            END IF                                                                     
        END IF                                                                         
        IF(IPD>2)THEN                                                                  
            IF(NOP/=0)THEN                                                             
                CALL APAGE(0)                                                          
                IF(KFL(1)>0)WRITE(KW(1),'(//T11,A,A)')'SA(# ID)   Y M D',&             
                ' OPERATION'                                                           
            END IF                                                                     
        ELSE                                                                           
            CALL APAGE(0)                                                              
        END IF                                                                         
        ND=366-NYD                                                                     
        DO I=1,LC                                                                      
   	        WA(I)=100.*CO2/(CO2+EXP(WAC2(1,I)-CO2*WAC2(2,I)))                          
        END DO                                                                         
        WRITE(KW(1),'(T10,A,F5.0)')'ATMOS CO2 = ',CO2                                  
        IPC=1                                                                          
        KOMP=0                                                                         
        DO ISA=1,MSA                                                                   
            KTMX(ISA)=1                                                                
            TFLG(ISA)=0.                                                               
            AFLG(ISA)=0.                                                               
            IRO(ISA)=IRO(ISA)+1                                                        
            IF(IRO(ISA)>NRO(ISA))IRO(ISA)=1
            IF(IGO(ISA)>NCP(IRO(ISA),ISA))THEN
                IF(LY(IRO(ISA),1,ISA)==KGO(IGO(ISA),ISA))THEN
                    LY(IRO(ISA),IGO(ISA),ISA)=KGO(NCP(IRO(ISA),ISA),ISA)
                ELSE
                    LY(IRO(ISA),IGO(ISA),ISA)=KGO(IGO(ISA),ISA)
                END IF
                NCP(IRO(ISA),ISA)=IGO(ISA)
            END IF
            DO I=1,LC                                                                  
                JE(I,ISA)=MNC                                                           
                IF(KGO(I,ISA)==0)CYCLE                                                 
                DO J=1,NCP(IRO(ISA),ISA)                                               
                    IF(I==LY(IRO(ISA),J,ISA))EXIT                                      
                END DO                                                                 
                JE(J,ISA)=I
                IF(IDC(I)==NDC(7).OR.IDC(I)==NDC(8))THEN
                    DO ISL=1,NBSL(ISA)
                        IF(CPRV(ISL,ISA)<1.E-10)CPRV(ISL,ISA)=CPV0
                        IF(CPRH(ISL,ISA)<1.E-10)CPRH(ISL,ISA)=CPH0
                    END DO 
                END IF                                                                   
            END DO
            IF(IPAT>0)THEN
	         IF(PDPLC(ISA)<20.)THEN
	          APMU=2.25*(30.-PDPLC(ISA))
	          JJK=LY(IRO(ISA),1,ISA)
	  	          IF(APMU>45.)CALL NFERT(APMU,7,IAUF(ISA),KT2,JRT)
                END IF
	        END IF        
	        IF(IKAT>0)THEN
	         IF(PDSKC(ISA)<20.)THEN
	          APMU=2.25*(30.-PDSKC(ISA))
	          JJK=LY(IRO(ISA),1,ISA)
	  	          IF(APMU>45.)CALL NFERT(APMU,8,IAUF(ISA),KT2,JRT)
                END IF
	        END IF                                                                     
            LD1=LID(1,ISA)                                                             
            ANA(IRO(ISA),ISA)=0.                                                       
            HSM(ISA)=0.                                                                
            X1=.2+.3*EXP(-.0256*SAN(LD1,ISA)*(1.-.01*SIL(LD1,ISA)))                    
            X2=(SIL(LD1,ISA)/(CLA(LD1,ISA)+SIL(LD1,ISA)))**.3                          
            X5=.1*WOC(LD1,ISA)/WT(LD1,ISA)                                             
            X3=1.-.25*X5/(X5+EXP(3.718-2.947*X5))                                      
            X4=1.-.01*SAN(LD1,ISA)                                                     
            X5=1.-.7*X4/(X4+EXP(-5.509+22.899*X4))                                     
            EK(ISA)=X1*X2*X3*X5                                                        
            USL(ISA)=EK(ISA)*SLF(ISA)*PEC(ISA)                                         
	        SUM=(SAN(LD1,ISA)*.0247-SIL(LD1,ISA)*3.65-CLA(LD1,ISA)*6.908)/&                 
            100.                                                                       
            DG=EXP(SUM)                                                                
            REK=9.811*(.0034+.0405*EXP(-.5*((LOG10(DG)+1.659)/.7101)**2))              
            RSK(ISA)=REK*PEC(ISA)*RSF(ISA)                                             
            RSLK(ISA)=RSK(ISA)*RLF(ISA)                                                
            CALL EWIK
            SAMA(ISA)=0.                                                               
            XMAP(ISA)=0.
            SELECT CASE(MNUL)                                                               
	            CASE(1)                                                                          
                    IF(PDPLC(ISA)<62.)THEN                                                 
                        XMAP(ISA)=2.*UPR                                                   
                        CYCLE                                                              
                    END IF                                                                 
                    IF(PDPLC(ISA)<120.)THEN                                                
                        XMAP(ISA)=1.5*UPR                                                  
                        CYCLE                                                              
                    END IF                                                                 
                    IF(PDPLC(ISA)<200.)THEN                                                
                        XMAP(ISA)=UPR                                                      
                        CYCLE                                                              
                    END IF
                CASE(2)                                                                
	                IF(PDPLC(ISA)<200.)CYCLE                                               
  	                XMAP(ISA)=UNR                                                             
	                CYCLE                                                                  
                CASE(3)
                    IF(IAPL(ISA)<=0)CYCLE
                    IF(PDPLC(ISA)<200.)XMAP(ISA)=2.*UPR
	            CASE DEFAULT     
	        END SELECT                                                                
        END DO                                                                              
        NT1=0                                                                          
        WRITE(*,50)IY,NBYR

    CALL TOHISAFE (p)

    return


END FUNCTION

!! ******************************************************************************************
!! addTreeLitters
!! In case you want to ADD tree litters in APEX SOIL
!! ******************************************************************************************
FUNCTION addTreeLitters (p) BIND(C, name='addTreeLitters')


    USE PARM
    USE HISAFE

    TYPE(Hisafe_),  intent(INOUT) :: p

    write(*,*) 'addTreeLitters'

    CALL FROMHISAFE (p)
	!!! TreeLitters biomass and N content from HiSAFE
	!p%TCL + p%TCF + p%TCR
	!p%TLF + p%TNF + p%TNC
	LDZ=p%HI_LID(1,p%HI_ISA)
	CALL NCNSTD(p%HI_TCL + p%HI_TCF + p%HI_TCR, p%HI_TLF + p%HI_TNF + p%HI_TNC,LDZ)  !!Inserted MB 7/29/19
	
	
    !!!HERE ADD THE FUNCTION FOR ADDING TREE RESIDUS TO THE SOIL

    CALL TOHISAFE (p)

    return

END FUNCTION

!!****************************************************************
!! dayLoopStart
!! ALL instructions of the DAILY LOOP including WATER DEMAND
!!****************************************************************
FUNCTION dayLoopStart (p) BIND(C, name='dayLoopStart')

    USE PARM
    USE HISAFE

    TYPE(Hisafe_),  intent(INOUT) :: p

    write(*,*) 'dayLoopStart'

    CALL FROMHISAFE (p)

    !!!HERE ADD THE FUNCTION FOR THE START OF THE DAILY LOOP


    CALL TOHISAFE (p)

    return

END FUNCTION

!!****************************************************************
!! dayLoopEnd
!! ALL instructions of the DAILY LOOP AFTER WATER DEMAND
!!****************************************************************
FUNCTION dayLoopEnd (p) BIND(C, name='dayLoopEnd')


    USE PARM
    USE HISAFE

    TYPE(Hisafe_),  intent(INOUT) :: p

    write(*,*) 'dayLoopEnd'

    CALL FROMHISAFE (p)

     !!!HERE ADD THE FUNCTION FOR THE END OF THE DAILY LOOP

    CALL TOHISAFE (p)

    return

END FUNCTION

!! ******************************************************************************************
!! yearLoopEnd
!! In this new function, copy all instruction of BSIM called AFTER the DAILY LOOP of BSIM
!! ******************************************************************************************

FUNCTION yearLoopEnd (p) BIND(C, name='yearLoopEnd')

    USE PARM
    USE HISAFE

    TYPE(Hisafe_),  intent(INOUT) :: p

    write(*,*) 'endYearLoop'

    CALL FROMHISAFE (p)

     !!!HERE ADD THE FUNCTION FOR THE END OF THE YEAR LOOP

    CALL TOHISAFE (p)

    return

END FUNCTION

!! ******************************************************************************************
!! Copy APEX data TO HISAFE
!! ******************************************************************************************

SUBROUTINE TOHISAFE(p)

        USE PARM

        USE HISAFE

        TYPE(Hisafe_),  intent(INOUT) :: p

        p%HI_IBD=IBD
        p%HI_IBDT=IBDT
        p%HI_ICDP=ICDP
        p%HI_ICMD=ICMD
        p%HI_ICO2=ICO2
        p%HI_ICP=ICP
        p%HI_IDA=IDA
        p%HI_IDAY=IDAY
        p%HI_IDIR=IDIR
        p%HI_IDN1=IDN1
        p%HI_IDN2=IDN2
        p%HI_IDNT=IDNT
        p%HI_IDO=IDO
        p%HI_IERT=IERT
        p%HI_IET=IET
        p%HI_IGC=IGC
        p%HI_IGN=IGN
        p%HI_IGSD=IGSD
        p%HI_IHD=IHD
        p%HI_IHRD=IHRD
        p%HI_IHV=IHV
        p%HI_IHUS=IHUS
        p%HI_IHY=IHY
        p%HI_III=III
        p%HI_IKAT=IKAT
        p%HI_IMON=IMON
        p%HI_INFL=INFL
        p%HI_INP=INP
        p%HI_IOF=IOF
        p%HI_IOW=IOW
        p%HI_IOX=IOX
        p%HI_IPAT=IPAT
        p%HI_IPC=IPC
        p%HI_IPD=IPD
        p%HI_IPF=IPF
        p%HI_IPL=IPL
        p%HI_IPRK=IPRK
        p%HI_IPY=IPY
        p%HI_IPYI=IPYI
        p%HI_IRGX=IRGX
        p%HI_IRH=IRH
        p%HI_IRUN=IRUN
        p%HI_ISA=ISA
        p%HI_ISAP=ISAP
        p%HI_ISCN=ISCN
        p%HI_ISLF=ISLF
        p%HI_ISL=ISL
        p%HI_ISTA=ISTA
        p%HI_ISW=ISW
        p%HI_IT1=IT1
        p%HI_IT2=IT2
        p%HI_IT3=IT3
        p%HI_ITYP=ITYP
        p%HI_IUN=IUN
        p%HI_IWI=IWI
        p%HI_IWTB=IWTB
        p%HI_IY=IY
        p%HI_IYER=IYER
        p%HI_IYR=IYR
        p%HI_IYR0=IYR0
        p%HI_IYX=IYX
        p%HI_JD0=JD0
        p%HI_JDA=JDA
        p%HI_JDE=JDE
        p%HI_JDHU=JDHU
        p%HI_JJK=JJK
        p%HI_JT1=JT1
        p%HI_JT2=JT2

        p%HI_KDA=KDA
        p%HI_KF=KF
        p%HI_KI=KI
        p%HI_KP=KP
        p%HI_LBP=LBP
        p%HI_KND=KND
        p%HI_LC=LC
        p%HI_LGRZ=LGRZ
        p%HI_LGZ=LGZ
        p%HI_LND=LND
        p%HI_LNS=LNS
        p%HI_LPD=LPD
        p%HI_LPYR=LPYR
        p%HI_LW=LW
        p%HI_MASP=MASP
        p%HI_MBS=MBS
        p%HI_MCA12=MCA12
        p%HI_MFT=MFT
        p%HI_MHD=MHD
        p%HI_MHP=MHP
        p%HI_MHX=MHX
        p%HI_MHY=MHY
        p%HI_ML1=ML1
        p%HI_MNC=MNC
        p%HI_MNT=MNT
        p%HI_MNUL=MNUL
        p%HI_MO=MO
        p%HI_MO1=MO1
        p%HI_MOW=MOW
        p%HI_MPO=MPO
        p%HI_MPS=MPS
        p%HI_MRO=MRO
        p%HI_MSA=MSA
        p%HI_MSC=MSC
        p%HI_MSCP=MSCP
        p%HI_MSL=MSL
        p%HI_MXT=MXT
        p%HI_MXW=MXW
        p%HI_NAQ=NAQ
        p%HI_NBCL=NBCL
        p%HI_NBCX=NBCX
        p%HI_NBDT=NBDT
        p%HI_NBFX=NBFX
        p%HI_NBMX=NBMX
        p%HI_NBON=NBON
        p%HI_NBYR=NBYR
        p%HI_NCMD=NCMD
        p%HI_NCMO=NCMO
        p%HI_ND=ND
        p%HI_NDF=NDF
        p%HI_NDP=NDP
        p%HI_NDRV=NDRV
        p%HI_NDT=NDT
        p%HI_NDVSS=NDVSS
        p%HI_NDWT=NDWT
        p%HI_NEV=NEV
        p%HI_NGN=NGN
        p%HI_NGN0=NGN0
        p%HI_NJC=NJC
        p%HI_NKA=NKA
        p%HI_NKD=NKD
        p%HI_NKS=NKS
        p%HI_NKY=NKY
        p%HI_NOFL=NOFL
        p%HI_NOP=NOP
        p%HI_NPD=NPD
        p%HI_NPRC=NPRC
        p%HI_NPSO=NPSO
        p%HI_NRF=NRF
        p%HI_NSH=NSH
        p%HI_NSM=NSM
        p%HI_MSO=MSO
        p%HI_NSNN=NSNN
        p%HI_NSTP=NSTP
        p%HI_NSX=NSX
        p%HI_NSZ=NSZ
        p%HI_NYD=NYD
        p%HI_NT0=NT0
        p%HI_NT1=NT1
        p%HI_NTV=NTV
        p%HI_NUPC=NUPC
        p%HI_NWP=NWP
        p%HI_NWTH=NWTH


        p%HI_KDT1=KDT1
        p%HI_KDC1=KDC1
        p%HI_KDF1=KDF1
        p%HI_KDP1=KDP1
        p%HI_KA=KA
        p%HI_NXP=NXP
        p%HI_KR=KR
        p%HI_KDT2=KDT2
        p%HI_KD=KD
        p%HI_KY=KY
        p%HI_KDP=KDP
        p%HI_NHC=NHC
        p%HI_KS=KS
        p%HI_NWDR=NWDR
        p%HI_IX=IX
        p%HI_NC=NC
        p%HI_IDG=IDG
        p%HI_IX0=IX0
        p%HI_IAD=IAD
        p%HI_ICMO=ICMO
        p%HI_NWPD=NWPD
        p%HI_NDC=NDC
        p%HI_JX=JX
        p%HI_KGN=KGN
        p%HI_JC=JC

        p%HI_ACW=ACW
        p%HI_ADEO=ADEO
        p%HI_ADHY=ADHY
        p%HI_ADRF=ADRF
        p%HI_AEPT=AEPT
        p%HI_AET=AET
        p%HI_AFN=AFN
        p%HI_AGP=AGP
        p%HI_AHSM=AHSM
        p%HI_AJWA=AJWA
        p%HI_ALG=ALG
        p%HI_ALMN=ALMN
        p%HI_ALTC=ALTC
        p%HI_AL5=AL5
        p%HI_AMPX=AMPX
        p%HI_ANG=ANG
        p%HI_AMSR=AMSR
        p%HI_AVT=AVT
        p%HI_BETA=BETA
        p%HI_BRNG=BRNG
        p%HI_BS1=BS1
        p%HI_BS2=BS2
        p%HI_BXCT=BXCT
        p%HI_BYCT=BYCT
        p%HI_CBVT=CBVT
        p%HI_CLF=CLF
        p%HI_CLT=CLT
        p%HI_CMM=CMM
        p%HI_CMS=CMS
        p%HI_CN=CN
        p%HI_CNO3I=CNO3I
        p%HI_COIR=COIR
        p%HI_COL=COL
        p%HI_CON=CON
        p%HI_COP=COP
        p%HI_CO2=CO2
        p%HI_COS1=COS1
        p%HI_CPH0=CPH0
        p%HI_CPV0=CPV0
        p%HI_CPVV=CPVV
        p%HI_CQNI=CQNI
        p%HI_CRLNC=CRLNC
        p%HI_CRUNC=CRUNC
        p%HI_CSFX=CSFX
        p%HI_CSLT=CSLT
        p%HI_D150=D150
        p%HI_DAYL=DAYL
        p%HI_DD=DD
        p%HI_DEMR=DEMR
        p%HI_DN2O=DN2O
        p%HI_DRSW=DRSW

        p%HI_DRTO=DRTO
        p%HI_DTG=DTG
        p%HI_DTHY=DTHY
        p%HI_DUR=DUR
        p%HI_DURG=DURG
        p%HI_DVOL=DVOL
        p%HI_DZ10=DZ10
        p%HI_DZDN=DZDN
        p%HI_EI=EI
        p%HI_ELEV=ELEV
        p%HI_EO=EO
        p%HI_ERTN=ERTN
        p%HI_ERTO=ERTO
        p%HI_ERTP=ERTP
        p%HI_ES=ES
        p%HI_EXNN=EXNN
        p%HI_EXPK=EXPK
        p%HI_FL=FL
        p%HI_FULP=FULP
        p%HI_FW=FW
        p%HI_GWBX=GWBX
        p%HI_GX=GX
        p%HI_HGX=HGX
        p%HI_HMN=HMN
        p%HI_HRLT=HRLT
        p%HI_HR1=HR1
        p%HI_PB=PB
        p%HI_PI2=PI2
        p%HI_PIT=PIT
        p%HI_PMOEO=PMOEO
        p%HI_PMORF=PMORF
        p%HI_PRFF=PRFF
        p%HI_PSTX=PSTX
        p%HI_QAPY=QAPY
        p%HI_QRB=QRB
        p%HI_QSFN=QSFN
        p%HI_QSFP=QSFP
        p%HI_QTH=QTH
        p%HI_RAMX=RAMX
        p%HI_REP=REP
        p%HI_RFNC=RFNC
        p%HI_RFQN=RFQN
        p%HI_RFRA=RFRA
        p%HI_RGIN=RGIN
        p%HI_RGRF=RGRF
        p%HI_RHCF=RHCF
        p%HI_RHM=RHM
        p%HI_RHP=RHP
        p%HI_RHS=RHS
        p%HI_RM=RM
        p%HI_RMNR=RMNR
        p%HI_RMX0=RMX0

        p%HI_RNO3=RNO3
        p%HI_RRF=RRF
        p%HI_RTP=RTP
        p%HI_RUNT=RUNT
        p%HI_RWO=RWO
        p%HI_SAET=SAET
        p%HI_SALF=SALF
        p%HI_SAT=SAT
        p%HI_SBAL=SBAL
        p%HI_SCN=SCN
        p%HI_SCN2=SCN2
        p%HI_SDEG=SDEG
        p%HI_SDEP=SDEP
        p%HI_SDN=SDN
        p%HI_SDRF=SDRF
        p%HI_SEP=SEP
        p%HI_SGMN=SGMN
        p%HI_SHRL=SHRL
        p%HI_SK=SK
        p%HI_SML=SML
        p%HI_SMNR=SMNR
        p%HI_SMP=SMP
        p%HI_SMSQ=SMSQ
        p%HI_SN2=SN2
        p%HI_SN2O=SN2O
        p%HI_SNIT=SNIT
        p%HI_SN=SN
        p%HI_SNMN=SNMN
        p%HI_SNOF=SNOF
        p%HI_SNPKT=SNPKT
        p%HI_SOFU=SOFU
        p%HI_SP=SP
        p%HI_SPRC=SPRC
        p%HI_SPRF=SPRF
        p%HI_SRPM=SRPM
        p%HI_SSFK=SSFK
        p%HI_SSFN=SSFN
        p%HI_SSST=SSST
        p%HI_STND=STND
        p%HI_SUK=SUK
        p%HI_SUN=SUN
        p%HI_SUP=SUP
        p%HI_SVOL=SVOL

        p%HI_SX=SX
        p%HI_SYMU=SYMU
        p%HI_SYW=SYW
        p%HI_TA=TA
        p%HI_TCF=TCF       !!Inserted MB 7/29/19  
        p%HI_TCL=TCL       !!Inserted MB 7/29/19
        p%HI_TCR=TCR       !!Inserted MB 7/29/19 
        p%HI_TDEG=TDEG
        p%HI_TDEP=TDEP
        p%HI_TEVP=TEVP
        p%HI_TEV1=TEV1
        p%HI_TFMA=TFMA
        p%HI_TFMN=TFMN
        p%HI_TFNO=TFNO
        p%HI_THW=THW
        p%HI_TLA=TLA
        p%HI_TLF=TLF       !!Inserted MB 7/29/19
        p%HI_TMAF=TMAF
        p%HI_TMAP=TMAP
        p%HI_TMPD=TMPD
        p%HI_TNC=TNC       !!Inserted MB 7/29/19
        p%HI_TNF=TNF       !!Inserted MB 7/29/19
        p%HI_TPRK=TPRK
        p%HI_TPSP=TPSP
        p%HI_TREV=TREV
        p%HI_TRFR=TRFR
        p%HI_TRSP=TRSP
        p%HI_TSAE=TSAE
        p%HI_TSFS=TSFS
        p%HI_TX=TX
        p%HI_TXXM=TXXM
        p%HI_UK2=UK2
        p%HI_UKM=UKM
        p%HI_DMN=DMN !! Inserted MB 7/19/19
        p%HI_UNM=UNM
        p%HI_UNR=UNR
        p%HI_UN2=UN2
        p%HI_UPM=UPM
        p%HI_UPR=UPR
        p%HI_UP2=UP2
        p%HI_USTRT=USTRT
        p%HI_USTT=USTT
        p%HI_USTW=USTW
        p%HI_UX=UX
        p%HI_UXP=UXP
        p%HI_V56=V56
        p%HI_V57=V57
        p%HI_VGF=VGF
        p%HI_VMU=VMU
        p%HI_VPD=VPD
        p%HI_V1=V1
        p%HI_V3=V3
        p%HI_WAGE=WAGE
        p%HI_WB=WB
        p%HI_WCF=WCF
        p%HI_WCYD=WCYD
        p%HI_WDN=WDN
        p%HI_WFX=WFX
        p%HI_WIM=WIM
        p%HI_WIP=WIP
        p%HI_WKA=WKA
        p%HI_WKMNH3=WKMNH3
        p%HI_WKMNO2=WKMNO2
        p%HI_WKMNO3=WKMNO3
        p%HI_WMP=WMP
        p%HI_WNCMAX=WNCMAX
        p%HI_WNCMIN=WNCMIN
        p%HI_WTN=WTN
        p%HI_XCS=XCS
        p%HI_XDA=XDA
        p%HI_XDA1=XDA1
        p%HI_XET=XET
        p%HI_XK1=XK1
        p%HI_XK2=XK2
        p%HI_XKN1=XKN1
        p%HI_XKN3=XKN3
        p%HI_XKN5=XKN5
        p%HI_XKP1=XKP1
        p%HI_XKP2=XKP2
        p%HI_XSA=XSA
        p%HI_XSL=XSL
        p%HI_YCS=YCS
        p%HI_YERO=YERO
        p%HI_YEW=YEW
        p%HI_YEWN=YEWN
        p%HI_YLAT=YLAT
        p%HI_YLAZ=YLAZ
        p%HI_YLN=YLN
        p%HI_YLP=YLP
        p%HI_YMP=YMP
        p%HI_YSL=YSL
        p%HI_YWKS=YWKS
        p%HI_ZF=ZF
        p%HI_ZQT=ZQT

        p%HI_XTP=XTP
        p%HI_XYP=XYP
        p%HI_PRMT=PRMT
        p%HI_SMYR=SMYR
        p%HI_VARS=VARS
        p%HI_RNCF=RNCF
        p%HI_TAV=TAV
        p%HI_TMNF=TMNF
        p%HI_TMXF=TMXF
        p%HI_UAV0=UAV0
        p%HI_UAVM=UAVM
        p%HI_AWXP=AWXP
        p%HI_RFSG=RFSG
        p%HI_SMSO=SMSO
        p%HI_OPV=OPV
        p%HI_SMSW=SMSW
        p%HI_PSZ=PSZ
        p%HI_PSZX=PSZX
        p%HI_PSZY=PSZY
        p%HI_BUS=BUS
        p%HI_WX=WX
        p%HI_XAV=XAV
        p%HI_XDV=XDV
        p%HI_XIM=XIM
        p%HI_XRG=XRG
        p%HI_SMMR=SMMR
        p%HI_SMR=SMR
        p%HI_DIR=DIR
        p%HI_OBMN=OBMN
        p%HI_OBMNX=OBMNX
        p%HI_OBMX=OBMX
        p%HI_OBSL=OBSL
        p%HI_PCF=PCF
        p%HI_RH=RH
        p%HI_SDTMN=SDTMN
        p%HI_SDTMX=SDTMX
        p%HI_WFT=WFT
        p%HI_WI=WI
        p%HI_SCRP=SCRP
        p%HI_CQRB=CQRB
        p%HI_RST=RST
        p%HI_PRW=PRW

      !!  p%HI_CPNM=CPNM !CHAR Down
      !!  p%HI_FPSO=FPSO
      !!  p%HI_FTNM=FTNM
      !!  p%HI_HED=HED
      !!  p%HI_HEDH=HEDH
      !!  p%HI_PSTN=PSTN
      !!  p%HI_TIL=TIL
      !!  p%HI_TITOP=TITOP
      !!  p%HI_TITSO=TITSO

        p%HI_IAC=IAC    !INT Down
        p%HI_IAMF=IAMF
        p%HI_IAPL=IAPL
        p%HI_IAUF=IAUF
        p%HI_IAUI=IAUI
        p%HI_IAUL=IAUL
        p%HI_IBSA=IBSA
        p%HI_ICDT=ICDT
        p%HI_ICUS=ICUS
        p%HI_IDC=IDC
        p%HI_IDF0=IDF0
        p%HI_IDFA=IDFA
        p%HI_IDFD=IDFD
        p%HI_IDFH=IDFH
        p%HI_IDFT=IDFT
        p%HI_IDMU=IDMU
        p%HI_IDN1T=IDN1T
        p%HI_IDN2T=IDN2T
        p%HI_IDNB=IDNB
        p%HI_IDNF=IDNF
        p%HI_IDOA=IDOA
        p%HI_IDON=IDON
        p%HI_IDOT=IDOT
        p%HI_IDOW=IDOW
        p%HI_IDR=IDR
        p%HI_IDRL=IDRL
        p%HI_IDRO=IDRO
        p%HI_IDS=IDS
        p%HI_IDSL=IDSL
        p%HI_IDSS=IDSS
        p%HI_IEXT=IEXT
        p%HI_IFA=IFA
        p%HI_IFD=IFD
        p%HI_IFED=IFED
        p%HI_IFLO=IFLO
        p%HI_IFLS=IFLS
        p%HI_IGO=IGO
        p%HI_IGZ=IGZ
        p%HI_IGZO=IGZO
        p%HI_IGZX=IGZX
        p%HI_IHBS=IHBS
        p%HI_IHC=IHC
        p%HI_IHDM=IHDM
        p%HI_IHDT=IHDT
        p%HI_IHRL=IHRL
        p%HI_IHT=IHT
        p%HI_IHU=IHU
        p%HI_IHX=IHX
        p%HI_IIR=IIR
        p%HI_ILQF=ILQF
        p%HI_IMW=IMW
        p%HI_IPMP=IPMP
        p%HI_IPSF=IPSF
        p%HI_IPSO=IPSO
        p%HI_IPST=IPST
        p%HI_IPTS=IPTS
        p%HI_IRF=IRF
        p%HI_IRI=IRI
        p%HI_IRO=IRO
        p%HI_IRP=IRP
        p%HI_IRR=IRR
        p%HI_IRRS=IRRS
        p%HI_ISAL=ISAL
        p%HI_ISAO=ISAO
        p%HI_ISAS=ISAS
        p%HI_ISCP=ISCP
        p%HI_ISG=ISG
        p%HI_ISPF=ISPF
        p%HI_ITL=ITL
        p%HI_IWTH=IWTH
        p%HI_IYH=IYH
        p%HI_IYHO=IYHO
        p%HI_JBG=JBG
        p%HI_JCN=JCN
        p%HI_JCN0=JCN0
        p%HI_JCN1=JCN1
        p%HI_JD=JD
        p%HI_JE=JE
        p%HI_JH=JH
        p%HI_JP=JP
        p%HI_JPC=JPC
        p%HI_JPL=JPL
        p%HI_KC=KC
        p%HI_KDC=KDC
        p%HI_KDF=KDF
        p%HI_KDT=KDT
        p%HI_KFL=KFL
        p%HI_KGO=KGO
        p%HI_KIR=KIR
        p%HI_KOMP=KOMP
        p%HI_KP1=KP1
        p%HI_KPC=KPC
        p%HI_KPSN=KPSN
        p%HI_KT=KT
        p%HI_KTF=KTF
        p%HI_KTMX=KTMX
        p%HI_KTT=KTT
        p%HI_KW=KW
        p%HI_LFT=LFT
        p%HI_LGIR=LGIR
        p%HI_LID=LID
        p%HI_LM=LM
        p%HI_LORG=LORG
        p%HI_LPC=LPC
        p%HI_LRD=LRD
        p%HI_LT=LT
        p%HI_LUN=LUN
        p%HI_LUNS=LUNS
        p%HI_LY=LY
        p%HI_LYR=LYR
        p%HI_MXSR=MXSR
        p%HI_NBCF=NBCF
        p%HI_NBCT=NBCT
        p%HI_NBE=NBE
        p%HI_NBFF=NBFF
        p%HI_NBFT=NBFT
        p%HI_NBHS=NBHS
        p%HI_NBSA=NBSA
        p%HI_NBSL=NBSL
        p%HI_NBSX=NBSX
        p%HI_NBT=NBT
        p%HI_NBW=NBW
        p%HI_NCOW=NCOW
        p%HI_NCP=NCP
        p%HI_NCR=NCR
        p%HI_NDFA=NDFA
        p%HI_NFED=NFED
        p%HI_NFRT=NFRT
        p%HI_NGIX=NGIX
        p%HI_NGZ=NGZ
        p%HI_NGZA=NGZA
        p%HI_NHBS=NHBS
        p%HI_NHRD=NHRD
        p%HI_NHU=NHU
        p%HI_NHY=NHY
        p%HI_NII=NII
        p%HI_NIR=NIR
        p%HI_NISA=NISA
        p%HI_NMW=NMW
        p%HI_NPC=NPC
        p%HI_NPSF=NPSF
        p%HI_NPST=NPST
        p%HI_NQRB=NQRB
        p%HI_NRO=NRO
        p%HI_NSAL=NSAL
        p%HI_NSAO=NSAO
        p%HI_NSAS=NSAS
        p%HI_NTL=NTL
        p%HI_NTP=NTP
        p%HI_NTX=NTX
        p%HI_NVCN=NVCN
        p%HI_NWDA=NWDA
        p%HI_NYHO=NYHO
        p%HI_NYLN=NYLN
        p%HI_ABD=ABD   !REAL Down
        p%HI_ACET=ACET
        p%HI_ACO2C=ACO2C
        p%HI_AEP=AEP
        p%HI_AFLG=AFLG
        p%HI_AFP=AFP
        p%HI_AGPM=AGPM
        p%HI_AJHI=AJHI
        p%HI_ALGI=ALGI
        p%HI_ALQ=ALQ
        p%HI_ALS=ALS
        p%HI_ALT=ALT
        p%HI_AN2OC=AN2OC
        p%HI_ANA=ANA
        p%HI_AO2C=AO2C
        p%HI_ARMN=ARMN
        p%HI_ARMX=ARMX
        p%HI_ARSD=ARSD
        p%HI_ASW=ASW
        p%HI_AWC=AWC
        p%HI_BA1=BA1
        p%HI_BA2=BA2
        p%HI_BCOF=BCOF
        p%HI_BCV=BCV
        p%HI_BD=BD
        p%HI_BDD=BDD
        p%HI_BDM=BDM
        p%HI_BDP=BDP
        p%HI_BFFL=BFFL
        p%HI_BFSN=BFSN
        p%HI_BFT=BFT
        p%HI_BGWS=BGWS
        p%HI_BIG=BIG
        p%HI_BIR=BIR
        p%HI_BK=BK
        p%HI_BLG=BLG
        p%HI_BN=BN
        p%HI_BP=BP
        p%HI_BPT=BPT
        p%HI_BR1=BR1
        p%HI_BR2=BR2
        p%HI_BRSV=BRSV
        p%HI_BSALA=BSALA
        p%HI_BSNO=BSNO
        p%HI_BTC=BTC
        p%HI_BTCX=BTCX
        p%HI_BTCZ=BTCZ
        p%HI_BTK=BTK
        p%HI_BTN=BTN
        p%HI_BTNX=BTNX
        p%HI_BTNZ=BTNZ
        p%HI_BTP=BTP
        p%HI_BTPX=BTPX
        p%HI_BTPZ=BTPZ
        p%HI_BV1=BV1
        p%HI_BV2=BV2
        p%HI_BVIR=BVIR
        p%HI_BWN=BWN
        p%HI_CAC=CAC
        p%HI_CAF=CAF
        p%HI_CAW=CAW
        p%HI_CBN=CBN
        p%HI_CDG=CDG
        p%HI_CEC=CEC
        p%HI_CFNP=CFNP
        p%HI_CGCO2=CGCO2
        p%HI_CGN2O=CGN2O
        p%HI_CGO2=CGO2
        p%HI_CHL=CHL
        p%HI_CHN=CHN
        p%HI_CHS=CHS
        p%HI_CHXA=CHXA
        p%HI_CHXP=CHXP
        p%HI_CKY=CKY
        p%HI_CLA=CLA
        p%HI_CLCO2=CLCO2
        p%HI_CLG=CLG
        p%HI_CLN2O=CLN2O
        p%HI_CLO2=CLO2
        p%HI_CN0=CN0
        p%HI_CN2=CN2
        p%HI_CND=CND
        p%HI_CNDS=CNDS
        p%HI_CNLV=CNLV
        p%HI_CNRT=CNRT
        p%HI_CNSC=CNSC
        p%HI_CNSX=CNSX
        p%HI_CNY=CNY
        p%HI_COOP=COOP
        p%HI_COST=COST
        p%HI_COTL=COTL
        p%HI_COWW=COWW
        p%HI_CPFH=CPFH
        p%HI_CPHT=CPHT
        p%HI_CPMX=CPMX
        p%HI_CPRH=CPRH
        p%HI_CPRV=CPRV
        p%HI_CPVH=CPVH
        p%HI_CPY=CPY
        p%HI_CST1=CST1
        p%HI_CSTF=CSTF
        p%HI_CSTS=CSTS
        p%HI_CTSA=CTSA
        p%HI_CV=CV
        p%HI_CVF=CVF
        p%HI_CVP=CVP
        p%HI_CVRS=CVRS
        p%HI_CX=CX
        p%HI_CYAV=CYAV
        p%HI_CYMX=CYMX
        p%HI_CYSD=CYSD
        p%HI_DALG=DALG
        p%HI_DCO2GEN=DCO2GEN
        p%HI_DDLG=DDLG
        p%HI_DDM=DDM
        p%HI_DEPC=DEPC
        p%HI_DHN=DHN
        p%HI_DHT=DHT
        p%HI_DKH=DKH
        p%HI_DKHL=DKHL
        p%HI_DKI=DKI
        p%HI_DKIN=DKIN
        p%HI_DLAI=DLAI
        p%HI_DLAP=DLAP
        p%HI_DM=DM
        p%HI_DM1=DM1
        p%HI_DMF=DMF
        p%HI_DMLA=DMLA
        p%HI_DMLX=DMLX
        p%HI_DN2G=DN2G
        p%HI_DN2OG=DN2OG
        p%HI_DO2CONS=DO2CONS
        p%HI_DPMT=DPMT
        p%HI_DPRC=DPRC
        p%HI_DPRN=DPRN
        p%HI_DPRO=DPRO
        p%HI_DRAV=DRAV
        p%HI_DRT=DRT
        p%HI_DRWX=DRWX
        p%HI_DST0=DST0
        p%HI_DUMP=DUMP
        p%HI_DWOC=DWOC
        p%HI_EAR=EAR
        p%HI_ECND=ECND
        p%HI_EFI=EFI
        p%HI_EFM=EFM
        p%HI_EK=EK
        p%HI_EM10=EM10
        p%HI_EMX=EMX
        p%HI_EO5=EO5
        p%HI_EP=EP
        p%HI_EQKE=EQKE
        p%HI_EQKS=EQKS
        p%HI_ERAV=ERAV
        p%HI_ETG=ETG
        p%HI_EVRS=EVRS
        p%HI_EVRT=EVRT
        p%HI_EXCK=EXCK
        p%HI_EXTC=EXTC
        p%HI_FBM=FBM
        p%HI_FC=FC
        p%HI_FCMN=FCMN
        p%HI_FCMP=FCMP
        p%HI_FCST=FCST
        p%HI_FDSF=FDSF
        p%HI_FE26=FE26
        p%HI_FFC=FFC
        p%HI_FFED=FFED
        p%HI_FFPQ=FFPQ
        p%HI_FGC=FGC
        p%HI_FGSL=FGSL
        p%HI_FHP=FHP
        p%HI_FIRG=FIRG
        p%HI_FIRX=FIRX
        p%HI_FIXK=FIXK
        p%HI_FK=FK
        p%HI_FLT=FLT
        p%HI_FN=FN
        p%HI_FNMA=FNMA
        p%HI_FNMN=FNMN
        p%HI_FNMX=FNMX
        p%HI_FNO=FNO
        p%HI_FNP=FNP
        p%HI_FOC=FOC
        p%HI_FOP=FOP
        p%HI_FP=FP
        p%HI_FPF=FPF
        p%HI_FPO=FPO
        p%HI_FPOP=FPOP
        p%HI_FPSC=FPSC
        p%HI_FRCP=FRCP
        p%HI_FRST=FRST
        p%HI_FRTK=FRTK
        p%HI_FRTN=FRTN
        p%HI_FRTP=FRTP
        p%HI_FSFN=FSFN
        p%HI_FSFP=FSFP
        p%HI_FSLT=FSLT
        p%HI_FTO=FTO
        p%HI_FULU=FULU
        p%HI_GCOW=GCOW
        p%HI_GMA=GMA
        p%HI_GMHU=GMHU
        p%HI_GRDD=GRDD
        p%HI_GRDL=GRDL
        p%HI_GRLV=GRLV
        p%HI_GSI=GSI
        p%HI_GWMX=GWMX
        p%HI_GWPS=GWPS
        p%HI_GWSN=GWSN
        p%HI_GWST=GWST
        p%HI_GZLM=GZLM
        p%HI_GZRT=GZRT
        p%HI_HA=HA
		p%HI_HCL=HCL
        p%HI_HCLD=HCLD
        p%HI_HCLN=HCLN
        p%HI_HE=HE
        p%HI_HI=HI
        p%HI_HKPC=HKPC
        p%HI_HKPN=HKPN
        p%HI_HKPO=HKPO
        p%HI_HLMN=HLMN
        p%HI_HMO=HMO
        p%HI_HMX=HMX
        p%HI_HR0=HR0
        p%HI_HSM=HSM
        p%HI_HU=HU
        p%HI_HUF=HUF
        p%HI_HUI=HUI
        p%HI_HUSC=HUSC
        p%HI_HYDV=HYDV
        p%HI_OCPD=OCPD
        p%HI_OMAP=OMAP
        p%HI_ORHI=ORHI
        p%HI_ORSD=ORSD
        p%HI_OSAA=OSAA
        p%HI_OWSA=OWSA
        p%HI_PAW=PAW
        p%HI_PCOF=PCOF
        p%HI_PCST=PCST
        p%HI_PCT=PCT
        p%HI_PCTH=PCTH
        p%HI_PDAW=PDAW
        p%HI_PDPL=PDPL
        p%HI_PDPL0=PDPL0
        p%HI_PDPLC=PDPLC
        p%HI_PDPLX=PDPLX
        p%HI_PDSKC=PDSKC
        p%HI_PDSW=PDSW
        p%HI_PEC=PEC
        p%HI_PFOL=PFOL
        p%HI_PH=PH
        p%HI_PHLF=PHLF
        p%HI_PHLS=PHLS
        p%HI_PHU=PHU
        p%HI_PHUX=PHUX
        p%HI_PKOC=PKOC
        p%HI_PKRZ=PKRZ
        p%HI_PLAX=PLAX
        p%HI_PLCH=PLCH
        p%HI_PM10=PM10
        p%HI_PMX=PMX
        p%HI_PO=PO
        p%HI_POP=POP
        p%HI_POPX=POPX
        p%HI_PPCF=PPCF
        p%HI_PPL0=PPL0
        p%HI_PPLA=PPLA
        p%HI_PPLP=PPLP
        p%HI_PPX=PPX
        p%HI_PQPS=PQPS
        p%HI_PRAV=PRAV
        p%HI_PRB=PRB
        p%HI_PRSD=PRSD
        p%HI_PRYF=PRYF
        p%HI_PRYG=PRYG
        p%HI_PSO3=PSO3
        p%HI_PSOL=PSOL
        p%HI_PSON=PSON
        p%HI_PSOP=PSOP
        p%HI_PSOQ=PSOQ
        p%HI_PSOY=PSOY
        p%HI_PSP=PSP
        p%HI_PSSF=PSSF
        p%HI_PSSP=PSSP
        p%HI_PST=PST
        p%HI_PSTE=PSTE
        p%HI_PSTF=PSTF
        p%HI_PSTM=PSTM
        p%HI_PSTR=PSTR
        p%HI_PSTS=PSTS
        p%HI_PSTZ=PSTZ
        p%HI_PSZM=PSZM
        p%HI_PVQ=PVQ
        p%HI_PVY=PVY
        p%HI_PWOF=PWOF
        p%HI_PYPS=PYPS
        p%HI_QC=QC
        p%HI_QCAP=QCAP
        p%HI_QDR=QDR
        p%HI_QDRN=QDRN
        p%HI_QDRP=QDRP
        p%HI_QGA=QGA
        p%HI_QHY=QHY
        p%HI_QIN=QIN
        p%HI_QIR=QIR
        p%HI_QN=QN
        p%HI_QP=QP
        p%HI_QPR=QPR
        p%HI_QPST=QPST
        p%HI_QPU=QPU
        p%HI_QRBQ=QRBQ
        p%HI_QRF=QRF
        p%HI_QRFN=QRFN
        p%HI_QRFP=QRFP
        p%HI_QRP=QRP
        p%HI_QRQB=QRQB
        p%HI_QSF=QSF
        p%HI_QURB=QURB
        p%HI_QVOL=QVOL
        p%HI_RBMD=RBMD
        p%HI_RCBW=RCBW
        p%HI_RCF=RCF
        p%HI_RCHC=RCHC
        p%HI_RCHD=RCHD
        p%HI_RCHK=RCHK
        p%HI_RCHL=RCHL
        p%HI_RCHN=RCHN
        p%HI_RCHS=RCHS
        p%HI_RCHX=RCHX
        p%HI_RCSS=RCSS
        p%HI_RCTC=RCTC
        p%HI_RCTW=RCTW
        p%HI_RD=RD
        p%HI_RDF=RDF
        p%HI_RDMX=RDMX
        p%HI_REG=REG
        p%HI_REPI=REPI
        p%HI_RF5=RF5
        p%HI_RFDT=RFDT
        p%HI_RFPK=RFPK
        p%HI_RFPL=RFPL
        p%HI_RFPS=RFPS
        p%HI_RFPW=RFPW
        p%HI_RFPX=RFPX
        p%HI_RFTT=RFTT
        p%HI_RFV=RFV
        p%HI_RFV0=RFV0
        p%HI_RHD=RHD
        p%HI_RHT=RHT
        p%HI_RHTT=RHTT
        p%HI_RIN=RIN
        p%HI_RINT=RINT
        p%HI_RLAD=RLAD
        p%HI_RLF=RLF
        p%HI_RMXS=RMXS
        p%HI_RNMN=RNMN
        p%HI_ROK=ROK
        p%HI_ROSP=ROSP
        p%HI_RQRB=RQRB
        p%HI_RR=RR
        p%HI_RRUF=RRUF
        p%HI_RSAE=RSAE
        p%HI_RSAP=RSAP
        p%HI_RSBD=RSBD
        p%HI_RSD=RSD
        p%HI_RSDM=RSDM
        p%HI_RSDP=RSDP
        p%HI_RSEE=RSEE
        p%HI_RSEP=RSEP
        p%HI_RSF=RSF
        p%HI_RSFN=RSFN
        p%HI_RSHC=RSHC
        p%HI_RSK=RSK
        p%HI_RSLK=RSLK
        p%HI_RSO3=RSO3
        p%HI_RSOC=RSOC
        p%HI_RSON=RSON
        p%HI_RSOP=RSOP
        p%HI_RSPC=RSPC
        p%HI_RSPK=RSPK
        p%HI_RSPS=RSPS
        p%HI_RSRR=RSRR
        p%HI_RSSA=RSSA
        p%HI_RSSF=RSSF
        p%HI_RSSP=RSSP
        p%HI_RST0=RST0
        p%HI_RSTK=RSTK
        p%HI_RSV=RSV
        p%HI_RSVB=RSVB
        p%HI_RSVE=RSVE
        p%HI_RSVF=RSVF
        p%HI_RSVP=RSVP
        p%HI_RSYB=RSYB
        p%HI_RSYF=RSYF
        p%HI_RSYN=RSYN
        p%HI_RSYS=RSYS
        p%HI_RVE0=RVE0
        p%HI_RVP0=RVP0
        p%HI_RW=RW
        p%HI_RWPC=RWPC
        p%HI_RWSA=RWSA
        p%HI_RWT=RWT
        p%HI_RWTZ=RWTZ
        p%HI_RZ=RZ
        p%HI_RZSW=RZSW
        p%HI_S15=S15
        p%HI_S3=S3
        p%HI_SALA=SALA
        p%HI_SALB=SALB
        p%HI_SAMA=SAMA
        p%HI_SAN=SAN
        p%HI_SATC=SATC
        p%HI_SATK=SATK
        p%HI_SCFS=SCFS
        p%HI_SCI=SCI
        p%HI_SCNX=SCNX
        p%HI_SDVR=SDVR
        p%HI_SDW=SDW
        p%HI_SET=SET
        p%HI_SEV=SEV
        p%HI_SFCP=SFCP
        p%HI_SFMO=SFMO
        p%HI_SHYD=SHYD
        p%HI_SIL=SIL
        p%HI_SLA0=SLA0
        p%HI_SLAI=SLAI
        p%HI_SLF=SLF
        p%HI_SLT0=SLT0
        p%HI_SLTX=SLTX
        p%HI_SM=SM
        p%HI_SMAP=SMAP
        p%HI_SMAS=SMAS
        p%HI_SMB=SMB
        p%HI_SMEA=SMEA
        p%HI_SMEO=SMEO
        p%HI_SMES=SMES
        p%HI_SMFN=SMFN
        p%HI_SMFU=SMFU
        p%HI_SMH=SMH
        p%HI_SMIO=SMIO
        p%HI_SMKS=SMKS
        p%HI_SMLA=SMLA
        p%HI_SMM=SMM
        p%HI_SMMC=SMMC
        p%HI_SMMH=SMMH
        p%HI_SMMP=SMMP
        p%HI_SMMRP=SMMRP
        p%HI_SMMU=SMMU
        p%HI_SMNS=SMNS
        p%HI_SMNU=SMNU
        p%HI_SMPL=SMPL
        p%HI_SMPQ=SMPQ
        p%HI_SMPS=SMPS
        p%HI_SMPY=SMPY
        p%HI_SMRF=SMRF
        p%HI_SMRP=SMRP
        p%HI_SMS=SMS
        p%HI_SMSS=SMSS
        p%HI_SMST=SMST
        p%HI_SMTS=SMTS
        p%HI_SMWS=SMWS
        p%HI_SMX=SMX
        p%HI_SMY=SMY
        p%HI_SMY1=SMY1
        p%HI_SMY2=SMY2
        p%HI_SMYH=SMYH
        p%HI_SMYP=SMYP
        p%HI_SMYRP=SMYRP
        p%HI_SNO=SNO
        p%HI_SOIL=SOIL
        p%HI_SOL=SOL
        p%HI_SOLK=SOLK
        p%HI_SOLQ=SOLQ
        p%HI_SOT=SOT
        p%HI_SPLG=SPLG
        p%HI_SQB=SQB
        p%HI_SQVL=SQVL
        p%HI_SRA=SRA
        p%HI_SRAD=SRAD
        p%HI_SRCH=SRCH
        p%HI_SRD=SRD
        p%HI_SRMX=SRMX
        p%HI_SRSD=SRSD
        p%HI_SSF=SSF
        p%HI_SSFCO2=SSFCO2
        p%HI_SSFI=SSFI
        p%HI_SSFN2O=SSFN2O
        p%HI_SSFO2=SSFO2
        p%HI_SSIN=SSIN
        p%HI_SSPS=SSPS
        p%HI_SST=SST
        p%HI_SSW=SSW
        p%HI_ST0=ST0
        p%HI_STD=STD
        p%HI_STDA=STDA
        p%HI_STDK=STDK
        p%HI_STDL=STDL
        p%HI_STDN=STDN
        p%HI_STDO=STDO
        p%HI_STDOK=STDOK
        p%HI_STDON=STDON
        p%HI_STDOP=STDOP
        p%HI_STDP=STDP
        p%HI_STFR=STFR
        p%HI_STIR=STIR
        p%HI_STKR=STKR
        p%HI_STL=STL
        p%HI_STLT=STLT
        p%HI_STMP=STMP
        p%HI_STP=STP
        p%HI_STV=STV
        p%HI_STX=STX
        p%HI_STY=STY
        p%HI_SULF=SULF
        p%HI_SUT=SUT
        p%HI_SW=SW
        p%HI_SWB=SWB
        p%HI_SWBD=SWBD
        p%HI_SWBX=SWBX
        p%HI_SWH=SWH
        p%HI_SWLT=SWLT
        p%HI_SWP=SWP
        p%HI_SWST=SWST
        p%HI_SYB=SYB
        p%HI_TAGP=TAGP
        p%HI_TAMX=TAMX
        p%HI_TBSC=TBSC
        p%HI_TC=TC
        p%HI_TCAV=TCAV
        p%HI_TCAW=TCAW
        p%HI_TCC=TCC
        p%HI_TCMN=TCMN
        p%HI_TCMX=TCMX
        p%HI_TCN=TCN
        p%HI_TCPA=TCPA
        p%HI_TCPY=TCPY
        p%HI_TCS=TCS
        p%HI_TCVF=TCVF
        p%HI_TDM=TDM
        p%HI_TEI=TEI
        p%HI_TET=TET
        p%HI_TETG=TETG
        p%HI_TFLG=TFLG
        p%HI_TFTK=TFTK
        p%HI_TFTN=TFTN
        p%HI_TFTP=TFTP
        p%HI_THK=THK
        p%HI_THRL=THRL
        p%HI_THU=THU
        p%HI_TILG=TILG
        p%HI_TIR=TIR
        p%HI_TKR=TKR
        p%HI_TLD=TLD
        p%HI_TLMF=TLMF
        p%HI_TMN=TMN
        p%HI_TMX=TMX
        p%HI_TNOR=TNOR
        p%HI_TNYL=TNYL
        p%HI_TOC=TOC
        p%HI_TOPC=TOPC
        p%HI_TPOR=TPOR
        p%HI_TPSF=TPSF
        p%HI_TQ=TQ
        p%HI_TQN=TQN
        p%HI_TQP=TQP
        p%HI_TQPU=TQPU
        p%HI_TR=TR
        p%HI_TRA=TRA
        p%HI_TRD=TRD
        p%HI_TRHT=TRHT
        p%HI_TRSD=TRSD
        p%HI_TSFC=TSFC
        p%HI_TSFK=TSFK
        p%HI_TSFN=TSFN
        p%HI_TSLA=TSLA
        p%HI_TSMY=TSMY
        p%HI_TSN=TSN
        p%HI_TSNO=TSNO
        p%HI_TSPS=TSPS
        p%HI_TSR=TSR
        p%HI_TSY=TSY
        p%HI_TVGF=TVGF
        p%HI_TVIR=TVIR
        p%HI_TXMN=TXMN
        p%HI_TXMX=TXMX
        p%HI_TYK=TYK
        p%HI_TYL1=TYL1
        p%HI_TYL2=TYL2
        p%HI_TYLK=TYLK
        p%HI_TYLN=TYLN
        p%HI_TYLP=TYLP
        p%HI_TYN=TYN
        p%HI_TYON=TYON
        p%HI_TYP=TYP
        p%HI_TYTP=TYTP
        p%HI_TYW=TYW
        p%HI_U10=U10
        p%HI_UB1=UB1
        p%HI_UK=UK
        p%HI_UK1=UK1
        p%HI_UN=UN
        p%HI_UN1=UN1
        p%HI_UNA=UNA
        p%HI_UOB=UOB
        p%HI_UP=UP
        p%HI_UP1=UP1
        p%HI_UPSX=UPSX
        p%HI_URBF=URBF
        p%HI_USL=USL
        p%HI_UW=UW
        p%HI_VAC=VAC
        p%HI_VALF1=VALF1
        p%HI_VAP=VAP
        p%HI_VAR=VAR
        p%HI_VARC=VARC
        p%HI_VARH=VARH
        p%HI_VARP=VARP
        p%HI_VARW=VARW
        p%HI_VCHA=VCHA
        p%HI_VCHB=VCHB
        p%HI_VCO2=VCO2
        p%HI_VFC=VFC
        p%HI_VFPA=VFPA
        p%HI_VFPB=VFPB
        p%HI_VIMX=VIMX
        p%HI_VIR=VIR
        p%HI_VIRR=VIRR
        p%HI_VIRT=VIRT
        p%HI_VLG=VLG
        p%HI_VLGB=VLGB
        p%HI_VLGI=VLGI
        p%HI_VLGM=VLGM
        p%HI_VLGN=VLGN
        p%HI_VN2O=VN2O
        p%HI_VNO3=VNO3
        p%HI_VO2=VO2
        p%HI_VPD2=VPD2
        p%HI_VPTH=VPTH
        p%HI_VPU=VPU
        p%HI_VQ=VQ
        p%HI_VRSE=VRSE
        p%HI_VSK=VSK
        p%HI_VSLT=VSLT
        p%HI_VURN=VURN
        p%HI_VWC=VWC
        p%HI_VWP=VWP
        p%HI_VY=VY
        p%HI_WA=WA
        p%HI_WAC2=WAC2
        p%HI_WAVP=WAVP
        p%HI_WBMC=WBMC
        p%HI_WBMN=WBMN
        p%HI_WCHT=WCHT
        p%HI_WCMU=WCMU
        p%HI_WCO2G=WCO2G
        p%HI_WCO2L=WCO2L
        p%HI_WCOU=WCOU
        p%HI_WCY=WCY
        p%HI_WDRM=WDRM
        p%HI_WFA=WFA
        p%HI_WHPC=WHPC
        p%HI_WHPN=WHPN
        p%HI_WHSC=WHSC
        p%HI_WHSN=WHSN
        p%HI_WK=WK
        p%HI_WKMU=WKMU
        p%HI_WLM=WLM
        p%HI_WLMC=WLMC
        p%HI_WLMN=WLMN
        p%HI_WLS=WLS
        p%HI_WLSC=WLSC
        p%HI_WLSL=WLSL
        p%HI_WLSLC=WLSLC
        p%HI_WLSLNC=WLSLNC
        p%HI_WLSN=WLSN
        p%HI_WLV=WLV
        p%HI_WN2O=WN2O
        p%HI_WN2OG=WN2OG
        p%HI_WN2OL=WN2OL
        p%HI_WNH3=WNH3
        p%HI_WNMU=WNMU
        p%HI_WNO2=WNO2
        p%HI_WNO3=WNO3
        p%HI_WNOU=WNOU
        p%HI_WO2G=WO2G
        p%HI_WO2L=WO2L
        p%HI_WOC=WOC
        p%HI_WON=WON
        p%HI_WPMA=WPMA
        p%HI_WPML=WPML
        p%HI_WPMS=WPMS
        p%HI_WPMU=WPMU
        p%HI_WPO=WPO
        p%HI_WPOU=WPOU
        p%HI_WS=WS
        p%HI_WSA=WSA
        p%HI_WSLT=WSLT
        p%HI_WSX=WSX
        p%HI_WSYF=WSYF
        p%HI_WT=WT
        p%HI_WTBL=WTBL
        p%HI_WTMB=WTMB
        p%HI_WTMN=WTMN
        p%HI_WTMU=WTMU
        p%HI_WTMX=WTMX
        p%HI_WXYF=WXYF
        p%HI_WYLD=WYLD
        p%HI_XCT=XCT
        p%HI_XDLA0=XDLA0
        p%HI_XDLAI=XDLAI
        p%HI_XHSM=XHSM
        p%HI_XIDK=XIDK
        p%HI_XIDS=XIDS
        p%HI_XLAI=XLAI
        p%HI_XMAP=XMAP
        p%HI_XMS=XMS
        p%HI_XMTU=XMTU
        p%HI_XN2O=XN2O
        p%HI_XNS=XNS
        p%HI_XRFI=XRFI
        p%HI_XZP=XZP
        p%HI_YC=YC
        p%HI_YCOU=YCOU
        p%HI_YCT=YCT
        p%HI_YCWN=YCWN
        p%HI_YHY=YHY
        p%HI_YLC=YLC
        p%HI_YLD=YLD
        p%HI_YLD1=YLD1
        p%HI_YLD2=YLD2
        p%HI_YLKF=YLKF
        p%HI_YLNF=YLNF
        p%HI_YLPF=YLPF
        p%HI_YLS=YLS
        p%HI_YLX=YLX
        p%HI_YMNU=YMNU
        p%HI_YN=YN
        p%HI_YNOU=YNOU
        p%HI_YNWN=YNWN
        p%HI_YP=YP
        p%HI_YPOU=YPOU
        p%HI_YPST=YPST
        p%HI_YPWN=YPWN
        p%HI_YSD=YSD
        p%HI_YTN=YTN
        p%HI_YTX=YTX
        p%HI_YW=YW
        p%HI_Z=Z
        p%HI_ZBMC=ZBMC
        p%HI_ZBMN=ZBMN
        p%HI_ZC=ZC
        p%HI_ZCO=ZCO
        p%HI_ZCOB=ZCOB
        p%HI_ZEK=ZEK
        p%HI_ZFK=ZFK
        p%HI_ZFOP=ZFOP
        p%HI_ZHPC=ZHPC
        p%HI_ZHPN=ZHPN
        p%HI_ZHSC=ZHSC
        p%HI_ZHSN=ZHSN
        p%HI_ZLM=ZLM
        p%HI_ZLMC=ZLMC
        p%HI_ZLMN=ZLMN
        p%HI_ZLS=ZLS
        p%HI_ZLSC=ZLSC
        p%HI_ZLSL=ZLSL
        p%HI_ZLSLC=ZLSLC
        p%HI_ZLSLNC=ZLSLNC
        p%HI_ZLSN=ZLSN
        p%HI_ZNMA=ZNMA
        p%HI_ZNMN=ZNMN
        p%HI_ZNMU=ZNMU
        p%HI_ZNOA=ZNOA
        p%HI_ZNOS=ZNOS
        p%HI_ZNOU=ZNOU
        p%HI_ZOC=ZOC
        p%HI_ZON=ZON
        p%HI_ZPMA=ZPMA
        p%HI_ZPML=ZPML
        p%HI_ZPMS=ZPMS
        p%HI_ZPMU=ZPMU
        p%HI_ZPO=ZPO
        p%HI_ZPOU=ZPOU
        p%HI_ZSK=ZSK
        p%HI_ZSLT=ZSLT
        p%HI_ZTP=ZTP

        p%HI_HSG=HSG
        p%HI_RTN1=RTN1
        p%HI_ZTK=ZTK
        p%HI_XLOG=XLOG
        p%HI_APM=APM

        p%HI_BCHL=BCHL
        p%HI_BCHS=BCHS
        p%HI_CHD=CHD
        p%HI_UPN=UPN

        p%HI_SAT1=SAT1
        p%HI_FPS1=FPS1
        p%HI_CO2X=CO2X
        p%HI_CQNX=CQNX
        p%HI_RFNX=RFNX

        p%HI_FMX=FMX
        p%HI_SFLG=SFLG

        p%HI_FI=FI



END SUBROUTINE

!! ******************************************************************************************
!! Restore APEX data FROM HISAFE
!! ******************************************************************************************

SUBROUTINE FROMHISAFE (p)

        USE PARM

        USE HISAFE

        TYPE(Hisafe_),  intent(INOUT) :: p

        IBD=p%HI_IBD
        IBDT=p%HI_IBDT
        ICDP=p%HI_ICDP
        ICMD=p%HI_ICMD
        ICO2=p%HI_ICO2
        ICP=p%HI_ICP
        IDA=p%HI_IDA
        IDAY=p%HI_IDAY
        IDIR=p%HI_IDIR
        IDN1=p%HI_IDN1
        IDN2=p%HI_IDN2
        IDNT=p%HI_IDNT
        IDO=p%HI_IDO
        IERT=p%HI_IERT
        IET=p%HI_IET
        IGC=p%HI_IGC
        IGN=p%HI_IGN
        IGSD=p%HI_IGSD
        IHD=p%HI_IHD
        IHRD=p%HI_IHRD
        IHV=p%HI_IHV
        IHUS=p%HI_IHUS
        IHY=p%HI_IHY
        III=p%HI_III
        IKAT=p%HI_IKAT
        IMON=p%HI_IMON
        INFL=p%HI_INFL
        INP=p%HI_INP
        IOF=p%HI_IOF
        IOW=p%HI_IOW
        IOX=p%HI_IOX
        IPAT=p%HI_IPAT
        IPC=p%HI_IPC
        IPD=p%HI_IPD
        IPF=p%HI_IPF
        IPL=p%HI_IPL
        IPRK=p%HI_IPRK
        IPY=p%HI_IPY
        IPYI=p%HI_IPYI
        IRGX=p%HI_IRGX
        IRH=p%HI_IRH
        IRUN=p%HI_IRUN
        ISA=p%HI_ISA
        ISAP=p%HI_ISAP
        ISCN=p%HI_ISCN
        ISLF=p%HI_ISLF
        ISL=p%HI_ISL
        ISTA=p%HI_ISTA
        ISW=p%HI_ISW
        IT1=p%HI_IT1
        IT2=p%HI_IT2
        IT3=p%HI_IT3
        ITYP=p%HI_ITYP
        IUN=p%HI_IUN
        IWI=p%HI_IWI
        IWTB=p%HI_IWTB
        IY=p%HI_IY
        IYER=p%HI_IYER
        IYR=p%HI_IYR
        IYR0=p%HI_IYR0
        IYX=p%HI_IYX
        JD0=p%HI_JD0
        JDA=p%HI_JDA
        JDE=p%HI_JDE
        JDHU=p%HI_JDHU
        JJK=p%HI_JJK
        JT1=p%HI_JT1
        JT2=p%HI_JT2

        KDA=p%HI_KDA
        KF=p%HI_KF
        KI=p%HI_KI
        KP=p%HI_KP
        LBP=p%HI_LBP
        KND=p%HI_KND
        LC=p%HI_LC
        LGRZ=p%HI_LGRZ
        LGZ=p%HI_LGZ
        LND=p%HI_LND
        LNS=p%HI_LNS
        LPD=p%HI_LPD
        LPYR=p%HI_LPYR
        LW=p%HI_LW
        MASP=p%HI_MASP
        MBS=p%HI_MBS
        MCA12=p%HI_MCA12
        MFT=p%HI_MFT
        MHD=p%HI_MHD
        MHP=p%HI_MHP
        MHX=p%HI_MHX
        MHY=p%HI_MHY
        ML1=p%HI_ML1
        MNC=p%HI_MNC
        MNT=p%HI_MNT
        MNUL=p%HI_MNUL
        MO=p%HI_MO
        MO1=p%HI_MO1
        MOW=p%HI_MOW
        MPO=p%HI_MPO
        MPS=p%HI_MPS
        MRO=p%HI_MRO
        MSA=p%HI_MSA
        MSC=p%HI_MSC
        MSCP=p%HI_MSCP
        MSL=p%HI_MSL
        MXT=p%HI_MXT
        MXW=p%HI_MXW
        NAQ=p%HI_NAQ
        NBCL=p%HI_NBCL
        NBCX=p%HI_NBCX
        NBDT=p%HI_NBDT
        NBFX=p%HI_NBFX
        NBMX=p%HI_NBMX
        NBON=p%HI_NBON
        NBYR=p%HI_NBYR
        NCMD=p%HI_NCMD
        NCMO=p%HI_NCMO
        ND=p%HI_ND
        NDF=p%HI_NDF
        NDP=p%HI_NDP
        NDRV=p%HI_NDRV
        NDT=p%HI_NDT
        NDVSS=p%HI_NDVSS
        NDWT=p%HI_NDWT
        NEV=p%HI_NEV
        NGN=p%HI_NGN
        NGN0=p%HI_NGN0
        NJC=p%HI_NJC
        NKA=p%HI_NKA
        NKD=p%HI_NKD
        NKS=p%HI_NKS
        NKY=p%HI_NKY
        NOFL=p%HI_NOFL
        NOP=p%HI_NOP
        NPD=p%HI_NPD
        NPRC=p%HI_NPRC
        NPSO=p%HI_NPSO
        NRF=p%HI_NRF
        NSH=p%HI_NSH
        NSM=p%HI_NSM
        MSO=p%HI_MSO
        NSNN=p%HI_NSNN
        NSTP=p%HI_NSTP
        NSX=p%HI_NSX
        NSZ=p%HI_NSZ
        NYD=p%HI_NYD
        NT0=p%HI_NT0
        NT1=p%HI_NT1
        NTV=p%HI_NTV
        NUPC=p%HI_NUPC
        NWP=p%HI_NWP
        NWTH=p%HI_NWTH

        KDT1=p%HI_KDT1
        KDC1=p%HI_KDC1
        KDF1=p%HI_KDF1
        KDP1=p%HI_KDP1
        KA=p%HI_KA
        NXP=p%HI_NXP
        KR=p%HI_KR
        KDT2=p%HI_KDT2
        KD=p%HI_KD
        KY=p%HI_KY
        KDP=p%HI_KDP
        NHC=p%HI_NHC
        KS=p%HI_KS
        NWDR=p%HI_NWDR
        IX=p%HI_IX
        NC=p%HI_NC
        IDG=p%HI_IDG
        IX0=p%HI_IX0
        IAD=p%HI_IAD
        ICMO=p%HI_ICMO
        NWPD=p%HI_NWPD
        NDC=p%HI_NDC
        JX=p%HI_JX
        KGN=p%HI_KGN
        JC=p%HI_JC

        ACW=p%HI_ACW
        ADEO=p%HI_ADEO
        ADHY=p%HI_ADHY
        ADRF=p%HI_ADRF
        AEPT=p%HI_AEPT
        AET=p%HI_AET
        AFN=p%HI_AFN
        AGP=p%HI_AGP
        AHSM=p%HI_AHSM
        AJWA=p%HI_AJWA
        ALG=p%HI_ALG
        ALMN=p%HI_ALMN
        ALTC=p%HI_ALTC
        AL5=p%HI_AL5
        AMPX=p%HI_AMPX
        ANG=p%HI_ANG
        AMSR=p%HI_AMSR
        AVT=p%HI_AVT
        BETA=p%HI_BETA
        BRNG=p%HI_BRNG
        BS1=p%HI_BS1
        BS2=p%HI_BS2
        BXCT=p%HI_BXCT
        BYCT=p%HI_BYCT
        CBVT=p%HI_CBVT
        CLF=p%HI_CLF
        CLT=p%HI_CLT
        CMM=p%HI_CMM
        CMS=p%HI_CMS
        CN=p%HI_CN
        CNO3I=p%HI_CNO3I
        COIR=p%HI_COIR
        COL=p%HI_COL
        CON=p%HI_CON
        COP=p%HI_COP
        CO2=p%HI_CO2
        COS1=p%HI_COS1
        CPH0=p%HI_CPH0
        CPV0=p%HI_CPV0
        CPVV=p%HI_CPVV
        CQNI=p%HI_CQNI
        CRLNC=p%HI_CRLNC
        CRUNC=p%HI_CRUNC
        CSFX=p%HI_CSFX
        CSLT=p%HI_CSLT
        D150=p%HI_D150
        DAYL=p%HI_DAYL
        DD=p%HI_DD
        DEMR=p%HI_DEMR
        DN2O=p%HI_DN2O
        DRSW=p%HI_DRSW

        DRTO=p%HI_DRTO
        DTG=p%HI_DTG
        DTHY=p%HI_DTHY
        DUR=p%HI_DUR
        DURG=p%HI_DURG
        DVOL=p%HI_DVOL
        DZ10=p%HI_DZ10
        DZDN=p%HI_DZDN
        EI=p%HI_EI
        ELEV=p%HI_ELEV
        EO=p%HI_EO
        ERTN=p%HI_ERTN
        ERTO=p%HI_ERTO
        ERTP=p%HI_ERTP
        ES=p%HI_ES
        EXNN=p%HI_EXNN
        EXPK=p%HI_EXPK
        FL=p%HI_FL
        FULP=p%HI_FULP
        FW=p%HI_FW
        GWBX=p%HI_GWBX
        GX=p%HI_GX
        HGX=p%HI_HGX
        HMN=p%HI_HMN
        HRLT=p%HI_HRLT
        HR1=p%HI_HR1
        PB=p%HI_PB
        PI2=p%HI_PI2
        PIT=p%HI_PIT
        PMOEO=p%HI_PMOEO
        PMORF=p%HI_PMORF
        PRFF=p%HI_PRFF
        PSTX=p%HI_PSTX
        QAPY=p%HI_QAPY
        QRB=p%HI_QRB
        QSFN=p%HI_QSFN
        QSFP=p%HI_QSFP
        QTH=p%HI_QTH
        RAMX=p%HI_RAMX
        REP=p%HI_REP
        RFNC=p%HI_RFNC
        RFQN=p%HI_RFQN
        RFRA=p%HI_RFRA
        RGIN=p%HI_RGIN
        RGRF=p%HI_RGRF
        RHCF=p%HI_RHCF
        RHM=p%HI_RHM
        RHP=p%HI_RHP
        RHS=p%HI_RHS
        RM=p%HI_RM
        RMNR=p%HI_RMNR
        RMX0=p%HI_RMX0

        RNO3=p%HI_RNO3
        RRF=p%HI_RRF
        RTP=p%HI_RTP
        RUNT=p%HI_RUNT
        RWO=p%HI_RWO
        SAET=p%HI_SAET
        SALF=p%HI_SALF
        SAT=p%HI_SAT
        SBAL=p%HI_SBAL
        SCN=p%HI_SCN
        SCN2=p%HI_SCN2
        SDEG=p%HI_SDEG
        SDEP=p%HI_SDEP
        SDN=p%HI_SDN
        SDRF=p%HI_SDRF
        SEP=p%HI_SEP
        SGMN=p%HI_SGMN
        SHRL=p%HI_SHRL
        SK=p%HI_SK
        SML=p%HI_SML
        SMNR=p%HI_SMNR
        SMP=p%HI_SMP
        SMSQ=p%HI_SMSQ
        SN2=p%HI_SN2
        SN2O=p%HI_SN2O
        SNIT=p%HI_SNIT
        SN=p%HI_SN
        SNMN=p%HI_SNMN
        SNOF=p%HI_SNOF
        SNPKT=p%HI_SNPKT
        SOFU=p%HI_SOFU
        SP=p%HI_SP
        SPRC=p%HI_SPRC
        SPRF=p%HI_SPRF
        SRPM=p%HI_SRPM
        SSFK=p%HI_SSFK
        SSFN=p%HI_SSFN
        SSST=p%HI_SSST
        STND=p%HI_STND
        SUK=p%HI_SUK
        SUN=p%HI_SUN
        SUP=p%HI_SUP
        SVOL=p%HI_SVOL

        SX=p%HI_SX
        SYMU=p%HI_SYMU
        SYW=p%HI_SYW
        TA=p%HI_TA
        TCF=p%HI_TCF        !!Inserted MB 7/29/19
        TCL=p%HI_TCL        !!Inserted MB 7/29/19
        TCR=p%HI_TCR        !!Inserted MB 7/29/19
        TDEG=p%HI_TDEG
        TDEP=p%HI_TDEP
        TEVP=p%HI_TEVP
        TEV1=p%HI_TEV1
        TFMA=p%HI_TFMA
        TFMN=p%HI_TFMN
        TFNO=p%HI_TFNO
        THW=p%HI_THW
        TLA=p%HI_TLA
        TLF=p%HI_TLF       !!Inserted MB 7/29/19
        TNC=p%HI_TNC       !!Inserted MB 7/29/19
        TNF=p%HI_TNF       !!Inserted MB 7/29/19
        TMAF=p%HI_TMAF
        TMAP=p%HI_TMAP
        TMPD=p%HI_TMPD
        TPRK=p%HI_TPRK
        TPSP=p%HI_TPSP
        TREV=p%HI_TREV
        TRFR=p%HI_TRFR
        TRSP=p%HI_TRSP
        TSAE=p%HI_TSAE
        TSFS=p%HI_TSFS
        TX=p%HI_TX
        TXXM=p%HI_TXXM
        UK2=p%HI_UK2
        UKM=p%HI_UKM
        DMN=p%HI_DMN  !! Inserted MB 7/19/19
        UNM=p%HI_UNM
        UNR=p%HI_UNR
        UN2=p%HI_UN2
        UPM=p%HI_UPM
        UPR=p%HI_UPR
        UP2=p%HI_UP2
        USTRT=p%HI_USTRT
        USTT=p%HI_USTT
        USTW=p%HI_USTW
        UX=p%HI_UX
        UXP=p%HI_UXP
        V56=p%HI_V56
        V57=p%HI_V57
        VGF=p%HI_VGF
        VMU=p%HI_VMU
        VPD=p%HI_VPD
        V1=p%HI_V1
        V3=p%HI_V3
        WAGE=p%HI_WAGE
        WB=p%HI_WB
        WCF=p%HI_WCF
        WCYD=p%HI_WCYD
        WDN=p%HI_WDN
        WFX=p%HI_WFX
        WIM=p%HI_WIM
        WIP=p%HI_WIP
        WKA=p%HI_WKA
        WKMNH3=p%HI_WKMNH3
        WKMNO2=p%HI_WKMNO2
        WKMNO3=p%HI_WKMNO3
        WMP=p%HI_WMP
        WNCMAX=p%HI_WNCMAX
        WNCMIN=p%HI_WNCMIN
        WTN=p%HI_WTN
        XCS=p%HI_XCS
        XDA=p%HI_XDA
        XDA1=p%HI_XDA1
        XET=p%HI_XET
        XK1=p%HI_XK1
        XK2=p%HI_XK2
        XKN1=p%HI_XKN1
        XKN3=p%HI_XKN3
        XKN5=p%HI_XKN5
        XKP1=p%HI_XKP1
        XKP2=p%HI_XKP2
        XSA=p%HI_XSA
        XSL=p%HI_XSL
        YCS=p%HI_YCS
        YERO=p%HI_YERO
        YEW=p%HI_YEW
        YEWN=p%HI_YEWN
        YLAT=p%HI_YLAT
        YLAZ=p%HI_YLAZ
        YLN=p%HI_YLN
        YLP=p%HI_YLP
        YMP=p%HI_YMP
        YSL=p%HI_YSL
        YWKS=p%HI_YWKS
        ZF=p%HI_ZF
        ZQT=p%HI_ZQT

        XTP=p%HI_XTP
        XYP=p%HI_XYP
        PRMT=p%HI_PRMT
        SMYR=p%HI_SMYR
        VARS=p%HI_VARS
        RNCF=p%HI_RNCF
        TAV=p%HI_TAV
        TMNF=p%HI_TMNF
        TMXF=p%HI_TMXF
        UAV0=p%HI_UAV0
        UAVM=p%HI_UAVM
        AWXP=p%HI_AWXP
        RFSG=p%HI_RFSG
        SMSO=p%HI_SMSO
        OPV=p%HI_OPV
        SMSW=p%HI_SMSW
        PSZ=p%HI_PSZ
        PSZX=p%HI_PSZX
        PSZY=p%HI_PSZY
        BUS=p%HI_BUS
        WX=p%HI_WX
        XAV=p%HI_XAV
        XDV=p%HI_XDV
        XIM=p%HI_XIM
        XRG=p%HI_XRG
        SMMR=p%HI_SMMR
        SMR=p%HI_SMR
        DIR=p%HI_DIR
        OBMN=p%HI_OBMN
        OBMNX=p%HI_OBMNX
        OBMX=p%HI_OBMX
        OBSL=p%HI_OBSL
        PCF=p%HI_PCF
        RH=p%HI_RH
        SDTMN=p%HI_SDTMN
        SDTMX=p%HI_SDTMX
        WFT=p%HI_WFT
        WI=p%HI_WI
        SCRP=p%HI_SCRP
        CQRB=p%HI_CQRB
        RST=p%HI_RST
        PRW=p%HI_PRW

      !!  CPNM=p%HI_CPNM  !CHAR Down
      !!  FPSO=p%HI_FPSO
      !!  FTNM=p%HI_FTNM
      !!  HED=p%HI_HED
      !!  HEDH=p%HI_HEDH
      !!  PSTN=p%HI_PSTN
      !!  TIL=p%HI_TIL
      !!  TITOP=p%HI_TITOP
      !!  TITSO=p%HI_TITSO

        IAC=p%HI_IAC   !INT Down
        IAMF=p%HI_IAMF
        IAPL=p%HI_IAPL
        IAUF=p%HI_IAUF
        IAUI=p%HI_IAUI
        IAUL=p%HI_IAUL
        IBSA=p%HI_IBSA
        ICDT=p%HI_ICDT
        ICUS=p%HI_ICUS
        IDC=p%HI_IDC
        IDF0=p%HI_IDF0
        IDFA=p%HI_IDFA
        IDFD=p%HI_IDFD
        IDFH=p%HI_IDFH
        IDFT=p%HI_IDFT
        IDMU=p%HI_IDMU
        IDN1T=p%HI_IDN1T
        IDN2T=p%HI_IDN2T
        IDNB=p%HI_IDNB
        IDNF=p%HI_IDNF
        IDOA=p%HI_IDOA
        IDON=p%HI_IDON
        IDOT=p%HI_IDOT
        IDOW=p%HI_IDOW
        IDR=p%HI_IDR
        IDRL=p%HI_IDRL
        IDRO=p%HI_IDRO
        IDS=p%HI_IDS
        IDSL=p%HI_IDSL
        IDSS=p%HI_IDSS
        IEXT=p%HI_IEXT
        IFA=p%HI_IFA
        IFD=p%HI_IFD
        IFED=p%HI_IFED
        IFLO=p%HI_IFLO
        IFLS=p%HI_IFLS
        IGO=p%HI_IGO
        IGZ=p%HI_IGZ
        IGZO=p%HI_IGZO
        IGZX=p%HI_IGZX
        IHBS=p%HI_IHBS
        IHC=p%HI_IHC
        IHDM=p%HI_IHDM
        IHDT=p%HI_IHDT
        IHRL=p%HI_IHRL
        IHT=p%HI_IHT
        IHU=p%HI_IHU
        IHX=p%HI_IHX
        IIR=p%HI_IIR
        ILQF=p%HI_ILQF
        IMW=p%HI_IMW
        IPMP=p%HI_IPMP
        IPSF=p%HI_IPSF
        IPSO=p%HI_IPSO
        IPST=p%HI_IPST
        IPTS=p%HI_IPTS
        IRF=p%HI_IRF
        IRI=p%HI_IRI
        IRO=p%HI_IRO
        IRP=p%HI_IRP
        IRR=p%HI_IRR
        IRRS=p%HI_IRRS
        ISAL=p%HI_ISAL
        ISAO=p%HI_ISAO
        ISAS=p%HI_ISAS
        ISCP=p%HI_ISCP
        ISG=p%HI_ISG
        ISPF=p%HI_ISPF
        ITL=p%HI_ITL
        IWTH=p%HI_IWTH
        IYH=p%HI_IYH
        IYHO=p%HI_IYHO
        JBG=p%HI_JBG
        JCN=p%HI_JCN
        JCN0=p%HI_JCN0
        JCN1=p%HI_JCN1
        JD=p%HI_JD
        JE=p%HI_JE
        JH=p%HI_JH
        JP=p%HI_JP
        JPC=p%HI_JPC
        JPL=p%HI_JPL
        KC=p%HI_KC
        KDC=p%HI_KDC
        KDF=p%HI_KDF
        KDT=p%HI_KDT
        KFL=p%HI_KFL
        KGO=p%HI_KGO
        KIR=p%HI_KIR
        KOMP=p%HI_KOMP
        KP1=p%HI_KP1
        KPC=p%HI_KPC
        KPSN=p%HI_KPSN
        KT=p%HI_KT
        KTF=p%HI_KTF
        KTMX=p%HI_KTMX
        KTT=p%HI_KTT
        KW=p%HI_KW
        LFT=p%HI_LFT
        LGIR=p%HI_LGIR
        LID=p%HI_LID
        LM=p%HI_LM
        LORG=p%HI_LORG
        LPC=p%HI_LPC
        LRD=p%HI_LRD
        LT=p%HI_LT
        LUN=p%HI_LUN
        LUNS=p%HI_LUNS
        LY=p%HI_LY
        LYR=p%HI_LYR
        MXSR=p%HI_MXSR
        NBCF=p%HI_NBCF
        NBCT=p%HI_NBCT
        NBE=p%HI_NBE
        NBFF=p%HI_NBFF
        NBFT=p%HI_NBFT
        NBHS=p%HI_NBHS
        NBSA=p%HI_NBSA
        NBSL=p%HI_NBSL
        NBSX=p%HI_NBSX
        NBT=p%HI_NBT
        NBW=p%HI_NBW
        NCOW=p%HI_NCOW
        NCP=p%HI_NCP
        NCR=p%HI_NCR
        NDFA=p%HI_NDFA
        NFED=p%HI_NFED
        NFRT=p%HI_NFRT
        NGIX=p%HI_NGIX
        NGZ=p%HI_NGZ
        NGZA=p%HI_NGZA
        NHBS=p%HI_NHBS
        NHRD=p%HI_NHRD
        NHU=p%HI_NHU
        NHY=p%HI_NHY
        NII=p%HI_NII
        NIR=p%HI_NIR
        NISA=p%HI_NISA
        NMW=p%HI_NMW
        NPC=p%HI_NPC
        NPSF=p%HI_NPSF
        NPST=p%HI_NPST
        NQRB=p%HI_NQRB
        NRO=p%HI_NRO
        NSAL=p%HI_NSAL
        NSAO=p%HI_NSAO
        NSAS=p%HI_NSAS
        NTL=p%HI_NTL
        NTP=p%HI_NTP
        NTX=p%HI_NTX
        NVCN=p%HI_NVCN
        NWDA=p%HI_NWDA
        NYHO=p%HI_NYHO
        NYLN=p%HI_NYLN
        ABD=p%HI_ABD   !REAL Down
        ACET=p%HI_ACET
        ACO2C=p%HI_ACO2C
        AEP=p%HI_AEP
        AFLG=p%HI_AFLG
        AFP=p%HI_AFP
        AGPM=p%HI_AGPM
        AJHI=p%HI_AJHI
        ALGI=p%HI_ALGI
        ALQ=p%HI_ALQ
        ALS=p%HI_ALS
        ALT=p%HI_ALT
        AN2OC=p%HI_AN2OC
        ANA=p%HI_ANA
        AO2C=p%HI_AO2C
        ARMN=p%HI_ARMN
        ARMX=p%HI_ARMX
        ARSD=p%HI_ARSD
        ASW=p%HI_ASW
        AWC=p%HI_AWC
        BA1=p%HI_BA1
        BA2=p%HI_BA2
        BCOF=p%HI_BCOF
        BCV=p%HI_BCV
        BD=p%HI_BD
        BDD=p%HI_BDD
        BDM=p%HI_BDM
        BDP=p%HI_BDP
        BFFL=p%HI_BFFL
        BFSN=p%HI_BFSN
        BFT=p%HI_BFT
        BGWS=p%HI_BGWS
        BIG=p%HI_BIG
        BIR=p%HI_BIR
        BK=p%HI_BK
        BLG=p%HI_BLG
        BN=p%HI_BN
        BP=p%HI_BP
        BPT=p%HI_BPT
        BR1=p%HI_BR1
        BR2=p%HI_BR2
        BRSV=p%HI_BRSV
        BSALA=p%HI_BSALA
        BSNO=p%HI_BSNO
        BTC=p%HI_BTC
        BTCX=p%HI_BTCX
        BTCZ=p%HI_BTCZ
        BTK=p%HI_BTK
        BTN=p%HI_BTN
        BTNX=p%HI_BTNX
        BTNZ=p%HI_BTNZ
        BTP=p%HI_BTP
        BTPX=p%HI_BTPX
        BTPZ=p%HI_BTPZ
        BV1=p%HI_BV1
        BV2=p%HI_BV2
        BVIR=p%HI_BVIR
        BWN=p%HI_BWN
        CAC=p%HI_CAC
        CAF=p%HI_CAF
        CAW=p%HI_CAW
        CBN=p%HI_CBN
        CDG=p%HI_CDG
        CEC=p%HI_CEC
        CFNP=p%HI_CFNP
        CGCO2=p%HI_CGCO2
        CGN2O=p%HI_CGN2O
        CGO2=p%HI_CGO2
        CHL=p%HI_CHL
        CHN=p%HI_CHN
        CHS=p%HI_CHS
        CHXA=p%HI_CHXA
        CHXP=p%HI_CHXP
        CKY=p%HI_CKY
        CLA=p%HI_CLA
        CLCO2=p%HI_CLCO2
        CLG=p%HI_CLG
        CLN2O=p%HI_CLN2O
        CLO2=p%HI_CLO2
        CN0=p%HI_CN0
        CN2=p%HI_CN2
        CND=p%HI_CND
        CNDS=p%HI_CNDS
        CNLV=p%HI_CNLV
        CNRT=p%HI_CNRT
        CNSC=p%HI_CNSC
        CNSX=p%HI_CNSX
        CNY=p%HI_CNY
        COOP=p%HI_COOP
        COST=p%HI_COST
        COTL=p%HI_COTL
        COWW=p%HI_COWW
        CPFH=p%HI_CPFH
        CPHT=p%HI_CPHT
        CPMX=p%HI_CPMX
        CPRH=p%HI_CPRH
        CPRV=p%HI_CPRV
        CPVH=p%HI_CPVH
        CPY=p%HI_CPY
        CST1=p%HI_CST1
        CSTF=p%HI_CSTF
        CSTS=p%HI_CSTS
        CTSA=p%HI_CTSA
        CV=p%HI_CV
        CVF=p%HI_CVF
        CVP=p%HI_CVP
        CVRS=p%HI_CVRS
        CX=p%HI_CX
        CYAV=p%HI_CYAV
        CYMX=p%HI_CYMX
        CYSD=p%HI_CYSD
        DALG=p%HI_DALG
        DCO2GEN=p%HI_DCO2GEN
        DDLG=p%HI_DDLG
        DDM=p%HI_DDM
        DEPC=p%HI_DEPC
        DHN=p%HI_DHN
        DHT=p%HI_DHT
        DKH=p%HI_DKH
        DKHL=p%HI_DKHL
        DKI=p%HI_DKI
        DKIN=p%HI_DKIN
        DLAI=p%HI_DLAI
        DLAP=p%HI_DLAP
        DM=p%HI_DM
        DM1=p%HI_DM1
        DMF=p%HI_DMF
        DMLA=p%HI_DMLA
        DMLX=p%HI_DMLX
        DN2G=p%HI_DN2G
        DN2OG=p%HI_DN2OG
        DO2CONS=p%HI_DO2CONS
        DPMT=p%HI_DPMT
        DPRC=p%HI_DPRC
        DPRN=p%HI_DPRN
        DPRO=p%HI_DPRO
        DRAV=p%HI_DRAV
        DRT=p%HI_DRT
        DRWX=p%HI_DRWX
        DST0=p%HI_DST0
        DUMP=p%HI_DUMP
        DWOC=p%HI_DWOC
        EAR=p%HI_EAR
        ECND=p%HI_ECND
        EFI=p%HI_EFI
        EFM=p%HI_EFM
        EK=p%HI_EK
        EM10=p%HI_EM10
        EMX=p%HI_EMX
        EO5=p%HI_EO5
        EP=p%HI_EP
        EQKE=p%HI_EQKE
        EQKS=p%HI_EQKS
        ERAV=p%HI_ERAV
        ETG=p%HI_ETG
        EVRS=p%HI_EVRS
        EVRT=p%HI_EVRT
        EXCK=p%HI_EXCK
        EXTC=p%HI_EXTC
        FBM=p%HI_FBM
        FC=p%HI_FC
        FCMN=p%HI_FCMN
        FCMP=p%HI_FCMP
        FCST=p%HI_FCST
        FDSF=p%HI_FDSF
        FE26=p%HI_FE26
        FFC=p%HI_FFC
        FFED=p%HI_FFED
        FFPQ=p%HI_FFPQ
        FGC=p%HI_FGC
        FGSL=p%HI_FGSL
        FHP=p%HI_FHP
        FIRG=p%HI_FIRG
        FIRX=p%HI_FIRX
        FIXK=p%HI_FIXK
        FK=p%HI_FK
        FLT=p%HI_FLT
        FN=p%HI_FN
        FNMA=p%HI_FNMA
        FNMN=p%HI_FNMN
        FNMX=p%HI_FNMX
        FNO=p%HI_FNO
        FNP=p%HI_FNP
        FOC=p%HI_FOC
        FOP=p%HI_FOP
        FP=p%HI_FP
        FPF=p%HI_FPF
        FPO=p%HI_FPO
        FPOP=p%HI_FPOP
        FPSC=p%HI_FPSC
        FRCP=p%HI_FRCP
        FRST=p%HI_FRST
        FRTK=p%HI_FRTK
        FRTN=p%HI_FRTN
        FRTP=p%HI_FRTP
        FSFN=p%HI_FSFN
        FSFP=p%HI_FSFP
        FSLT=p%HI_FSLT
        FTO=p%HI_FTO
        FULU=p%HI_FULU
        GCOW=p%HI_GCOW
        GMA=p%HI_GMA
        GMHU=p%HI_GMHU
        GRDD=p%HI_GRDD
        GRDL=p%HI_GRDL
        GRLV=p%HI_GRLV
        GSI=p%HI_GSI
        GWMX=p%HI_GWMX
        GWPS=p%HI_GWPS
        GWSN=p%HI_GWSN
        GWST=p%HI_GWST
        GZLM=p%HI_GZLM
        GZRT=p%HI_GZRT
        HA=p%HI_HA
		HCL=p%HI_HCL
        HCLD=p%HI_HCLD
        HCLN=p%HI_HCLN
        HE=p%HI_HE
        HI=p%HI_HI
        HKPC=p%HI_HKPC
        HKPN=p%HI_HKPN
        HKPO=p%HI_HKPO
        HLMN=p%HI_HLMN
        HMO=p%HI_HMO
        HMX=p%HI_HMX
        HR0=p%HI_HR0
        HSM=p%HI_HSM
        HU=p%HI_HU
        HUF=p%HI_HUF
        HUI=p%HI_HUI
        HUSC=p%HI_HUSC
        HYDV=p%HI_HYDV
        OCPD=p%HI_OCPD
        OMAP=p%HI_OMAP
        ORHI=p%HI_ORHI
        ORSD=p%HI_ORSD
        OSAA=p%HI_OSAA
        OWSA=p%HI_OWSA
        PAW=p%HI_PAW
        PCOF=p%HI_PCOF
        PCST=p%HI_PCST
        PCT=p%HI_PCT
        PCTH=p%HI_PCTH
        PDAW=p%HI_PDAW
        PDPL=p%HI_PDPL
        PDPL0=p%HI_PDPL0
        PDPLC=p%HI_PDPLC
        PDPLX=p%HI_PDPLX
        PDSKC=p%HI_PDSKC
        PDSW=p%HI_PDSW
        PEC=p%HI_PEC
        PFOL=p%HI_PFOL
        PH=p%HI_PH
        PHLF=p%HI_PHLF
        PHLS=p%HI_PHLS
        PHU=p%HI_PHU
        PHUX=p%HI_PHUX
        PKOC=p%HI_PKOC
        PKRZ=p%HI_PKRZ
        PLAX=p%HI_PLAX
        PLCH=p%HI_PLCH
        PM10=p%HI_PM10
        PMX=p%HI_PMX
        PO=p%HI_PO
        POP=p%HI_POP
        POPX=p%HI_POPX
        PPCF=p%HI_PPCF
        PPL0=p%HI_PPL0
        PPLA=p%HI_PPLA
        PPLP=p%HI_PPLP
        PPX=p%HI_PPX
        PQPS=p%HI_PQPS
        PRAV=p%HI_PRAV
        PRB=p%HI_PRB
        PRSD=p%HI_PRSD
        PRYF=p%HI_PRYF
        PRYG=p%HI_PRYG
        PSO3=p%HI_PSO3
        PSOL=p%HI_PSOL
        PSON=p%HI_PSON
        PSOP=p%HI_PSOP
        PSOQ=p%HI_PSOQ
        PSOY=p%HI_PSOY
        PSP=p%HI_PSP
        PSSF=p%HI_PSSF
        PSSP=p%HI_PSSP
        PST=p%HI_PST
        PSTE=p%HI_PSTE
        PSTF=p%HI_PSTF
        PSTM=p%HI_PSTM
        PSTR=p%HI_PSTR
        PSTS=p%HI_PSTS
        PSTZ=p%HI_PSTZ
        PSZM=p%HI_PSZM
        PVQ=p%HI_PVQ
        PVY=p%HI_PVY
        PWOF=p%HI_PWOF
        PYPS=p%HI_PYPS
        QC=p%HI_QC
        QCAP=p%HI_QCAP
        QDR=p%HI_QDR
        QDRN=p%HI_QDRN
        QDRP=p%HI_QDRP
        QGA=p%HI_QGA
        QHY=p%HI_QHY
        QIN=p%HI_QIN
        QIR=p%HI_QIR
        QN=p%HI_QN
        QP=p%HI_QP
        QPR=p%HI_QPR
        QPST=p%HI_QPST
        QPU=p%HI_QPU
        QRBQ=p%HI_QRBQ
        QRF=p%HI_QRF
        QRFN=p%HI_QRFN
        QRFP=p%HI_QRFP
        QRP=p%HI_QRP
        QRQB=p%HI_QRQB
        QSF=p%HI_QSF
        QURB=p%HI_QURB
        QVOL=p%HI_QVOL
        RBMD=p%HI_RBMD
        RCBW=p%HI_RCBW
        RCF=p%HI_RCF
        RCHC=p%HI_RCHC
        RCHD=p%HI_RCHD
        RCHK=p%HI_RCHK
        RCHL=p%HI_RCHL
        RCHN=p%HI_RCHN
        RCHS=p%HI_RCHS
        RCHX=p%HI_RCHX
        RCSS=p%HI_RCSS
        RCTC=p%HI_RCTC
        RCTW=p%HI_RCTW
        RD=p%HI_RD
        RDF=p%HI_RDF
        RDMX=p%HI_RDMX
        REG=p%HI_REG
        REPI=p%HI_REPI
        RF5=p%HI_RF5
        RFDT=p%HI_RFDT
        RFPK=p%HI_RFPK
        RFPL=p%HI_RFPL
        RFPS=p%HI_RFPS
        RFPW=p%HI_RFPW
        RFPX=p%HI_RFPX
        RFTT=p%HI_RFTT
        RFV=p%HI_RFV
        RFV0=p%HI_RFV0
        RHD=p%HI_RHD
        RHT=p%HI_RHT
        RHTT=p%HI_RHTT
        RIN=p%HI_RIN
        RINT=p%HI_RINT
        RLAD=p%HI_RLAD
        RLF=p%HI_RLF
        RMXS=p%HI_RMXS
        RNMN=p%HI_RNMN
        ROK=p%HI_ROK
        ROSP=p%HI_ROSP
        RQRB=p%HI_RQRB
        RR=p%HI_RR
        RRUF=p%HI_RRUF
        RSAE=p%HI_RSAE
        RSAP=p%HI_RSAP
        RSBD=p%HI_RSBD
        RSD=p%HI_RSD
        RSDM=p%HI_RSDM
        RSDP=p%HI_RSDP
        RSEE=p%HI_RSEE
        RSEP=p%HI_RSEP
        RSF=p%HI_RSF
        RSFN=p%HI_RSFN
        RSHC=p%HI_RSHC
        RSK=p%HI_RSK
        RSLK=p%HI_RSLK
        RSO3=p%HI_RSO3
        RSOC=p%HI_RSOC
        RSON=p%HI_RSON
        RSOP=p%HI_RSOP
        RSPC=p%HI_RSPC
        RSPK=p%HI_RSPK
        RSPS=p%HI_RSPS
        RSRR=p%HI_RSRR
        RSSA=p%HI_RSSA
        RSSF=p%HI_RSSF
        RSSP=p%HI_RSSP
        RST0=p%HI_RST0
        RSTK=p%HI_RSTK
        RSV=p%HI_RSV
        RSVB=p%HI_RSVB
        RSVE=p%HI_RSVE
        RSVF=p%HI_RSVF
        RSVP=p%HI_RSVP
        RSYB=p%HI_RSYB
        RSYF=p%HI_RSYF
        RSYN=p%HI_RSYN
        RSYS=p%HI_RSYS
        RVE0=p%HI_RVE0
        RVP0=p%HI_RVP0
        RW=p%HI_RW
        RWPC=p%HI_RWPC
        RWSA=p%HI_RWSA
        RWT=p%HI_RWT
        RWTZ=p%HI_RWTZ
        RZ=p%HI_RZ
        RZSW=p%HI_RZSW
        S15=p%HI_S15
        S3=p%HI_S3
        SALA=p%HI_SALA
        SALB=p%HI_SALB
        SAMA=p%HI_SAMA
        SAN=p%HI_SAN
        SATC=p%HI_SATC
        SATK=p%HI_SATK
        SCFS=p%HI_SCFS
        SCI=p%HI_SCI
        SCNX=p%HI_SCNX
        SDVR=p%HI_SDVR
        SDW=p%HI_SDW
        SET=p%HI_SET
        SEV=p%HI_SEV
        SFCP=p%HI_SFCP
        SFMO=p%HI_SFMO
        SHYD=p%HI_SHYD
        SIL=p%HI_SIL
        SLA0=p%HI_SLA0
        SLAI=p%HI_SLAI
        SLF=p%HI_SLF
        SLT0=p%HI_SLT0
        SLTX=p%HI_SLTX
        SM=p%HI_SM
        SMAP=p%HI_SMAP
        SMAS=p%HI_SMAS
        SMB=p%HI_SMB
        SMEA=p%HI_SMEA
        SMEO=p%HI_SMEO
        SMES=p%HI_SMES
        SMFN=p%HI_SMFN
        SMFU=p%HI_SMFU
        SMH=p%HI_SMH
        SMIO=p%HI_SMIO
        SMKS=p%HI_SMKS
        SMLA=p%HI_SMLA
        SMM=p%HI_SMM
        SMMC=p%HI_SMMC
        SMMH=p%HI_SMMH
        SMMP=p%HI_SMMP
        SMMRP=p%HI_SMMRP
        SMMU=p%HI_SMMU
        SMNS=p%HI_SMNS
        SMNU=p%HI_SMNU
        SMPL=p%HI_SMPL
        SMPQ=p%HI_SMPQ
        SMPS=p%HI_SMPS
        SMPY=p%HI_SMPY
        SMRF=p%HI_SMRF
        SMRP=p%HI_SMRP
        SMS=p%HI_SMS
        SMSS=p%HI_SMSS
        SMST=p%HI_SMST
        SMTS=p%HI_SMTS
        SMWS=p%HI_SMWS
        SMX=p%HI_SMX
        SMY=p%HI_SMY
        SMY1=p%HI_SMY1
        SMY2=p%HI_SMY2
        SMYH=p%HI_SMYH
        SMYP=p%HI_SMYP
        SMYRP=p%HI_SMYRP
        SNO=p%HI_SNO
        SOIL=p%HI_SOIL
        SOL=p%HI_SOL
        SOLK=p%HI_SOLK
        SOLQ=p%HI_SOLQ
        SOT=p%HI_SOT
        SPLG=p%HI_SPLG
        SQB=p%HI_SQB
        SQVL=p%HI_SQVL
        SRA=p%HI_SRA
        SRAD=p%HI_SRAD
        SRCH=p%HI_SRCH
        SRD=p%HI_SRD
        SRMX=p%HI_SRMX
        SRSD=p%HI_SRSD
        SSF=p%HI_SSF
        SSFCO2=p%HI_SSFCO2
        SSFI=p%HI_SSFI
        SSFN2O=p%HI_SSFN2O
        SSFO2=p%HI_SSFO2
        SSIN=p%HI_SSIN
        SSPS=p%HI_SSPS
        SST=p%HI_SST
        SSW=p%HI_SSW
        ST0=p%HI_ST0
        STD=p%HI_STD
        STDA=p%HI_STDA
        STDK=p%HI_STDK
        STDL=p%HI_STDL
        STDN=p%HI_STDN
        STDO=p%HI_STDO
        STDOK=p%HI_STDOK
        STDON=p%HI_STDON
        STDOP=p%HI_STDOP
        STDP=p%HI_STDP
        STFR=p%HI_STFR
        STIR=p%HI_STIR
        STKR=p%HI_STKR
        STL=p%HI_STL
        STLT=p%HI_STLT
        STMP=p%HI_STMP
        STP=p%HI_STP
        STV=p%HI_STV
        STX=p%HI_STX
        STY=p%HI_STY
        SULF=p%HI_SULF
        SUT=p%HI_SUT
        SW=p%HI_SW
        SWB=p%HI_SWB
        SWBD=p%HI_SWBD
        SWBX=p%HI_SWBX
        SWH=p%HI_SWH
        SWLT=p%HI_SWLT
        SWP=p%HI_SWP
        SWST=p%HI_SWST
        SYB=p%HI_SYB
        TAGP=p%HI_TAGP
        TAMX=p%HI_TAMX
        TBSC=p%HI_TBSC
        TC=p%HI_TC
        TCAV=p%HI_TCAV
        TCAW=p%HI_TCAW
        TCC=p%HI_TCC
        TCMN=p%HI_TCMN
        TCMX=p%HI_TCMX
        TCN=p%HI_TCN
        TCPA=p%HI_TCPA
        TCPY=p%HI_TCPY
        TCS=p%HI_TCS
        TCVF=p%HI_TCVF
        TDM=p%HI_TDM
        TEI=p%HI_TEI
        TET=p%HI_TET
        TETG=p%HI_TETG
        TFLG=p%HI_TFLG
        TFTK=p%HI_TFTK
        TFTN=p%HI_TFTN
        TFTP=p%HI_TFTP
        THK=p%HI_THK
        THRL=p%HI_THRL
        THU=p%HI_THU
        TILG=p%HI_TILG
        TIR=p%HI_TIR
        TKR=p%HI_TKR
        TLD=p%HI_TLD
        TLMF=p%HI_TLMF
        TMN=p%HI_TMN
        TMX=p%HI_TMX
        TNOR=p%HI_TNOR
        TNYL=p%HI_TNYL
        TOC=p%HI_TOC
        TOPC=p%HI_TOPC
        TPOR=p%HI_TPOR
        TPSF=p%HI_TPSF
        TQ=p%HI_TQ
        TQN=p%HI_TQN
        TQP=p%HI_TQP
        TQPU=p%HI_TQPU
        TR=p%HI_TR
        TRA=p%HI_TRA
        TRD=p%HI_TRD
        TRHT=p%HI_TRHT
        TRSD=p%HI_TRSD
        TSFC=p%HI_TSFC
        TSFK=p%HI_TSFK
        TSFN=p%HI_TSFN
        TSLA=p%HI_TSLA
        TSMY=p%HI_TSMY
        TSN=p%HI_TSN
        TSNO=p%HI_TSNO
        TSPS=p%HI_TSPS
        TSR=p%HI_TSR
        TSY=p%HI_TSY
        TVGF=p%HI_TVGF
        TVIR=p%HI_TVIR
        TXMN=p%HI_TXMN
        TXMX=p%HI_TXMX
        TYK=p%HI_TYK
        TYL1=p%HI_TYL1
        TYL2=p%HI_TYL2
        TYLK=p%HI_TYLK
        TYLN=p%HI_TYLN
        TYLP=p%HI_TYLP
        TYN=p%HI_TYN
        TYON=p%HI_TYON
        TYP=p%HI_TYP
        TYTP=p%HI_TYTP
        TYW=p%HI_TYW
        U10=p%HI_U10
        UB1=p%HI_UB1
        UK=p%HI_UK
        UK1=p%HI_UK1
        UN=p%HI_UN
        UN1=p%HI_UN1
        UNA=p%HI_UNA
        UOB=p%HI_UOB
        UP=p%HI_UP
        UP1=p%HI_UP1
        UPSX=p%HI_UPSX
        URBF=p%HI_URBF
        USL=p%HI_USL
        UW=p%HI_UW
        VAC=p%HI_VAC
        VALF1=p%HI_VALF1
        VAP=p%HI_VAP
        VAR=p%HI_VAR
        VARC=p%HI_VARC
        VARH=p%HI_VARH
        VARP=p%HI_VARP
        VARW=p%HI_VARW
        VCHA=p%HI_VCHA
        VCHB=p%HI_VCHB
        VCO2=p%HI_VCO2
        VFC=p%HI_VFC
        VFPA=p%HI_VFPA
        VFPB=p%HI_VFPB
        VIMX=p%HI_VIMX
        VIR=p%HI_VIR
        VIRR=p%HI_VIRR
        VIRT=p%HI_VIRT
        VLG=p%HI_VLG
        VLGB=p%HI_VLGB
        VLGI=p%HI_VLGI
        VLGM=p%HI_VLGM
        VLGN=p%HI_VLGN
        VN2O=p%HI_VN2O
        VNO3=p%HI_VNO3
        VO2=p%HI_VO2
        VPD2=p%HI_VPD2
        VPTH=p%HI_VPTH
        VPU=p%HI_VPU
        VQ=p%HI_VQ
        VRSE=p%HI_VRSE
        VSK=p%HI_VSK
        VSLT=p%HI_VSLT
        VURN=p%HI_VURN
        VWC=p%HI_VWC
        VWP=p%HI_VWP
        VY=p%HI_VY
        WA=p%HI_WA
        WAC2=p%HI_WAC2
        WAVP=p%HI_WAVP
        WBMC=p%HI_WBMC
        WBMN=p%HI_WBMN
        WCHT=p%HI_WCHT
        WCMU=p%HI_WCMU
        WCO2G=p%HI_WCO2G
        WCO2L=p%HI_WCO2L
        WCOU=p%HI_WCOU
        WCY=p%HI_WCY
        WDRM=p%HI_WDRM
        WFA=p%HI_WFA
        WHPC=p%HI_WHPC
        WHPN=p%HI_WHPN
        WHSC=p%HI_WHSC
        WHSN=p%HI_WHSN
        WK=p%HI_WK
        WKMU=p%HI_WKMU
        WLM=p%HI_WLM
        WLMC=p%HI_WLMC
        WLMN=p%HI_WLMN
        WLS=p%HI_WLS
        WLSC=p%HI_WLSC
        WLSL=p%HI_WLSL
        WLSLC=p%HI_WLSLC
        WLSLNC=p%HI_WLSLNC
        WLSN=p%HI_WLSN
        WLV=p%HI_WLV
        WN2O=p%HI_WN2O
        WN2OG=p%HI_WN2OG
        WN2OL=p%HI_WN2OL
        WNH3=p%HI_WNH3
        WNMU=p%HI_WNMU
        WNO2=p%HI_WNO2
        WNO3=p%HI_WNO3
        WNOU=p%HI_WNOU
        WO2G=p%HI_WO2G
        WO2L=p%HI_WO2L
        WOC=p%HI_WOC
        WON=p%HI_WON
        WPMA=p%HI_WPMA
        WPML=p%HI_WPML
        WPMS=p%HI_WPMS
        WPMU=p%HI_WPMU
        WPO=p%HI_WPO
        WPOU=p%HI_WPOU
        WS=p%HI_WS
        WSA=p%HI_WSA
        WSLT=p%HI_WSLT
        WSX=p%HI_WSX
        WSYF=p%HI_WSYF
        WT=p%HI_WT
        WTBL=p%HI_WTBL
        WTMB=p%HI_WTMB
        WTMN=p%HI_WTMN
        WTMU=p%HI_WTMU
        WTMX=p%HI_WTMX
        WXYF=p%HI_WXYF
        WYLD=p%HI_WYLD
        XCT=p%HI_XCT
        XDLA0=p%HI_XDLA0
        XDLAI=p%HI_XDLAI
        XHSM=p%HI_XHSM
        XIDK=p%HI_XIDK
        XIDS=p%HI_XIDS
        XLAI=p%HI_XLAI
        XMAP=p%HI_XMAP
        XMS=p%HI_XMS
        XMTU=p%HI_XMTU
        XN2O=p%HI_XN2O
        XNS=p%HI_XNS
        XRFI=p%HI_XRFI
        XZP=p%HI_XZP
        YC=p%HI_YC
        YCOU=p%HI_YCOU
        YCT=p%HI_YCT
        YCWN=p%HI_YCWN
        YHY=p%HI_YHY
        YLC=p%HI_YLC
        YLD=p%HI_YLD
        YLD1=p%HI_YLD1
        YLD2=p%HI_YLD2
        YLKF=p%HI_YLKF
        YLNF=p%HI_YLNF
        YLPF=p%HI_YLPF
        YLS=p%HI_YLS
        YLX=p%HI_YLX
        YMNU=p%HI_YMNU
        YN=p%HI_YN
        YNOU=p%HI_YNOU
        YNWN=p%HI_YNWN
        YP=p%HI_YP
        YPOU=p%HI_YPOU
        YPST=p%HI_YPST
        YPWN=p%HI_YPWN
        YSD=p%HI_YSD
        YTN=p%HI_YTN
        YTX=p%HI_YTX
        YW=p%HI_YW
        Z=p%HI_Z
        ZBMC=p%HI_ZBMC
        ZBMN=p%HI_ZBMN
        ZC=p%HI_ZC
        ZCO=p%HI_ZCO
        ZCOB=p%HI_ZCOB
        ZEK=p%HI_ZEK
        ZFK=p%HI_ZFK
        ZFOP=p%HI_ZFOP
        ZHPC=p%HI_ZHPC
        ZHPN=p%HI_ZHPN
        ZHSC=p%HI_ZHSC
        ZHSN=p%HI_ZHSN
        ZLM=p%HI_ZLM
        ZLMC=p%HI_ZLMC
        ZLMN=p%HI_ZLMN
        ZLS=p%HI_ZLS
        ZLSC=p%HI_ZLSC
        ZLSL=p%HI_ZLSL
        ZLSLC=p%HI_ZLSLC
        ZLSLNC=p%HI_ZLSLNC
        ZLSN=p%HI_ZLSN
        ZNMA=p%HI_ZNMA
        ZNMN=p%HI_ZNMN
        ZNMU=p%HI_ZNMU
        ZNOA=p%HI_ZNOA
        ZNOS=p%HI_ZNOS
        ZNOU=p%HI_ZNOU
        ZOC=p%HI_ZOC
        ZON=p%HI_ZON
        ZPMA=p%HI_ZPMA
        ZPML=p%HI_ZPML
        ZPMS=p%HI_ZPMS
        ZPMU=p%HI_ZPMU
        ZPO=p%HI_ZPO
        ZPOU=p%HI_ZPOU
        ZSK=p%HI_ZSK
        ZSLT=p%HI_ZSLT
        ZTP=p%HI_ZTP

        HSG=p%HI_HSG
        RTN1=p%HI_RTN1
        ZTK=p%HI_ZTK
        XLOG=p%HI_XLOG
        APM=p%HI_APM
        BCHL=p%HI_BCHL
        BCHS=p%HI_BCHS

        CHD=p%HI_CHD
        UPN=p%HI_UPN

        SAT1=p%HI_SAT1
        FPS1=p%HI_FPS1
        CO2X=p%HI_CO2X
        CQNX=p%HI_CQNX
        RFNX=p%HI_RFNX

        FMX=p%HI_FMX
        SFLG=p%HI_SFLG

        FI=p%HI_FI


END SUBROUTINE

!! ******************************************************************************************
!! Restore APEX data FROM HISAFE
!! ******************************************************************************************

SUBROUTINE FROMINIT (p)

        USE PARM

        USE HISAFE

        TYPE(Hisafe_),  intent(INOUT) :: p

!!!soil (*.sol)
        IOW= p%HI_IOW
        FI=p%HI_FI
        IAPL=p%HI_IAPL
        NVCN=p%HI_NVCN
        IPTS=p%HI_IPTS
        ISAO=p%HI_ISAO
        LUNS=p%HI_LUNS
        IMW=p%HI_IMW
        SNO=p%HI_SNO
        STDO=p%HI_STDO

        WSA=p%HI_WSA
        CHL=p%HI_CHL
        CHD=p%HI_CHD
        CHS=p%HI_CHS
        CHN=p%HI_CHN
        STP=p%HI_STP
        SPLG=p%HI_SPLG
        UPN=p%HI_UPN
        FFPQ=p%HI_FFPQ
        URBF=p%HI_URBF

        RCHL=p%HI_RCHL
        RCHD=p%HI_RCHD
        RCBW=p%HI_RCBW
        RCTW=p%HI_RCTW
        RCHS=p%HI_RCHS
        RCHN=p%HI_RCHN
        RCHC=p%HI_RCHC
        RCHK=p%HI_RCHK
        RFPW=p%HI_RFPW
        RFPL=p%HI_RFPL
        SAT1=p%HI_SAT1
        FPS1=p%HI_FPS1

        RSEE=p%HI_RSEE
        RSAE=p%HI_RSAE
        RVE0=p%HI_RVE0
        RSEP=p%HI_RSEP
        RSAP=p%HI_RSAP
        RVP0=p%HI_RVP0
        RSV=p%HI_RSV
        RSRR=p%HI_RSRR
        RSYS=p%HI_RSYS
        RSYN=p%HI_RSYN
        RSHC=p%HI_RSHC
        RSDP=p%HI_RSDP
        RSBD=p%HI_RSBD
        PCOF=p%HI_PCOF
        BCOF=p%HI_BCOF
        BFFL=p%HI_BFFL

        IRR=p%HI_IRR
        IRI=p%HI_IRI
        IFA=p%HI_IFA
        LM=p%HI_LM
        IFD=p%HI_IFD
        IDR=p%HI_IDR
        IDF0=p%HI_IDF0
        IRRS=p%HI_IRRS
        BIR=p%HI_BIR
        EFI=p%HI_EFI
        VIMX=p%HI_VIMX
        ARMN=p%HI_ARMN
        ARMX=p%HI_ARMX
        BFT=p%HI_BFT

        FNP=p%HI_FNP
        FMX=p%HI_FMX
        DRT=p%HI_DRT

        FDSF=p%HI_FDSF
        PEC=p%HI_PEC
        DALG=p%HI_DALG
        VLGN=p%HI_VLGN
        COWW=p%HI_COWW
        DDLG=p%HI_DDLG
        SOLQ=p%HI_SOLQ
        SFLG=p%HI_SFLG
        FIRG=p%HI_FIRG
       !!NY=p%HI_NY
        XTP=p%HI_XTP


        YCT=p%HI_YCT
        XCT=p%HI_XCT
        FL=p%HI_FL
        FW=p%HI_FW

        YLAT=p%HI_YLAT
        XLOG=p%HI_XLOG
        ELEV=p%HI_ELEV
        APM=p%HI_APM
        CO2X=p%HI_CO2X
        CQNX=p%HI_CQNX
        RFNX=p%HI_RFNX
        UPR=p%HI_UPR
        UNR=p%HI_UNR


       IF(FIRG(1)<1.E-10)THEN
          IF(p%HI_FIRG(1)<1.E-10)THEN
               FIRG(1)=1.
          ELSE
               FIRG(1)=p%HI_FIRG(1)
          END IF
       END IF


        BCHL=p%HI_BCHL
        BCHS=p%HI_BCHS

        SALB=p%HI_SALB
        HSG=p%HI_HSG
        FFC=p%HI_FFC
        WTMN=p%HI_WTMN
        WTMX=p%HI_WTMX
        WTBL=p%HI_WTBL
        GWST=p%HI_GWST
        GWMX=p%HI_GWMX
        RFTT=p%HI_RFTT
        RFPK=p%HI_RFPK
        TSLA=p%HI_TSLA
        XIDS=p%HI_XIDS
        RTN1=p%HI_RTN1
        XIDK=p%HI_XIDK
        ZQT=p%HI_ZQT
        ZF=p%HI_ZF
        ZTK=p%HI_ZTK
        FBM=p%HI_FBM
        FHP=p%HI_FHP

!!layers
            Z=p%HI_Z
            BD=p%HI_BD
            UW=p%HI_UW
            FC=p%HI_FC
            SAN=p%HI_SAN
            SIL=p%HI_SIL
            WON=p%HI_WON
            PH=p%HI_PH
            SMB=p%HI_SMB
            WOC=p%HI_WOC
            CAC=p%HI_CAC
            CEC=p%HI_CEC
            ROK=p%HI_ROK
            CNDS=p%HI_CNDS
            SSF=p%HI_SSF
            RSD=p%HI_RSD
            BDD=p%HI_BDD
            PSP=p%HI_PSP
            SATC=p%HI_SATC
            HCL=p%HI_HCL
            WPO=p%HI_WPO
            DHN=p%HI_DHN
            ECND=p%HI_ECND
            STFR=p%HI_STFR
            SWST=p%HI_SWST
            CPRV=p%HI_CPRV
            CPRH=p%HI_CPRH
            WLS=p%HI_WLS
            WLM=p%HI_WLM
            WLSL=p%HI_WLSL
            WLSC=p%HI_WLSC
            WLMC=p%HI_WLMC
            WLSLC=p%HI_WLSLC
            WLSLNC=p%HI_WLSLNC
            WBMC=p%HI_WBMC
            WHSC=p%HI_WHSC
            WHPC=p%HI_WHPC
            WLSN=p%HI_WLSN
            WLMN=p%HI_WLMN
            WBMN=p%HI_WBMN
            WHSN=p%HI_WHSN
            WHPN=p%HI_WHPN
            FE26=p%HI_FE26
            SULF=p%HI_SULF
        !!    ASHZ; //SOIL HORIZON(A,B,C)
            CGO2=p%HI_CGO2
            CGCO2=p%HI_CGCO2
            CGN2O=p%HI_CGN2O

 !!!evolution (apexcont.dat)
        NBYR=p%HI_NBYR
        IYR0=p%HI_IYR0
        IMO=p%HI_IMO
        IDA=p%HI_IDA
        IPD = p%HI_IPD
        NGN0 = p%HI_NGN0
        IGN = p%HI_IGN
        IGSD = p%HI_IGSD
        LPYR = p%HI_LPYR
        IET = p%HI_IET
        ISCN = p%HI_ISCN
        ITYP = p%HI_ITYP
        ISTA = p%HI_ISTA
        IHUS = p%HI_IHUS
        NVCN(1) = p%HI_NVCN0
        INFL = p%HI_INFL0 + 1
        MASP = p%HI_MASP
        IERT = p%HI_IERT
        LBP = p%HI_LBP
        NUPC = p%HI_NUPC
        MNUL = p%HI_MNUL
        LPD = p%HI_LPD
        MSCP = p%HI_MSCP
        ISLF = p%HI_ISLF
        NAQ = p%HI_NAQ
        IHY = p%HI_IHY
        ICO2 = p%HI_ICO2
        ISW = p%HI_ISW
        IGMX = p%HI_IGMX
        IDIR = p%HI_IDIR

        IF(IMW(1)==0)IMW(1)=p%HI_IMW0

        IOX = p%HI_IOX
        IDNT = p%HI_IDNT
        IAZM = p%HI_IAZM
        IPAT = p%HI_IPAT
        IHRD = p%HI_IHRD
        IWTB = p%HI_IWTB
        IKAT = p%HI_IKAT
        NSTP = p%HI_NSTP
        IPRK = p%HI_IPRK
        ICP = p%HI_ICP
        NTV = p%HI_NTV
        ISAP = p%HI_ISAP
        RFNC = p%HI_RFN0
        CO2 = p%HI_CO20
        CQNI = p%HI_CQN0
        PSTX = p%HI_PSTX
        YWI = p%HI_YWI
        BTA = p%HI_BTA
        EXPK = p%HI_EXPK
        QG = p%HI_QG
        QCF = p%HI_QCF
        CHS0 = p%HI_CHS0
        BWD = p%HI_BWD
        FCW = p%HI_FCW
        FPS0 = p%HI_FPS0
        GWS0 = p%HI_GWS0
        RFT0 = p%HI_RFT0
        RFP0 = p%HI_RFP0
        PCO0 = p%HI_PCO0
        RCC0 = p%HI_RCC0


       IF(SAT1>0.)THEN
            SATZ=SAT1
      ELSE
            IF(p%HI_SAT0>0.)THEN
                 SATZ=p%HI_SAT0
            ELSE
                 SATZ=1.
           END IF
       END IF
       IF(FL<1.E-10)FL=p%HI_FL0
       IF(FW<1.E-10)FW=p%HI_FW0
       IF(ANGL<1.E-10)ANGL=p%HI_ANG0

        UXP = p%HI_UXP

        IF(p%HI_DIAM<1.E-10)p%HI_DIAM=500.
        USTRT=.0161*SQRT(p%HI_DIAM)

        ACW = p%HI_ACW

        IF(GZLM(1,1)<1.E-5)GZLM(1,1)=p%HI_GZL0
        IF(RTN1<1.E-5)RTN1=p%HI_RTN0

        BXCT = p%HI_BXCT
        BYCT = p%HI_BYCT
        DTHY = p%HI_DTHY
        QTH = p%HI_QTH
        STND = p%HI_STND

        NDRV=p%HI_DRV+1.1


        IF(PCOF(1)<1.E-20)PCOF(1)=p%HI_PCO0
        IF(RCHC(1)<1.E-10)RCHC(1)=p%HI_RCC0

        CSLT = p%HI_CSLT
        CPV0 = p%HI_CPV0
        CPH0 = p%HI_CPH0
        DZDN = p%HI_DZDN
        DTG = p%HI_DTG

END SUBROUTINE



