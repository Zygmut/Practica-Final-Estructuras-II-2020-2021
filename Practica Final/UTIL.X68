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
;   MOD: D0, D1, D2, A1
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
;   DES: DRAWS 
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
;   IN:  D0.W X0 COORDINATE
;        D1.W Y0 COORDINATE
;        D2.W X1 COORDINATE
;        D3.W Y1 COORDINATE
;   OUT: D0.B = FF IF COLLISION, 00 ELSEWISE
;   MOD: NONE
;   DES: CHECKS IF ELEMENTS 0 AND 1 HAVE THE SAME POSITION 

        MOVEM.W D4-D7,-(A7)
        ADD.W   D0,D4
        CMP.W   D2,D4
        BLE     .NOCOL
        ADD.W   D2,D5
        CMP.W   D0,D5
        BLE     .NOCOL
        ADD.W   D1,D6
        CMP.W   D3,D6
        BLE     .NOCOL
        ADD.W   D3,D7
        CMP.W   D1,D7
        BLE     .NOCOL
        MOVE.B  #$FF,D0
        BRA     .END
.NOCOL  CLR.B   D0
.END    MOVEM.W (A7)+,D4-D7
        RTS
        

    