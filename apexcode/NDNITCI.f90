      SUBROUTINE NDNITCI
      ! APEX1501
      USE PARM
      DATA B1,B2,B3/70.,140.,720./,COX/.032/,DAO2/7.2E-6/,O2MW/32./,&
      XN/2.58368E15/,FD/.19/,RGF,RMF/.547,.01785/,VU/1./,VL/-.15/,&
      DIAM1/3.27E-7/,STN/.0728/,A1/.61821/,T1/3.27536/,FCMX/3.06/,&
      VWCR/.03/,WPMP/153.06/,A,B,C/.002,1.4,.5/
      ! THIS LOOP CALCULATES THE PRODUCTION AND CONSUMPTION OF O2, CO2, AND
      ! N2O BY SOIL LAYER WITHIN ONE HOUR. IT ALSO UPDATES POOLS OF NO3 AND
      ! NO2 FACTOR TO CONVERT MASS (kg/ha FOR A GIVEN SOIL LAYER) TO 
      ! GAS CONCENTRATION (G/M3 SOIL)
	  AD1=0.
      AD2=0.
      AD3=0.
      XFCM=LOG10(FCMX)
      XMP=XFCM-LOG10(WPMP)
      XSTN=2.*STN
      DO J=1,NBCL
          AD1=AD1+WNO3(J,ISA)+WNO2(J,ISA)+WN2O(J,ISA)
          ! EA=TOTAL ELECTRONS ACCEPTED BY O2 AND N OXIDES
          EA=0.
          EAO2=0.
          EAO2R=0.
          ESRR=0.
          WN2G=0.
          ESMR=RSPC(J,ISA)/B3
          X4=SOT(J,ISA)+273.15
          IF(IDNT==3)THEN
              VWCE=MIN(.99,(VWC(J,ISA)-VWCR)/(TPOR(J,ISA)-VWCR))
              X3=.001*((VWCE**(-1./C)-1.)**(1./B))/A
              DW=MAX(1.01E-6,1.E-6+8.E-6*X3**(-0.945703126))
          ELSE
              DIAM2=1.E-6*(T1-(1./A1)*LOG((VU-VL)/(CBVT-VL)-1.))
              XFC=LOG10(VFC(J,ISA))
              BX=XMP/(LOG10(VWP(J,ISA))-XFC)
              A2=10.**(BX*XFC+XFCM)
              CONSTA=9.82*A2/XSTN
              CONSTB=1./BX
              PVC=(CONSTA*DIAM2)**CONSTB
              VEDW=VWC(J,ISA)-PVC
              HX=.9549*PVC/((.5*DIAM1)**2+(.5*DIAM2)**2+DIAM1*DIAM2/4.)
              XL=SQRT(HX**2+(.5*(DIAM2-DIAM1))**2)
              SA=1.5708*(DIAM1+DIAM2)*XL
              DW=MAX(1.1E-6,VEDW/SA)
          END IF
          DAO2TC=DAO2*(X4/293.15)**6
          XKT=1.5708E-10*XN*WBMC(J,ISA)*DAO2TC*DW/(DW-1.E-6)
          IF(XKT>0.)THEN
              QTB=XKT*(CLO2(J,ISA)-COX)-ESMR
              QTC=XKT*COX*CLO2(J,ISA)
              IF(QTB>1.E10)THEN
                  EAO2=ESMR
              ELSE
                  O2M=(QTB+SQRT(QTB*QTB+4.*XKT*QTC))/(2.*XKT)
                  EAO2=ESMR*O2M/(O2M+COX)
              END IF
          ELSE
              EAO2=0.
          END IF
          IF(RWTZ(J,ISA)>1.E-5.AND.JRRS==0)THEN
              ! NEW DERIVATION FOR ELECTRON SUPPLY DUE TO ROOT RESPIRATION
              ! SEE MODEL DOCUMENTATION
              ! ROOT RESPIRED C (KG C HA-1 D-1)
              X1=(RGF/(1.-RGF))*MAX(0.,DRWX(J,ISA))+RMF*RWTZ(J,ISA)
              RRTC=.42*X1
              ! ESRR=MOLE E- M-2 H-1 FROM ROOT RESPIRATION - USE ESRR
              ESRR=5.833E-4*X1
  	          RRC=ESRR*B3 
              !XKTR=54.573*DAO2TC*RWTZ(J,ISA)
              X2=LOG(DW/.001)
              IF(X2<=0.)X2=1.
              XKTR=125.664*DAO2TC*RWTZ(J,ISA)/X2
              QTBR=XKTR*(CLO2(J,ISA)-COX)-ESRR
              IF(QTBR>1.E10)THEN
                  EAO2R=ESRR
              ELSE
                  QTCR=XKTR*COX*CLO2(J,ISA)            
                  ! SOLVE QUADRATIC EQN FOR O2M AND O2MR
                  O2R=(QTBR+SQRT(QTBR*QTBR+4.*XKTR*QTCR))/(2.*XKTR)
                  ! ELECTRONS FROM MICROBE AND ROOT RESPIRATION ACCEPTED BY O2
                  EAO2R=ESRR*O2R/(O2R+COX)
              END IF
          END IF	
          SUM=EAO2+EAO2R
          ESD=ESMR+ESRR-SUM
          ! ELECTRONS AVAILABLE FOR DENITRIFICATION
          ESD=FD*ESD
          ! COMPETITION FOR ELECTRONS AMONG OXIDES OF N
          ! CALCULATE WEIGHING FACTORS FIRST
          X1=DZ10*VWC(J,ISA)
          CNO3=MAX(1.E-5,WNO3(J,ISA)/X1)
          CNO2=MAX(1.E-5,WNO2(J,ISA)/X1)
          WN5=2.*CNO3/(XKN5+CNO3)
          WN3=2.*CNO2/(XKN3*(1.+CNO3/XKN5)+CNO2)
          WN1=CLN2O(J,ISA)/(XKN1*(1.+CNO2/XKN3)+CLN2O(J,ISA))
          ! CALCULATE THE RATES OF REDUCTION OF OXIDES OF N
          X2=ESD/(WN1+WN3+WN5)
          X1=MAX(1.E-10,WNO3(J,ISA)/B1)
          EAN5=MIN(X1,X2*WN5)
          X1=MAX(1.E-10,WNO2(J,ISA)/B1)
          EAN3=MIN(X1,X2*WN3)
          IF(WN2O(J,ISA)>0.)THEN
              X1=WN2O(J,ISA)/B2
              EAN1=MIN(X1,X2*WN1)
          ELSE
              EAN1=0.
          END IF
          ! THESE ARE THE RESULTS BY LAYER AT THE END OF ONE HOUR
          ! IF NOT ALL ELECTRONS CAN BE ACCEPTED BY O2 (ESD>0.)
          ! TOTAL ELECTRONS ACCEPTED AND TRANSFORMATIONS OF N OXIDES
          EA=EA+EAO2+EAO2R+EAN5+EAN3+EAN1
          SMEA(J,ISA)=SMEA(J,ISA)+EA
          SMES(J,ISA)=SMES(J,ISA)+ESMR+ESRR
          ! EAD=TOTAL DEFICIT OF ELECTRONS
          EAD=EAN5+EAN3+EAN1
          ! LIQUID POOLS
          WNO3(J,ISA)=WNO3(J,ISA)-EAN5*B1
          WNO2(J,ISA)=WNO2(J,ISA)-(EAN3-EAN5)*B1
          ! GAS POOLS
          ! NITROUS OXIDE AND DINITROGEN
          ! GENN2O CALCULATES HOW MUCH N2O IS GENERATED (kg/ha/h per layer)
          GENN2O=EAN3*B1-EAN1*B2
          ! DN2OG(J,ISA) ACCUMULATES N2O GENERATED DURING A DAY (kg/ha)
          DN2OG(J,ISA)=DN2OG(J,ISA)+GENN2O
          ! WN2O(J,ISA) UPDATES THE N2O POOL (kg/ha). *WN2O(J,ISA)=DN2O(J,ISA)*
          WN2O(J,ISA)=WN2O(J,ISA)+GENN2O
          ! AN2OC(J,ISA) CONVERTS MASS OF N2O INTO CONCENTRATION (G/M3)
          AN2OC(J,ISA)=WN2O(J,ISA)/DZ10
          ! WN2G CALCULATES THE MASS OF N2 GENERATED (kg/ha)
          WN2G=EAN1*B2
          IF(WN2O(J,ISA)<0.)WRITE(KW(1),'(1X,A,4I4,10E16.6)')'~~~~~',IY,MO,&
          KDA,J,WN2O(J,ISA),GENN2O,WN2G
          ! DN2G(J,ISA) ACCUMULATES N2 GENERATED DURING A DAY (kg/ha)
          DN2G(J,ISA)=DN2G(J,ISA)+WN2G
          ! O2CONS= O2 CONSUMED (kg/ha)
          ! (MOL E/M2*1/4*MOL O2/MOL E*32 G O2/MOL O2*10.)
          O2CONS=2.5*SUM*O2MW
          ! DO2CONS ACCUMULATES O2 CONSUMED DAILY 
          ! CARBON DIOXIDE
          DO2CONS(J,ISA)=DO2CONS(J,ISA)+O2CONS
          ! AO2C(J,ISA) RECALCULATES O2 CONCENTRATION IN LAYER (G/M3)
          AO2C(J,ISA)=MAX(0.,AO2C(J,ISA)-O2CONS/DZ10)
          ! CO2GEN IS CO2 GENERATED (kg/ha)
          !(MOL E/M2*1/4*MOL C/MOL E*12 G C/MOL C*10.)
          ! FACTOR 10. ABOVE IS TO CONVERT G/M2 TO kg/ha
          CO2GEN=EA*30.
          !	  DCO2GEN(J,ISA) ACCUMULATES CO2 GENERATED DAILY 
          DCO2GEN(J,ISA)=DCO2GEN(J,ISA)+CO2GEN
          ! ACO2C(J,ISA) RECALCULATES CO2 CONCENTRATION IN LAYER (G/M3)
          ACO2C(J,ISA)=MAX(0.,ACO2C(J,ISA)+CO2GEN/DZ10)
          AD2=AD2+WNO3(J,ISA)+WNO2(J,ISA)+WN2O(J,ISA)
          AD3=AD3+WN2G
      END DO
      DF=AD2+AD3-AD1
      IF(ABS(DF/AD1)>1.E-5)WRITE(KW(1),1)IY,MO,KDA,AD1,AD2,AD3,DF
    1 FORMAT(1X,'NDNITCI',3I4,4E16.6)
      RETURN
      END