MISCINIT
        RTS
MISCUPDT
        RTS
        
MISCPLOT
        JSR .LVLPLOT
        RTS


.LVLPLOT
        MOVEM.L D0-D2/A1, -(A7)
        
        UTILFILL #TILEDARK      

        LEA     LEVELSTRING, A1
        CLR.L   D1
        MOVE.W  (LEVEL), D1
        MOVE.B  #17,D0
        TRAP    #15
        
        MOVEM.L (A7)+, D0-D2/A1
        RTS 