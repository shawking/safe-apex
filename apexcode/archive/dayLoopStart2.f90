!     SUBROUTINE HUSE
!     APEX1501
!     THIS SUBPROGRAM IS THE MASTER WATER AND NUTRIENT USE SUBROUTINE.
!     CALLS HSWU AND NUPPO FOR EACH SOIL LAYER.
!     USE PARM
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
!               SUBROUTINE HSWU(CPWU,RGS)
!     			APEX1501
!     			THIS SUBPROGRAM DISTRIBUTES PLANT EVAPORATION THROUGH THE ROOT
!     			ZONE AND CALCULATES ACTUAL PLANT WATER USE BASED ON SOIL WATER
!     			AVAILABILITY.
!      			USE PARM
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
!				RETURN
!      			END
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
!     RETURN
!     END