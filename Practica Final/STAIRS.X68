STAIRSINIT          ; RANDOM POSTION
            MOVE.L D0, -(A7)
            JSR     RNGX
            MOVE.W  D0, (STAIRSX)
            JSR     RNGY
            MOVE.W  D0, (STAIRSY)
            MOVE.L  (A7)+, D0
            CLR     ONSTAIRS
            RTS
STAIRSUPDT          
            MOVEM.L D0-D2/A1-A3, -(A7)
            MOVE.W  (STAIRSX), D0
            MOVE.W  (STAIRSY), D1
            JSR     UTILCOLL
            CMP.B   #$FF, D2
            BNE     .ENDD
            
            ; THE PLAYER IS IN THE POSITION OF THE STAIRS
            CMP.B   #1, (KEYOBTEINED)
            BNE     .NOKEY
            JSR     KEYINIT
            JSR     STAIRSINIT

; CREATE ENEMIES BASED ON LEVEL 
            CLR.L   D0
            MOVE.W  #ENEMYID, D0
            JSR     AGLFKIL     ; KILLS ALL AGENTS WITH ID       
            MOVE.W (LEVEL), D1
            
.ENEMYADD
            LEA     ENEMYINIT, A1
            LEA     ENEMYUPDT, A2
            LEA     ENEMYPLOT, A3
            MOVE.W  #ENEMYID, D0
            
            JSR     AGLADD
            DBRA.W    D1, .ENEMYADD

            MOVE.B  #0, (KEYOBTEINED)
            ADDQ.W  #1, (LEVEL)
            BRA     .END
.NOKEY      ; SAME POSITION NO KEY
            MOVE.W  #1, (ONSTAIRS)
            BRA     .END
            
.ENDD
            CLR     ONSTAIRS
.END
            
            MOVEM.L (A7)+, D0-D2/A1-A3
            RTS
            
STAIRSPLOT          
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


