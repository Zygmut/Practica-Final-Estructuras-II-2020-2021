; ----------------------------------------------------------------------------- 
MISCPLOT
; DES	:	PLOTS ALL MISC PROCEDURES
; IN 	:	NONE
; OUT	:	NONE
; MOD	:	NONE
;------------------------------------------------------------------------------
        JSR .LVLPLOT
        JSR .NOOKEYPLOT
        RTS

;------------------------------------------------------------------------------
.LVLPLOT
; DES	:	PLOTS LEVEL COUNTER ON THE TOP LEFT CORNER
; IN	:	NONE
; OUT	:	NONE
; MOD	:	NONE
;------------------------------------------------------------------------------
        MOVEM.L D0-D2/A1, -(A7)
        
        UTILFILL #00000000      

        LEA     LEVELSTRING, A1
        CLR.L   D1
        MOVE.W  (LEVEL), D1
        MOVE.B  #17,D0
        TRAP    #15
        
        MOVEM.L (A7)+, D0-D2/A1
        RTS 
;------------------------------------------------------------------------------
.NOOKEYPLOT
; DES	:	PLOTS A TEXT IF PLAYER IS ON STAIRS AND HAS NO KEY
; IN	:	NONE
; OUT	:	NONE
; MOD	:	NONE
;------------------------------------------------------------------------------
        CMP     #1, (ONSTAIRS)
        BNE     .END     
        MOVEM.L D0-D2/A1, -(A7)
        UTILTEXT NOKEYSTRING, #SCRWIDTH/2-100, #SCRHEIGH/8  
        MOVEM.L (A7)+, D0-D2/A1
.END        
        RTS
