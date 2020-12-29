STAIRSINIT          ; RANDOM POSTION
            MOVE.L D0, -(A7)
            JSR     RNGX
            MOVE.W  D0, (STAIRSX)
            JSR     RNGY
            MOVE.W  D0, (STAIRSY)
            MOVE.L  (A7)+, D0
            RTS
STAIRSUPDT          ; NOTHING
            MOVEM.L D0-D1, -(A7)
            MOVE.W  (STAIRSX), D0
            CMP.W   (PLAYERX), D0
            BNE     .END
            MOVE.W  (STAIRSY), D0
            CMP.W   (PLAYERY), D0
            BNE     .END
            ; THE PLAYER IS IN THE POSITION OF THE STAIRS
            CMP.B   #1, (KEYOBTEINED)
            BNE     .NOKEY
            JSR     KEYINIT
            JSR     STAIRSINIT
            JSR     ENEMYINIT
            MOVE.B  #0, (KEYOBTEINED)
            ADDQ.W  #1, (LEVEL)
            BRA     .END
.NOKEY      ; SAME POSITION NO KEY

            MOVE.W  #81, D0                      ; SET FILL CALL
            MOVE.L  #0, D1                       ; SET FILL COLOR
            TRAP    #15

            UTILTEXT NOKEYSTRING, #SCRWIDTH/2-100, #SCRHEIGH/8  
            
.END
            MOVEM.L (A7)+, D0-D1
            RTS
            
STAIRSPLOT          ; LIGHT FILLED CIRCLE
           
            MOVEM.L D0-D4, -(A7)
                    
            UTILPEN #TILELIGH
            UTILFILL #TILELIGH 
                            
            CMP.B   #1, (KEYOBTEINED)
            BEQ     .KEYOBTEINED
            UTILTILE #88, (STAIRSX), (STAIRSY)
            BRA     .END
.KEYOBTEINED
            UTILTILE #91, (STAIRSX), (STAIRSY)

.END
            MOVEM.L (A7)+,D0-D4
            RTS


