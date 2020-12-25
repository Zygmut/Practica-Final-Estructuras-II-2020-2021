MAPINIT
        RTS      
MAPUPDT
        RTS
MAPPLOT
        MOVEM.L D0-D4, -(A7)

        MOVE.B  #80, D0                     ; SET PEN CALL
        MOVE.L  #TILEDARK, D1               ; SET PEN COLOR
        TRAP    #15                         
            
        ADDQ.W  #1, D0                      ; SET FILL CALL
        MOVE.L  #TILEDARK, D1               ; SET FILL COLOR
        TRAP    #15

        CLR     D1                          ; LEFT BORDER
        CLR     D2                      
        MOVE.W  #79, D3
        MOVE.W  #SCRHEIGH, D4
        MOVE.W  #87, D0
        TRAP    #15

        MOVE.W  #561, D1                    ; RIGHT BORDER                                
        MOVE.W  #SCRWIDTH, D3
        TRAP    #15

        CLR     D0
        CLR     D1

        MOVE.B  #80, D0                     ; SET PEN CALL
        MOVE.L  #TILEDETA, D1               ; SET PEN COLOR
        TRAP    #15                         
            
        ADDQ.W  #1, D0                      ; SET FILL CALL
        MOVE.L  #TILEDETA, D1               ; SET FILL COLOR
        TRAP    #15

        MOVE.W  #145, D1                    ; FLOOR                      
        MOVE.W  #495, D3
        TRAP    #15
        MOVEM.L (A7)+,D0-D4

        RTS