; =============================================================================
; TITLE    : CUBE MANAGEMENT (AGENT)
; AUTHOR   :
; COMMENTS : BALL AGENT LOCAL VARIABLE:
;           (A0) X1,  2(A0) Y1     - CUBE LOCADE UP   - 2 WORD
;           4(A0) X2, 6(A0) Y2     - CUBE LOCADE DOWN - 2 WORD
; HISTORY  :
; =============================================================================
;------------------------------------------------------------------------------
CUBINIT
; INITILIZE A CUBE
; INPUT -  D0,D1 (ONE LONG WITH THE FIRST LOCATION)
; OUTPUT - NONE
; MODIFIES -NONE
;------------------------------------------------------------------------------
    MOVE.L D0/D1, -(A7)
    MOVE.W D0,(A0)       ; LOC FIRST X   
    MOVE.W D1, 2(A0)     ; LOC FIRST Y
    ADD.W #45,D0
    ADD.W #45,D1 
    MOVE.W D0,4(A0)      ; LOC SECOND X                
    MOVE.W D1,6(A0)      ; LOC SECOND Y
    MOVE.L (A7)+, D0/D1
    RTS
;------------------------------------------------------------------------------
;CUBUPD
; INITILIZE A CUBE
; INPUT -  NONE
; OUTPUT - NONE
; MODIFIES -NONE
;------------------------------------------------------------------------------

    RTS
;------------------------------------------------------------------------------
CUBPLOT
; INITILIZE A CUBE
; INPUT -  NONE
; OUTPUT - NONE
; MODIFIES -NONE
;------------------------------------------------------------------------------
    RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
