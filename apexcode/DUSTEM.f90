      SUBROUTINE DUSTEM
!     APEX1501
!     THIS SUBPROGRAM ESTIMATES THE PARTICULATE MATTER(DUST) EMISSION
!     RATE FROM FEEDYARDS.
      USE PARM
      LD1=LID(1,ISA)
      DEMR=32.*NCOW(IDFH(ISA),IDON(ISA))
      IF(STLT(ISA)>FC(LD1,ISA)-S15(LD1,ISA))THEN
          RTO=800.*SWLT(ISA)/RSD(LD1,ISA)
      ELSE
          RTO=10.*SWST(LD1,ISA)
      END IF
      F=1.-RTO/(RTO+EXP(SCRP(19,1)-SCRP(19,2)*RTO))
      DEMR=.001*DEMR*F
      EM10(ISA)=EM10(ISA)+DEMR
      SMM(93,MO,ISA)=SMM(93,MO,ISA)+DEMR
      RETURN
      END      