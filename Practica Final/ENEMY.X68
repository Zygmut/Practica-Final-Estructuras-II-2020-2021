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
            MOVEM.L D0-D1, -(A7)
            MOVE.W  (ENEMYX), D0
            CMP.W   (PLAYERX), D0
            BNE     .END
            MOVE.W  (ENEMYY), D0
            CMP.W   (PLAYERY), D0
            BNE     .END
            ; THE PLAYER IS IN THE POSITION OF THE STAIRS

            MOVE.W  #81, D0                      ; SET FILL CALL
            MOVE.L  #0, D1                       ; SET FILL COLOR
            TRAP    #15

            LEA     DEATHSTRING, A1
            MOVE.W  #SCRWIDTH/2-100, D1
            MOVE.W  #SCRHEIGH/8, D2

            MOVE.W  #95, D0
            TRAP    #15

.END
            MOVEM.L (A7)+, D0-D1
            RTS

ENEMYPLOT
            MOVEM.L D0-D4, -(A7)
            MOVE.B  #80, D0                     ; SET PEN CALL
            MOVE.L  #TILEDETA, D1               ; SET PEN COLOR
            TRAP    #15                         
            
            ADDQ.W  #1, D0                      ; SET FILL CALL
            MOVE.L  #TILEDETA, D1               ; SET FILL COLOR
            TRAP    #15
            
            MOVE.W  (ENEMYX), D1               ; D1 = X CENTER
            MOVE.W  (ENEMYY), D2               ; D1 = Y CENTER
            MOVE.W  D1, D3
            MOVE.W  D2, D4
            SUB.W   #TILEDIM/2, D1              ; SET TOP LEFT CORNER
            SUB.W   #TILEDIM/2, D2              ; SET TOP LEFT CORNER 
            ADD.W   #TILEDIM/2, D4              ; SET LOW RIGHT CORNER
            ADD.W   #TILEDIM/2, D3              ; SET LOW RIGHT CORNER

            MOVE.W  #87, D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D4
            RTS