      SUBROUTINE NCONT(I)
!     APEX1501
!     THIS SUBPROGRAM IS USED TO CHECK N & P BALANCES FOR TROUBLE-
!     SHOOTING PURPOSES.
      USE PARM
      CHARACTER(1)::ABL
      DATA ABL/'N'/
      DATA YLNX/0./
      ZEK(I)=0.
      ZFK(I)=0.
      ZSK(I)=0.
      ZNMN(I)=0.
      ZNMA(I)=0.
      ZLSN(I)=0.
      ZLMN(I)=0.
      ZBMN(I)=0.
      ZHSN(I)=0.
      ZHPN(I)=0.
      ZNMU(I)=0.
      ZNOU(I)=0.
      ZLSC(I)=0.
      ZLMC(I)=0.
      ZBMC(I)=0.
      ZHSC(I)=0.
      ZHPC(I)=0.
      ZPML(I)=0.
      ZPO(I)=0.
      ZPMA(I)=0.
      ZPMU(I)=0.
      ZPOU(I)=0.
!     TRSD(I)=0.
      ZFOP(I)=0.
      ZNOS(I)=0.
      ZNOA(I)=0.
      ZPMS(I)=0.
      SW(I)=0.
      SUM=0.
      DO J=1,NBSL(I)
          ISL=LID(J,I)
          ZNMN(I)=ZNMN(I)+WNO3(ISL,I)
          ZNMA(I)=ZNMA(I)+WNH3(ISL,I)
          ZLSN(I)=ZLSN(I)+WLSN(ISL,I)
          ZLMN(I)=ZLMN(I)+WLMN(ISL,I)
          ZBMN(I)=ZBMN(I)+WBMN(ISL,I)
          ZHSN(I)=ZHSN(I)+WHSN(ISL,I)
          ZHPN(I)=ZHPN(I)+WHPN(ISL,I)
          ZNMU(I)=ZNMU(I)+WNMU(ISL,I)
          ZNOU(I)=ZNOU(I)+WNOU(ISL,I)
          ZLSC(I)=ZLSC(I)+WLSC(ISL,I)
          ZLMC(I)=ZLMC(I)+WLMC(ISL,I)
          ZBMC(I)=ZBMC(I)+WBMC(ISL,I)
          ZHSC(I)=ZHSC(I)+WHSC(ISL,I)
          ZHPC(I)=ZHPC(I)+WHPC(ISL,I)
          ZPML(I)=ZPML(I)+WPML(ISL,I)
          ZPMS(I)=ZPMS(I)+WPMS(ISL,I)
          ZPMA(I)=ZPMA(I)+WPMA(ISL,I)
          ZPMU(I)=ZPMU(I)+WPMU(ISL,I)
          ZPOU(I)=ZPOU(I)+WPOU(ISL,I)
          ZPO(I)=ZPO(I)+WPO(ISL,I)
          ZFOP(I)=ZFOP(I)+FOP(ISL,I)
          ZEK(I)=ZEK(I)+EXCK(ISL,I)
          ZFK(I)=ZFK(I)+FIXK(ISL,I)
          ZSK(I)=ZSK(I)+SOLK(ISL,I)
          ! TRSD(I)=TRSD(I)+RSD(ISL,I)
          SW(I)=SW(I)+SWST(ISL,I)
          SUM=SUM+RSPC(ISL,ISA)
      END DO
      IF(ABL=='C')THEN
          ZOC(I)=ZLSC(I)+ZLMC(I)+ZBMC(I)+ZHSC(I)+ZHPC(I)
          BAL=BTCZ(I)-YC(IDO)-QC(IDO)-VAR(75,ISA)+VAR(99,ISA)-SUM+VAR(73,&
          ISA)-VAR(101,ISA)+DEPC(I)-ZOC(I)
          SBAL=SBAL+BAL
          IF(ABS(BAL)>.001)THEN
              WRITE(KW(1),125)I,NBSA(I),IYR,MO,KDA,BTCZ(I),ZLSC(I),ZLMC&
              (I),ZBMC(I),ZHSC(I),ZHPC(I),ZOC(I)
              WRITE(KW(1),125)I,NBSA(I),IYR,MO,KDA,QC(IDO),YC(IDO),VAR&
              (75,ISA),VAR(99,ISA),SUM,VAR(73,ISA),VAR(101,ISA),DEPC(I),&
              BAL,SBAL
              BTCZ(I)=ZOC(I)
          END IF
      END IF
      IF(ABL=='W')THEN
          SUM=SWLT(I)+SNO(I)+XRFI(ISA)+SW(I)
          WRITE(KW(1),4)IYR,MO,KDA,SWLT(I),SNO(I),XRFI(ISA),SW(I),SUM
          4 FORMAT(3I4,5F10.4)
      END IF      
      IF(ABL=='P')THEN
          X3=TYP(I)-YLPX 
          ADD=0.
          TOT=0.
          DO J=1,12
              TOT=TOT+STDP(J,I)
              ADD=ADD+UP1(J,I)
          END DO
          SUM=ZPML(I)+ZPMS(I)+ZPMA(I)+ZPO(I)+ZFOP(I)+ZPOU(I)+ZPMU(I)+TOT+&
          STDOP(I)+ADD
          BAL=BTPZ(I)-YP(I)-YPOU(I)-YPWN(I)-QP(I)-VAP(I)-X3+V56+V57-SUM+&
          VAR(92,ISA)-VAR(90,ISA)
          SBAL=SBAL+BAL
          IF(ABS(BAL)>.01)THEN
              WRITE(KW(1),125)I,NBSA(I),IY,MO,KDA,BTPZ(I),ZPML(I),ZPMS(I),&
              ZPMA(I),ZPO(I),ZFOP(I),ZPMU(I),ZPOU(I),TOT,STDOP(I),ADD,SUM
              WRITE(KW(1),125)I,NBSA(I),IY,MO,KDA,YP(I),YPOU(I),YPWN(I),&
              QP(I),VAP(I),V56,V57,X3,VAR(90,ISA),VAR(92,ISA),BAL,SBAL
          END IF
          V56=0.
          V57=0.
          BTPZ(I)=SUM
          YLPX=TYP(I)
      END IF
      IF(ABL=='N')THEN
          X4=TYN(I)-YLNX 
          ADD=0.
          TOT=0.
          DO J=1,12
              TOT=TOT+STDN(J,I)
              ADD=ADD+UN1(J,I)
          END DO
          ZON(I)=ZLSN(I)+ZLMN(I)+ZBMN(I)+ZHSN(I)+ZHPN(I)
          SUM=ZNMN(I)+ZNMA(I)+ZON(I)+TOT+STDON(I)+ADD+ZNMU(I)+ZNOU(I)
          X1=VAR(54,ISA)
          X2=VAR(55,ISA)
          X3=VAR(53,ISA)
          X5=VAR(40,ISA)
          BAL=BTNZ(I)-YN(IDO)-YNWN(IDO)-QN(IDO)-TSFN(IDO)-YNOU(IDO)-&
          QRFN(IDO)-X5-X4+X1+X2+X3-SVOL-SDN-SUM+VAR(43,ISA)+RFQN-&
          QDRN(IDO)-VAR(89,ISA)
          SBAL=SBAL+BAL
          IF(ABS(BAL)>.01)THEN
              WRITE(KW(1),125)I,NBSA(I),IY,MO,KDA,BTNZ(I),ZNMN(I),ZNMA(I),&
              ZON(I),TOT,STDON(I),ADD,ZNMU(I),ZNOU(I),SUM
              WRITE(KW(1),1)I,NBSA(I),IY,MO,KDA,RFQN,YN(IDO),YNOU(IDO),YNWN&
              (IDO),QN(IDO),TSFN(IDO),X5,QRFN(IDO),SVOL,VAR(43,ISA),&
              SDN,QDRN(IDO),X1,X2,X3,X4,VAR(89,ISA),BAL,SBAL
          END IF
          BTNZ(I)=SUM
          YLNX=TYN(I)
      END IF
      RETURN
    1 FORMAT(6X,2I8,1X,3I4,' RF',E12.5,' Y',E12.5,' YNOU',E12.5,' YW',E12.5,&
      ' Q',E12.5,' SSF',E12.5,' PRK',E12.5,' QRF',E12.5,' VOL',E12.5,' FX',&
      E12.5,' DN',E12.5,' DR',E12.5,' FNO3',E12.5,' FNH3',E12.5,' FON',E12.5,&
      ' YLN',E12.5,' SCN',E12.5,' BAL',E12.5,' SBAL',F10.3)  
  125 FORMAT(1X,'^^^^^',2I8,1X,3I4,2X,20F10.2)
      END