      SUBROUTINE NCQYL
!     APEX1501
!     THIS SUBPROGRAM PREDICTS DAILY C LOSS, GIVEN SOIL LOSS AND
!     ENRICHMENT RATIO.
      USE PARM
      LD1=LID(1,ISA)
      Y1=WBMC(LD1,ISA)
      YY=YSD(NDRV,ISA)
      Y4=PKRZ(LD1)
      V=0.
      VBC=0.
      QC(IDO)=0.
      TOT=WHPC(LD1,ISA)+WHSC(LD1,ISA)+WLMC(LD1,ISA)+WLSC(LD1,ISA)
      X1=MAX(1.E-5,1.-YEW-YEWN)
      YC(IDO)=YEW*TOT
      YCWN(IDO)=YEWN*TOT
      WHSC(LD1,ISA)=WHSC(LD1,ISA)*X1
      WHPC(LD1,ISA)=WHPC(LD1,ISA)*X1
      WLS(LD1,ISA)=WLS(LD1,ISA)*X1
      WLM(LD1,ISA)=WLM(LD1,ISA)*X1
      WLSL(LD1,ISA)=WLSL(LD1,ISA)*X1
      WLSC(LD1,ISA)=WLSC(LD1,ISA)*X1
      WLMC(LD1,ISA)=WLMC(LD1,ISA)*X1
      WLSLC(LD1,ISA)=WLSLC(LD1,ISA)*X1
      WLSLNC(LD1,ISA)=WLSC(LD1,ISA)-WLSLC(LD1,ISA)
      IF(Y1>.01)THEN
          V=QVOL(IDO)+Y4
          X1=MAX(5.*V,WT(LD1,ISA)*PRMT(21))
          IF(QVOL(IDO)>0.)QC(IDO)=Y1*QVOL(IDO)/X1
          VBC=MIN(.5*Y1,Y1*PKRZ(LD1)/X1)
          WBMC(LD1,ISA)=Y1-VBC-QC(IDO)
          WCMU(LD1,ISA)=MAX(0.,WCMU(LD1,ISA)-VBC-QC(IDO))
      END IF
      DO L=2,NBSL(ISA)
          ISL=LID(L,ISA)
          Y1=WBMC(ISL,ISA)+VBC
          WCMU(ISL,ISA)=WCMU(ISL,ISA)+VBC
          VBC=0.
          IF(Y1>.01)THEN
              V=PKRZ(ISL)
          ELSE
              IF(V>0.)THEN
                  XX=MIN(.75,PKRZ(ISL)/WT(ISL,ISA))
                  VBC=XX*Y1
              END IF
          END IF
          WBMC(ISL,ISA)=Y1-VBC
          WCMU(ISL,ISA)=WCMU(ISL,ISA)-VBC
      END DO
      SMM(75,MO,ISA)=SMM(75,MO,ISA)+VBC
      VAR(75,ISA)=VBC
      SMM(76,MO,ISA)=SMM(76,MO,ISA)+QC(IDO)
      VAR(76,ISA)=QC(IDO)
      X4=MIN(WCOU(LD1,ISA),YMNU(IDO)*WCOU(LD1,ISA)/(RSDM(LD1,ISA)+1.E-10))
      WCOU(LD1,ISA)=WCOU(LD1,ISA)-X4
      WHSC(LD1,ISA)=WHSC(LD1,ISA)-X4
      !ZZ=WLMC(LD1,ISA)+WLSC(LD1,ISA)
      !RTO=WLMC(LD1,ISA)/ZZ
      !WLMC(LD1,ISA)=WLMC(LD1,ISA)-RTO*X4
      !X1=MIN(.8,WLSLC(LD1,ISA)/WLSC(LD1,ISA))
      !WLSC(LD1,ISA)=MAX(.001,WLSC(LD1,ISA)-X4*(1.-RTO))
      !WLSLC(LD1,ISA)=WLSC(LD1,ISA)*X1
      !WLSLNC(LD1,ISA)=WLSC(LD1,ISA)-WLSLC(LD1,ISA)
      YCOU(IDO)=X4
      YC(IDO)=YC(IDO)+X4
      SMM(77,MO,ISA)=SMM(77,MO,ISA)+YC(IDO)
      VAR(77,ISA)=YC(IDO)
      SMM(136,MO,ISA)=SMM(136,MO,ISA)+YCWN(IDO)
      VAR(136,ISA)=YCWN(IDO)
      RETURN
      END