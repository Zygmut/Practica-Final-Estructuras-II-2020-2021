;-------------------------------------------------------
MAPPLOT
; DES	:	PLOTS MAP BORDERS
; IN 	: 	NONE
; OUT	:	NONE
; MOD	:	NONE
;-------------------------------------------------------
        MOVEM.L D0-D4, -(A7)
        
        UTILPEN #TILEDARK
        UTILFILL #TILEDARK

        CLR     D1                          ; LEFT BORDER
        CLR     D2                      
        MOVE.W  #79, D3
        MOVE.W  #SCRHEIGH, D4
        MOVE.W  #87, D0
        TRAP    #15

        MOVE.W  #561, D1                    ; RIGHT BORDER                                
        MOVE.W  #SCRWIDTH, D3
        TRAP    #15
        
        MOVEM.L (A7)+,D0-D4

        RTS
