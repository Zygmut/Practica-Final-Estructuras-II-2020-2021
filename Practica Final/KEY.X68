KEYINIT             ; RANDOM POSITION
            MOVE.L D0, -(A7)
            JSR     RNGX
            MOVE.W  D0, (KEYX)
            JSR     RNGY
            MOVE.W  D0, (KEYY)
            MOVE.L  (A7)+, D0
            RTS
KEYUPDT             ; NOTHING
            MOVEM.L D0, -(A7)
            MOVE.W  (KEYX), D0
            CMP.W   (PLAYERX), D0
            BNE     .END
            MOVE.W  (KEYY), D0
            CMP.W   (PLAYERY), D0
            BNE     .END
            MOVE.B  #1, (KEYOBTEINED)           ; THE PLAYER IS IN THE POSITION OF THE KEY
.END
            MOVEM.L (A7)+, D0
            RTS

KEYPLOT             ; LIGHT BORDERED CIRCLE
            CMP.B   #1, (KEYOBTEINED)
            BEQ     .NOKEY
            MOVEM.L D0-D4, -(A7)
            MOVE.B  #80, D0                     ; SET PEN CALL
            MOVE.L  #TILELIGH, D1               ; SET PEN COLOR
            TRAP    #15                         
            
            MOVE.W  (KEYX), D1               ; D1 = X CENTER
            MOVE.W  (KEYY), D2               ; D1 = Y CENTER
            MOVE.W  D1, D3
            MOVE.W  D2, D4
            SUB.W   #TILEDIM/2, D1              ; SET TOP LEFT CORNER
            SUB.W   #TILEDIM/2, D2              ; SET TOP LEFT CORNER 
            ADD.W   #TILEDIM/2, D4              ; SET LOW RIGHT CORNER
            ADD.W   #TILEDIM/2, D3              ; SET LOW RIGHT CORNER

            MOVE.W  #91, D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D4
.NOKEY            
            RTS