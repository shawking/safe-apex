      SUBROUTINE SLTB(SLI,SLF,SLL,SLS,SLQ,SLB,SLE,ISA,NBSA,KW,MSO)
!     APEX1501      
!     THIS SUBPROGRAM IS THE SALT BALANCE
      DIMENSION KW(MSO),NBSA(ISA)
      WRITE(KW(1),2)ISA,NBSA(ISA)
      DF=SLB+SLI+SLF-SLL-SLS-SLQ-SLE
      PER=100.*DF/(SLE+.0001)
      WRITE(KW(1),1)PER,DF,SLB,SLI,SLF,SLL,SLS,SLQ,SLE
      RETURN
    1 FORMAT(5X,'PER =',E13.6,2X,'DF  =',E13.6,2X,'BTOT=',E13.6,2X,&
     &'IRR =',E13.6,2X,'FERT=',E13.6,2X,'PRK =',E13.6/5X,'SSF =',E13.6,&
     &2X,'Q   =',E13.6,2X,'FTOT=',E13.6)
    2 FORMAT(/T10,'SALT BALANCE',2X,'SA#= ',I8,1X,'ID= ',I8)
      END