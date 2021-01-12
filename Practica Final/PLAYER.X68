; =============================================================================
; TITLE    : PLAYER MANAGER
; AUTHOR   : RUBEN PALMER PEREZ 
; COMMENTS : 
; =============================================================================

;---------------------------------------------------------------------
PLAYERINIT
; DES	:	INIT METHOD FOR THE PLAYER. SET PLAYER TO CENTER
; IN 	:	NONE
; OUT	:	NONE
; MOD	:	(PLAYERX) WITH X COORDINATE
;		(PLAYERY) WITH Y COORDINATE
;---------------------------------------------------------------------
            MOVE.W #SCRWIDTH/2, (PLAYERX)       ; SET PLAYER TO CENTER
            MOVE.W #SCRHEIGH/2, (PLAYERY)       ; SET PLAYER TO CENTER
            RTS

;---------------------------------------------------------------------
PLAYERUPDT  
; DES	:	CHECKS IF PLAYER HAS TO MOVE SOMEWHERE
; IN	:	NONE
; OUT 	:	NONE
; MOD	:	(PLAYERX)||(PLAYERY) DEPENDS ON MOVEMENT
;---------------------------------------------------------------------

            BTST.B  #0, (SCRCYCCT)
            BNE     .END  
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
.END
            RTS

;-------------------------------------------------------------------
PLAYERPLOT
; DES	:	PLOTS THE PLAYER GRAPHICS
; IN	:	NONE
; OUT	:	NONE
; MOD	:	NONE
;-------------------------------------------------------------------
            MOVEM.L D0-D4, -(A7)
            UTILPEN #TILELIGH                         

            UTILFILL #TILELIGH
            
            UTILTILE #87, (PLAYERX), (PLAYERY)
            MOVEM.L (A7)+,D0-D4
            RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
