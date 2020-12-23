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
    ADD.W #CUBCOS,D0
    ADD.W #CUBCOS,D1 
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
    MOVE.L D0/D1/D2/D3/D4, -(A7)
    MOVE.B #80,D0
    MOVE.L #CUBCOLP,D1
    TRAP #15
    
    MOVE.W (A0), D1
    MOVE.W 2(A0), D2
    MOVE.W 4(A0), D3
    MOVE.W 6(A0), D4
    
    MOVE.B #88, D0
    TRAP #15
    MOVE.L (A7)+, D0/D1/D2/D3/D4
    RTS
    RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
