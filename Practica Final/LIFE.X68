LIFEINIT
        MOVE.W  #3, (PLAYERL)   ; SET PLAYER LIVES TO X, IN THIS CASE 3+
        RTS
LIFEUPDT
        CMP.W   #0, (PLAYERL)   ; CHECK IF THE PLAYER IS DEAD
        BEQ     DEATH
        RTS

DEATH      ; PLAYER HAS 0 LIVES

            ; -- BLACK SQUARE ---
        MOVE.B  #80, D0                     ; SET PEN CALL
        MOVE.L  #0, D1               ; SET PEN COLOR
        TRAP    #15                         
        
        ADDQ.W  #1, D0                      ; SET FILL CALL
        MOVE.L  #0, D1               ; SET FILL COLOR
        TRAP    #15
        
        MOVE.W  #0, D1               ; D1 = X CENTER
        MOVE.W  #0, D2               ; D1 = Y CENTER
        MOVE.W  #SCRWIDTH, D3
        MOVE.W  #SCRHEIGH, D4

        MOVE.W  #87, D0
        TRAP    #15

        ; --- TEXT ---
        MOVE.W  #81, D0                      ; SET FILL CALL
        MOVE.L  #0, D1                       ; SET TEXT FILL COLOR
        TRAP    #15

        LEA     DEATHSTRING, A1
        MOVE.W  #SCRWIDTH/2-230, D1             ; CENTER 
        MOVE.W  #SCRHEIGH/3, D2             ; CENTER

        MOVE.W  #95, D0
        TRAP    #15

        LEA     SUSSERTOD, A1
        MOVE.W  #SCRWIDTH/2-230, D1             ; CENTER 
        MOVE.W  #SCRHEIGH/2, D2             ; CENTER

        MOVE.W  #95, D0
        TRAP    #15

        TRAP    #SCRTRAP                ; SHOW GRAPHICS
        JSR     LOOSE