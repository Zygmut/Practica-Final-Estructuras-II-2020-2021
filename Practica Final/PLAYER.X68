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
            CMP.W   #TILEDIM/2+(SCRWIDTH-SCRHEIGH)-64, (PLAYERX)       ; LEFT BOUNDARY
            BGT     .RMVEL
            RTS
.RMVEL
            SUB.W   #TILEDIM, (PLAYERX)         ; MOVE LEFT
            RTS

.MOVER
            CMP.W   #SCRHEIGH-1-TILEDIM/2+64, (PLAYERX)    ; RIGHT BOUNDARY
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
            UTILPEN #TILELIGH                         

            UTILFILL #TILELIGH
            
            UTILTILE #87, (PLAYERX), (PLAYERY)
            MOVEM.L (A7)+,D0-D4
            RTS

DEATH      ; PLAYER HAS 0 LIVES

            ; -- BLACK SQUARE ---
        UTILPEN #0                       
        UTILFILL #0

        MOVE.W  #0, D1               ; D1 = X CENTER
        MOVE.W  #0, D2               ; D1 = Y CENTER
        MOVE.W  #SCRWIDTH, D3
        MOVE.W  #SCRHEIGH, D4

        MOVE.W  #87, D0
        TRAP    #15

        ; --- TEXT ---
        UTILFILL #0

        UTILTEXT DEATHSTRING, #SCRWIDTH/2-230, #SCRHEIGH/3

        UTILTEXT SUSSERTOD, #SCRWIDTH/2-230, #SCRHEIGH/2

        TRAP    #SCRTRAP                ; SHOW GRAPHICS
        JSR     LOOSE
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
