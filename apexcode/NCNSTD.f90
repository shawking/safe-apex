      SUBROUTINE NCNSTD(X1,X2,JSL)
!     THIS SUBPROGRAM REMOVES C AND N FROM STANDING RESIDUE AND ADDS IT
!     TO THE TOP SOIL LAYER AS A RESULT OF A TILLAGE OPERATION.
      USE PARM
      RLN=1000.*STDL(JJK,ISA)/(STDN(JJK,ISA)+1.E-5)
      RLR=MIN(.8,STDL(JJK,ISA)/(STD(JJK,ISA)+1.E-5))
      X7=1000.*X1
      C7=.42*X7
      SMS(7,JSL,ISA)=SMS(7,JSL,ISA)+C7
      SMM(73,MO,ISA)=SMM(73,MO,ISA)+C7
      VAR(73,ISA)=VAR(73,ISA)+C7
      RCN=420.*STD(JJK,ISA)/(STDN(JJK,ISA)+1.E-5)
      X8=.85-.018*RLN
      IF(X8<.01)THEN
          X8=.01
      ELSE
          IF(X8>.7)X8=.7
      END IF    
      XX=X7*X8
      Y1=WLM(JSL,ISA)+XX
	  IF(Y1>0.)THEN
	      WLM(JSL,ISA)=Y1
          Y2=XX
      ELSE
	      Y2=-WLM(JSL,ISA)
          WLM(JSL,ISA)=1.E-5
	  END IF    
      XZ=X7-Y2
      WLS(JSL,ISA)=MAX(1.E-5,WLS(JSL,ISA)+XZ)
      WLSL(JSL,ISA)=MAX(1.E-5,WLSL(JSL,ISA)+XZ*RLR)
      X6=X2
      XY=.42*XZ
      WLSC(JSL,ISA)=MAX(1.E-5,WLSC(JSL,ISA)+XY)
      WLSLC(JSL,ISA)=MAX(1.E-5,WLSLC(JSL,ISA)+XY*RLR)
      WLSLNC(JSL,ISA)=WLSC(JSL,ISA)-WLSLC(JSL,ISA)
      X3=MIN(X6,XY/150.)
	  Y1=WLSN(JSL,ISA)+X3
	  IF(Y1>0.)THEN
	      Y2=X3
          WLSN(JSL,ISA)=Y1
	  ELSE
	      Y2=-WLSN(JSL,ISA)
	      WLSN(JSL,ISA)=1.E-5
	  END IF
	  WLMN(JSL,ISA)=MAX(1.E-5,WLMN(JSL,ISA)+X6-Y2)
      WLMC(JSL,ISA)=MAX(1.E-5,WLMC(JSL,ISA)+.42*XX)      
      RSD(JSL,ISA)=.001*(WLS(JSL,ISA)+WLM(JSL,ISA))
      ARSD(ISA)=ARSD(ISA)+X1
      RETURN
      END


     