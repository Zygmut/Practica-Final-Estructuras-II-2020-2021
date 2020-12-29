ENEMYINIT
            MOVE.L  D0, -(A7)
            JSR     RNGX
            CMP.W   (PLAYERX), D0   ;CHECK IF THE ENEMY IS ON THE PLAYER, STAIRS O KEY
            BEQ     PLAYERINIT
            CMP.W   (STAIRSX), D0
            BEQ     PLAYERINIT
            CMP.W   (KEYX), D0
            BEQ     PLAYERINIT
            MOVE.W  D0, (ENEMYX)

.INVALIDY
            JSR     RNGY
            CMP.W   (PLAYERY), D0   ;CHECK IF THE ENEMY IS ON THE PLAYER, STAIRS O KEY
            BEQ     .INVALIDY
            CMP.W   (STAIRSY), D0
            BEQ     .INVALIDY
            CMP.W   (KEYY), D0
            BEQ     .INVALIDY
            MOVE.W  D0, (ENEMYY)

            MOVE.L  (A7)+, D0
            RTS

ENEMYUPDT
            MOVEM.L D0-D2/A1, -(A7)

            MOVE.W  (ENEMYX), D0
            CMP.W   (PLAYERX), D0
            BNE     .END
            MOVE.W  (ENEMYY), D0
            CMP.W   (PLAYERY), D0
            BNE     .END
            ; THE PLAYER IS IN THE POSITION OF THE STAIRS  
            
            JSR     DEATH
            
.END
            MOVEM.L (A7)+, D0-D2/A1
            RTS
ENEMYPLOT
            MOVEM.L D0-D4, -(A7)

            UTILPEN #TILEDETA                       
            
            UTILFILL #TILEDETA
            
            UTILTILE #87, (ENEMYX), (ENEMYY)
            
            MOVEM.L (A7)+,D0-D4
            RTS