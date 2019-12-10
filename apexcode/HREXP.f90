      SUBROUTINE HREXP
!     APEX1501
!     THIS SUBPROGRAM DISTRIBUTES DAILY RAINFALL EXPONENTIALLY &
!     FURNISHES THE GREEN & AMPT SUBPROGRAM RAIN INCREMENTS OF EQUAL
!     VOLUME = DRFV
      USE PARM
      DRFV=MIN(5.,.1*RFV(IRF(ISA)))
      RFX=RFV(IRF(ISA))
      PT=DRFV
      RX=0.
      DO WHILE(PT<RTP)
          RX=REP*(1.-(RTP-PT)/XKP1)
          CALL HGASP(DRFV,PT,Q1,RX)
          PT=PT+DRFV
      END DO
      A=RTP-PT+DRFV
      PT=RTP
      RX=REP
      CALL HGASP(A,PT,Q1,RX)
      PT=PT+DRFV
      DO WHILE(PT<RFX)
          RX=REP*(1.-(PT-RTP)/XKP2)
          CALL HGASP(DRFV,PT,Q1,RX)
          PT=PT+DRFV
      END DO
      RX=0.
      A=RFX-PT+DRFV
      PT=RFX
      CALL HGASP(A,PT,Q1,RX)
      RETURN
      END