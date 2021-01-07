;   LOCAL VARIABLES:
;       XCENTER -   (A0)    WORD
;       YCENTER -   2(A0)   WORD
;       ID      -   

ENEMYINIT
                 
            MOVEM.L  D0-D1, -(A7)
            MOVE.W  #1, D1
.CHECKX            
            JSR     RNGX
            MOVE.W  D0, (A0)        ; MOVE X COORDINATE TO (A0) | AGENT CONTROL
          
.CHECKY     JSR     RNGY 
            
            MOVE.W  D0, 2(A0)       ; MOVE Y COORDIANTE TO 2(A0) | AGENT CONTROL

            MOVEM.L  (A7)+, D0-D1
            RTS

ENEMYUPDT
            MOVEM.L D0-D2, -(A7)

            MOVE.W  (A0), D0
            MOVE.W  2(A0), D1
            JSR     UTILCOLL
            CMP.B   #$FF, D2
            BNE     .END
            ; THE PLAYER IS IN THE POSITION OF THE STAIRS  
            
            JSR     DEATH
            
.END
            MOVEM.L (A7)+, D0-D2
            RTS
ENEMYPLOT
            MOVEM.L D0-D4, -(A7)

            UTILPEN #TILEDETA                       
            
            UTILFILL #TILEDETA
            
            UTILTILE #87, (A0), 2(A0)
            
            MOVEM.L (A7)+,D0-D4
            RTS