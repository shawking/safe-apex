      SUBROUTINE NKMIN
!     APEX1501
!     THIS SUBPROGRAM COMPUTES K FLUX BETWEEN THE WATER SOLUBLE,
!     EXCHANGEABLE, & FIXED POOLS
      USE PARM
      RSE=(SOLK(ISL,ISA)-EXCK(ISL,ISA)*EQKS(ISL,ISA))*PRMT(98)
      REF=(EXCK(ISL,ISA)-FIXK(ISL,ISA)*EQKE(ISL,ISA))*PRMT(99)
      SOLK(ISL,ISA)=MAX(.0001,SOLK(ISL,ISA)-RSE)
      EXCK(ISL,ISA)=MAX(.0001,EXCK(ISL,ISA)+RSE-REF)
      FIXK(ISL,ISA)=FIXK(ISL,ISA)+REF
      RETURN
      END