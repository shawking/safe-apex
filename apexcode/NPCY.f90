      SUBROUTINE NPCY
!     APEX1501
!     THIS SUBPROGRAM IS THE MASTER NUTRIENT CYCLING SUBROUTINE.
!     CALLS NPMIN, NYNIT, NLCH, NCNMI, AND NDNIT FOR EACH SOIL
!     LAYER.
      USE PARM 
      STDX=0.
      DO K=1,LC
          STDX=STDX+STD(K,ISA)
      END DO          
      SGMN=0.
      SDN=0.
      SN2=0.
      SMP=0.
      TSFN(IDO)=0.
      TSFK(IDO)=0.
      QRFN(IDO)=0.
      SVOL=0.
      SNIT=0.
      TRSP=0.
      TSFS=0.
      XX=0.
      DO J=1,NBSL(ISA)
          ISL=LID(J,ISA)
          RSPC(ISL,ISA)=0.
          RNMN(ISL,ISA)=0.
          WDN=0.
          X1=SWST(ISL,ISA)-S15(ISL,ISA)
          IF(X1<0.)THEN
              SUT(ISL,ISA)=.1*(SWST(ISL,ISA)/S15(ISL,ISA))**2
          ELSE
              SUT(ISL,ISA)=.1+.9*SQRT(X1/(FC(ISL,ISA)-S15(ISL,ISA)))
          END IF    
          CALL NPMIN
          CALL NKMIN
          IF(ISL/=LID(1,ISA))THEN
              L1=LID(J-1,ISA) 
              CALL NLCH(L1)
          ELSE
              ZZ=MIN(.9,PRMT(76)*(1.+.1*RFV(IRF(ISA))))
              IF(STDX+STDO(ISA)>.001)CALL NSTDFAL(ZZ)
              CALL NYNIT
          END IF    
          IF(ISL/=IDR(ISA))THEN
              QRFN(IDO)=QRFN(IDO)+QSFN
              SMM(84,MO,ISA)=SMM(84,MO,ISA)+QSFN
              QRFP(IDO)=QRFP(IDO)+QSFP
              SMM(142,MO,ISA)=SMM(142,MO,ISA)+QSFP
          ELSE
              SMM(47,MO,ISA)=SMM(47,MO,ISA)+QSFN
              QDRN(IDO)=QSFN
              VAR(47,ISA)=QSFN
              SMM(143,MO,ISA)=SMM(143,MO,ISA)+QSFP
              QDRP(IDO)=QSFP
              VAR(143,ISA)=QSFP
          END IF
          TSFN(IDO)=TSFN(IDO)+SSFN
          TSFK(IDO)=TSFK(IDO)+SSFK
          TSFS=TSFS+SSST
          Z5=500.*(Z(ISL,ISA)+XX)
          IF(WNH3(ISL,ISA)>.01)CALL NITVOL(Z5)
          IF(STMP(ISL,ISA)>0.)THEN
              CDG(ISL,ISA)=STMP(ISL,ISA)/(STMP(ISL,ISA)+EXP(SCRP(14,1)-SCRP(14,2)*&
              STMP(ISL,ISA)))
              X1=MIN(20.,EXP(PRMT(52)*(BD(ISL,ISA)-BDP(ISL,ISA))))
              OX=1.-PRMT(53)*Z5/(Z5+EXP(SCRP(20,1)-SCRP(20,2)*Z5))
              IF(IDNT>2.AND.CGO2(LID(1,ISA),ISA)>0..AND.IOX==2)OX=CGO2(ISL,ISA)&
              /CGO2(LID(1,ISA),ISA)
              CS=MIN(10.,SQRT(CDG(ISL,ISA)*SUT(ISL,ISA))*PRMT(70)*X1*OX)
	          CALL NRSPC(CS)
              CALL NPMN(CS)
              SMP=SMP+WMP
              IF(IDNT<3)THEN
	              DZA=1000.*(Z(ISL,ISA)-XX)
	              IF(IDNT==2)THEN
	                  CALL NDNITAK(DZA)
	              ELSE
	                  WDN=0.
	                  DN2=0.
	                  DN2O=0.
	                  CALL NDNIT
	                  SN2=SN2+DN2
	              END IF  
	              SDN=SDN+WDN
	              SN2O=SN2O+DN2O
	          END IF
          END IF
          XX=Z(ISL,ISA)
      END DO
      GWSN(ISA)=GWSN(ISA)+VNO3(LNS,ISA)
      SMM(80,MO,ISA)=SMM(80,MO,ISA)+RSFN(IDO)
      SMM(51,MO,ISA)=SMM(51,MO,ISA)+VAP(ISA)+VPU(ISA)
      VAR(51,ISA)=VAP(ISA)+VPU(ISA)
      SMM(133,MO,ISA)=SMM(133,MO,ISA)+VSLT(ISA)
      SMM(152,MO,ISA)=SMM(152,MO,ISA)+VSK(ISA) 
      RETURN
      END