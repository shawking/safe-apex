      SUBROUTINE NYNIT
!     APEX1501
!     THIS SUBPROGRAM ESTIMATES DAILY SOL N LEACHING BY PERCOLATION AND
!     LATERAL SUBSURFACE FLOW AND SOL N LOSS IN RUNOFF FOR THE SURFACE
!     LAYER
      USE PARM
      LD1=LID(1,ISA)
      WNO3(LD1,ISA)=WNO3(LD1,ISA)+VNO3(LD1,ISA)
      WSLT(LD1,ISA)=WSLT(LD1,ISA)+VSLT(ISA)
      VH=QSF(LD1,ISA)+CPFH(LD1,ISA)
      V=PKRZ(LD1)+QVOL(IDO)+SSF(LD1,ISA)+VH
      QN(IDO)=0.
      VNO3(LD1,ISA)=0.
      SSFN=0.
      SSFK=0.
      QSFN=0.
      VSLT(ISA)=0.
      SSST=0.
      VSK(ISA)=0.
      IF(V>0.)THEN
          X2=V/(PRMT(4)*PO(LD1,ISA))
          IF(X2>10.)THEN
		      X3=.99
	      ELSE
		      X3=1.-EXP(-X2)
	      END IF
	      X4=PKRZ(LD1)+PRMT(14)*(QVOL(IDO)+SSF(LD1,ISA)+VH)
          IF(WNO3(LD1,ISA)>0.)THEN
              VQN=WNO3(LD1,ISA)*X3
              VQNU=WNMU(LD1,ISA)*X3
              CO=(VQN+VQNU)/X4
			  CS=PRMT(14)*CO
			  QN(IDO)=QN(IDO)+QVOL(IDO)*CS*(1.-URBF(ISA))+URBF(ISA)*QURB&
			  (IDO)*.005
			  VNO3(LD1,ISA)=PKRZ(LD1)*CO
			  SSFN=CS*SSF(LD1,ISA)
			  QSFN=CS*VH
			  WNO3(LD1,ISA)=WNO3(LD1,ISA)-VQN
			  WNMU(LD1,ISA)=MAX(0.,WNMU(LD1,ISA)-VQNU)
          END IF
		  IF(SOLK(LD1,ISA)>0.)THEN
              X1=SOLK(LD1,ISA)*X3
              SOLK(LD1,ISA)=SOLK(LD1,ISA)-X1
              COK=X1/X4
              CSK=PRMT(14)*COK
              VSK(ISA)=COK*PKRZ(LD1)
              SSFK=CSK*SSF(LD1,ISA)
              QSK=CSK*QVOL(IDO)
              SMM(150,MO,ISA)=SMM(150,MO,ISA)+QSK
              VAR(150,ISA)=QSK
          END IF
          IF(WSLT(LD1,ISA)>0.)THEN
			  X5=(WSLT(LD1,ISA)+1.E-5)*X3
			  COSL=X5/X4
			  CSSL=PRMT(14)*COSL
			  SSST=CSSL*SSF(LD1,ISA)
			  VSLT(ISA)=COSL*PKRZ(LD1)
			  QSLT=CSSL*QVOL(IDO)
			  SMM(130,MO,ISA)=SMM(130,MO,ISA)+QSLT
			  VAR(130,ISA)=QSLT
			  WSLT(LD1,ISA)=WSLT(LD1,ISA)-X5
		  END IF
      END IF		  
      RETURN
      END