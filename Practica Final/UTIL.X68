UTILPEN     MACRO
;   IN:  \1 AS THE COLOR, FORMATED AS #00BBGGRR
;   OUT: NONE
;   MOD: D0, D1    
;   DES: MACRO TO SET PEN COLOR

        MOVE.B  #80, D0 
        MOVE.L  \1, D1
        TRAP    #15
        ENDM

UTILFILL    MACRO
;   IN:  \1 AS THE COLOR, FORMATED AS #00BBGGRR
;   OUT: NONE
;   MOD: D0, D1
;   DES: MACRO TO SET FILL COLOR

        MOVE.B  #81, D0
        MOVE.L  \1, D1
        TRAP    #15
        ENDM

UTILTEXT    MACRO
;   IN:  \1 TEXT 
;        \2 TEXT X
;        \3 TEXT Y
;   OUT: NONE
;   MOD: D0-D2 / A1
;   DES: PRINTS THE 0 TERINATED STRING IN \1 IN COORDINATES \2 \3

        LEA     \1, A1
        MOVE.W  \2, D1
        MOVE.W  \3, D2

        MOVE.W  #95, D0
        TRAP    #15
        ENDM

UTILTILE    MACRO
;   IN:  \1 PROCEDURE OF THE TRAP #15
;        \2 X COORDINATE
;        \3 Y COORDINATE
;   OUT: NONE
;   MOD: D1-D4
;   DES: DRAWS A GRAPHIC AT \2 \3
        MOVE.W  \2, D1               ; D1 = X CENTER
        MOVE.W  \3, D2               ; D1 = Y CENTER
        MOVE.W  D1, D3
        MOVE.W  D2, D4
        SUB.W   #TILEDIM/2, D1              ; SET TOP LEFT CORNER
        SUB.W   #TILEDIM/2, D2              ; SET TOP LEFT CORNER 
        ADD.W   #TILEDIM/2, D3              ; SET LOW RIGHT CORNER
        ADD.W   #TILEDIM/2, D4              ; SET LOW RIGHT CORNER

        MOVE.W  \1, D0
        TRAP    #15
        ENDM

UTILCOLL    
;   IN:  D0 X0 COORDINATE
;        D1 Y0 COORDINATE
;   OUT: D2.B = FF IF COLLISION, 00 ELSEWISE
;   MOD: D2
;   DES: CHECKS IF ELEMENTS 0 AND 1 HAVE THE SAME POSITION 

        CLR     D2
        CMP.W   (PLAYERX), D0   ; COMPARE X COORDINATES
        BNE .NOCOL
        CMP.W   (PLAYERY), D1   ; COMPARE Y COORDINATES
        BNE .NOCOL
        MOVE.B  #$FF, D2
.NOCOL
        RTS
        
LVLPLOT
        MOVEM.L D0-D2/A1, -(A7)
        
        UTILFILL #TILEDARK      

        LEA     LEVELSTRING, A1
        CLR.L   D1
        MOVE.W  (LEVEL), D1
        MOVE.B  #17,D0
        TRAP    #15
        
        MOVEM.L (A7)+, D0-D2/A1
        RTS 

    