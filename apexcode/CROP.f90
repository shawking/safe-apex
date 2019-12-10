      SUBROUTINE CROP
!     APEX1501
!     THIS SUBPROGRAM PREDICTS DAILY POTENTIAL GROWTH OF TOTAL PLANT
!     BIOMASS AND ROOTS.
      USE PARM
      IF(ROSP(ISA)>0.)THEN
          XX=.685-.209*ROSP(ISA)
      ELSE
          XX=EXTC(JJK)
      END IF
      PAR=.0005*SRAD(IRF(ISA))*(1.-EXP(-XX*SLAI(JJK,ISA)))
      X1=MAX(VPD-1.,-.5)
      XX=WA(JJK)-WAVP(JJK)*X1
      DDM(JJK)=MAX(0.,XX*PAR)
      DM(JJK,ISA)=DM(JJK,ISA)+DDM(JJK)
      RETURN
      END