      SUBROUTINE HPURK
!     APEX1501
!     THIS SUBPROGRAM IS THE MASTER PERCOLATION COMPONENT.  IT MANAGES
!     THE ROUTING PROCESS
      USE PARM
      ADD=0.
      SUM=0.
      TOT=0.
      XX=0.
      CPVV=0.
      QDR(IDO)=0.
      VAR(98,ISA)=FPF(ISA)
      AD1=SWLT(ISA)
      DO K=1,NBSL(ISA)
          ISL=LID(K,ISA)
          AD1=AD1+SWST(ISL,ISA)
      END DO
      SEP=(10.*SALA(ISA)*(RFV(IRF(ISA))-QVOL(IDO)+FPF(ISA))+RSPK(ISA))/(10.*WSA(ISA))
      SP1=SEP
      LD1=LID(1,ISA)
	  STLT(ISA)=PRMT(51)*RSD(LD1,ISA)
      SWLT(ISA)=SWLT(ISA)+SEP
      IF(SWLT(ISA)>STLT(ISA))THEN
          SEP=SWLT(ISA)-STLT(ISA)
          SWLT(ISA)=STLT(ISA)
      ELSE
          SEP=0.
      END IF
      DO KK=1,NBSL(ISA)
          ISL=LID(KK,ISA)
          DZ=Z(ISL,ISA)-XX
          XX=Z(ISL,ISA)
          SWST(ISL,ISA)=SWST(ISL,ISA)+SEP
          IF(WTBL(ISA)<=Z(ISL,ISA))THEN
              SSF(ISL,ISA)=0.
              PKRZ(ISL)=0.
              CPFH(ISL,ISA)=0.
              SEP=0.
          ELSE    
              CPVV=SEP*CPRV(ISL,ISA)
              X1=SEP-CPVV
              CPVH(IDO)=X1*CPRH(ISL,ISA)
              SWST(ISL,ISA)=MAX(1.E-5,SWST(ISL,ISA)-CPVV-CPVH(IDO))
	          !IF(RSAE(ISA)>0.)THEN
	              !SATX=MAX(1.E-10,RSHC(ISA))
	          !ELSE
	              SATX=SATC(ISL,ISA)
              !END IF
              IF(IPRK==0)THEN
                  CALL HPERC(DZ,SATX)
              ELSE    
                  CALL HPERC1(DZ,SATX)
              END IF    
              SWST(ISL,ISA)=MAX(1.E-5,SWST(ISL,ISA)-SEP-SST(IDO)-QRF(IDO))
              IF(ISL/=IDR(ISA))THEN
                  SUM=SUM+QRF(IDO)
              ELSE
                  SMM(17,MO,ISA)=SMM(17,MO,ISA)+QRF(IDO)
                  VAR(17,ISA)=QRF(IDO)
                  QDR(IDO)=QRF(IDO)
              END IF
              ADD=ADD+SST(IDO)
              TOT=TOT+CPVH(IDO)
              SSF(ISL,ISA)=SST(IDO)
              QSF(ISL,ISA)=QRF(IDO)
              CPFH(ISL,ISA)=CPVH(IDO)
              SEP=SEP+CPVV
              PKRZ(ISL)=SEP
          END IF    
      END DO
      SST(IDO)=ADD
      QRF(IDO)=SUM
      CPVH(IDO)=TOT
      L1=LD1
      DO K=NBSL(ISA),2,-1
          ISL=LID(K,ISA)
          L1=LID(K-1,ISA)
          XX=SWST(ISL,ISA)-PO(ISL,ISA)
          IF(XX>0.)THEN
              SWST(L1,ISA)=SWST(L1,ISA)+XX
              PKRZ(L1)=MAX(0.,PKRZ(L1)-XX)
              SWST(ISL,ISA)=PO(ISL,ISA)
          END IF
          XX=SWST(ISL,ISA)-FC(ISL,ISA)
          IF(XX<=0.)CYCLE
          WP1=LOG10(S15(L1,ISA))
          FC1=LOG10(FC(L1,ISA))
	      IF(SWST(L1,ISA)>.01)THEN
	          T1=10.**(3.1761-1.6576*((LOG10(SWST(L1,ISA))-WP1)/(FC1-WP1)))
          ELSE
	          T1=1500.
          END IF
          ZH=10.*(Z(ISL,ISA)-Z(L1,ISA))
	      WP2=LOG10(S15(ISL,ISA))
          FC2=LOG10(FC(ISL,ISA))
          T2=10.**(3.1761-1.6576*(LOG10(SWST(ISL,ISA))-WP2)/(FC2-WP2))
          T2=T2+ZH
          IF(T1<T2)CYCLE
          X1=XX*MIN(PRMT(61),(T1-T2)/T1,PKRZ(L1))
          SWST(L1,ISA)=SWST(L1,ISA)+X1
          PKRZ(L1)=PKRZ(L1)-X1
          SWST(ISL,ISA)=MAX(1.E-5,SWST(ISL,ISA)-X1)
      END DO
      IF(PKRZ(L1)<0.)PKRZ(L1)=0.
      FPF(ISA)=0.
      AD2=SWLT(ISA)
      DO K=1,NBSL(ISA)
          ISL=LID(K,ISA)
          AD2=AD2+SWST(ISL,ISA)
      END DO
      DF=AD1+SP1-SST(IDO)-QRF(IDO)-PKRZ(LID(NBSL(ISA),ISA))-AD2
      IF(ABS(DF)>.001)WRITE(KW(1),1)IY,MO,KDA,AD1,AD2,SP1,SST(IDO),QRF(IDO),&
      PKRZ(LID(NBSL(ISA),ISA)),DF
    1 FORMAT(5X,'PURK',3I4,10E13.5)  
      RETURN
      END

