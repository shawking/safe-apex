!SUBROUTINE BSIM                                                                
!!     APEX1501                                                                       
!!     THIS SUBPROGRAM DRIVES THE DAILY SIMULATION FOR THE ENTIRE WATER-              
!!     SHED FOR USER SPECIFIED NUMBER OF YEARS. IT CALLS SUBAREA, ROUTING             
!!     , ADDING, AND RESERVOIR COMPONENTS IN PROPER SEQUENCE. 
!      USE PARM                                                                       
!      CHARACTER(4)::CMDN,HD28                                                                
!      CHARACTER(2)::HDN                                                                                                                                      
!      CHARACTER*7 HD30,HDG
!      DIMENSION HDN(30),HD30(30),HDG(15),CMDN(5)
!	  DIMENSION HD28(15,10)                                    
!      DIMENSION KTP(7),MNST(7)                                                       
!      DIMENSION ZTX(37),TDFP(MPS),TDRP(MPS),TDSP(MPS),&
!      TLHP(MPS),TRFP(MPS),TSSP(MPS),XTX(14),YTP(13),ZTZ(6)
!      DIMENSION XTMP(MPS,MHY)                   
!      DATA MNST/1,2,3,4,5,6,7/,IIP/1/
!      DATA YTP/13*0./
!      DATA HD28/'  Z1','  Z2','  Z3','  Z4','  Z5','  Z6','  Z7','  Z8',&            
!      '  Z9',' Z10',' Z11',' Z12',' Z13',' Z14',' Z15',' SW1',' SW2',&               
!      ' SW3',' SW4',' SW5',' SW6',' SW7',' SW8',' SW9','SW10','SW11',&               
!      'SW12','SW13','SW14','SW15',' WU1',' WU2',' WU3',' WU4',' WU5',&               
!      ' WU6',' WU7',' WU8',' WU9','WU10','WU11','WU12','WU13','WU14',&               
!      'WU15',' EV1',' EV2',' EV3',' EV4',' EV5',' EV6',' EV7',' EV8',&               
!      ' EV9','EV10','EV11','EV12','EV13','EV14','EV15',' PK1',' PK2',&               
!      ' PK3',' PK4',' PK5',' PK6',' PK7',' PK8',' PK9','PK10','PK11',&               
!      'PK12','PK13','PK14','PK15',' SF1',' SF2',' SF3',' SF4',' SF5',&               
!      ' SF6',' SF7',' SF8',' SF9','SF10','SF11','SF12','SF13','SF14',&               
!      'SF15',' N31',' N32',' N33',' N34',' N35',' N36',' N37',' N38',&               
!      ' N39','N310','N311','N312','N313','N314','N315',' UN1',' UN2',&               
!      ' UN3',' UN4',' UN5',' UN6',' UN7',' UN8',' UN9','UN10','UN11',&               
!      'UN12','UN13','UN14','UN15',' LN1',' LN2',' LN3',' LN4',' LN5',&               
!      ' LN6',' LN7',' LN8',' LN9','LN10','LN11','LN12','LN13','LN14',&               
!      'LN15','  T1','  T2','  T3','  T4','  T5','  T6','  T7','  T8',&               
!      '  T9',' T10',' T11',' T12',' T13',' T14',' T15'/
!      DATA HDG/'   GFO2','  GFCO2','  GFN2O','  DFO2S',' DBFO2B','  DFO2T',&
!      '    QO2',' DFCO2S',' DFCO2B',' DFCO2T','   QCO2',' DFN2OS',' DFN2OB',&
!      ' DFN2OT','   QN2O'/
!      DATA HD30/'     ZC','    VWC','    AFP','   HKPO','   DPRO','   HKPC',&
!      '   DPRC','   HKPN','   DPRN','   SMEA','   SMES','   WNH3','   WNO3',&
!      '   WNO2','   WO2L','   WO2G','DO2CONS','  SSFO2','    VO2','  WCO2L',&
!      '  WCO2G','DCO2GEN',' SSFCO2','   VCO2','  WN2OL','  WN2OG',' SSFN2O',&
!      '   VN2O','  DN2OG','   DN2G'/
!      DATA HDN/'1 ','2 ','3 ','4 ','5 ','6 ','7 ','8 ','9 ','10','11',&
!      '12','13','14','15','16','17','18','19','20','21','22','23','24',&
!      '25','26','27','28','29','30'/ 
!      CMDN=(/'HYDV','ROUT','ADD ','RSRT','PDRT'/)
!      RWSX=RWSA(NCMD)
!      IF(NPSO>0)THEN
!          DO I=1,NPSO
!              II=I+LND
!              DO J=1,6
!                  READ(KR(II),'()')
!              END DO
!          END DO
!      END IF
!      IF(KFL(42)>0)THEN
!          DO ISA=1,MSA
!              WRITE(KW(42),731)HED(4),HED(10),HED(11),(HED(I),&                 
!              I=13,20),(HEDS(I),I=6,8),((HD28(I,J),I=1,NBSL(ISA)),J=1,10)
!          END DO
!      END IF    
!      IF(KFL(41)>0)THEN
!          WRITE(KW(41),'(T15,3(A,E16.6))')'XKN1=',XKN1,' XKN3=',XKN3,&
!          ' XKN5=',XKN5                                            
!          WRITE(KW(41),730)HED(4),((HD30(J),HDN(I),I=1,NBCL),&
!          J=2,3),((HD30(J),HDN(I),I=1,NBCL),J=12,17),(HDG(I),'  ',I=4,7),&
!          ((HD30(J),HDN(I),I=1,NBCL),J=18,22),(HDG(I),'  ',I=8,11),((HD30(J),&
!          HDN(I),I=1,NBCL),J=23,26),(HDG(I),'  ',I=12,15),((HD30(J),HDN(I),&
!          I=1,NBCL),J=27,30)
!      END IF           
!      IPSF=0.
!      T2=0.
!      DO IY=1,NBYR ! ANNUAL LOOP                                                               
!          JDA=IBD
!          JJ=IBD-1 
!          IPF=0                                                                      
!          IF(ICO2==1)THEN                                                                 
!              IF(IYX<25)THEN                                                             
!                  CO2=280.33                                                
!              ELSE                                                                       
!                  X1=IYX                                                                 
!                  CO2=280.33-X1*(.1879-X1*.0077)                                         
!              END IF                                                                     
!          END IF                                                                         
!          IF(IPD>2)THEN                                                                  
!              IF(NOP/=0)THEN                                                             
!                  CALL APAGE(0)                                                          
!                  IF(KFL(1)>0)WRITE(KW(1),'(//T11,A,A)')'SA(# ID)   Y M D',&             
!                  ' OPERATION'                                                           
!              END IF                                                                     
!          ELSE                                                                           
!              CALL APAGE(0)                                                              
!          END IF                                                                         
!          ND=366-NYD                                                                     
!          DO I=1,LC                                                                      
!     	        WA(I)=100.*CO2/(CO2+EXP(WAC2(1,I)-CO2*WAC2(2,I)))                          
!          END DO                                                                         
!          WRITE(KW(1),'(T10,A,F5.0)')'ATMOS CO2 = ',CO2                                  
!          IPC=1                                                                          
!          KOMP=0                                                                         
!          DO ISA=1,MSA                                                                   
!              KTMX(ISA)=1                                                                
!              TFLG(ISA)=0.                                                               
!              AFLG(ISA)=0.                                                               
!              IRO(ISA)=IRO(ISA)+1                                                        
!              IF(IRO(ISA)>NRO(ISA))IRO(ISA)=1
!              IF(IGO(ISA)>NCP(IRO(ISA),ISA))THEN
!                  IF(LY(IRO(ISA),1,ISA)==KGO(IGO(ISA),ISA))THEN
!                      LY(IRO(ISA),IGO(ISA),ISA)=KGO(NCP(IRO(ISA),ISA),ISA)
!                  ELSE
!                      LY(IRO(ISA),IGO(ISA),ISA)=KGO(IGO(ISA),ISA)
!                  END IF
!                  NCP(IRO(ISA),ISA)=IGO(ISA)
!              END IF
!              DO I=1,LC                                                                  
!                  JE(I,ISA)=MNC                                                           
!                  IF(KGO(I,ISA)==0)CYCLE                                                 
!                  DO J=1,NCP(IRO(ISA),ISA)                                               
!                      IF(I==LY(IRO(ISA),J,ISA))EXIT                                      
!                  END DO                                                                 
!                  JE(J,ISA)=I
!                  IF(IDC(I)==NDC(7).OR.IDC(I)==NDC(8))THEN
!                      DO ISL=1,NBSL(ISA)
!                          IF(CPRV(ISL,ISA)<1.E-10)CPRV(ISL,ISA)=CPV0
!                          IF(CPRH(ISL,ISA)<1.E-10)CPRH(ISL,ISA)=CPH0
!                      END DO 
!                  END IF                                                                   
!              END DO
!              IF(IPAT>0)THEN
!		          IF(PDPLC(ISA)<20.)THEN
!			          APMU=2.25*(30.-PDPLC(ISA))
!			          JJK=LY(IRO(ISA),1,ISA)
!	    	          IF(APMU>45.)CALL NFERT(APMU,7,IAUF(ISA),KT2,JRT)
!                  END IF
!	          END IF        
!	          IF(IKAT>0)THEN
!		          IF(PDSKC(ISA)<20.)THEN
!			          APMU=2.25*(30.-PDSKC(ISA))
!			          JJK=LY(IRO(ISA),1,ISA)
!	    	          IF(APMU>45.)CALL NFERT(APMU,8,IAUF(ISA),KT2,JRT)
!                  END IF
!	          END IF                                                                     
!              LD1=LID(1,ISA)                                                             
!              ANA(IRO(ISA),ISA)=0.                                                       
!              HSM(ISA)=0.                                                                
!              X1=.2+.3*EXP(-.0256*SAN(LD1,ISA)*(1.-.01*SIL(LD1,ISA)))                    
!              X2=(SIL(LD1,ISA)/(CLA(LD1,ISA)+SIL(LD1,ISA)))**.3                          
!              X5=.1*WOC(LD1,ISA)/WT(LD1,ISA)                                             
!              X3=1.-.25*X5/(X5+EXP(3.718-2.947*X5))                                      
!              X4=1.-.01*SAN(LD1,ISA)                                                     
!              X5=1.-.7*X4/(X4+EXP(-5.509+22.899*X4))                                     
!              EK(ISA)=X1*X2*X3*X5                                                        
!              USL(ISA)=EK(ISA)*SLF(ISA)*PEC(ISA)                                         
!	          SUM=(SAN(LD1,ISA)*.0247-SIL(LD1,ISA)*3.65-CLA(LD1,ISA)*6.908)/&                 
!              100.                                                                       
!              DG=EXP(SUM)                                                                
!              REK=9.811*(.0034+.0405*EXP(-.5*((LOG10(DG)+1.659)/.7101)**2))              
!              RSK(ISA)=REK*PEC(ISA)*RSF(ISA)                                             
!              RSLK(ISA)=RSK(ISA)*RLF(ISA)                                                
!              CALL EWIK
!              SAMA(ISA)=0.                                                               
!              XMAP(ISA)=0.
!              SELECT CASE(MNUL)                                                               
!	              CASE(1)                                                                          
!                      IF(PDPLC(ISA)<62.)THEN                                                 
!                          XMAP(ISA)=2.*UPR                                                   
!                          CYCLE                                                              
!                      END IF                                                                 
!                      IF(PDPLC(ISA)<120.)THEN                                                
!                          XMAP(ISA)=1.5*UPR                                                  
!                          CYCLE                                                              
!                      END IF                                                                 
!                      IF(PDPLC(ISA)<200.)THEN                                                
!                          XMAP(ISA)=UPR                                                      
!                          CYCLE                                                              
!                      END IF
!                  CASE(2)                                                                
!	                  IF(PDPLC(ISA)<200.)CYCLE                                               
!  	                  XMAP(ISA)=UNR                                                             
!	                  CYCLE                                                                  
!                  CASE(3)
!                      IF(IAPL(ISA)<=0)CYCLE
!                      IF(PDPLC(ISA)<200.)XMAP(ISA)=2.*UPR
!	              CASE DEFAULT     
!	          END SELECT                                                                
!          END DO                                                                              
!          NT1=0                                                                          
!          WRITE(*,50)IY,NBYR

          DO IDA=IBD,ND ! DAILY LOOP

              NTX=0                                                                          
              ISA=1                                                                          
              NOFL=40 
              NHY=0                                                                       
              IOF=1
              VARC=0.
        !     SLAP=0.                                                                          
              CALL AICL                                                                      
              XDA=KDA                                                                        
              IPC=MAX(IPC,IDA)                                                               
              XDA1=31.-XDA                                                                   
              TSFN=0.;QRP=0.;SST=0.;YP=0.;YN=0.;YC=0.;QC=0.;YCOU=0.;YPOU=0.                       
              YNOU=0.;QN=0.;QP=0.;QPU=0.;QURB=0.;YMNU=0.;RQRB=0.;QVOL=0.                             
	          YSD=0.;QPST=0.;YPST=0.;TSFK=0.                                                              
  	          RFV=0.;CVF=0.;EVRT=0.

              IF(NPSO>0)THEN                                                                      
	              DO I=1,NPSO
	                  IF(IPSF(I)>0)THEN
				          PSOQ(I)=0.
				          PSOY(I)=0.
				          PSON(I)=0.
				          PSOP(I)=0.
				          PSO3(I)=0.
				          PSSP(I)=0.
				          PQPS(I)=0.
				          PYPS(I)=0.
				          CYCLE
			          END IF                                                                     
	                  II=I+LND                                                                    
                      !     POINT SOURCE INPUT
                      !             I1   = DAY OF YEAR
                      !             I2   = YEAR
                      !             PSOQ = FLOW(M3/D)
                      !             PSOY = SEDIMENT LOAD(T/D)
                      !             PSON = ORGANIC N(KG/D)
                      !             PSOP = ORGANIC P(KG/D) 
                      !             PSO3 = NITRATE N LOAD(KG/D)
                      !             PSH3 = AMMONIA N LOAD(KG/D)
                      !             PSO2 = NITRITE N LOAD(KG/D)
                      !             PSSP = SOLUBLE P LOAD(KG/D)
                      !             PBOD = BOD LOAD(KG/D)
                      !             PSDO = DISOLVED OXYGEN LOAD(KG/D)
                      !             PSCA = CHLORAFIL LOAD(KG/D)
                      !             PQPS = SOLUBLE PESTICIDE LOAD(G/D)
                      !             PYPS = ADSORBED PESTICIDE LOAD(G/D)
                      !             KPSN = PESTICIDE # FROM PESTCOM.DAT
			          READ(KR(II),*,IOSTAT=NFL)I1,I2,PSOQ(I),PSOY(I),PSON(I),&
                      PSOP(I),PSO3(I),PSH3,PSO2,PSSP(I),PBOD,PSDO,PSCA,PQPS(I),&
                      PYPS(I),X1,X2,X3,X4,X5,KPSN(I)
			          IF(NFL/=0)THEN
			              WRITE(KW(36),'(5X,A,I8,A,3I4)')'POINT SOURCE #',I,&
	                      ' ENDS (Y M D)',IYR,MO,KDA                      
	                      IPSF(I)=1                           
                      END IF
                  END DO    
              END IF    
              REP=0.                                                                         
              IF(IHY>0)THEN
                  NRF=0                                                                          
                  RFDT=0.
                  YHY=0.
              END IF

              IF(INFL==5)THEN
                  CALL HRFIN
		          RFV0(1)=RFDT(NRF)
                  CALL WGN                                                                       
                  CALL WTAIR(1)                                                                     
                  X1=TMX(1)-TMN(1)                                                               
                  TMX(1)=TMX(1)+TMXF(MO)                                                         
                  TMN(1)=TMX(1)-TMNF(MO)*X1                                                      
                  CALL WRLHUM(1)                                                                    
                  CALL WNSPD                                                                     
                  TMX=TMX(1)                                                                     
                  TMN=TMN(1)                                                                     
                  SRAD=SRAD(1)                                                                   
                  RHD=RHD(1)                                                                     
                  U10=U10(1)                                                                     
              ELSE
                  I=NWTH
                  IF(NGN>0)THEN
                      DO I=1,NWTH                                                                    
                          II=I+KND                                                                   
                          !     READ DAILY WEATHER IF NOT GENERATED                                            
                          !  1  SRAD = SOLAR RADIAION(MJ/m2 OR LY)(BLANK TO GENERATE)                          
                          !  2  TMX  = MAX TEMP(c)                                                             
                          !  3  TMN  = MIN TEMP(c)                                                             
                          !  4  RFV0 = RAINFALL(mm)(999. TO GENERATE OCCURRENCE & AMOUNT;                      
                          !            -1. TO GENERATE AMOUNT GIVEN OCCURRENCE)                                
                          !  5  RHD  = RELATIVE HUMIDITY(FRACTION)(BLANK TO GENERATE)                          
                          !  6  U10  = WIND VELOCITY(m/s)(BLANK TO GENERATE)                                   
                          !  7  CO2I = ATMOSPHERIC CO2 CONC(ppm)                                                 
                          !  8  REP  = PEAK RAINFALL RATE(mm/h)
                          !  9  ORSD = OBSERVED SOIL SURFACE CROP RESIDUE(t/ha) 
                          READ(KR(II),1070,IOSTAT=NFL)SRAD(I),TMX(I),TMN(I),RFV0(I),RHD&             
                          (I),U10(I),CO2I,REP,ORSD(I)                                                             
                          IF(NFL/=0)THEN                                                             
                              NGN=-1                                                                 
                              IRF=1
                              KGN=0                                                                  
                              WRITE(KW(1),'(5X,A,A,3I4,1X,A80)')'GENERATED WEATHER STARTS',&               
                              ' (Y M D)',IYR,MO,KDA,FWTH(I)                                                  
                              EXIT
                          END IF
                          SRAD(I)=SRAD(I)*RUNT                                                            
                          RHD(I)=RHD(I)/RHCF                                                         
                          III=0                                                                      
                          IF(RFV0(I)>900..OR.RFV0(I)<0.)THEN                                                         
                              CALL WRWD(I,0)                                                           
                              RFV0(I)=RFV0(I)*RNCF(MO)                                               
                          END IF
                          IF(KGN(2)==0.OR.TMX(I)<=TMN(I))THEN
                              CALL WGN                                                                   
                              CALL WTAIR(I)                                                              
                              X1=TMX(I)-TMN(I)                                                           
                              TMX(I)=TMX(I)+TMXF(MO)                                                     
                              TMN(I)=TMX(I)-TMNF(MO)*X1
                          ELSE                                                      
                              IF(TMX(I)>100..OR.TMN(I)>100.)THEN
                                  CALL WGN                                                                   
                                  CALL WTAIX(I)
                                  X1=TMX(I)-TMN(I)                                                           
                                  TMX(I)=TMX(I)+TMXF(MO)                                                     
                                  TMN(I)=TMX(I)-TMNF(MO)*X1
                              END IF    
                          END IF                
                          IF(KGN(5)>0)THEN
                              IF((RHD(I)<0..OR.RHD(I)>1..OR.IRH>0).AND.RHD(I)<900.)THEN
                                  ! RHD=DEW POINT TEMP--CONVERT TO RELATIVE HUM
                                  TX=.5*(TMX(I)+TMN(I)) 
                                  RHD(I)=MIN(.99,ASVP(RHD(I)+273.)/ASVP(TX+273.))
                                  IRH=1                                                                    
                              ELSE
                                  IF(RHD(I)<1.E-5.OR.RHD(I)>900.)THEN 
                                      ! RHD IS MISSING DATA (0. OR 999.)                                                 
                                      IF(III==0)CALL WGN                                                           
                                      CALL WRLHUM(I)
                                  END IF    
                              END IF    
                          ELSE
                              IF(III==0)CALL WGN                                                           
                              CALL WRLHUM(I)
                          END IF    
                          IF(U10(I)>0..AND.U10(I)<900..AND.KGN(4)>0)CYCLE                                            
                          CALL WNSPD                                                                 
                      END DO                                                                         
                      IWI=1                                                                          
                  ELSE    
                      U10(1)=0.                                                                      
                      RHD(1)=0.
                      IF(NWP>1)THEN                                                                  
                          XX=AUNIF(IDG(12))                                                          
                          DO IWI=1,NWP                                                               
                              IF(XX<=AWXP(IWI))EXIT                                                    
                          END DO
                          IAD(IWI)=IAD(IWI)+1                                                                     
                      ELSE                                                                           
                          IWI=1                                                                      
                      END IF                                                                         
                      CALL WRWD(1,0)                                                                   
                      NWPD(IWI)=NWPD(IWI)+1
                      RFSG(IWI)=RFSG(IWI)+RFV0(1)                                                          
                      RFV0(1)=RFV0(1)*RNCF(MO)                                                       
                      CALL WGN                                                                       
                      CALL WTAIR(1)                                                                     
                      X1=TMX(1)-TMN(1)                                                               
                      TMX(1)=TMX(1)+TMXF(MO)                                                         
                      TMN(1)=TMX(1)-TMNF(MO)*X1                                                      
                      CALL WRLHUM(1)                                                                    
                      CALL WNSPD                                                                     
                      TMX=TMX(1)                                                                     
                      TMN=TMN(1)                                                                     
                      SRAD=SRAD(1)                                                                   
                      RHD=RHD(1)                                                                     
                      U10=U10(1)
                  END IF
              END IF

              IXP=NXP(90)
              IF(ICO2==2)THEN
                  IF(CO2I>0.)CO2=CO2I                                                                    
              END IF
              IF(RFV0(1)>0.)THEN
                  SDRF=SDRF+RFV0(1)*RFV0(1)                                                      
                  IF(RFV0(1)>RMX0)RMX0=RFV0(1)                                                   
                  IF(ITYP==0)THEN                                                                
                      AJP=1.-EXP(-125./(RFV0(1)+5.))                                             
                      AL5=ATRI(ALMN,WI(IWI,MO),AJP,4)                                            
                  ELSE                                                                           
                      AL5=WI(IWI,MO)                                                             
                  END IF
                  IF(AL5>0.)THEN
                      PRFF=-2.*LOG(1.-AL5)                                                           
                  ELSE
                      PRFF=.2
                  END IF        
                  DUR=MIN(24.,4.605/PRFF)                                                        
                  IF(NGN<0)THEN
                      DO ISA=1,MSA                                                                   
                          RFV(ISA)=RFV0(1)                                                           
                      END DO
                  END IF
                  IF(NGN==0)THEN                             
                      XX=AUNIF(IDG(10))                                                              
                      YY=AUNIF(IDG(11))                                                              
                      XX=XX*XSL+XCS                                                                  
                      YY=YY*YSL+YCS                                                                  
                      SUM=0.                                                                         
                      X1=DUR**(-.1478)                                                               
                      DO ISA=1,MSA                                                                   
                          XA=111.2*ABS(XCT(ISA))*COS1                                                           
                          YA=111.2*ABS(YCT(ISA))
                          D2=(XX-XA)**2+(YY-YA)**2                                                   
                          D=SQRT(D2)                                                                 
                          X2=MAX(.001,1.-X1*D/(D+EXP(SCRP(21,1)-SCRP(21,2)*D)))
                          X3=(1.+BXCT*(XA-XCS))*(1.+BYCT*(YA-YCS))                                                           
                          ZTP(ISA)=X2*X3
                          SUM=SUM+ZTP(ISA)                                                           
                      END DO                                                                         
                      RTO=XSA*RFV0(1)/SUM                                                            
                      DO ISA=1,MSA                                                                   
                          X1=ATRI(.8,1.,1.2,6)                                                       
                          RFV(ISA)=RTO*ZTP(ISA)*X1                                                   
                      END DO                                                                         
                  END IF
              END IF

              DO IOW=1,NBON                                                                  
                  DO IHD=1,NHRD(IOW)                                                         
	                  II=IHBS(IHD,IOW)                                                            
	                  IYMD=10000*IYHO(IHD,IOW)+100*MO+KDA                                         
	                  IF(IHDT(II,IHD,IOW)/=IYMD)CYCLE                                             
	                  NCOW(IHD,IOW)=NBSX(II,IHD,IOW)                                              
	                  IF(KFL(1)>0)WRITE(KW(1),892)IY,MO,KDA,IOW,IHD,NCOW(IHD,&                    
                      IOW)                                                                   
  	                  IHBS(IHD,IOW)=IHBS(IHD,IOW)+1                                             
	                  IF(IHBS(IHD,IOW)>NHBS(IHD,IOW))IHBS(IHD,IOW)=1                              
	              END DO                                                                          
                  IF(NSAS(IOW)>=2.AND.MNUL<3)THEN                                           
                      X5=PDPL(IDSS(1,IOW))                                                   
                      ISAS(IOW)=IDSS(1,IOW)                                                  
                      DO J=2,NSAS(IOW)                                                       
                          IF(X5<PDPL(IDSS(J,IOW)))CYCLE                                      
                          X5=PDPL(IDSS(J,IOW))                                               
                          ISAS(IOW)=IDSS(J,IOW)                                              
                      END DO                                                                 
                  END IF                                                                     
                  IF(NSAL(IOW)==0)CYCLE                                                      
                  X5=PDPL(IDSL(1,IOW))                                                       
                  ISAL(IOW)=IDSL(1,IOW)                                                      
                  IF(NSAL(IOW)<2)CYCLE                                                       
                  DO J=2,NSAL(IOW)                                                           
                      IF(X5<PDPL(IDSL(J,IOW)))CYCLE                                          
                      X5=PDPL(IDSL(J,IOW))                                                   
                      ISAL(IOW)=IDSL(J,IOW)                                                  
                  END DO                                                                     
              END DO                                                                         
              SYW=0.                                                                         
              SDEP=0.                                                                        
	          SDEG=0.                                                                             
	          SRYF=0.                                                                             
	          VAR=0.
	          VARH=0.
	          TAC=0.

              DO ICMD=1,NCMD ! COMMAND LOOP

                  SELECT CASE(ICDT(ICMD))                                                        
                      CASE(1)                                                                    
!                         SUBROUTINE BSUB(IXP)
!                         APEX1501
!                         THIS SUBPROGRAM DRIVES THE DAILY SUBAREA SIMULATION.
!                         USE PARM
                          DIMENSION JGO(MNC)
                          IDO=IDOT(ICMD)
                          ISA=IDN1T(ICMD)
                          IDOA(ISA)=IDO
                          NISA(NBSA(ISA))=ISA
	                      IDNB(IDO)=NBSA(ISA)
                          IOW=IDON(ISA)
                          WSAX=WSA(ISA)
                          WSAX1=WSAX*10.
                          RWSA(IDO)=WSAX
                          LNS=LID(NBSL(ISA),ISA)
                          LD1=LID(1,ISA)
                          NMW(ISA)=NMW(ISA)+1
                          DDMP=0.
                          LRD(ISA)=MIN(LRD(ISA),NBSL(ISA))
                          CALL WHLRMX(IDA)                                                                    
                          IHRL(MO,ISA)=IHRL(MO,ISA)+1                                                            
                          THRL(MO,ISA)=THRL(MO,ISA)+HRLT                                                         
                          SRMX(MO,ISA)=SRMX(MO,ISA)+RAMX
                          IF(SRAD(IRF(ISA))==0..OR.KGN(3)==0)THEN
                              OBSL(IWI,MO)=RAMX*MAX(.8,.21*SQRT(OBMX(IWI,MO)-OBMN(IWI,MO)))
                              CALL WGN
                              I=IRF(ISA)
                              CALL WSOLRA(I)
                          END IF
                          IF(IPTS(ISA)>0)THEN
	                          I=IPSO(ISA)
	                          PSQX=PSOQ(I)/WSAX1
	                          PSYX=PSOY(I)/WSAX
                              PONX=PSON(I)/WSAX
                              PPPX=PSOP(I)/WSAX
                              PS3X=PSO3(I)/WSAX
                              PSPX=PSSP(I)/WSAX
                              PQPX=PQPS(I)/WSAX
                              PYPX=PYPS(I)/WSAX	
                              SMM(104,MO,ISA)=SMM(104,MO,ISA)+PSQX
                              SMM(121,MO,ISA)=SMM(121,MO,ISA)+PSYX
                              SMM(105,MO,ISA)=SMM(105,MO,ISA)+PONX
                              SMM(106,MO,ISA)=SMM(106,MO,ISA)+PPPX
                              SMM(137,MO,ISA)=SMM(137,MO,ISA)+PS3X
                              SMM(138,MO,ISA)=SMM(138,MO,ISA)+PSPX
                              SMM(122,MO,ISA)=SMM(122,MO,ISA)+PQPX
                              SMM(123,MO,ISA)=SMM(123,MO,ISA)+PYPX
                          END IF
                          PCT(1,ISA)=.01*SAN(1,ISA)
                          PCT(2,ISA)=.01*SIL(1,ISA)
                          PCT(3,ISA)=.01*CLA(1,ISA)
                          PCT(4,ISA)=0.
                          PCT(5,ISA)=0.
                          DO I=1,NSZ
                              PCTH(I,IDO)=PCT(I,ISA)
                              PCT(I,IDO)=PCT(I,ISA)
                          END DO
                          VAR(4,ISA)=0.
                          SMM(100,MO,ISA)=SMM(100,MO,ISA)+RFV0(IRF(ISA))
                          IF(NGN/=0)RFV(IRF(ISA))=RFV0(IRF(ISA))
                          IF(RFV(IRF(ISA))>0.)THEN
                              RF1=RFV(IRF(ISA))
                              SRD(MO,ISA)=SRD(MO,ISA)+1.
                              SMM(4,MO,ISA)=SMM(4,MO,ISA)+RF1
                              VAR(4,ISA)=RF1
                              !SMMH(35,MO,IDO)=SMMH(35,MO,IDO)+RF1
                              SDVR(ISA)=SDVR(ISA)+RF1*RF1
	                          TSNO(ISA)=0.
                              IF(RF1>RMXS(ISA))THEN
                                  RMXS(ISA)=RF1
                                  MXSR(ISA)=KDA+100*MO+10000*IY
                              END IF
                          END IF
                          VNO3(LD1,ISA)=RFNC*RFV(IRF(ISA))
                          RFQN=VNO3(LD1,ISA)
                          TAGP(ISA)=MAX(.001,TAGP(ISA))
                          XRFI(ISA)=MIN(RFV(IRF(ISA)),PRMT(49)*(1.-EXP(-PRMT(50)*SQRT(TAGP&
                          (ISA)*SMLA(ISA)))))
                          SMM(85,MO,ISA)=SMM(85,MO,ISA)+XRFI(ISA)
                          RFV(IRF(ISA))=RFV(IRF(ISA))-XRFI(ISA)
                          EI=0.
                          AL5=.02083
                          IF(RFV(IRF(ISA))>0.)THEN
	                          CALL HRFEI
                              UPLM=.95
                              QMN=.25
                              BLM=.05
                              R1=ATRI(BLM,QMN,UPLM,8)
                              RTP=R1*RFV(IRF(ISA))
                              XK1=R1/4.605
                              XK2=XK1*(1.-R1)/R1
                              DURG=RFV(IRF(ISA))/(REP*(XK1+XK2))
                              X1=REP*DURG
                              XKP1=XK1*X1
                              XKP2=XK2*X1
                          END IF
                          IF(ORSD(IRF(ISA))>0.)THEN
                              RTO=ORSD(IRF(ISA))/RSD(LD1,ISA)
                              WLS(LD1,ISA)=RTO*WLS(LD1,ISA)
                              WLM(LD1,ISA)=RTO*WLM(LD1,ISA)
                              RSD(LD1,ISA)=ORSD(IRF(ISA))
                              WLMC(LD1,ISA)=RTO*WLMC(LD1,ISA)
                              WLSC(LD1,ISA)=RTO*WLSC(LD1,ISA)
                              WLMN(LD1,ISA)=RTO*WLMN(LD1,ISA)
                              WLSN(LD1,ISA)=RTO*WLSN(LD1,ISA)
                              FOP(LD1,ISA)=RTO*FOP(LD1,ISA)
                          END IF            
                          CV(ISA)=CV(ISA)+RSD(LD1,ISA)+STDO(ISA)
                          CVRS(ISA)=CVRS(ISA)+RSD(LD1,ISA)+STDO(ISA)
                          BCV(ISA)=1.
                          RCF(ISA)=.9997*RCF(ISA)
                          IF(CV(ISA)<10.)BCV(ISA)=CV(ISA)/(CV(ISA)+EXP(SCRP(5,1)-SCRP(5,2)*&
                          CV(ISA)))
                          SNOF=0.
                          IF(SNO(ISA)>0.)THEN
                              SNOF=SNO(ISA)/(SNO(ISA)+EXP(2.303-.2197*SNO(ISA)))
                              BCV(ISA)=MAX(SNOF,BCV(ISA))
                          END IF
                          BCV(ISA)=MIN(BCV(ISA),.95)
                          NN1=NTL(IRO(ISA),ISA)
                          JT1=LT(IRO(ISA),KT(ISA),ISA)
                          YW(IDO)=0.
                          ERTO=1.
                          ERTP=1.
	                      YERO=0.
                          IF(ACW>0..AND.SNO(ISA)<10.)THEN
                              CALL WNDIR
                              CALL EWER(JRT)
                              IF(JRT==0)THEN
                                  YW(IDO)=YW(IDO)*ACW
                                  SMM(36,MO,ISA)=SMM(36,MO,ISA)+YW(IDO)
                                  VAR(36,ISA)=YW(IDO)
	                              SYW=SYW+YW(IDO)*WSA(ISA)
	                              YERO=YERO+YW(IDO)
                                  VAR(58,ISA)=RRF
                                  SMM(35,MO,ISA)=SMM(35,MO,ISA)+RGRF
                                  VAR(35,ISA)=RGRF
                              END IF
                              IF(YW(IDO)>PRMT(94))SMM(145,MO,ISA)=SMM(145,MO,ISA)+1.
                              IF(WB>0.)CALL EWEMHKS(JRT)
                              IF(JRT==0)THEN
                                  YWKS=YWKS*ACW
                                  SMM(139,MO,ISA)=SMM(139,MO,ISA)+YWKS
                              END IF
                          END IF
                          QN(IDO)=0.
                          SMM(7,MO,ISA)=SMM(7,MO,ISA)+U10(IRF(ISA))
                          VAR(7,ISA)=U10(IRF(ISA))
                          SMM(8,MO,ISA)=SMM(8,MO,ISA)+RHD(IRF(ISA))
                          VAR(8,ISA)=RHD(IRF(ISA))
                          TX=(TMN(IRF(ISA))+TMX(IRF(ISA)))/2.
                          IF(TX>0.)HSM(ISA)=HSM(ISA)+TX
                          IF(NAQ>0)CALL DUSTDST
                          CALL SOLT
                          LD2=LID(2,ISA)
                          SMM(59,MO,ISA)=SMM(59,MO,ISA)+STMP(LD2,ISA)
                          VAR(59,ISA)=STMP(LD2,ISA)
                          YP(IDO)=0.
                          YN(IDO)=0.
                          YC(IDO)=0.
                          QC(IDO)=0.
                          YNWN(IDO)=0.
                          YPWN(IDO)=0.
                          YCWN(IDO)=0.
                          YCOU(IDO)=0.
                          YPOU(IDO)=0.
                          YNOU(IDO)=0.
                          QP(IDO)=0.
	                      QPU(IDO)=0.
	                      PKRZ=0.
	                      SMM(1,MO,ISA)=SMM(1,MO,ISA)+TMX(IRF(ISA))
                          VAR(1,ISA)=TMX(IRF(ISA))
                          SMM(2,MO,ISA)=SMM(2,MO,ISA)+TMN(IRF(ISA))
                          VAR(2,ISA)=TMN(IRF(ISA))
                          SMM(3,MO,ISA)=SMM(3,MO,ISA)+SRAD(IRF(ISA))
                          VAR(3,ISA)=SRAD(IRF(ISA))
                          SML=0.
	                      SNMN=0.
	                      DO J=1,8
                              YSD(J,IDO)=0.
                          END DO
                          YMNU(IDO)=0.
                          CVF(ISA)=0.
                          RQRB(IDO)=0.
                          QVOL(IDO)=0.
                          CPVV=0.
                          CPVH(IDO)=0.
                          VAR(5,ISA)=0.
                          TSNO(ISA)=TSNO(ISA)+1.
                          YMP=0.
                          QAPY=0.
                          IF(.5*(TX+STMP(LID(2,ISA),ISA))>0.)THEN
                              IF(SNO(ISA)>0..AND.SRAD(IRF(ISA))>10..AND.TMX(IRF(ISA))&
                              >0.)CALL HSNOM
                              RFV(IRF(ISA))=RFV(IRF(ISA))+SML
                              SMM(6,MO,ISA)=SMM(6,MO,ISA)+SML
                              VAR(6,ISA)=SML
                          ELSE
                              DSNO=RFV(IRF(ISA))
                              SNO(ISA)=SNO(ISA)+DSNO
                              SMM(5,MO,ISA)=SMM(5,MO,ISA)+RFV(IRF(ISA))
                              VAR(5,ISA)=RFV(IRF(ISA))
                              RFV(IRF(ISA))=0.
                          END IF
                          IF(BVIR(ISA)>RFV(IRF(ISA)))THEN
                              IVR=1  
                              RFV(IRF(ISA))=RFV(IRF(ISA))+BVIR(ISA)
	                          REPI(ISA)=BVIR(ISA)/24.
	                          DUR=24.
                              BVIR(ISA)=0.
                              REP=MAX(REP,REPI(ISA))  
                          ELSE
                              IVR=0
                          END IF
	                      CALL HVOLQ(IVR)
                          JCN(ISA)=JCN(ISA)+1
                          SMM(14,MO,ISA)=SMM(14,MO,ISA)+CN
                          VAR(14,ISA)=CN
                          IF(QVOL(IDO)>1.)THEN
                              NQRB(IDO)=NQRB(IDO)+1
                              PRAV(IDO)=PRAV(IDO)+RQRB(IDO)
                              PRSD(ISA)=PRSD(ISA)+RQRB(IDO)*RQRB(IDO)
                              IF(RQRB(IDO)>PRB(IDO))PRB(IDO)=RQRB(IDO)
                              X1=RQRB(IDO)/(QVOL(IDO)+1.)
                              IF(X1>QRQB(ISA))QRQB(ISA)=X1
                              QRBQ(ISA)=QRBQ(ISA)+X1
                              TCAV(IDO)=TCAV(IDO)+TC(IDO)
                              IF(TC(IDO)<TCMX(IDO))THEN
                                  IF(TC(IDO)<TCMN(IDO))TCMN(IDO)=TC(IDO)
                              ELSE
                                  TCMX(IDO)=TC(IDO)
                              END IF
                          END IF
!                         COMPUTE SEDIMENT YLD
                          IF(PEC(ISA)>0..AND.LUN(ISA)/=35)THEN
                              CALL EYSED(JRT)
                              IF(JRT==0.OR.YERO>0.)THEN
                                  YERO=YERO+YSD(NDRV,IDO)
                                  X1=.9*WT(LD1,ISA)
                                  IF(YERO>X1)THEN
                                      RTO=X1/YERO
                                      YSD(NDRV,IDO)=YSD(NDRV,IDO)*RTO
                                      YW(IDO)=YW(IDO)*RTO
                                      YERO=X1
                                  END IF
                                  IF(JRT==0)THEN
                                      IF(BCOF(ISA)>0.)CALL EBUFSA
                                      VARH(6,IDO)=WSAX*YSD(NDRV,IDO)
                                      SMMH(6,MO,IDO)=SMMH(6,MO,IDO)+VARH(6,IDO)
                                      VAR(28,ISA)=YSD(2,IDO)
                                      SMM(28,MO,ISA)=SMM(28,MO,ISA)+YSD(2,IDO)
                                      SMM(29,MO,ISA)=SMM(29,MO,ISA)+YSD(4,IDO)
                                      VAR(29,ISA)=YSD(4,IDO)
                                      SMM(27,MO,ISA)=SMM(27,MO,ISA)+YSD(5,IDO)
                                      VAR(27,ISA)=YSD(5,IDO)
                                      ERAV(IDO)=ERAV(IDO)+ERTO
                                      SMM(124,MO,ISA)=SMM(124,MO,ISA)+YSD(6,IDO)
                                      VAR(124,ISA)=YSD(6,IDO)
                                      SMM(107,MO,ISA)=SMM(107,MO,ISA)+YSD(7,IDO)
                                      VAR(107,ISA)=YSD(7,IDO)
                                      SMM(88,MO,ISA)=SMM(88,MO,ISA)+YMNU(IDO)
                                      VAR(88,ISA)=YMNU(IDO)
                                      CY=1.E5*YSD(NDRV,IDO)/QVOL(IDO)
                                      CYAV(ISA)=CYAV(ISA)+CY
                                      CYSD(ISA)=CYSD(ISA)+CY*CY
                                      IF(CY>CYMX(ISA))CYMX(ISA)=CY
                                  END IF
                              END IF          
                              SMM(26,MO,ISA)=SMM(26,MO,ISA)+YSD(3,IDO)
                              VAR(26,ISA)=YSD(3,IDO)
                              SMM(31,MO,ISA)=SMM(31,MO,ISA)+YSD(8,IDO)
                              VAR(31,ISA)=YSD(8,IDO)
                              VAR(25,ISA)=CVF(ISA)
                          END IF          
                          YEW=MIN(ERTO*YSD(NDRV,IDO)/WT(LD1,ISA),.9)      
                          YEWN=MIN(ERTO*YW(IDO)/WT(LD1,ISA),.9)
                          CALL NYON
                          SMM(37,MO,ISA)=SMM(37,MO,ISA)+YN(IDO)+YNOU(IDO)
                          VAR(37,ISA)=YN(IDO)+YNOU(IDO)
                          SMM(134,MO,ISA)=SMM(134,MO,ISA)+YNWN(IDO)
                          VAR(134,ISA)=YNWN(IDO)
                          XX=.0001+EXP(-.1*YW(IDO)-YSD(3,IDO))
                          RHTT(ISA)=MAX(.001,RHTT(ISA)*XX)
                          DHT(ISA)=MAX(.001,DHT(ISA)*XX)
                          SMM(34,MO,ISA)=SMM(34,MO,ISA)+RRUF(ISA)
                          VAR(34,ISA)=RRUF(ISA)
                          IF(IHY>0)THEN
                              NHY(IDO)=0
                              HYDV(IDO)=0.
                              IF(QVOL(IDO)>QTH)THEN
                                  IF(INFL<4)THEN
                                      IF(NRF==0.AND.RFV(IRF(ISA))>0.)THEN
                                          IF(IHY>4)THEN
                                              CALL HRFDT
                                          ELSE
                                              CALL HRFDTS
                                          END IF
                                      END IF    
                                  END IF                  
                                  SMM(33,MO,ISA)=SMM(33,MO,ISA)+RHTT(ISA)
                                  VAR(33,ISA)=RHTT(ISA)
                                  RRUF(ISA)=MAX(.001,RRUF(ISA)*XX)
                                  !CALL HYDDV
                                  CALL HYDUNT
	                              !IF(IHY==0)CALL EHYD
                              END IF	          
                          END IF	      
                          AFN=MIN(BVIR(ISA)*CQNI,FNMX(IRO(ISA),ISA)-ANA(IRO(ISA),ISA))
                          IF(AFN>0.)THEN
                              ANA(IRO(ISA),ISA)=ANA(IRO(ISA),ISA)+AFN
                              WNO3(LD1,ISA)=WNO3(LD1,ISA)+AFN
                              IF(NOP>0.OR.NBSA(ISA)==ISAP)WRITE(KW(1),1140)ISA,NBSA(ISA),&
                              IYR,MO,KDA,AFN,BVIR(ISA),XHSM(ISA)
                          END IF
                          RFV(IRF(ISA))=RFV(IRF(ISA))+BVIR(ISA)
                          BVIR(ISA)=0.
                          IF(LUN(ISA)/=35)CALL HPURK
!                         PKRZ(LNS)=PKRZ(LNS)+CPVV
                          SMM(97,MO,ISA)=SMM(97,MO,ISA)+CPVV
                          SMM(87,MO,ISA)=SMM(87,MO,ISA)+CPVH(IDO)
                          XX=PKRZ(LNS)
                          SMM(16,MO,ISA)=SMM(16,MO,ISA)+XX
                          VAR(16,ISA)=XX
                          SMM(83,MO,ISA)=SMM(83,MO,ISA)+QRF(IDO)
                          VAR(83,ISA)=QRF(IDO)
                          GWST(ISA)=GWST(ISA)+XX
                          X1=RFTT(ISA)*GWST(ISA)
                          X2=X1*RFPK(ISA)
                          VAR(71,ISA)=X1-X2
                          CONC=GWSN(ISA)/(GWST(ISA)+1.E-10)
                          IF(GWST(ISA)/GWMX(ISA)<PRMT(40))X2=0.
	                      TNL=CONC*X1
	                      CNV=TNL/(X2*PRMT(74)+VAR(71,ISA))
	                      CNH=CNV*PRMT(74)
                          RSFN(IDO)=CNH*X2
                          DPKN=CNV*VAR(71,ISA)
                          SMM(96,MO,ISA)=SMM(96,MO,ISA)+DPKN
                          VAR(96,ISA)=DPKN
                          GWSN(ISA)=MAX(1.E-10,GWSN(ISA)-RSFN(IDO)-DPKN)
                          DO K=1,NDP
                              X3=GWPS(K,ISA)/GWST(ISA)
                              RSPS(K,IDO)=MIN(GWPS(K,ISA),X2*X3)
                              GWPS(K,ISA)=GWPS(K,ISA)-RSPS(K,IDO)
                              VARP(12,K,IDO)=MIN(GWPS(K,ISA),VAR(71,ISA)*X3)
                              GWPS(K,ISA)=GWPS(K,ISA)-VARP(12,K,IDO)
                              SMMP(11,K,MO,IDOA(ISA))=SMMP(11,K,MO,IDOA(ISA))+RSPS(K,IDO)
                              SMMP(12,K,MO,IDOA(ISA))=SMMP(12,K,MO,IDOA(ISA))+VARP(12,K,IDO)
                          END DO
                          SMM(15,MO,ISA)=SMM(15,MO,ISA)+SST(IDO)
                          VAR(15,ISA)=SST(IDO)
                          RSSF(IDO)=X2
                          SMM(71,MO,ISA)=SMM(71,MO,ISA)+VAR(71,ISA)
                          SMM(72,MO,ISA)=SMM(72,MO,ISA)+RSSF(IDO)
                          VAR(72,ISA)=RSSF(IDO)
                          X2=X2*SALA(ISA)/WSA(ISA)
                          GWST(ISA)=MAX(1.E-10,GWST(ISA)-VAR(71,ISA)-X2)
                          CALL NCQYL
                          X1=RSSF(IDO)+SST(IDO)+QRF(IDO)
                          XX=QVOL(IDO)+X1
                          X1=MAX(RQRB(IDO),X1/24.)
                          IF(KFL(9)>0)WRITE(KW(9),1202)ISA,NBSA(ISA),IYR,MO,KDA,CN,SCI(ISA),&
                          VAR(4,ISA),STMP(LD2,ISA),SML,QVOL(IDO),SST(IDO),QRF(IDO),RSSF(IDO),&
                          XX,X1,TC(IDO),DUR,ALTC,AL5,REP,RZSW(ISA),GWST(ISA)
 	                      REP=0.
	                      REPI(ISA)=0. 
                          CALL HEVP
                          SMM(10,MO,ISA)=SMM(10,MO,ISA)+EO
                          VAR(10,ISA)=EO
                          ADEO=(XDA*SMM(10,MO,ISA)+XDA1*PMOEO)*.0226
                          ADRF=(XDA*(SMM(4,MO,ISA)-SMM(13,MO,ISA)-SMM(17,MO,ISA))+XDA1*PMORF&
                          )/31.
                          SMRF(ISA)=SMRF(ISA)-RF5(IWTB,ISA)+RFV(IRF(ISA))
                          DO I=IWTB,2,-1
                              RF5(I,ISA)=RF5(I-1,ISA)
                          END DO
                          RF5(1,ISA)=RFV(IRF(ISA))
                          X1=STMP(LD2,ISA)*CLF
                          SMEO(ISA)=SMEO(ISA)-EO5(IWTB,ISA)+X1
                          DO I=IWTB,2,-1
                              EO5(I,ISA)=EO5(I-1,ISA)
                          END DO
                          EO5(1,ISA)=X1
                          IF(WTMN(ISA)<Z(LNS,ISA))CALL HWTBL
                          VAP(ISA)=0.
                          VPU(ISA)=0.
                          QSFP=0.
	                      IF(LUN(ISA)/=35.AND.RFV(IRF(ISA))>0.)THEN
	                          !IF(LBP==1)THEN
	                              CALL NYPA
	                          !ELSE
	                              !CALL NYPAV
                              !END IF
                          END IF
                          SMM(48,MO,ISA)=SMM(48,MO,ISA)+YP(IDO)+YPOU(IDO)
                          VAR(48,ISA)=YP(IDO)+YPOU(IDO)
                          VARH(2,IDO)=WSAX1*QVOL(IDO)/86400.
	                      SMMH(2,MO,IDO)=SMMH(2,MO,IDO)+VARH(2,IDO)
                          VARH(9,IDO)=WSAX*(YN(IDO)+YNOU(IDO))
                          SMMH(9,MO,IDO)=SMMH(9,MO,IDO)+VARH(9,IDO)
                          VARH(11,IDO)=WSAX*(YP(IDO)+YPOU(IDO))
                          SMMH(11,MO,IDO)=SMMH(11,MO,IDO)+VARH(11,IDO)
                          VAR(118,ISA)=YMP+QAPY
                          SMM(118,MO,ISA)=SMM(118,MO,ISA)+VAR(118,ISA)
                          VAR(119,ISA)=VAR(48,ISA)-VAR(118,ISA)
                          SMM(119,MO,ISA)=SMM(119,MO,ISA)+VAR(119,ISA)
                          SMM(135,MO,ISA)=SMM(135,MO,ISA)+YPWN(IDO)
                          VAR(135,ISA)=YPWN(IDO)
                          RSDM(LD1,ISA)=RSDM(LD1,ISA)-YMNU(IDO)
                          ZZ=WLM(LD1,ISA)+WLS(LD1,ISA)
                          RTO=MIN(1.,WLM(LD1,ISA)/ZZ)
                          WLM(LD1,ISA)=WLM(LD1,ISA)-RTO*YMNU(IDO)
                          X1=WLSL(LD1,ISA)/WLS(LD1,ISA)
                          WLS(LD1,ISA)=MAX(1.E-10,WLS(LD1,ISA)-YMNU(IDO)*(1.-RTO))
                          WLSL(LD1,ISA)=MAX(1.E-10,WLS(LD1,ISA)*X1)
                          UNM=0.
                          UPM=0.
                          UKM=0.
                          NDFA(ISA)=NDFA(ISA)+1
                          NII(ISA)=NII(ISA)+1
                          XHSM(ISA)=HSM(ISA)/AHSM
                          IRGX=0
                          IF(NYD/=1.AND.IDA==60)THEN
                              NT1=1
                          ELSE
                              N1=KT(ISA)
                              LGZ=0
                              DO KT2=N1,NN1
                                  KT(ISA)=KT2
                                  IF(KOMP(KT2,ISA)>0)CYCLE
                                  IF(KTF(ISA)==0)KTF(ISA)=KT2
                                  DO K=1,LC
                                      IF(JH(IRO(ISA),KT2,ISA)==KDC(K))EXIT
                                  END DO
                                  IF(K>LC)K=1
                                  JJK=K
                                  IF(IHUS==0)THEN
                                      IF(IDA<ITL(IRO(ISA),KT2,ISA)+NT1)EXIT
                                  END IF
                                  IF(KGO(JJK,ISA)>0.OR.JPL(JJK,ISA)>0)XHSM(ISA)=HU(JJK,ISA)/&
                                  PHU(JJK,IHU(JJK,ISA),ISA)
                                  IF(XHSM(ISA)<HUSC(IRO(ISA),KT2,ISA))THEN
                                      IF(MO<12.OR.IDC(JJK)==NDC(7).OR.IDC(JJK)==NDC(8).OR.IDC(JJK)&
                                      ==NDC(10))EXIT
                                  ELSE
	                                  IF(PDSW(ISA)/PDAW(ISA)>PRMT(78).AND.RSAE(ISA)<1.E-5.AND.MO<&
                                      12)THEN
	                                      IF(KFL(1)>0)WRITE(KW(1),589)ISA,NBSA(ISA),IY,MO,KDA,PDSW(ISA),&
                                          PDAW(ISA)
                                          EXIT
                                      END IF    
                                  END IF    
                                  JT1=LT(IRO(ISA),KT2,ISA)
                                  KOMP(KT2,ISA)=1
                                  IF(KT2>KTMX(ISA))KTMX(ISA)=KT(ISA)
                                  CSTX=COTL(JT1)
                                  COX=COOP(JT1)
                                  II=0
                                  SELECT CASE(IHC(JT1))
                                      CASE(7)
                                          IF(RFV(IRF(ISA))>PRMT(77))THEN
                                              KOMP(KT2,ISA)=0
                                              CYCLE
                                          END IF
                                          CALL PSTAPP
	                                      IF(IDA==JD0.AND.NBT(JT1)==0.AND.NBE(JT1)==JDE)THEN
                                              CSTX=0.
                                              COX=0.
                                          END IF
                                          II=1
                                      CASE(8)
                                          IF(IRGX>0)THEN
                                              KOMP(KT2,ISA)=0
                                              CYCLE
                                          END IF
                                          BVIR(ISA)=VIRR(IRO(ISA),KT2,ISA)
                                          IF(BVIR(ISA)<1.E-10)IAUI(ISA)=JT1
                                          CALL HIRG(BVIR(ISA),EFM(JT1),TLD(JT1),JRT,JT1,1)
                                          IRGX=1
                                      CASE(9)    
                                          IHD=0
	                                      CALL NFERT(APMU,6,JT1,KT2,JRT)
	                                      IF(IDA==JD0.AND.NBT(JT1)==0.AND.NBE(JT1)==JDE)THEN
                                              CSTX=0.
                                              COX=0.
                                          END IF
                                            II=1
                                      CASE(20)
                                          KOMP(N1,ISA)=1 
                                          RST0(ISA)=0.         
                                          IGZ(ISA)=0
                                          DO IHD=1,NHRD(IOW)
                                              NGZ(IHD,ISA)=0
                                              GCOW(IHD,ISA)=0.
                                          END DO
                                          KTF(ISA)=KTF(ISA)+1
                                      CASE DEFAULT
                                          II=1    
                                  END SELECT
                                  IF(II==1)THEN
                                      JD0=IDA
                                      JDE=NBE(JT1)
                                      CALL TLOP(CSTX,COX,JRT)
                                      IF(JRT>0)EXIT
                                  END IF    
                                  IF(IFD(ISA)>0.AND.DKHL(ISA)>.001)THEN
                                      DHT(ISA)=DKHL(ISA)
                                      IF(NOP>0.OR.NBSA(ISA)==ISAP)WRITE(KW(1),970)ISA,NBSA(ISA),IYR&
                                      ,MO,KDA,DHT(ISA),DKIN(ISA),XHSM(ISA)
                                  END IF    
                                  COST(ISA)=COST(ISA)+CSTX
                                  CSFX=CSFX+COX
                                  JT2=JT1
                              END DO
                              IF(KT2>NN1)KTF(ISA)=N1
                              KT(ISA)=KTF(ISA)
                              DO IHD=1,NHRD(IOW)
                                  IZ=IFED(IHD,IOW)
	                              IF(IZ==ISA)THEN
                                      IF(NCOW(IHD,IOW)>0)GCOW(IHD,ISA)=NCOW(IHD,IOW)*FFED(IHD,IOW)
	                              ELSE
                                      IF(RST0(ISA)<1.E-5)THEN
                                          IF(IGZX(IHD,IOW)/=ISA)CYCLE
                                          GCOW(IHD,ISA)=NCOW(IHD,IOW)*(1.-FFED(IHD,IOW))
	                                  END IF	              
	                                  IF(NGZ(IHD,ISA)==0.OR.IGZ(ISA)==0)CYCLE
	                              END IF
                                  STKR(ISA)=STKR(ISA)+GCOW(IHD,ISA)
                                  DDMP=DUMP(IHD,IOW)*GCOW(IHD,ISA)
                                  TMPD=TMPD+DDMP
                                  X1=DDMP*SOLQ(ISA)
                                  WTMU(ISA)=WTMU(ISA)+X1
                                  AFLG(ISA)=AFLG(ISA)+X1
                                  SMM(61,MO,ISA)=SMM(61,MO,ISA)+X1
                                  VAR(61,ISA)=X1
                                  X5=.0001*VURN(IHD,IOW)*GCOW(IHD,ISA)/WSAX
                                  RFV(IRF(ISA))=RFV(IRF(ISA))+X5
                                  X2=DDMP-X1
                                  APMU=X2/WSA(ISA)
                                  CALL NFERT(APMU,3,IAMF(ISA),KT2,JRT)
                              END DO
                              IHD=NHRD(IOW)
                              IF(IAPL(ISA)>0)THEN
                                  IF(ISAS(IOW)/=ISA)GO TO 5 
                                  APMU=FNP(2,ISA)
                                  IF(SMNU(IOW)<.001*APMU*WSA(ISA))GO TO 5
	                              CALL NFERT(APMU,2,ISPF(ISA),KT2,JRT)
                                  IF(JRT>0)GO TO 5      
                                  X4=.001*APMU
                                  SMNU(IOW)=SMNU(IOW)-X4
                                  GO TO 5
                              END IF
                              IF(DALG(ISA)>0.)THEN
                                  ALQ(ISA)=0.
                                  CALL HLGOON(JRT)
                                  IF(JRT==0)THEN
                                      ALQ(ISA)=MIN(CFNP(ISA)*VLGI(ISA),.95*WTMU(ISA))
                                      CFNP(ISA)=WTMU(ISA)/VLG(ISA)
                                      GO TO 5
                                  END IF
                              END IF
                              IF(ISAL(IOW)/=ISA)GO TO 5
                              IZ=-IAPL(ISA)
                              IF(ALQ(IZ)<1.E-5)GO TO 5
    !                         IF(RZSW(ISA)-PAW(ISA)>BIR(ISA))GO TO 5
                              APMU=MIN(.9*WTMU(IZ),ALQ(IZ))
                              APMU=APMU/WSA(ISA)
	                          CALL NFERT(APMU,1,ILQF(ISA),KT2,JRT)
                              IF(JRT>0)GO TO 5
                              SMM(62,MO,IZ)=SMM(62,MO,IZ)+APMU
                              VAR(62,ISA)=APMU
                              X6=APMU
                              WTMU(IZ)=WTMU(IZ)-APMU
                              BVIR(ISA)=.1*ALGI(IOW)/WSA(ISA)
                              CALL HIRG(BVIR(ISA),1.,0.,JRT,JT1,1)
                              IF(JRT==0)TFLG(ISA)=TFLG(ISA)+APMU
                            5 BIR(ISA)=TIR(IRO(ISA),KTMX(ISA),ISA)
                              EFI(ISA)=QIR(IRO(ISA),KTMX(ISA),ISA)
                              FIRG(ISA)=FIRX(IRO(ISA),KTMX(ISA),ISA)
                              JT1=LT(IRO(ISA),KT(ISA),ISA)
                              IF(NDFA(ISA)>=IFA(ISA).AND.IDFT(5,ISA)/=0)THEN
                                  APMU=FNP(5,ISA)
	                              IF(APMU>1.E-5)CALL NFERT(APMU,5,JT1,KT2,JRT)
	                          END IF
                              KTF(ISA)=0
                              IF(ABS(BIR(ISA))>1.E-5)THEN
                                  IF(BIR(ISA)<0.)THEN
                                      IF(RZSW(ISA)-PAW(ISA)<BIR(ISA))CALL HIRG(BVIR(ISA),&
                                      EFM(IAUI(ISA)),TLD(IAUI(ISA)),JRT,IAUI(ISA),0)
                                  ELSE
                                      IF(BIR(ISA)>=1.)THEN
                                          CALL SWTN
                                          IF(WTN>BIR(ISA))CALL HIRG(BVIR(ISA),EFM(IAUI(ISA)),&
                                          TLD(IAUI(ISA)),JRT,IAUI(ISA),0)
                                      ELSE
                                          IF(WS(ISA)<BIR(ISA))CALL HIRG(BVIR(ISA),EFM(IAUI(ISA)),&
                                          TLD(IAUI(ISA)),JRT,IAUI(ISA),0)
                                      END IF
                                  END IF    
                              END IF
                          END IF    
                          IF(LUN(ISA)/=35)CALL NPCY
                          IF(IRR(ISA)==1)RFV(IRF(ISA))=RFV(IRF(ISA))+BVIR(ISA)
                          IF(IDNT>2)CALL GASDF3
                          XX=0.
                          RSPC=0.
                          DO J=1,NBSL(ISA)
                              ISL=LID(J,ISA)
                              IF(STMP(ISL,ISA)>0.)THEN
                                  Z5=500.*(Z(ISL,ISA)+XX)
                                  IF(ICP==0)THEN
                                      CALL NCNMI_PHOENIX(Z5,CS,EAR(ISL,ISA))
                                  ELSE    
                                      CALL NCNMI_CENTURY(Z5,CS,EAR(ISL,ISA))
                                  END IF
                              END IF
                              XX=Z(ISL,ISA)
                          END DO                                                                 
                          CV(ISA)=0.
                          CVP(ISA)=0.
                          CVRS(ISA)=0.
                          VAC(ISA)=0.
                          AEPT=0.
                          XES=ES
                          AGPM(ISA)=0.
                          TAGP(ISA)=0.
                          IF(IGO(ISA)>1)XES=ES/IGO(ISA)
                          WS(ISA)=1.
                          IF(IGO(ISA)>0)THEN
                              JGO=0
                              JBG(ISA)=JBG(ISA)+1
                              IF(JBG(ISA)>IGO(ISA))JBG(ISA)=1
                              I=JBG(ISA)
                              DO J=1,LC
                                  IF(KGO(J,ISA)>0)THEN
                                      JGO(I)=KGO(J,ISA)
                                      I=I+1
                                      IF(I>IGO(ISA))I=1
                                  END IF    
                              END DO
                              I1=0
                              DO IN2=1,IGO(ISA)
                                  I1=I1+1
                                  JJK=JGO(I1)
                                  AEP(JJK)=0.
                                  IF(JPL(JJK,ISA)>0)THEN
                                      HU(JJK,ISA)=HU(JJK,ISA)+MAX(0.,DST0(ISA)-TBSC(JJK))
	                                  IF(PDSW(ISA)/PDAW(ISA)>PRMT(11).AND.HU(JJK,ISA)>GMHU(JJK))THEN
	                                      JPL(JJK,ISA)=0
                                          IF(NOP>0.OR.NBSA(ISA)==ISAP)WRITE(KW(1),950)ISA,NBSA(ISA),IYR&
                                          ,MO,KDA,CPNM(JJK),PDSW(ISA),HU(JJK,ISA),XHSM(ISA)
                                          HU(JJK,ISA)=0.
                                      ELSE
                                          IF(HU(JJK,ISA)/PHU(JJK,IHU(JJK,ISA),ISA)>.3.AND.KGO(JJK,ISA)>0)THEN
                                              KGO(JJK,ISA)=0
                                              IGO(ISA)=IGO(ISA)-1
                                              JPL(JJK,ISA)=0
                                          END IF    
                                          CYCLE
                                      END IF
                                  END IF
                                  CV(ISA)=CV(ISA)+DM(JJK,ISA)-RW(JJK,ISA)
                                  XX=PPL0(JJK,ISA)
                                  CVP(ISA)=MAX(CVP(ISA),XX/(XX+EXP(SCRP(15,1)-SCRP(15,2)*XX)))
                                  STLX=STL(JJK,ISA)
                                  VAC(ISA)=VAC(ISA)+BWN(1,JJK)*STLX
                                  AWC(JJK,ISA)=AWC(JJK,ISA)+RFV(IRF(ISA))-QVOL(IDO)
                                  DO L1=1,NBSL(ISA)
                                      ISL=LID(L1,ISA)
                                      UW(ISL)=0.
                                      UK(ISL)=0.
                                      UN(ISL)=0.
                                      UP(ISL)=0.
                                  END DO
                                  UNM=0.
                                  UPM=0.
                                  UKM=0.
                                  DDM(JJK)=0.
                                  CALL CGROW(JRT)
                                  IF(JRT/=1)THEN
                                      IF(JRT==0)THEN
                                          VARC(14,JJK,ISA)=REG(JJK,ISA)
                                          SUN=0.
                                          SUP=0.
                                          SUK=0.
!                                         CALL HUSE
			   !                          SUBROUTINE HUSE
			   !                          APEX1501
			   !                          THIS SUBPROGRAM IS THE MASTER WATER AND NUTRIENT USE SUBROUTINE.
			   !                          CALLS HSWU AND NUPPO FOR EACH SOIL LAYER.
			   !                          USE PARM
			                              LRD(ISA)=0
			                              L1=0
			                              UX=0.
			                              SEP=0.
			                              SUM=0.
			                              TOT=0.
			                              CPWU=1.
			                              RGS=1.
			                              DO J=1,NBSL(ISA)
			                                  ISL=LID(J,ISA)
			                                  SUM=SUM+SWST(ISL,ISA)-FC(ISL,ISA)
			                                  TOT=TOT+PO(ISL,ISA)-FC(ISL,ISA)
			                                  SEP=Z(ISL,ISA)
			                                  IF(L1>0)CYCLE
			                                  IF(RD(JJK,ISA)>Z(ISL,ISA))THEN
			                                      GX=Z(ISL,ISA)
			                                  ELSE
			                                      GX=RD(JJK,ISA)
			                                      LRD(ISA)=MAX(LRD(ISA),J)
			                                      L1=J
			                                  END IF
!                                             SUBROUTINE HSWU(CPWU,RGS)
!                                         	APEX1501
!                                         	THIS SUBPROGRAM DISTRIBUTES PLANT EVAPORATION THROUGH THE ROOT
!                                         	ZONE AND CALCULATES ACTUAL PLANT WATER USE BASED ON SOIL WATER
!                                         	AVAILABILITY.
!                                          	USE PARM
		                                      BLM=S15(ISL,ISA)
		                                      IF(Z(ISL,ISA)<=.5)BLM=PRMT(5)*S15(ISL,ISA)
		                                      IF(ISL/=LID(1,ISA))THEN
		                                          CALL CRGBD(RGS)  
		                                          CPWU=CPWU*RGS  
		                                      END IF  
		                                      SUM=EP(JJK)*(1.-EXP(-UB1(ISA)*GX/RD(JJK,ISA)))/UOB(ISA)  
		                                      TOS=36.*ECND(ISL,ISA)  
		                                      XX=LOG10(S15(ISL,ISA))  
		                                      X1=3.1761-1.6576*(LOG10(SWST(ISL,ISA))-XX)/(LOG10(FC(ISL,ISA))-XX)  
		                                      IF(X1<4.)THEN  
		                                          WTN=MAX(5.,10.**X1)  
		                                          XX=TOS+WTN  
		                                          IF(XX<5000.)THEN  
		                                              F=1.-XX/(XX+EXP(SCRP(22,1)-SCRP(22,2)*XX))  
		                                              UW(ISL)=MIN(SUM-CPWU*AEP(JJK)-(1.-CPWU)*UX,SWST(ISL,ISA)-BLM)*F*RGS  
		                                              UW(ISL)=MAX(0.,UW(ISL))*SALF  
		                                          END IF      
		                                      END IF  
		                                      UX=SUM  
!                                                                	RETURN  
!                                                                	END  
			                                  AEP(JJK)=AEP(JJK)+UW(ISL)  
			                              END DO 
			                              IF(LRD(ISA)==0)LRD(ISA)=NBSL(ISA)
			                              RTO=MIN(1.,SUM/TOT)
			                              F=100.*(RTO-CAF(JJK))/(1.0001-CAF(JJK))
			                              IF(F>0.)THEN
			                                  SAT=1.-F/(F+EXP(SCRP(7,1)-SCRP(7,2)*F))
			                              ELSE
			                                  SAT=1.
			                              END IF
			   !                          RETURN
			   !                          END
                                          CALL CROP
                                          CALL NUP
                                          CALL NPUP
                                          CALL NKUP
                                          CALL NUSE
                                          CALL CSTRS
                                          VARC(10,JJK,ISA)=WS(ISA)
                                          VARC(11,JJK,ISA)=SN
                                          VARC(12,JJK,ISA)=SP
                                          VARC(13,JJK,ISA)=SK
                                          VARC(15,JJK,ISA)=SAT            
                                          VARC(17,JJK,ISA)=REG(JJK,ISA)
                                          VAR(43,ISA)=WFX
                                          AEPT=AEPT+AEP(JJK)
                                          IF(HUI(JJK,ISA)>PRMT(3))THEN
                                              SWH(JJK,ISA)=SWH(JJK,ISA)+AEP(JJK)
                                              SWP(JJK,ISA)=SWP(JJK,ISA)+EP(JJK)
                                          END IF
                                          VAR(12,ISA)=AEP(JJK)
                                          ACET(JJK,ISA)=ACET(JJK,ISA)+AEP(JJK)+XES
                                      END IF          
                                      CALL CAGRO
                                      STV(5,MO,ISA)=UN1(JJK,ISA)
                                      VARS(5)=UN1(JJK,ISA)
                                      STV(6,MO,ISA)=UP1(JJK,ISA)
                                      VARS(6)=UP1(JJK,ISA)
                                      STV(7,MO,ISA)=UK1(JJK,ISA)
                                      VARS(7)=UK1(JJK,ISA)
                                  END IF          
                                  STLX=STL(JJK,ISA)
                                  IF(IDC(JJK)/=NDC(7).AND.IDC(JJK)/=NDC(8).AND.IDC(JJK)/=NDC(10))&
                                  AGPM(ISA)=AGPM(ISA)+STLX
                                  TAGP(ISA)=TAGP(ISA)+STLX
                                  VARC(1,JJK,ISA)=HUI(JJK,ISA)
                                  VARC(2,JJK,ISA)=SLAI(JJK,ISA)
                                  VARC(3,JJK,ISA)=RD(JJK,ISA)
                                  VARC(4,JJK,ISA)=RW(JJK,ISA)
                                  VARC(5,JJK,ISA)=DM(JJK,ISA)
                                  VARC(6,JJK,ISA)=STLX
                                  VARC(7,JJK,ISA)=CPHT(JJK,ISA)
                                  VARC(8,JJK,ISA)=STD(JJK,ISA)
                                  VARC(9,JJK,ISA)=STDL(JJK,ISA)
                              END DO          
                          END IF
                          !WRITE(KW(1),'(A,I8,A,I8)')'ISA=',ISA,'NBSA=',NBSA                                                         
                          WSAX=WSA(NISA(IDNB(IDO)))                                              
	                      X1=WSAX*(QN(IDO)+RSFN(IDO)+TSFN(IDO)+QRFN(IDO)+QDRN(IDO))
	                      VARH(13,IDO)=X1                                                             
	                      SMMH(13,MO,IDO)=SMMH(13,MO,IDO)+X1                                          
                          X1=WSAX*QP(IDO)                                                        
	                      VARH(19,IDO)=X1                                                             
	                      SMMH(19,MO,IDO)=SMMH(19,MO,IDO)+X1                                          
	                      SST(IDO)=SST(IDO)+QRP(IDO)                                                  
	                  CASE(2)
	                      TDEG=0.
                          TDEP=0.                                                                         
                          CALL ROUTE
                          !WRITE(KW(1),'(A)')'ROUTE'                                                             
                      CASE(3)                                                                    
                          CALL RTADD                                                             
                      CASE(4)                                                                    
                          CALL RESRT                                                             
                      CASE(5)                                                                    
                          CALL RESPOND                                                           
                  END SELECT                                                                     
                  SRCH(7,IDO)=SRCH(7,IDO)+QVOL(IDO)                                              
                  SRCH(8,IDO)=SRCH(8,IDO)+YSD(NDRV,IDO)
                  SRCH(9,IDO)=SRCH(9,IDO)+YN(IDO)+YNOU(IDO)                                                
                  SRCH(10,IDO)=SRCH(10,IDO)+YP(IDO)+YPOU(IDO)                                              
                  SRCH(11,IDO)=SRCH(11,IDO)+QN(IDO)                                              
                  SRCH(12,IDO)=SRCH(12,IDO)+QP(IDO)                                              
                  SRCH(15,IDO)=SRCH(15,IDO)+SST(IDO)                                             
                  SRCH(16,IDO)=SRCH(16,IDO)+RSSF(IDO)                                            
                  SRCH(17,IDO)=SRCH(17,IDO)+TSFN(IDO)                                            
                  SRCH(21,IDO)=SRCH(21,IDO)+QRFN(IDO)                                            
                  SRCH(22,IDO)=SRCH(22,IDO)+QDRN(IDO)                                            
                  SRCH(18,IDO)=SRCH(18,IDO)+RSFN(IDO)                                            
                  SRCH(19,IDO)=SRCH(19,IDO)+QRF(IDO)                                             
                  SRCH(20,IDO)=SRCH(20,IDO)+QDR(IDO)                                             
                  SRCH(23,IDO)=SRCH(23,IDO)+CPVH(IDO)                                            
                  SRCH(24,IDO)=SRCH(24,IDO)+YMNU(IDO)                                            
                  SRCH(25,IDO)=SRCH(25,IDO)+.001*YC(IDO)                                         
	              SRCH(26,IDO)=SRCH(26,IDO)+QPU(IDO)
	              SRCH(27,IDO)=SRCH(27,IDO)+QDRP(IDO)                                            
	              VARW(13)=QVOL(IDO)
                  VARW(15)=SST(IDO)
                  VARW(NDVSS)=YSD(NDRV,IDO)
                  VARW(37)=YN(IDO)
                  VARW(38)=QN(IDO)+RSFN(IDO)+TSFN(IDO)+QRFN(IDO)+QDRN(IDO)                                                                      
                  VARW(39)=TSFN(IDO)
                  VARW(72)=RSSF(IDO)
                  VARW(80)=RSFN(IDO)
                  VARW(17)=QDR(IDO)
                  VARW(47)=QDRN(IDO)
                  VARW(48)=YP(IDO)
                  VARW(49)=QP(IDO)
                  VARW(76)=QC(IDO)
                  VARW(77)=YC(IDO)
                  VARW(83)=QRF(IDO)
                  VARW(84)=QRFN(IDO)
                  VARW(88)=YMNU(IDO)
                  VARW(108)=QPU(IDO)
                  VARW(117)=.1*WYLD(IDO)/RWSX
                  VARW(143)=QDRP(IDO)
                  IF(IHY>0)THEN
                      T1=0.
                      AD1=0.
                      X2=0.
                      AD1=-.5*(QHY(1,IDO,IHX(1))+QHY(NPD,IDO,IHX(1)))
                      DO K=1,NPD
                          X1=QHY(K,IDO,IHX(1)) 
                          AD1=AD1+X1
                          IF(X1>X2)THEN
                              X2=X1
                              X3=T1
                          END IF
                          T1=T1+DTHY
                      END DO
                      AD1=AD1*DTHY*360./RWSA(IDO)
	                  HYDV(IDO)=AD1
	                  IWH=0.
                      IF(AD1>=QTH)THEN
                          IWH=1
                          T1=0.
	                      DO K=1,NPD
	                          WRITE(KW(26),26)T1,(QHY(K,IDO,IHX(J)),J=1,MHX)
	                          T1=T1+DTHY
	                      END DO
                          IF(IDO==NCMD.AND.KFL(12)>0)THEN
	                          T1=0.
	                          DO K=2,NPD
	                              T1=T1+DTHY
	                              T2=T2+DTHY
	                              WRITE(KW(12),'(5X,3I4,F8.3,F10.2,E13.5)')IY,MO,KDA,T1,&
	                              T2,QHY(K,IDO,IHX(1))
	                              ADHY=ADHY+QHY(K,IDO,IHX(1))
                              END DO
	                      END IF    
	                  END IF
	                  SQVL(IDO)=SQVL(IDO)+QVOL(IDO)
                      SHYD(IDO)=SHYD(IDO)+AD1
	                  IF(ICDT(ICMD)==3)THEN
	                      II=0
	                  ELSE
	                      II=IDNB(IDO)
	                  END IF
	                  IF(IWH>0)WRITE(KW(26),12)CMDX(ICDT(IDO)),IDO,II,IY,MO,KDA,X2,&
                      X3,AD1,SQVL(IDO),SHYD(IDO)
                      WRITE(KW(25),12)CMDX(ICDT(IDO)),IDO,II,IY,MO,KDA,X2,&
                      X3,AD1,SQVL(IDO),SHYD(IDO)
	              END IF 
	              !IF(ICDT(ICMD)==2.AND.IDO==5)THEN
	                  !DF=YSD(NDRV,4)+TDEG-TDEP-YSD(NDRV,IDO)
	                  !IF(ABS(DF)>.001)WRITE(KW(1),35)YSD(NDRV,4),TDEG,TDEP,YSD(NDRV,IDO),DF
	                  !DF=SRCH(8,4)+SRCH(14,IDO)-SRCH(13,IDO)-SRCH(8,IDO)
	                  !IF(ABS(DF)>.1)WRITE(KW(1),35)SRCH(8,4),SRCH(14,IDO),&
	                  !SRCH(13,IDO),SRCH(8,IDO),DF
                  !END IF	                                                        
            !	SUM=0.                                                                             
            !     DO 908 L=1,NBSL(ISA)                                                           
            !     ISL=LID(L,ISA)                                                                 
            !     YTP(ISL)=QSF(ISL,ISA)+SSF(ISL,ISA)+CPFH(ISL,ISA)                               
            !     SUM=SUM+YTP(ISL)                                                               
            !     ZTP(ISL)=100.*PSSF(1,ISL,ISA)/(YTP(ISL)+.001)                                  
            ! 908 CONTINUE                                                                       
            !     WRITE(KW(1),154)IYR,MO,KDA,IDO,RFV(ISA),QVOL(IDO),TMX(IRF(ISA)),               
            !    1TMN(IRF(ISA)),SRAD(IRF(ISA)),EO,AET                                            
            !     WRITE(KW(1),906)(PO(LID(L,ISA),ISA),L=1,NBSL(ISA))                             
            !     WRITE(KW(1),906)(FC(LID(L,ISA),ISA),L=1,NBSL(ISA))                             
            !     WRITE(KW(1),906)(S15(LID(L,ISA),ISA),L=1,NBSL(ISA))                            
            !     WRITE(KW(1),906)(SWST(LID(L,ISA),ISA),L=1,NBSL(ISA))                             
            !     WRITE(KW(1),906)(PKRZ(LID(L,ISA)),L=1,NBSL(ISA))                               
            !     WRITE(KW(1),906)(QSF(LID(L,ISA),ISA),L=1,NBSL(ISA))                            
            !     WRITE(KW(1),906)(SSF(LID(L,ISA),ISA),L=1,NBSL(ISA))                            
            !     WRITE(KW(1),906)(CPFH(LID(L,ISA),ISA),L=1,NBSL(ISA))                           
            !     WRITE(KW(1),906)(YTP(LID(L,ISA)),L=1,NBSL(ISA)),SUM                            
            !     WRITE(KW(1),906)(PSTZ(1,LID(L,ISA),ISA),L=1,NBSL(ISA))                         
            !     WRITE(KW(1),906)(PSSF(1,LID(L,ISA),ISA),L=1,NBSL(ISA))                         
            !     WRITE(KW(1),906)(ZTP(L),L=1,NBSL(ISA))                                         
              END DO ! COMMAND LOOP