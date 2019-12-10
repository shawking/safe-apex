      SUBROUTINE CSTRS
!     APEX1501
!     THIS SUBPROGRAM CALCULATES PLANT STRESS FACTORS CAUSED BY LIMITED
!     N, P, AIR, AND WATER AND DETERMINES THE ACTIVE CONSTRAINT
!    (MINIMUM STRESS FACTOR--N, P, WATER, OR TEMPERATURE).  CALLS
!     NFIX AND NFERT(AUTOMATIC FERTILIZER OPTION).
      USE PARM
      J3=5
      IF(EP(JJK)>0..AND.SWST(LID(1,ISA),ISA)<PO(LID(1,ISA),ISA))THEN
          IF(RZSW(ISA)>0.)THEN
              WS(ISA)=100.*RZSW(ISA)/PAW(ISA)
              WS(ISA)=WS(ISA)/(WS(ISA)+EXP(SCRP(17,1)-SCRP(17,2)*WS(ISA)))
          ELSE
              WS(ISA)=0.
          END IF          
          WS(ISA)=(1.-PRMT(38))*WS(ISA)+PRMT(38)*AEP(JJK)/(EP(JJK)+1.E-10)
      END IF
      WFX=0.
      IF(IDC(JJK)==NDC(1).OR.IDC(JJK)==NDC(2).OR.IDC(JJK)==NDC(3))&
      CALL NFIX
      SUX=SUN 
      CALL NAJN(UN,WNO3,UNM,SUX,1.,0)
	  SUN=SUX
	  X1=SUN/(UNM+1.E-10)
      UNM=SUN+WFX
      UN1(JJK,ISA)=UN1(JJK,ISA)+UNM
	  SUX=SUP
      IF(UPM>SUP)CALL NAJN(UP,WPML,UPM,SUX,1.,1)
	  SUP=SUX
      X2=SUP/(UPM+1.E-10)
      UPM=SUP
      UP1(JJK,ISA)=UP1(JJK,ISA)+UPM
      IF(UKM>SUK)CALL NAJN(UK,SOLK,UKM,SUK,1.,1)
      X3=MIN(1.,SUK/(UKM+1.E-10))
      UKM=SUK
      UK1(JJK,ISA)=UK1(JJK,ISA)+UKM
      CALL NUTS(UN1(JJK,ISA),UN2,SN)
      SN=MAX(X1,SN)
      CALL NUTS(UP1(JJK,ISA),UP2,SP)
      SP=MAX(X2,SP)
      CALL NUTS(UK1(JJK,ISA),UK2,SK)
      !SK=MAX(X3,SK)
      SK=1.
      X1=.15625*ZSLT(ISA)/SW(ISA)
      XX=X1-STX(2,JJK)
      IF(XX>0.)THEN
          SSLT=MAX(0.,1.-STX(1,JJK)*XX)
	  ELSE 
          SSLT=1.
      END IF
      VARC(16,JJK,ISA)=SSLT                                  
      DO
          CALL CFRG(6,J3,SAT,REG(JJK,ISA),0.,JRT)
          IF(JRT>0)EXIT
          CALL CFRG(1,J3,WS(ISA),REG(JJK,ISA),0.,JRT)
          IF(JRT>0)EXIT
          CALL CFRG(3,J3,SP,REG(JJK,ISA),0.,JRT)
          IF(JRT>0)EXIT
          CALL CFRG(4,J3,SK,REG(JJK,ISA),0.,JRT)
          IF(JRT>0)EXIT
          CALL CFRG(7,J3,SSLT,REG(JJK,ISA),0.,JRT)
          IF(JRT>0)EXIT
          ZZ=REG(JJK,ISA)
          CALL CFRG(2,J3,SN,ZZ,REG(JJK,ISA),JRT)
          IF(JRT==0)EXIT
          REG(JJK,ISA)=ZZ
          IF(IDC(JJK)==NDC(1).OR.IDC(JJK)==NDC(2).OR.IDC(JJK)==NDC(3))&
          EXIT
          IF(BFT(ISA)<=SN.OR.NDFA(ISA)<IFA(ISA))EXIT
          APMU=FNP(4,ISA)
	      CALL NFERT(APMU,4,IAUF(ISA),KT2,JRT)
	      EXIT
	  END DO    
      XX=1.-REG(JJK,ISA)
      SFMO(J3,JJK,ISA)=SFMO(J3,JJK,ISA)+XX
      SFCP(J3,JJK,ISA)=SFCP(J3,JJK,ISA)+XX
      J1=J3+9
      SMMC(J1,JJK,MO,ISA)=SMMC(J1,JJK,MO,ISA)+XX
	  SMMC(17,JJK,MO,ISA)=SMMC(17,JJK,MO,ISA)+XX
	  VARC(17,JJK,ISA)=REG(JJK,ISA)
      RETURN
      END