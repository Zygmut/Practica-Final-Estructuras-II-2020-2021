;   LOCAL VARIABLES:
;       XCENTER -   (A0)    WORD
;       YCENTER -   2(A0)   WORD
;       ID      -   
;------------------------------------------------------------------------------
ENEMYINIT
; DES	:	ENEMY INIT
; IN	: 	NONE
; OUT	:	NONE
; MOD	:	(A0) WITH X COORDINATE
;		2(A0) WITH Y COORDINATE
;------------------------------------------------------------------------------
                 
            MOVEM.L  D0, -(A7)
		; move.w #1, d1 ????            
            JSR     RNGX
            MOVE.W  D0, (A0)        ; MOVE X COORDINATE TO (A0) | AGENT CONTROL
            JSR     RNGY 
            MOVE.W  D0, 2(A0)       ; MOVE Y COORDIANTE TO 2(A0) | AGENT CONTROL

            MOVEM.L  (A7)+, D0
            RTS

;------------------------------------------------------------------------------
ENEMYUPDT
; DES	:	ENEMY UPDATE. SEES IF PLAYER IS IN THE SAME BLOCK AS HIMSELF
; IN 	:	NONE
; OUT	:	NONE
; MOD	:	(STANEXT) IN CASE PLAYER IS IN THE SAME BLOCK AS HIMSELF
;------------------------------------------------------------------------------

            MOVEM.L D0-D2, -(A7)

            MOVE.W  (A0), D0
            MOVE.W  2(A0), D1
            JSR     UTILCOLL
            CMP.B   #$FF, D2
            BNE     .END
            ; THE PLAYER IS IN THE POSITION OF THE STAIRS  
            MOVE.W  #STADM, (STANEXT)
.END
            MOVEM.L (A7)+, D0-D2
            RTS
;------------------------------------------------------------------------------
ENEMYPLOT
; DES	:	ENEMY PLOT
; IN 	:	NONE
; OUT	:	NONE
; MOD	:	NONE
;------------------------------------------------------------------------------
            MOVEM.L D0-D4, -(A7)

            UTILPEN #TILEDETA                       
            UTILFILL #TILEDETA
            UTILTILE #87, (A0), 2(A0)
            
            MOVEM.L (A7)+,D0-D4
            RTS

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
