; =============================================================================
; TITLE    : PLAYER MANAGER
; AUTHOR   : 
; COMMENTS : 
; =============================================================================


PLAYERINIT
            MOVE.W #SCRWIDTH/2, (PLAYERX)       ; SET PLAYER TO CENTER
            MOVE.W #SCRHEIGH/2, (PLAYERY)       ; SET PLAYER TO CENTER
            RTS

PLAYERUPDT
            BTST.B  #KBDBITLF, (KBDVAL)         ; LEFT KEY PRESSED
            BNE     .MOVEL
            BTST.B  #KBDBITRT, (KBDVAL)         ; RIGHT KEY PRESSED
            BNE     .MOVER
            BTST.B  #KBDBITUP, (KBDVAL)         ; UP KEY PRESSED
            BNE     .MOVEU
            BTST.B  #KBDBITDN, (KBDVAL)         ; DOWN KEY PRESSED
            BNE     .MOVED
            RTS
.MOVEL
            CMP.W   #TILEDIM/2+(SCRWIDTH-SCRHEIGH), (PLAYERX)       ; LEFT BOUNDARY
            BGT     .RMVEL
            RTS
.RMVEL
            SUB.W   #TILEDIM, (PLAYERX)         ; MOVE LEFT
            RTS

.MOVER
            CMP.W   #SCRHEIGH-1-TILEDIM/2, (PLAYERX)    ; RIGHT BOUNDARY
            BLT     .RMVER
            RTS
.RMVER
            ADD.W   #TILEDIM, (PLAYERX)         ; MOVE RIGHT
            RTS

.MOVEU
            CMP.W   #TILEDIM/2, (PLAYERY)       ; TOP BOUNDARY
            BGT     .RMVEU
            RTS
.RMVEU
            SUB.W   #TILEDIM, (PLAYERY)         ; MOVE UP
            RTS

.MOVED
            CMP.W   #SCRHEIGH-1-TILEDIM/2, (PLAYERY)    ; BOTTOM BOUNDARY
            BLT     .RMVED
            RTS
.RMVED
            ADD.W   #TILEDIM, (PLAYERY)         ; MOVE DOWN
            RTS

PLAYERPLOT
            MOVEM.L D0-D4, -(A7)
            MOVE.B  #80, D0                     ; SET PEN CALL
            MOVE.L  #TILELIGH, D1               ; SET PEN COLOR
            TRAP    #15                         
            
            ADDQ.W  #1, D0                      ; SET FILL CALL
            MOVE.L  #TILELIGH, D1               ; SET FILL COLOR
            TRAP    #15
            
            MOVE.W  (PLAYERX), D1               ; D1 = X CENTER
            MOVE.W  (PLAYERY), D2               ; D1 = Y CENTER
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
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
