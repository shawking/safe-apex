      SUBROUTINE BSUB(IXP)
!     APEX1501
!     THIS SUBPROGRAM DRIVES THE DAILY SUBAREA SIMULATION.
      USE PARM
      DIMENSION JGO(MNC)
      IDO=IDOT(ICMD)
      ISA=IDN1T(ICMD)
      IDOA(ISA)=IDO
      NISA(NBSA(ISA))=ISA
	  IDNB(IDO)=NBSA(ISA)
      IOW=IDON(ISA)
      WSAX=WSA(ISA)
      WSAX1=WSAX*10.
      RWSA(IDO)=WSAX
      LNS=LID(NBSL(ISA),ISA)
      LD1=LID(1,ISA)
      NMW(ISA)=NMW(ISA)+1
      DDMP=0.
      LRD(ISA)=MIN(LRD(ISA),NBSL(ISA))
      CALL WHLRMX(IDA)                                                                    
      IHRL(MO,ISA)=IHRL(MO,ISA)+1                                                            
      THRL(MO,ISA)=THRL(MO,ISA)+HRLT                                                         
      SRMX(MO,ISA)=SRMX(MO,ISA)+RAMX
      IF(SRAD(IRF(ISA))==0..OR.KGN(3)==0)THEN
          OBSL(IWI,MO)=RAMX*MAX(.8,.21*SQRT(OBMX(IWI,MO)-OBMN(IWI,MO)))
          CALL WGN
          I=IRF(ISA)
          CALL WSOLRA(I)
      END IF
      IF(IPTS(ISA)>0)THEN
	      I=IPSO(ISA)
	      PSQX=PSOQ(I)/WSAX1
	      PSYX=PSOY(I)/WSAX
          PONX=PSON(I)/WSAX
          PPPX=PSOP(I)/WSAX
          PS3X=PSO3(I)/WSAX
          PSPX=PSSP(I)/WSAX
          PQPX=PQPS(I)/WSAX
          PYPX=PYPS(I)/WSAX	
          SMM(104,MO,ISA)=SMM(104,MO,ISA)+PSQX
          SMM(121,MO,ISA)=SMM(121,MO,ISA)+PSYX
          SMM(105,MO,ISA)=SMM(105,MO,ISA)+PONX
          SMM(106,MO,ISA)=SMM(106,MO,ISA)+PPPX
          SMM(137,MO,ISA)=SMM(137,MO,ISA)+PS3X
          SMM(138,MO,ISA)=SMM(138,MO,ISA)+PSPX
          SMM(122,MO,ISA)=SMM(122,MO,ISA)+PQPX
          SMM(123,MO,ISA)=SMM(123,MO,ISA)+PYPX
      END IF
      PCT(1,ISA)=.01*SAN(1,ISA)
      PCT(2,ISA)=.01*SIL(1,ISA)
      PCT(3,ISA)=.01*CLA(1,ISA)
      PCT(4,ISA)=0.
      PCT(5,ISA)=0.
      DO I=1,NSZ
          PCTH(I,IDO)=PCT(I,ISA)
          PCT(I,IDO)=PCT(I,ISA)
      END DO
      VAR(4,ISA)=0.
      SMM(100,MO,ISA)=SMM(100,MO,ISA)+RFV0(IRF(ISA))
      IF(NGN/=0)RFV(IRF(ISA))=RFV0(IRF(ISA))
      IF(RFV(IRF(ISA))>0.)THEN
          RF1=RFV(IRF(ISA))
          SRD(MO,ISA)=SRD(MO,ISA)+1.
          SMM(4,MO,ISA)=SMM(4,MO,ISA)+RF1
          VAR(4,ISA)=RF1
          !SMMH(35,MO,IDO)=SMMH(35,MO,IDO)+RF1
          SDVR(ISA)=SDVR(ISA)+RF1*RF1
	      TSNO(ISA)=0.
          IF(RF1>RMXS(ISA))THEN
              RMXS(ISA)=RF1
              MXSR(ISA)=KDA+100*MO+10000*IY
          END IF
      END IF
      VNO3(LD1,ISA)=RFNC*RFV(IRF(ISA))
      RFQN=VNO3(LD1,ISA)
      TAGP(ISA)=MAX(.001,TAGP(ISA))
      XRFI(ISA)=MIN(RFV(IRF(ISA)),PRMT(49)*(1.-EXP(-PRMT(50)*SQRT(TAGP&
      (ISA)*SMLA(ISA)))))
      SMM(85,MO,ISA)=SMM(85,MO,ISA)+XRFI(ISA)
      RFV(IRF(ISA))=RFV(IRF(ISA))-XRFI(ISA)
      EI=0.
      AL5=.02083
      IF(RFV(IRF(ISA))>0.)THEN
	      CALL HRFEI
          UPLM=.95
          QMN=.25
          BLM=.05
          R1=ATRI(BLM,QMN,UPLM,8)
          RTP=R1*RFV(IRF(ISA))
          XK1=R1/4.605
          XK2=XK1*(1.-R1)/R1
          DURG=RFV(IRF(ISA))/(REP*(XK1+XK2))
          X1=REP*DURG
          XKP1=XK1*X1
          XKP2=XK2*X1
      END IF
      IF(ORSD(IRF(ISA))>0.)THEN
          RTO=ORSD(IRF(ISA))/RSD(LD1,ISA)
          WLS(LD1,ISA)=RTO*WLS(LD1,ISA)
          WLM(LD1,ISA)=RTO*WLM(LD1,ISA)
          RSD(LD1,ISA)=ORSD(IRF(ISA))
          WLMC(LD1,ISA)=RTO*WLMC(LD1,ISA)
          WLSC(LD1,ISA)=RTO*WLSC(LD1,ISA)
          WLMN(LD1,ISA)=RTO*WLMN(LD1,ISA)
          WLSN(LD1,ISA)=RTO*WLSN(LD1,ISA)
          FOP(LD1,ISA)=RTO*FOP(LD1,ISA)
      END IF            
      CV(ISA)=CV(ISA)+RSD(LD1,ISA)+STDO(ISA)
      CVRS(ISA)=CVRS(ISA)+RSD(LD1,ISA)+STDO(ISA)
      BCV(ISA)=1.
      RCF(ISA)=.9997*RCF(ISA)
      IF(CV(ISA)<10.)BCV(ISA)=CV(ISA)/(CV(ISA)+EXP(SCRP(5,1)-SCRP(5,2)*&
      CV(ISA)))
      SNOF=0.
      IF(SNO(ISA)>0.)THEN
          SNOF=SNO(ISA)/(SNO(ISA)+EXP(2.303-.2197*SNO(ISA)))
          BCV(ISA)=MAX(SNOF,BCV(ISA))
      END IF
      BCV(ISA)=MIN(BCV(ISA),.95)
      NN1=NTL(IRO(ISA),ISA)
      JT1=LT(IRO(ISA),KT(ISA),ISA)
      YW(IDO)=0.
      ERTO=1.
      ERTP=1.
	  YERO=0.
      IF(ACW>0..AND.SNO(ISA)<10.)THEN
          CALL WNDIR
          CALL EWER(JRT)
          IF(JRT==0)THEN
              YW(IDO)=YW(IDO)*ACW
              SMM(36,MO,ISA)=SMM(36,MO,ISA)+YW(IDO)
              VAR(36,ISA)=YW(IDO)
	          SYW=SYW+YW(IDO)*WSA(ISA)
	          YERO=YERO+YW(IDO)
              VAR(58,ISA)=RRF
              SMM(35,MO,ISA)=SMM(35,MO,ISA)+RGRF
              VAR(35,ISA)=RGRF
          END IF
          IF(YW(IDO)>PRMT(94))SMM(145,MO,ISA)=SMM(145,MO,ISA)+1.
          IF(WB>0.)CALL EWEMHKS(JRT)
          IF(JRT==0)THEN
              YWKS=YWKS*ACW
              SMM(139,MO,ISA)=SMM(139,MO,ISA)+YWKS
          END IF
      END IF
      QN(IDO)=0.
      SMM(7,MO,ISA)=SMM(7,MO,ISA)+U10(IRF(ISA))
      VAR(7,ISA)=U10(IRF(ISA))
      SMM(8,MO,ISA)=SMM(8,MO,ISA)+RHD(IRF(ISA))
      VAR(8,ISA)=RHD(IRF(ISA))
      TX=(TMN(IRF(ISA))+TMX(IRF(ISA)))/2.
      IF(TX>0.)HSM(ISA)=HSM(ISA)+TX
      IF(NAQ>0)CALL DUSTDST
      CALL SOLT
      LD2=LID(2,ISA)
      SMM(59,MO,ISA)=SMM(59,MO,ISA)+STMP(LD2,ISA)
      VAR(59,ISA)=STMP(LD2,ISA)
      YP(IDO)=0.
      YN(IDO)=0.
      YC(IDO)=0.
      QC(IDO)=0.
      YNWN(IDO)=0.
      YPWN(IDO)=0.
      YCWN(IDO)=0.
      YCOU(IDO)=0.
      YPOU(IDO)=0.
      YNOU(IDO)=0.
      QP(IDO)=0.
	  QPU(IDO)=0.
	  PKRZ=0.
	  SMM(1,MO,ISA)=SMM(1,MO,ISA)+TMX(IRF(ISA))
      VAR(1,ISA)=TMX(IRF(ISA))
      SMM(2,MO,ISA)=SMM(2,MO,ISA)+TMN(IRF(ISA))
      VAR(2,ISA)=TMN(IRF(ISA))
      SMM(3,MO,ISA)=SMM(3,MO,ISA)+SRAD(IRF(ISA))
      VAR(3,ISA)=SRAD(IRF(ISA))
      SML=0.
	  SNMN=0.
	  DO J=1,8
          YSD(J,IDO)=0.
      END DO
      YMNU(IDO)=0.
      CVF(ISA)=0.
      RQRB(IDO)=0.
      QVOL(IDO)=0.
      CPVV=0.
      CPVH(IDO)=0.
      VAR(5,ISA)=0.
      TSNO(ISA)=TSNO(ISA)+1.
      YMP=0.
      QAPY=0.
      IF(.5*(TX+STMP(LID(2,ISA),ISA))>0.)THEN
          IF(SNO(ISA)>0..AND.SRAD(IRF(ISA))>10..AND.TMX(IRF(ISA))&
          >0.)CALL HSNOM
          RFV(IRF(ISA))=RFV(IRF(ISA))+SML
          SMM(6,MO,ISA)=SMM(6,MO,ISA)+SML
          VAR(6,ISA)=SML
      ELSE
          DSNO=RFV(IRF(ISA))
          SNO(ISA)=SNO(ISA)+DSNO
          SMM(5,MO,ISA)=SMM(5,MO,ISA)+RFV(IRF(ISA))
          VAR(5,ISA)=RFV(IRF(ISA))
          RFV(IRF(ISA))=0.
      END IF
      IF(BVIR(ISA)>RFV(IRF(ISA)))THEN
          IVR=1  
          RFV(IRF(ISA))=RFV(IRF(ISA))+BVIR(ISA)
	      REPI(ISA)=BVIR(ISA)/24.
	      DUR=24.
          BVIR(ISA)=0.
          REP=MAX(REP,REPI(ISA))  
      ELSE
          IVR=0
      END IF
	  CALL HVOLQ(IVR)
      JCN(ISA)=JCN(ISA)+1
      SMM(14,MO,ISA)=SMM(14,MO,ISA)+CN
      VAR(14,ISA)=CN
      IF(QVOL(IDO)>1.)THEN
          NQRB(IDO)=NQRB(IDO)+1
          PRAV(IDO)=PRAV(IDO)+RQRB(IDO)
          PRSD(ISA)=PRSD(ISA)+RQRB(IDO)*RQRB(IDO)
          IF(RQRB(IDO)>PRB(IDO))PRB(IDO)=RQRB(IDO)
          X1=RQRB(IDO)/(QVOL(IDO)+1.)
          IF(X1>QRQB(ISA))QRQB(ISA)=X1
          QRBQ(ISA)=QRBQ(ISA)+X1
          TCAV(IDO)=TCAV(IDO)+TC(IDO)
          IF(TC(IDO)<TCMX(IDO))THEN
              IF(TC(IDO)<TCMN(IDO))TCMN(IDO)=TC(IDO)
          ELSE
              TCMX(IDO)=TC(IDO)
          END IF
      END IF
!     COMPUTE SEDIMENT YLD
      IF(PEC(ISA)>0..AND.LUN(ISA)/=35)THEN
          CALL EYSED(JRT)
          IF(JRT==0.OR.YERO>0.)THEN
              YERO=YERO+YSD(NDRV,IDO)
              X1=.9*WT(LD1,ISA)
              IF(YERO>X1)THEN
                  RTO=X1/YERO
                  YSD(NDRV,IDO)=YSD(NDRV,IDO)*RTO
                  YW(IDO)=YW(IDO)*RTO
                  YERO=X1
              END IF
              IF(JRT==0)THEN
                  IF(BCOF(ISA)>0.)CALL EBUFSA
                  VARH(6,IDO)=WSAX*YSD(NDRV,IDO)
                  SMMH(6,MO,IDO)=SMMH(6,MO,IDO)+VARH(6,IDO)
                  VAR(28,ISA)=YSD(2,IDO)
                  SMM(28,MO,ISA)=SMM(28,MO,ISA)+YSD(2,IDO)
                  SMM(29,MO,ISA)=SMM(29,MO,ISA)+YSD(4,IDO)
                  VAR(29,ISA)=YSD(4,IDO)
                  SMM(27,MO,ISA)=SMM(27,MO,ISA)+YSD(5,IDO)
                  VAR(27,ISA)=YSD(5,IDO)
                  ERAV(IDO)=ERAV(IDO)+ERTO
                  SMM(124,MO,ISA)=SMM(124,MO,ISA)+YSD(6,IDO)
                  VAR(124,ISA)=YSD(6,IDO)
                  SMM(107,MO,ISA)=SMM(107,MO,ISA)+YSD(7,IDO)
                  VAR(107,ISA)=YSD(7,IDO)
                  SMM(88,MO,ISA)=SMM(88,MO,ISA)+YMNU(IDO)
                  VAR(88,ISA)=YMNU(IDO)
                  CY=1.E5*YSD(NDRV,IDO)/QVOL(IDO)
                  CYAV(ISA)=CYAV(ISA)+CY
                  CYSD(ISA)=CYSD(ISA)+CY*CY
                  IF(CY>CYMX(ISA))CYMX(ISA)=CY
              END IF
          END IF          
          SMM(26,MO,ISA)=SMM(26,MO,ISA)+YSD(3,IDO)
          VAR(26,ISA)=YSD(3,IDO)
          SMM(31,MO,ISA)=SMM(31,MO,ISA)+YSD(8,IDO)
          VAR(31,ISA)=YSD(8,IDO)
          VAR(25,ISA)=CVF(ISA)
      END IF          
      YEW=MIN(ERTO*YSD(NDRV,IDO)/WT(LD1,ISA),.9)      
      YEWN=MIN(ERTO*YW(IDO)/WT(LD1,ISA),.9)
      CALL NYON
      SMM(37,MO,ISA)=SMM(37,MO,ISA)+YN(IDO)+YNOU(IDO)
      VAR(37,ISA)=YN(IDO)+YNOU(IDO)
      SMM(134,MO,ISA)=SMM(134,MO,ISA)+YNWN(IDO)
      VAR(134,ISA)=YNWN(IDO)
      XX=.0001+EXP(-.1*YW(IDO)-YSD(3,IDO))
      RHTT(ISA)=MAX(.001,RHTT(ISA)*XX)
      DHT(ISA)=MAX(.001,DHT(ISA)*XX)
      SMM(34,MO,ISA)=SMM(34,MO,ISA)+RRUF(ISA)
      VAR(34,ISA)=RRUF(ISA)
      IF(IHY>0)THEN
          NHY(IDO)=0
          HYDV(IDO)=0.
          IF(QVOL(IDO)>QTH)THEN
              IF(INFL<4)THEN
                  IF(NRF==0.AND.RFV(IRF(ISA))>0.)THEN
                      IF(IHY>4)THEN
                          CALL HRFDT
                      ELSE
                          CALL HRFDTS
                      END IF
                  END IF    
              END IF                  
              SMM(33,MO,ISA)=SMM(33,MO,ISA)+RHTT(ISA)
              VAR(33,ISA)=RHTT(ISA)
              RRUF(ISA)=MAX(.001,RRUF(ISA)*XX)
              !CALL HYDDV
              CALL HYDUNT
	          !IF(IHY==0)CALL EHYD
          END IF	          
      END IF	      
      AFN=MIN(BVIR(ISA)*CQNI,FNMX(IRO(ISA),ISA)-ANA(IRO(ISA),ISA))
      IF(AFN>0.)THEN
          ANA(IRO(ISA),ISA)=ANA(IRO(ISA),ISA)+AFN
          WNO3(LD1,ISA)=WNO3(LD1,ISA)+AFN
          IF(NOP>0.OR.NBSA(ISA)==ISAP)WRITE(KW(1),1140)ISA,NBSA(ISA),&
          IYR,MO,KDA,AFN,BVIR(ISA),XHSM(ISA)
      END IF
      RFV(IRF(ISA))=RFV(IRF(ISA))+BVIR(ISA)
      BVIR(ISA)=0.
      IF(LUN(ISA)/=35)CALL HPURK
!     PKRZ(LNS)=PKRZ(LNS)+CPVV
      SMM(97,MO,ISA)=SMM(97,MO,ISA)+CPVV
      SMM(87,MO,ISA)=SMM(87,MO,ISA)+CPVH(IDO)
      XX=PKRZ(LNS)
      SMM(16,MO,ISA)=SMM(16,MO,ISA)+XX
      VAR(16,ISA)=XX
      SMM(83,MO,ISA)=SMM(83,MO,ISA)+QRF(IDO)
      VAR(83,ISA)=QRF(IDO)
      GWST(ISA)=GWST(ISA)+XX
      X1=RFTT(ISA)*GWST(ISA)
      X2=X1*RFPK(ISA)
      VAR(71,ISA)=X1-X2
      CONC=GWSN(ISA)/(GWST(ISA)+1.E-10)
      IF(GWST(ISA)/GWMX(ISA)<PRMT(40))X2=0.
	  TNL=CONC*X1
	  CNV=TNL/(X2*PRMT(74)+VAR(71,ISA))
	  CNH=CNV*PRMT(74)
      RSFN(IDO)=CNH*X2
      DPKN=CNV*VAR(71,ISA)
      SMM(96,MO,ISA)=SMM(96,MO,ISA)+DPKN
      VAR(96,ISA)=DPKN
      GWSN(ISA)=MAX(1.E-10,GWSN(ISA)-RSFN(IDO)-DPKN)
      DO K=1,NDP
          X3=GWPS(K,ISA)/GWST(ISA)
          RSPS(K,IDO)=MIN(GWPS(K,ISA),X2*X3)
          GWPS(K,ISA)=GWPS(K,ISA)-RSPS(K,IDO)
          VARP(12,K,IDO)=MIN(GWPS(K,ISA),VAR(71,ISA)*X3)
          GWPS(K,ISA)=GWPS(K,ISA)-VARP(12,K,IDO)
          SMMP(11,K,MO,IDOA(ISA))=SMMP(11,K,MO,IDOA(ISA))+RSPS(K,IDO)
          SMMP(12,K,MO,IDOA(ISA))=SMMP(12,K,MO,IDOA(ISA))+VARP(12,K,IDO)
      END DO
      SMM(15,MO,ISA)=SMM(15,MO,ISA)+SST(IDO)
      VAR(15,ISA)=SST(IDO)
      RSSF(IDO)=X2
      SMM(71,MO,ISA)=SMM(71,MO,ISA)+VAR(71,ISA)
      SMM(72,MO,ISA)=SMM(72,MO,ISA)+RSSF(IDO)
      VAR(72,ISA)=RSSF(IDO)
      X2=X2*SALA(ISA)/WSA(ISA)
      GWST(ISA)=MAX(1.E-10,GWST(ISA)-VAR(71,ISA)-X2)
      CALL NCQYL
      X1=RSSF(IDO)+SST(IDO)+QRF(IDO)
      XX=QVOL(IDO)+X1
      X1=MAX(RQRB(IDO),X1/24.)
      IF(KFL(9)>0)WRITE(KW(9),1202)ISA,NBSA(ISA),IYR,MO,KDA,CN,SCI(ISA),&
      VAR(4,ISA),STMP(LD2,ISA),SML,QVOL(IDO),SST(IDO),QRF(IDO),RSSF(IDO),&
      XX,X1,TC(IDO),DUR,ALTC,AL5,REP,RZSW(ISA),GWST(ISA)
 	  REP=0.
	  REPI(ISA)=0. 
      CALL HEVP
      SMM(10,MO,ISA)=SMM(10,MO,ISA)+EO
      VAR(10,ISA)=EO
      ADEO=(XDA*SMM(10,MO,ISA)+XDA1*PMOEO)*.0226
      ADRF=(XDA*(SMM(4,MO,ISA)-SMM(13,MO,ISA)-SMM(17,MO,ISA))+XDA1*PMORF&
      )/31.
      SMRF(ISA)=SMRF(ISA)-RF5(IWTB,ISA)+RFV(IRF(ISA))
      DO I=IWTB,2,-1
          RF5(I,ISA)=RF5(I-1,ISA)
      END DO
      RF5(1,ISA)=RFV(IRF(ISA))
      X1=STMP(LD2,ISA)*CLF
      SMEO(ISA)=SMEO(ISA)-EO5(IWTB,ISA)+X1
      DO I=IWTB,2,-1
          EO5(I,ISA)=EO5(I-1,ISA)
      END DO
      EO5(1,ISA)=X1
      IF(WTMN(ISA)<Z(LNS,ISA))CALL HWTBL
      VAP(ISA)=0.
      VPU(ISA)=0.
      QSFP=0.
	  IF(LUN(ISA)/=35.AND.RFV(IRF(ISA))>0.)THEN
	      !IF(LBP==1)THEN
	          CALL NYPA
	      !ELSE
	          !CALL NYPAV
          !END IF
      END IF
      SMM(48,MO,ISA)=SMM(48,MO,ISA)+YP(IDO)+YPOU(IDO)
      VAR(48,ISA)=YP(IDO)+YPOU(IDO)
      VARH(2,IDO)=WSAX1*QVOL(IDO)/86400.
	  SMMH(2,MO,IDO)=SMMH(2,MO,IDO)+VARH(2,IDO)
      VARH(9,IDO)=WSAX*(YN(IDO)+YNOU(IDO))
      SMMH(9,MO,IDO)=SMMH(9,MO,IDO)+VARH(9,IDO)
      VARH(11,IDO)=WSAX*(YP(IDO)+YPOU(IDO))
      SMMH(11,MO,IDO)=SMMH(11,MO,IDO)+VARH(11,IDO)
      VAR(118,ISA)=YMP+QAPY
      SMM(118,MO,ISA)=SMM(118,MO,ISA)+VAR(118,ISA)
      VAR(119,ISA)=VAR(48,ISA)-VAR(118,ISA)
      SMM(119,MO,ISA)=SMM(119,MO,ISA)+VAR(119,ISA)
      SMM(135,MO,ISA)=SMM(135,MO,ISA)+YPWN(IDO)
      VAR(135,ISA)=YPWN(IDO)
      RSDM(LD1,ISA)=RSDM(LD1,ISA)-YMNU(IDO)
      ZZ=WLM(LD1,ISA)+WLS(LD1,ISA)
      RTO=MIN(1.,WLM(LD1,ISA)/ZZ)
      WLM(LD1,ISA)=WLM(LD1,ISA)-RTO*YMNU(IDO)
      X1=WLSL(LD1,ISA)/WLS(LD1,ISA)
      WLS(LD1,ISA)=MAX(1.E-10,WLS(LD1,ISA)-YMNU(IDO)*(1.-RTO))
      WLSL(LD1,ISA)=MAX(1.E-10,WLS(LD1,ISA)*X1)
      UNM=0.
      UPM=0.
      UKM=0.
      NDFA(ISA)=NDFA(ISA)+1
      NII(ISA)=NII(ISA)+1
      XHSM(ISA)=HSM(ISA)/AHSM
      IRGX=0
      IF(NYD/=1.AND.IDA==60)THEN
          NT1=1
      ELSE
          N1=KT(ISA)
          LGZ=0
          DO KT2=N1,NN1
              KT(ISA)=KT2
              IF(KOMP(KT2,ISA)>0)CYCLE
              IF(KTF(ISA)==0)KTF(ISA)=KT2
              DO K=1,LC
                  IF(JH(IRO(ISA),KT2,ISA)==KDC(K))EXIT
              END DO
              IF(K>LC)K=1
              JJK=K
              IF(IHUS==0)THEN
                  IF(IDA<ITL(IRO(ISA),KT2,ISA)+NT1)EXIT
              END IF
              IF(KGO(JJK,ISA)>0.OR.JPL(JJK,ISA)>0)XHSM(ISA)=HU(JJK,ISA)/&
              PHU(JJK,IHU(JJK,ISA),ISA)
              IF(XHSM(ISA)<HUSC(IRO(ISA),KT2,ISA))THEN
                  IF(MO<12.OR.IDC(JJK)==NDC(7).OR.IDC(JJK)==NDC(8).OR.IDC(JJK)&
                  ==NDC(10))EXIT
              ELSE
	              IF(PDSW(ISA)/PDAW(ISA)>PRMT(78).AND.RSAE(ISA)<1.E-5.AND.MO<&
                  12)THEN
	                  IF(KFL(1)>0)WRITE(KW(1),589)ISA,NBSA(ISA),IY,MO,KDA,PDSW(ISA),&
                      PDAW(ISA)
                      EXIT
                  END IF    
              END IF    
              JT1=LT(IRO(ISA),KT2,ISA)
              KOMP(KT2,ISA)=1
              IF(KT2>KTMX(ISA))KTMX(ISA)=KT(ISA)
              CSTX=COTL(JT1)
              COX=COOP(JT1)
              II=0
              SELECT CASE(IHC(JT1))
                  CASE(7)
                      IF(RFV(IRF(ISA))>PRMT(77))THEN
                          KOMP(KT2,ISA)=0
                          CYCLE
                      END IF
                      CALL PSTAPP
	                  IF(IDA==JD0.AND.NBT(JT1)==0.AND.NBE(JT1)==JDE)THEN
                          CSTX=0.
                          COX=0.
                      END IF
                      II=1
                  CASE(8)
                      IF(IRGX>0)THEN
                          KOMP(KT2,ISA)=0
                          CYCLE
                      END IF
                      BVIR(ISA)=VIRR(IRO(ISA),KT2,ISA)
                      IF(BVIR(ISA)<1.E-10)IAUI(ISA)=JT1
                      CALL HIRG(BVIR(ISA),EFM(JT1),TLD(JT1),JRT,JT1,1)
                      IRGX=1
                  CASE(9)    
                      IHD=0
	                  CALL NFERT(APMU,6,JT1,KT2,JRT)
	                  IF(IDA==JD0.AND.NBT(JT1)==0.AND.NBE(JT1)==JDE)THEN
                          CSTX=0.
                          COX=0.
                      END IF
                        II=1
                  CASE(20)
                      KOMP(N1,ISA)=1 
                      RST0(ISA)=0.         
                      IGZ(ISA)=0
                      DO IHD=1,NHRD(IOW)
                          NGZ(IHD,ISA)=0
                          GCOW(IHD,ISA)=0.
                      END DO
                      KTF(ISA)=KTF(ISA)+1
                  CASE DEFAULT
                      II=1    
              END SELECT
              IF(II==1)THEN
                  JD0=IDA
                  JDE=NBE(JT1)
                  CALL TLOP(CSTX,COX,JRT)
                  IF(JRT>0)EXIT
              END IF    
              IF(IFD(ISA)>0.AND.DKHL(ISA)>.001)THEN
                  DHT(ISA)=DKHL(ISA)
                  IF(NOP>0.OR.NBSA(ISA)==ISAP)WRITE(KW(1),970)ISA,NBSA(ISA),IYR&
                  ,MO,KDA,DHT(ISA),DKIN(ISA),XHSM(ISA)
              END IF    
              COST(ISA)=COST(ISA)+CSTX
              CSFX=CSFX+COX
              JT2=JT1
          END DO
          IF(KT2>NN1)KTF(ISA)=N1
          KT(ISA)=KTF(ISA)
          DO IHD=1,NHRD(IOW)
              IZ=IFED(IHD,IOW)
	          IF(IZ==ISA)THEN
                  IF(NCOW(IHD,IOW)>0)GCOW(IHD,ISA)=NCOW(IHD,IOW)*FFED(IHD,IOW)
	          ELSE
                  IF(RST0(ISA)<1.E-5)THEN
                      IF(IGZX(IHD,IOW)/=ISA)CYCLE
                      GCOW(IHD,ISA)=NCOW(IHD,IOW)*(1.-FFED(IHD,IOW))
	              END IF	              
	              IF(NGZ(IHD,ISA)==0.OR.IGZ(ISA)==0)CYCLE
	          END IF
              STKR(ISA)=STKR(ISA)+GCOW(IHD,ISA)
              DDMP=DUMP(IHD,IOW)*GCOW(IHD,ISA)
              TMPD=TMPD+DDMP
              X1=DDMP*SOLQ(ISA)
              WTMU(ISA)=WTMU(ISA)+X1
              AFLG(ISA)=AFLG(ISA)+X1
              SMM(61,MO,ISA)=SMM(61,MO,ISA)+X1
              VAR(61,ISA)=X1
              X5=.0001*VURN(IHD,IOW)*GCOW(IHD,ISA)/WSAX
              RFV(IRF(ISA))=RFV(IRF(ISA))+X5
              X2=DDMP-X1
              APMU=X2/WSA(ISA)
              CALL NFERT(APMU,3,IAMF(ISA),KT2,JRT)
          END DO
          IHD=NHRD(IOW)
          IF(IAPL(ISA)>0)THEN
              IF(ISAS(IOW)/=ISA)GO TO 5 
              APMU=FNP(2,ISA)
              IF(SMNU(IOW)<.001*APMU*WSA(ISA))GO TO 5
	          CALL NFERT(APMU,2,ISPF(ISA),KT2,JRT)
              IF(JRT>0)GO TO 5      
              X4=.001*APMU
              SMNU(IOW)=SMNU(IOW)-X4
              GO TO 5
          END IF
          IF(DALG(ISA)>0.)THEN
              ALQ(ISA)=0.
              CALL HLGOON(JRT)
              IF(JRT==0)THEN
                  ALQ(ISA)=MIN(CFNP(ISA)*VLGI(ISA),.95*WTMU(ISA))
                  CFNP(ISA)=WTMU(ISA)/VLG(ISA)
                  GO TO 5
              END IF
          END IF
          IF(ISAL(IOW)/=ISA)GO TO 5
          IZ=-IAPL(ISA)
          IF(ALQ(IZ)<1.E-5)GO TO 5
    !     IF(RZSW(ISA)-PAW(ISA)>BIR(ISA))GO TO 5
          APMU=MIN(.9*WTMU(IZ),ALQ(IZ))
          APMU=APMU/WSA(ISA)
	      CALL NFERT(APMU,1,ILQF(ISA),KT2,JRT)
          IF(JRT>0)GO TO 5
          SMM(62,MO,IZ)=SMM(62,MO,IZ)+APMU
          VAR(62,ISA)=APMU
          X6=APMU
          WTMU(IZ)=WTMU(IZ)-APMU
          BVIR(ISA)=.1*ALGI(IOW)/WSA(ISA)
          CALL HIRG(BVIR(ISA),1.,0.,JRT,JT1,1)
          IF(JRT==0)TFLG(ISA)=TFLG(ISA)+APMU
        5 BIR(ISA)=TIR(IRO(ISA),KTMX(ISA),ISA)
          EFI(ISA)=QIR(IRO(ISA),KTMX(ISA),ISA)
          FIRG(ISA)=FIRX(IRO(ISA),KTMX(ISA),ISA)
          JT1=LT(IRO(ISA),KT(ISA),ISA)
          IF(NDFA(ISA)>=IFA(ISA).AND.IDFT(5,ISA)/=0)THEN
              APMU=FNP(5,ISA)
	          IF(APMU>1.E-5)CALL NFERT(APMU,5,JT1,KT2,JRT)
	      END IF
          KTF(ISA)=0
          IF(ABS(BIR(ISA))>1.E-5)THEN
              IF(BIR(ISA)<0.)THEN
                  IF(RZSW(ISA)-PAW(ISA)<BIR(ISA))CALL HIRG(BVIR(ISA),&
                  EFM(IAUI(ISA)),TLD(IAUI(ISA)),JRT,IAUI(ISA),0)
              ELSE
                  IF(BIR(ISA)>=1.)THEN
                      CALL SWTN
                      IF(WTN>BIR(ISA))CALL HIRG(BVIR(ISA),EFM(IAUI(ISA)),&
                      TLD(IAUI(ISA)),JRT,IAUI(ISA),0)
                  ELSE
                      IF(WS(ISA)<BIR(ISA))CALL HIRG(BVIR(ISA),EFM(IAUI(ISA)),&
                      TLD(IAUI(ISA)),JRT,IAUI(ISA),0)
                  END IF
              END IF    
          END IF
      END IF    
      IF(LUN(ISA)/=35)CALL NPCY
      IF(IRR(ISA)==1)RFV(IRF(ISA))=RFV(IRF(ISA))+BVIR(ISA)
      IF(IDNT>2)CALL GASDF3
      XX=0.
      RSPC=0.
      DO J=1,NBSL(ISA)
          ISL=LID(J,ISA)
          IF(STMP(ISL,ISA)>0.)THEN
              Z5=500.*(Z(ISL,ISA)+XX)
              IF(ICP==0)THEN
                  CALL NCNMI_PHOENIX(Z5,CS,EAR(ISL,ISA))
              ELSE    
                  CALL NCNMI_CENTURY(Z5,CS,EAR(ISL,ISA))
              END IF
          END IF
          XX=Z(ISL,ISA)
      END DO                                                                 
      CV(ISA)=0.
      CVP(ISA)=0.
      CVRS(ISA)=0.
      VAC(ISA)=0.
      AEPT=0.
      XES=ES
      AGPM(ISA)=0.
      TAGP(ISA)=0.
      IF(IGO(ISA)>1)XES=ES/IGO(ISA)
      WS(ISA)=1.
      IF(IGO(ISA)>0)THEN
          JGO=0
          JBG(ISA)=JBG(ISA)+1
          IF(JBG(ISA)>IGO(ISA))JBG(ISA)=1
          I=JBG(ISA)
          DO J=1,LC
              IF(KGO(J,ISA)>0)THEN
                  JGO(I)=KGO(J,ISA)
                  I=I+1
                  IF(I>IGO(ISA))I=1
              END IF    
          END DO
          I1=0
          DO IN2=1,IGO(ISA)
              I1=I1+1
              JJK=JGO(I1)
              AEP(JJK)=0.
              IF(JPL(JJK,ISA)>0)THEN
                  HU(JJK,ISA)=HU(JJK,ISA)+MAX(0.,DST0(ISA)-TBSC(JJK))
	              IF(PDSW(ISA)/PDAW(ISA)>PRMT(11).AND.HU(JJK,ISA)>GMHU(JJK))THEN
	                  JPL(JJK,ISA)=0
                      IF(NOP>0.OR.NBSA(ISA)==ISAP)WRITE(KW(1),950)ISA,NBSA(ISA),IYR&
                      ,MO,KDA,CPNM(JJK),PDSW(ISA),HU(JJK,ISA),XHSM(ISA)
                      HU(JJK,ISA)=0.
                  ELSE
                      IF(HU(JJK,ISA)/PHU(JJK,IHU(JJK,ISA),ISA)>.3.AND.KGO(JJK,ISA)>0)THEN
                          KGO(JJK,ISA)=0
                          IGO(ISA)=IGO(ISA)-1
                          JPL(JJK,ISA)=0
                      END IF    
                      CYCLE
                  END IF
              END IF
              CV(ISA)=CV(ISA)+DM(JJK,ISA)-RW(JJK,ISA)
              XX=PPL0(JJK,ISA)
              CVP(ISA)=MAX(CVP(ISA),XX/(XX+EXP(SCRP(15,1)-SCRP(15,2)*XX)))
              STLX=STL(JJK,ISA)
              VAC(ISA)=VAC(ISA)+BWN(1,JJK)*STLX
              AWC(JJK,ISA)=AWC(JJK,ISA)+RFV(IRF(ISA))-QVOL(IDO)
              DO L1=1,NBSL(ISA)
                  ISL=LID(L1,ISA)
                  UW(ISL)=0.
                  UK(ISL)=0.
                  UN(ISL)=0.
                  UP(ISL)=0.
              END DO
              UNM=0.
              UPM=0.
              UKM=0.
              DDM(JJK)=0.
              CALL CGROW(JRT)
              IF(JRT/=1)THEN
                  IF(JRT==0)THEN
                      VARC(14,JJK,ISA)=REG(JJK,ISA)
                      SUN=0.
                      SUP=0.
                      SUK=0.
                      CALL HUSE
                      CALL CROP
                      CALL NUP
                      CALL NPUP
                      CALL NKUP
                      CALL NUSE
                      CALL CSTRS
                      VARC(10,JJK,ISA)=WS(ISA)
                      VARC(11,JJK,ISA)=SN
                      VARC(12,JJK,ISA)=SP
                      VARC(13,JJK,ISA)=SK
                      VARC(15,JJK,ISA)=SAT            
                      VARC(17,JJK,ISA)=REG(JJK,ISA)
                      VAR(43,ISA)=WFX
                      AEPT=AEPT+AEP(JJK)
                      IF(HUI(JJK,ISA)>PRMT(3))THEN
                          SWH(JJK,ISA)=SWH(JJK,ISA)+AEP(JJK)
                          SWP(JJK,ISA)=SWP(JJK,ISA)+EP(JJK)
                      END IF
                      VAR(12,ISA)=AEP(JJK)
                      ACET(JJK,ISA)=ACET(JJK,ISA)+AEP(JJK)+XES
                  END IF          
                  CALL CAGRO
                  STV(5,MO,ISA)=UN1(JJK,ISA)
                  VARS(5)=UN1(JJK,ISA)
                  STV(6,MO,ISA)=UP1(JJK,ISA)
                  VARS(6)=UP1(JJK,ISA)
                  STV(7,MO,ISA)=UK1(JJK,ISA)
                  VARS(7)=UK1(JJK,ISA)
              END IF          
              STLX=STL(JJK,ISA)
              IF(IDC(JJK)/=NDC(7).AND.IDC(JJK)/=NDC(8).AND.IDC(JJK)/=NDC(10))&
              AGPM(ISA)=AGPM(ISA)+STLX
              TAGP(ISA)=TAGP(ISA)+STLX
              VARC(1,JJK,ISA)=HUI(JJK,ISA)
              VARC(2,JJK,ISA)=SLAI(JJK,ISA)
              VARC(3,JJK,ISA)=RD(JJK,ISA)
              VARC(4,JJK,ISA)=RW(JJK,ISA)
              VARC(5,JJK,ISA)=DM(JJK,ISA)
              VARC(6,JJK,ISA)=STLX
              VARC(7,JJK,ISA)=CPHT(JJK,ISA)
              VARC(8,JJK,ISA)=STD(JJK,ISA)
              VARC(9,JJK,ISA)=STDL(JJK,ISA)
          END DO          
      END IF
      DO K=1,LC                                          
          STDX=STD(K,ISA)
          AGPM(ISA)=AGPM(ISA)+STDX
          TAGP(ISA)=TAGP(ISA)+STDX
          CVRS(ISA)=CVRS(ISA)+STDX
          CV(ISA)=CV(ISA)+STDX
          VAC(ISA)=VAC(ISA)+BWN(2,K)*STDX
      END DO
!     IF(IDFH(ISA)>0)THEN
!         SUM=0.
!         DO J=1,NBSL(ISA)
!             ISL=LID(J,ISA)
!             SUM=SUM+RSDM(ISL,ISA)
!         END DO
!         SUM=SUM*WSA(ISA)
!         X2=.001*WTMU(ISA)
!         AD1=SLAP*WSA(ISA)
!         DDMP=.001*DDMP
!         X6=.001*X6
!         DF=DDMP-X2+WTM1-SUM+RSM0-SMNU(IOW)+SMN1-X4-X6-AD1
!         DDF=DDF+DF
!         IF(ABS(DF)>.001)WRITE(KW(1),150)NBSA(ISA),ISA,IY,MO,KDA,X2,SUM,DDMP,&
!         SMNU(IOW),AD1,X4,X6,DF,DDF
! 150     FORMAT(1X,'#####',2I8,3I4,9E13.5)          
!         WTM1=X2
!         RSM0=SUM
!         SMN1=SMNU(IOW)
!         X4=0.
!         X6=0.
!     END IF
      ! CALL NCONT X
      IF(NDP>0)THEN
          CALL PSTCY(PQPX,PYPX,IXP)
          CALL PSTEV
      END IF
      PDPL(ISA)=0.
      PDSKC=0.
      SW(ISA)=SWLT(ISA)+XRFI(ISA)
      RZSW(ISA)=0.
      ZNMN(ISA)=0.
      ZNMA(ISA)=0.
      ZNMU(ISA)=0.
      ZNOU(ISA)=0.
      ZPML(ISA)=0.
      ZPO(ISA)=0.
      ZPMA(ISA)=0.
	  ZPMU(ISA)=0.
	  ZPOU(ISA)=0.
	  ZEK(ISA)=0.
	  ZFK(ISA)=0.
	  ZSK(ISA)=0.
      TRSD(ISA)=0.
      ZFOP(ISA)=0.
      ZNOS(ISA)=0.
      ZNOA(ISA)=0.
      ZPMS(ISA)=0.
      TNOR(ISA)=0.
      ZON(ISA)=0.
      ZOC(ISA)=0.
      ZLS(ISA)=0.
      ZLM(ISA)=0.
      ZLSL(ISA)=0.
      ZLSC(ISA)=0.
      ZLMC(ISA)=0.
      ZLSLC(ISA)=0.
      ZLSLNC(ISA)=0.
      ZBMC(ISA)=0.
      ZHSC(ISA)=0.
      ZHPC(ISA)=0.
      ZLSN(ISA)=0.
      ZLMN(ISA)=0.
      ZBMN(ISA)=0.
      ZHSN(ISA)=0.
      ZHPN(ISA)=0.
      ZSLT(ISA)=0.
      XX=0.
      SUM=0.
      OCPD(ISA)=0.
      PDSW(ISA)=0.
	  PDAW(ISA)=0.
      IF(BIG(ISA)>0.)CALL SAJBD
      DO J=1,NBSL(ISA)
          ISL=LID(J,ISA)
          SMS(2,ISL,ISA)=SMS(2,ISL,ISA)+STMP(ISL,ISA)
          WOC(ISL,ISA)=WBMC(ISL,ISA)+WHPC(ISL,ISA)+WHSC(ISL,ISA)+WLMC(ISL,&
          ISA)+WLSC(ISL,ISA)
          IF(Z(ISL,ISA)<=PMX(ISA))THEN
              PDSW(ISA)=PDSW(ISA)+SWST(ISL,ISA)-S15(ISL,ISA)
	          PDAW(ISA)=PDAW(ISA)+FC(ISL,ISA)-S15(ISL,ISA)
              PDPL(ISA)=PDPL(ISA)+WPML(ISL,ISA)+WPMU(ISL,ISA)
              PDSKC(ISA)=PDSKC(ISA)+SOLK(ISL,ISA)
              OCPD(ISA)=OCPD(ISA)+WOC(ISL,ISA)
              SUM=SUM+WT(ISL,ISA)
              K1=J
              K2=ISL
          END IF
          IF(Z(ISL,ISA)<=RZ(ISA))THEN
              TNOR(ISA)=TNOR(ISA)+WNO3(ISL,ISA)
              LZ=ISL
              L1=J
              RZSW(ISA)=RZSW(ISA)+SWST(ISL,ISA)-S15(ISL,ISA)
              XX=Z(ISL,ISA)
          END IF
          ZPML(ISA)=ZPML(ISA)+WPML(ISL,ISA)
          ZPMS(ISA)=ZPMS(ISA)+WPMS(ISL,ISA)
          ZPMA(ISA)=ZPMA(ISA)+WPMA(ISL,ISA)
          ZPO(ISA)=ZPO(ISA)+WPO(ISL,ISA)
	      ZPMU(ISA)=ZPMU(ISA)+WPMU(ISL,ISA)
	      ZPOU(ISA)=ZPOU(ISA)+WPOU(ISL,ISA)
	      ZEK(ISA)=ZEK(ISA)+EXCK(ISL,ISA)
	      ZSK(ISA)=ZSK(ISA)+SOLK(ISL,ISA)
	      ZFK(ISA)=ZFK(ISA)+FIXK(ISL,ISA)
          ZNMN(ISA)=ZNMN(ISA)+WNO3(ISL,ISA)
          ZNMA(ISA)=ZNMA(ISA)+WNH3(ISL,ISA)
          ZNMU(ISA)=ZNMU(ISA)+WNMU(ISL,ISA)
          ZNOU(ISA)=ZNOU(ISA)+WNOU(ISL,ISA)
          TRSD(ISA)=TRSD(ISA)+RSD(ISL,ISA)
          SW(ISA)=SW(ISA)+SWST(ISL,ISA)
          ZFOP(ISA)=ZFOP(ISA)+FOP(ISL,ISA)
          ZSLT(ISA)=ZSLT(ISA)+WSLT(ISL,ISA)
          ZLS(ISA)=ZLS(ISA)+WLS(ISL,ISA)
          ZLM(ISA)=ZLM(ISA)+WLM(ISL,ISA)
          ZLSL(ISA)=ZLSL(ISA)+WLSL(ISL,ISA)
          ZLSC(ISA)=ZLSC(ISA)+WLSC(ISL,ISA)
          ZLMC(ISA)=ZLMC(ISA)+WLMC(ISL,ISA)
          ZLSLC(ISA)=ZLSLC(ISA)+WLSLC(ISL,ISA)
          ZLSLNC(ISA)=ZLSLNC(ISA)+WLSLNC(ISL,ISA)
          ZBMC(ISA)=ZBMC(ISA)+WBMC(ISL,ISA)
          ZHSC(ISA)=ZHSC(ISA)+WHSC(ISL,ISA)
          ZHPC(ISA)=ZHPC(ISA)+WHPC(ISL,ISA)
          ZLSN(ISA)=ZLSN(ISA)+WLSN(ISL,ISA)
          ZLMN(ISA)=ZLMN(ISA)+WLMN(ISL,ISA)
          ZBMN(ISA)=ZBMN(ISA)+WBMN(ISL,ISA)
          ZHSN(ISA)=ZHSN(ISA)+WHSN(ISL,ISA)
          ZHPN(ISA)=ZHPN(ISA)+WHPN(ISL,ISA)
          WON(ISL,ISA)=WBMN(ISL,ISA)+WHPN(ISL,ISA)+WHSN(ISL,ISA)+WLMN(ISL,&
          ISA)+WLSN(ISL,ISA)
      END DO         
      ZON(ISA)=ZLSN(ISA)+ZLMN(ISA)+ZBMN(ISA)+ZHSN(ISA)+ZHPN(ISA)
      ZOC(ISA)=ZLSC(ISA)+ZLMC(ISA)+ZBMC(ISA)+ZHSC(ISA)+ZHPC(ISA)
      IF(LZ/=ISL)THEN
          ZZ=RZ(ISA)-Z(LZ,ISA)
          L1=LID(L1+1,ISA)
          RTO=ZZ/(Z(L1,ISA)-Z(LZ,ISA))
          RZSW(ISA)=RZSW(ISA)+(SWST(L1,ISA)-S15(L1,ISA))*RTO
          TNOR(ISA)=TNOR(ISA)+WNO3(L1,ISA)*RTO
      END IF
      SSW(ISA)=SSW(ISA)+RZSW(ISA)
      IF(K1/=NBSL(ISA))THEN
          KK=LID(K1+1,ISA)
          RTO=(PMX(ISA)-Z(K2,ISA))/(Z(KK,ISA)-Z(K2,ISA))
          PDSW(ISA)=PDSW(ISA)+RTO*(SWST(KK,ISA)-S15(KK,ISA))
	      PDAW(ISA)=PDAW(ISA)+RTO*(FC(KK,ISA)-S15(KK,ISA))
	      SUM=SUM+RTO*WT(KK,ISA)
          OCPD(ISA)=.1*(OCPD(ISA)+RTO*WOC(KK,ISA))/SUM
          PDPL(ISA)=PDPL(ISA)+(WPML(KK,ISA)+WPMU(KK,ISA))*RTO
          PDPLC(ISA)=1000.*PDPL(ISA)/SUM
          PDSKC(ISA)=PDSKC(ISA)+SOLK(KK,ISA)*RTO
          PDSKC(ISA)=1000.*PDSKC(ISA)/SUM
      END IF
      AET=AEPT+ES
      SMM(11,MO,ISA)=SMM(11,MO,ISA)+AET
      VAR(11,ISA)=AET
      SMM(12,MO,ISA)=SMM(12,MO,ISA)+AEPT
      VAR(155,ISA)=10.*AET*SALA(ISA)
      SMM(155,MO,ISA)=SMM(155,MO,ISA)+VAR(155,ISA)
      IF(NVCN(ISA)==4.AND.LUN(ISA)/=35)THEN
          IF(IGO(ISA)>0)THEN
              X1=MAX(AET,EO*EXP(-PRMT(42)*SCI(ISA)/SMX(ISA)))
          ELSE
              X1=AET
          END IF
          SCI(ISA)=MAX(3.,SCI(ISA)+X1-RFV(IRF(ISA))+QVOL(IDO))
    !     +QRF(IDO)+SST(IDO)+QDR(IDO)+VAR(16,ISA)
          SCI(ISA)=MIN(SCI(ISA),PRMT(44)*SMX(ISA))
      END IF
      !IF(NBSA(ISA)==ISAP)WRITE(KW(9),'(10F10.4)')RFV(IRF(ISA)),QVOL(IDO),&
      !EO,AET,X1,SMX(ISA),SCI(ISA) 
	  X1=(ADRF-PRMT(9))/100.
      X2=CV(ISA)-PRMT(10)
      IPST(ISA)=IPST(ISA)+1
      IF(TMN(IRF(ISA))>0.)THEN
          IF(X1>0..AND.X2>0.)PSTS(ISA)=PSTS(ISA)+(X1+1.)*TMN(IRF(ISA))
      ELSE
          PSTS(ISA)=PSTS(ISA)+TMN(IRF(ISA))
      END IF
      SSFN=0.
      SSFK=0.
      CALL NEVN
      CALL NEVP
      VAR(41,ISA)=SGMN
      VAR(44,ISA)=SNMN
      VAR(42,ISA)=SDN
      VAR(128,ISA)=SN2
      VAR(154,ISA)=SN2O
      VAR(50,ISA)=SMP
      VAR(46,ISA)=SVOL
      VAR(45,ISA)=SNIT
      VAR(13,ISA)=QVOL(IDO)
      VAR(38,ISA)=QN(IDO)
      VAR(40,ISA)=VNO3(LNS,ISA)
      VAR(49,ISA)=QP(IDO)
	  VAR(108,ISA)=QPU(IDO)
      VAR(39,ISA)=TSFN(IDO)
      VAR(131,ISA)=TSFS
      VAR(151,ISA)=TSFK(IDO)
      VAR(120,ISA)=RZSW(ISA)
      VARS(1)=ZNMA(ISA)
      VARS(2)=ZNMN(ISA)
      VARS(3)=ZPML(ISA)
      VARS(4)=ZSK(ISA)
      VARS(8)=RZSW(ISA)
      VARS(9)=WTBL(ISA)
      VARS(10)=GWST(ISA)
      VARS(11)=STDO(ISA)
      VARS(12)=RSD(LD1,ISA)
      VARS(16)=SWLT(ISA)
      VARS(17)=SNO(ISA)
      VARS(18)=RSDM(LD1,ISA)
      VARS(19)=GWSN(ISA)
      VARS(20)=ZSLT(ISA)
      IF(KFL(11)>0)THEN
          NN=NCP(IRO(ISA),ISA)
          DO J=1,NN 
              !WRITE(KW(11),154)ISA,NBSA(ISA),IYR,MO,KDA,CPNM(J),(VARC(K,&
              !LY(IRO(ISA),J,ISA),ISA),K=1,16),(VAR(KD(K),ISA),K=1,NKD),&
              !(VARS(KS(K)),K=1,NKS)
              WRITE(KW(11),154)ISA,NBSA(ISA),IYR,MO,KDA,(VAR(KD(K),ISA),K=1,NKD),&
              (VARS(KS(K)),K=1,NKS),(VARC(K,LY(IRO(ISA),J,ISA),ISA),K=1,17)
          END DO
      END IF    
      CALL SPRNT
      IF(KFL(22)>0)CALL SOCIOD(KDA)
!     PRINTOUT DAILY
      IF(IPD<6)GO TO 500
      IF(NBSA(ISA)/=ISAP)GO TO 500
      IF(IPD<8.AND.IDA/=IPC)GO TO 500
      IF(IPD/=7.AND.IPD/=8)THEN
          WRITE(KW(1),1090)ISA,NBSA(ISA),IYR,MO,KDA,(HED(KD(K)),VAR(KD(K),&
          ISA),K=1,NKD)
          WRITE(KW(1),1201)(HEDS(KS(K)),VARS(KS(K)),K=1,NKS)
          WRITE(KW(1),1201)((HEDC(K),VARC(K,LY(IRO(ISA),J,ISA),ISA),K=1,17),&
          J=1,NCP(IRO(ISA),ISA))
    !     WRITE(KW(1),1200)(LID(K,ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'Z',(Z(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'ST',(SWST(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'S15',(S15(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'FC',(FC(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'PO',(PO(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'BD',(BD(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WT',(WT(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'SAN',(SAN(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'SIL',(SIL(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'ROK',(ROK(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'HK',(HK(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WNO3',(WNO3(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WNH3',(WNH3(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WPML',(WPML(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WPMA',(WPMA(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WPMS',(WPMS(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'RWT',(RWT(LID(K,ISA),JJK,ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'VNO3',(VNO3(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'U',(U(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'SEV',(SEV(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'O',(O(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'SSF',(SSF(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'UN',(UN(LID(K,ISA)),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'UP',(UP(LID(K,ISA)),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'WPO',(WPO(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'FOP',(FOP(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1040)'RSD',(RSD(LID(K,ISA),ISA),K=1,NBSL(ISA))
    !     WRITE(KW(1),1110)ISA,NBSA(ISA),IYR,MO,KDA,(STMP(LID(K,ISA),ISA),
    !     K=1,NBSL(ISA)),DD,DST0(ISA)
          GO TO 490
      END IF          
      WRITE(KW(1),1061)ISA,NBSA(ISA),IYR,MO,KDA,IY
      CALL SOLIOP
      CALL SOLIOC
  490 IF(ISA==MSA)IPC=IPC+INP
  500 SMM(41,MO,ISA)=SMM(41,MO,ISA)+SGMN
      SMM(44,MO,ISA)=SMM(44,MO,ISA)+SNMN
      SMM(42,MO,ISA)=SMM(42,MO,ISA)+SDN
      SMM(128,MO,ISA)=SMM(128,MO,ISA)+SN2
      SMM(154,MO,ISA)=SMM(154,MO,ISA)+SN2O
      SMM(50,MO,ISA)=SMM(50,MO,ISA)+SMP
      SMM(46,MO,ISA)=SMM(46,MO,ISA)+SVOL
      SMM(45,MO,ISA)=SMM(45,MO,ISA)+SNIT
      SMM(13,MO,ISA)=SMM(13,MO,ISA)+QVOL(IDO)
      SMM(30,MO,ISA)=SMM(30,MO,ISA)+YSD(1,IDO)
      SMMR(1,MO)=SMMR(1,MO)+WSAX*QVOL(IDO)
      WYLD(IDO)=10.*SALA(ISA)*(QVOL(IDO)+RSSF(IDO)+QRF(IDO)+SST(IDO)+QDR(IDO)+CPVH(IDO))
      VARH(34,IDO)=WYLD(IDO)
      VARH(35,IDO)=WYLD(IDO)/86400.
      VAR(117,ISA)=WYLD(ISA)
      SMM(117,MO,ISA)=SMM(117,MO,ISA)+WYLD(IDO)
      SMMH(35,MO,IDO)=SMMH(35,MO,IDO)+VARH(35,IDO)
      SMMH(34,MO,IDO)=SMMH(34,MO,IDO)+WYLD(IDO)
      IF(IPTS(ISA)>0)THEN
	      I=IPSO(ISA)
	      WYLD(IDO)=WYLD(IDO)+PSOQ(I)
          YSD(NDRV,IDO)=YSD(NDRV,IDO)+PSOY(I)/WSAX
		  QN(IDO)=QN(IDO)+PSO3(I)/WSAX
		  QP(IDO)=QP(IDO)+PSSP(I)/WSAX
		  YN(IDO)=YN(IDO)+PSON(I)/WSAX
		  YP(IDO)=YP(IDO)+PSOP(I)/WSAX
	  END IF
      SMMR(2,MO)=SMMR(2,MO)+.1*WYLD(IDO)
      !WYLD(IDO)=WYLD(IDO)*10.*SALA(ISA)/WSAX
      SMMR(3,MO)=SMMR(3,MO)+WSAX*YSD(NDRV,IDO)
      SMMR(4,MO)=SMMR(4,MO)+WSAX*(YN(IDO)+YNOU(IDO))
      SMMR(5,MO)=SMMR(5,MO)+WSAX*(YP(IDO)+YPOU(IDO))
      TNYL(IDO)=WSAX*(QN(IDO)+RSFN(IDO)+QRFN(IDO)+QDRN(IDO))
      SMMR(6,MO)=SMMR(6,MO)+TNYL(IDO)
      SMMR(7,MO)=SMMR(7,MO)+WSAX*QP(IDO)
      SMMR(8,MO)=SMMR(8,MO)+WSAX*YMNU(IDO)
	  SMMR(9,MO)=SMMR(9,MO)+WSAX*QPU(IDO)
	  SMMR(10,MO)=SMMR(10,MO)+WSAX*YC(IDO)
      DO K=1,NDP
          SMMRP(1,K,MO)=SMMRP(1,K,MO)+WSAX*(QPST(K,IDO)+TSPS(K,IDO)&
          +RSPS(K,IDO))
          SMMRP(2,K,MO)=SMMRP(2,K,MO)+WSAX*YPST(K,IDO)
      END DO
      SMM(38,MO,ISA)=SMM(38,MO,ISA)+QN(IDO)
      SMM(40,MO,ISA)=SMM(40,MO,ISA)+VNO3(LNS,ISA)
      SMM(49,MO,ISA)=SMM(49,MO,ISA)+QP(IDO)
      SMM(39,MO,ISA)=SMM(39,MO,ISA)+TSFN(IDO)
	  SMM(108,MO,ISA)=SMM(108,MO,ISA)+QPU(IDO)
	  SMM(131,MO,ISA)=SMM(131,MO,ISA)+TSFS 
	  SMM(151,MO,ISA)=SMM(151,MO,ISA)+TSFK(IDO)
      !CALL NCONT
      IF(IDA==IGSD+NT1)THEN
          IGN=IGN+100
          DO KK=1,IGN
              DO J=1,12
                  XX=AUNIF(13)
                  IX(J)=IX(13)
              END DO
          END DO
      END IF
      IF(YERO>.001.AND.ISTA==0.AND.Z(LID(NBSL(ISA),ISA),ISA)>ZF.AND.&
      NBSL(ISA)>=3)CALL ESLOS(JRT)
      JDA=IDA+1
      RETURN
  154 FORMAT(1X,2I8,1X,3I4,6X,100F10.4)
  !154 FORMAT(1X,2I8,1X,3I4,6X,A4,100F10.4)      
  589 FORMAT(5X,'^^^^^',2I8,3I4,' PDSW = ',E13.5,1X,'PDAW = ',E13.5)
  950 FORMAT(1X,2I8,1X,3I4,1X,A4,2X,'GERMINATION--0.2 M SW = ',F7.0,' mm',&
      2X,'HU = ',F6.0,'c',2X,'HUSC = ',F5.2)
  970 FORMAT(1X,2I8,1X,I4,2I2,2X,'RB FR DK',20X,'DKH = ',F6.0,' mm',2X,&
      'DKI = ',F7.2,'m',2X,'HUSC = ',F5.2)
 1061 FORMAT(35X,'SUBAREA NO=',I8,' ID=',I8,' DATE=',I4,2I2,' YR#=',I4)
 1090 FORMAT(/1X,2I8,1X,I4,2I2,2X,5(1X,A4,F8.2)/(19X,5(1X,A4,F8.2)))
 1140 FORMAT(1X,2I8,1X,I4,2I2,2X,'SOL N FERT = ',F5.0,'kg/ha',2X,'IRR&
       VOL',' = ',F5.0,' mm',2X,'HUSC = ',F5.2)
 1201 FORMAT((19X,5(1X,A4,F8.2)))
 1202 FORMAT(2I8,1X,3I4,25F10.2)
      END
