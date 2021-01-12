;---------------------------------------------------------------
KEYINIT             
; DES	:	INIT METHOD TO KEY OBJECT
; IN 	: 	NONE
; OUT	: 	NONE
; MOD 	:	(KEYX) WITH X POSITION 
;		(KEYY) WITH Y POSITION
;---------------------------------------------------------------
            MOVE.L D0, -(A7)
            JSR     RNGX
            MOVE.W  D0, (KEYX)
            JSR     RNGY
            MOVE.W  D0, (KEYY)
            MOVE.L  (A7)+, D0
            RTS

;---------------------------------------------------------------
KEYUPDT
; DES	:	SEES IF PLAYER IS ON THE SAME BLOCK AS HIMSELF
; IN 	: 	NONE
; OUT	: 	NONE
; MOD	:	(KEYOBTAINED) IF PLAYER IS IN THE SAME POSITION AS HIMSELF             
;---------------------------------------------------------------
            
	    MOVEM.L D0-D2, -(A7)
           
            MOVE.W  (KEYX), D0
            MOVE.W  (KEYY), D1
            JSR     UTILCOLL
            CMP.B   #$FF, D2
            BNE     .END
            MOVE.B  #1, (KEYOBTEINED)           ; THE PLAYER IS IN THE POSITION OF THE KEY
.END
            MOVEM.L (A7)+, D0-D2
            RTS
;--------------------------------------------------------------
KEYPLOT             
; DES 	:	PLOTS THE KEY GRAPHIC
; IN	: 	NONE
; OUT	:	NONE
; MOD	:	NONE
;--------------------------------------------------------------
            CMP.B   #1, (KEYOBTEINED)
            BEQ     .NOKEY
            MOVEM.L D0-D4, -(A7)
            UTILPEN #TILELIGH

            UTILTILE #91, (KEYX), (KEYY)             
           
            MOVEM.L (A7)+,D0-D4
.NOKEY            
            RTS
