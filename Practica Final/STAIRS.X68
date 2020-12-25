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
            MOVE.B  #0, (KEYOBTEINED)
            BRA     .END
.NOKEY      ; SAME POSITION NO KEY

            MOVE.W  #81, D0                      ; SET FILL CALL
            MOVE.L  #00000000, D1               ; SET FILL COLOR
            TRAP    #15

            LEA     NOKEYSTRING, A1
            MOVE.W  #SCRWIDTH/2-100, D1
            MOVE.W  #SCRHEIGH/8, D2

            MOVE.W #95, D0
            TRAP    #15

.END
            MOVEM.L (A7)+, D0-D1
            RTS
            RTS
STAIRSPLOT          ; LIGHT FILLED CIRCLE
           
            MOVEM.L D0-D4, -(A7)
            MOVE.B  #80, D0                     ; SET PEN CALL
            MOVE.L  #TILELIGH, D1               ; SET PEN COLOR
            TRAP    #15        

            ADDQ.W  #1, D0                      ; SET FILL CALL
            MOVE.L  #TILELIGH, D1               ; SET FILL COLOR
            TRAP    #15                 
            
            MOVE.W  (STAIRSX), D1               ; D1 = X CENTER
            MOVE.W  (STAIRSY), D2               ; D1 = Y CENTER
            MOVE.W  D1, D3
            MOVE.W  D2, D4
            SUB.W   #TILEDIM/2, D1              ; SET TOP LEFT CORNER
            SUB.W   #TILEDIM/2, D2              ; SET TOP LEFT CORNER 
            ADD.W   #TILEDIM/2, D4              ; SET LOW RIGHT CORNER
            ADD.W   #TILEDIM/2, D3              ; SET LOW RIGHT CORNER
            
            CMP.B  #1, (KEYOBTEINED)
            BEQ     .KEYOBTEINED
            MOVE.W  #88, D0
            TRAP    #15

            MOVEM.L (A7)+,D0-D4

            RTS
.KEYOBTEINED
            MOVE.W  #91, D0
            TRAP    #15

            MOVEM.L (A7)+,D0-D4
            RTS


