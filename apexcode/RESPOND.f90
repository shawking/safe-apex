      SUBROUTINE RESPOND
!     APEX1501
!     THIS SUBPROGRAM ROUTES WATER AND SEDIMENT THROUGH RESEVOIRS.
!     COMPUTES EVAPORATION AND SEEPAGE FROM THE RESERVOIR.
      USE PARM
      IDO=IDOT(ICMD)
      IDN1=IDN1T(ICMD)
      IDN2=IDN2T(ICMD)
      IDX=IDOA(IDN2)
	  IDNB(IDO)=NBSA(IDN2)
	  YB=RSYS(IDN2)
	  RWSA(IDO)=RWSA(IDN1)
	  IF(IEXT(IDN2)>0)THEN
	      A1=WSA(IDN2)
	  ELSE
	      A1=RWSA(IDN1)
	  END IF
      A10=10.*A1
      AP=WSA(IDN2)*PCOF(IDN2)
	  AP10=10.*AP
      V0=RSV(IDN2)
      XX=V0/AP10
      STV(13,MO,IDN2)=XX
      VARS(13)=XX
      TC(IDO)=TC(IDN1)
      SST(IDO)=SST(IDN1)
      RSSF(IDO)=RSSF(IDN1)
	  XX=MAX(.1,V0+RVP0(IDN2)-RSVP(IDN2))
      X2=BR1(IDN2)*XX**BR2(IDN2)
   	  RSSA(IDN2)=MIN(X2,RSAE(IDN2))
      STV(15,MO,IDN2)=RSSA(IDN2)
      VARS(15)=RSSA(IDN2)
      EV=6.*EO*RSSA(IDN2)
      SP=RSHC(IDN2)*RSSA(IDN2)*240.
      RFRA=RFV(IRF(IDN2))*RSSA(IDN2)*10.
	  SALA(IDN2)=MAX(0.,AP-RSSA(IDN2))
      Q1=10.*SALA(IDN2)*QVOL(IDX)+RFRA
      Y1=MAX(0.,SALA(IDN2)*YSD(NDRV,IDX))
      XX=SP+EV
      X1=Q1/AP10
      SMM(64,MO,IDN2)=SMM(64,MO,IDN2)+Q1
      VAR(64,IDN2)=Q1
      V0=V0+Q1
      IF(V0<=XX)THEN
          X1=V0/(XX+1.E-10)
          EV=EV*X1
          SP=SP*X1
          RSV(IDN2)=0.
          QVOL(IDO)=0.
          YSD(NDRV,IDO)=0.
          YN(IDO)=0.
          YP(IDO)=0.
          QN(IDO)=0.
          QP(IDO)=0.
          TSFN(IDO)=0.
          RSFN(IDO)=0.
	      RSYS(IDN2)=0.
	      DEP=YB
	      Y2=0.
          GO TO 7
      END IF
      V0=V0-XX
      VRR=V0-RSVE(IDN2)
      OFLO=0.
      IF(VRR>0.)OFLO=VRR
      VVR=V0-RSVP(IDN2)
      IF(VVR>0.)THEN
          OFLO=OFLO+MIN(RSRR(IDN2),RSVE(IDN2)-RSVP(IDN2),VVR)
          V0=V0-OFLO
      END IF
      VV=V0+OFLO
      SMM(65,MO,IDN2)=SMM(65,MO,IDN2)+OFLO
      VAR(65,IDN2)=OFLO
      QVOL(IDO)=MAX(0.,(OFLO-10.*QVOL(IDX)*AP+A10*QVOL(IDN1))/A10)
      X1=Y1/AP
      YY=RSYS(IDN2)+Y1
      SMM(68,MO,IDN2)=SMM(68,MO,IDN2)+Y1
      VAR(68,IDN2)=Y1
      CY=YY/VV
      CD=MAX(RSYN(IDN2),(CY-RSYN(IDN2))*RSDP(IDN2)+RSYN(IDN2))
      Y2=OFLO*MIN(CD,CY)
      X1=Y2/AP
      SMM(69,MO,IDN2)=SMM(69,MO,IDN2)+Y2
      VAR(69,IDN2)=Y2
	  YSD(NDRV,IDO)=MAX(0.,(Y2-YSD(NDRV,IDX)*AP+A1*YSD(NDRV,IDN1))/A1)
	  DEP=MAX(0.,V0*(CY-CD))
      X1=DEP/A1
      SRCH(13,IDO)=SRCH(13,IDO)+X1
      SMM(70,MO,IDN2)=SMM(70,MO,IDN2)+DEP
      VAR(70,IDN2)=DEP
      X1=YY-Y2-DEP
      RSYS(IDN2)=X1
      XX=X1/AP
      STV(14,MO,IDN2)=X1
      VARS(14)=X1
      TOT=0.
      DRTO=MIN(1.,(.001+Y2)/(Y1+.001))
      B1=LOG(DRTO)/4.47
      DO I=1,NSZ
          PCTH(I,IDO)=PCT(I,IDN1)
          X1=MAX(-10.,B1*PSZY(I))
          PCT(I,IDO)=PCT(I,IDN1)*EXP(X1)
          TOT=TOT+PCT(I,IDO)
      END DO
      DO I=1,NSZ
          PCT(I,IDO)=PCT(I,IDO)/(TOT+1.E-10)
      END DO
      YX=YY+1.E-5 
	  RSON(IDN2)=RSON(IDN2)+YN(IDN1)*AP
      CON=RSON(IDN2)/YX
	  RSOP(IDN2)=RSOP(IDN2)+YP(IDN1)*AP
      COP=RSOP(IDN2)/YX
      X2=Y2+DEP
      X1=CON*X2
      RTO=X1/RSON(IDN2)
      IF(RTO>.1)THEN
          X1=.1*RSON(IDN2)
          CON=X1/X2
      END IF
      YN(IDO)=MAX(0.,(Y2*CON-YN(IDX)*AP+A1*YN(IDN1))/A1)
      RSON(IDN2)=MAX(.01,RSON(IDN2)-X1)
      X1=COP*X2
      RTO=X1/RSOP(IDN2)
      IF(RTO>.1)THEN
          X1=.1*RSOP(IDN2)
          COP=X1/X2
      END IF
      YP(IDO)=MAX(0.,(Y2*COP-YP(IDX)*AP+A1*YP(IDN1))/A1)
      RSOP(IDN2)=MAX(.01,RSOP(IDN2)-X1)
      RSO3(IDN2)=RSO3(IDN2)+AP*QN(IDX)
      CO3=RSO3(IDN2)/VV
      RSSP(IDN2)=RSSP(IDN2)+AP*QP(IDX)
      CSP=RSSP(IDN2)/VV
	  X1=OFLO*CO3
      QN(IDO)=MAX(0.,(X1-QN(IDX)*AP+A1*QN(IDN1))/A1)
      RSO3(IDN2)=MAX(.01,RSO3(IDN2)-X1)
      X1=OFLO*CSP
      QP(IDO)=MAX(0.,(X1-QP(IDX)*AP+A1*QP(IDN1))/A1)
      RSSP(IDN2)=MAX(.01,RSSP(IDN2)-X1)
      RSV(IDN2)=V0
    7 SMM(66,MO,IDN2)=SMM(66,MO,IDN2)+EV
      VAR(66,IDN2)=EV
      TREV=TREV+EV
      SAET=10.*SALA(IDN2)*AET
      TSAE=TSAE+SAET
      SMM(67,MO,IDN2)=SMM(67,MO,IDN2)+SP
      VAR(67,IDN2)=SP
      RSPK(IDN2)=.1*SP/WSA(IDN2)
      X1=DEP/RSBD(IDN2)
      RSVP(IDN2)=MAX(0.,RSVP(IDN2)-X1)
	  RSVE(IDN2)=MAX(0.,RSVE(IDN2)-X1)
      IF(KFL(13)>0)WRITE(KW(13),12)IDN2,NBSA(IDN2),IY,MO,KDA,RFV&
      (IRF(IDN2)),Q1,EV,SP,OFLO,RSV(IDN2),RSVP(IDN2),RSVE(IDN2),Y1,Y2,DEP&
      ,RSYS(IDN2),RSSA(IDN2),YSD(NDRV,IDN1),YSD(NDRV,IDN2),YSD(NDRV,IDO)
   12 FORMAT(1X,2I4,1X,I4,2I2,2X,8F10.0,20F10.2)
      RETURN
      END