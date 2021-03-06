      SUBROUTINE NBL(BTN,RN,YN,YNWN,QN,SSFN,PRKN,DN,TFO,YLN,VOL,FNMN,FNMA,&
      FX,FTN,SSIN,DRN,BURN,QRFN,SCOU,DEP,PSON,ISA,KBL,KFL,KW,NBSA,MSO,JRT)
!     APEX1501
!     THIS SUBPROGRAM COMPUTES THE N & P BALANCES AT THE END OF THE
!     SIMULATION.
      DIMENSION NBSA(ISA),KFL(MSO+1),KW(MSO)
	  JRT=0
	  DF=BTN+RN-YN-YNWN-QN-SSFN-PRKN-DN-YLN-VOL+FNMN+FNMA-FTN+FX+TFO+SSIN-&
      DRN-BURN-QRFN-SCOU+DEP+PSON
      PER=200.*DF/(FTN+BTN)
	  IF(ABS(PER)>1..OR.KFL(1)>0)THEN
	      SELECT CASE(KBL)
              CASE(1)
                  WRITE(KW(1),4)ISA,NBSA(ISA)
                  WRITE(KW(1),1)PER,DF,BTN,RN,YN,YNWN,QN,SSFN,PRKN,QRFN,DRN,&
                  SSIN,DN,VOL,BURN,YLN,FX,FNMN,FNMA,TFO,SCOU,DEP,PSON,FTN
              CASE(2)
                  WRITE(KW(1),5)ISA,NBSA(ISA)  
                  WRITE(KW(1),6)PER,DF,BTN,YN,YNWN,QN,PRKN,YLN,FNMN,TFO,SCOU,&
                  DEP,PSON,FTN
              CASE(3)    
                  WRITE(KW(1),2)ISA,NBSA(ISA)  
                  WRITE(KW(1),3)PER,DF,BTN,YN,YNWN,QN,PRKN,YLN,FNMN,FTN
    	      END SELECT
    	      JRT=1
      END IF
      RETURN
    1 FORMAT(5X,'PER =',E13.6,2X,'DF  =',E13.6,2X,'BTOT=',E13.6,2X,&
      'RFN =',E13.6,2X,'Y   =',E13.6,2X,'YW  =',E13.6/5X,'Q   =',E13.6,&
      2X,'SSF =',E13.6,2X,'PRK =',E13.6,2X,'QRF =',E13.6,2X,'DR  =',&
      E13.6,2X,'SSFI=',E13.6/5X,'DN  =',E13.6,2X,'VOL =',E13.6,2X,'BURN=',&
      E13.6,2X,'YLD =',E13.6,2X,'FIX =',E13.6,2X,'FNMN=',E13.6/5X,'FNMA=',&
      E13.6,2X,'FNO =',E13.6,2X,'SNOU=',E13.6,2X,'DEP =',E13.6,2X,'PSON=',&
      E13.6,2X,'ETOT=',E13.6)
    2 FORMAT(/T10,'K BALANCE',2X,'SA#= ',I8,1X,'ID= ',I8)
    3 FORMAT(5X,'PER =',E13.6,2X,'DF  =',E13.6,2X,'BTOT=',E13.6,2X,&
      'Y   =',E13.6,2X,'YW  =',E13.6,2X,'Q   =',E13.6/5X,'PRK =',E13.6,2X,&
      'YLD =',E13.6,2X,'FSK =',E13.6,2X,'ETOT=',E13.6)
    4 FORMAT(/T10,'N BALANCE',2X,'SA#= ',I8,1X,'ID= ',I8)
    5 FORMAT(/T10,'P BALANCE',2X,'SA#= ',I8,1X,'ID= ',I8)
    6 FORMAT(5X,'PER =',E13.6,2X,'DF  =',E13.6,2X,'BTOT=',E13.6,2X,&
      'Y   =',E13.6,2X,'YW  =',E13.6,2X,'Q   =',E13.6/5X,'PRK =',E13.6,2X,&
      'YLD =',E13.6,2X,'FPML=',E13.6,2X,'FPO =',E13.6,2X,'SPOU=',E13.6,2X,&
      'DEP =',E13.6/5X,'PSOP=',E13.6,2X,'ETOT=',E13.6)
      END