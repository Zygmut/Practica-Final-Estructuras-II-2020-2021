LIFEINIT
        MOVE.W  #3, (PLAYERL)   ; SET PLAYER LIVES TO X, IN THIS CASE 3+
        RTS
LIFEUPDT
        CMP.W   #0, (PLAYERL)   ; CHECK IF THE PLAYER IS DEAD
        BEQ     DEATH
        RTS

DEATH      ; PLAYER HAS 0 LIVES

            ; -- BLACK SQUARE ---
        UTILPEN #0                       
        UTILFILL #0

        MOVE.W  #0, D1               ; D1 = X CENTER
        MOVE.W  #0, D2               ; D1 = Y CENTER
        MOVE.W  #SCRWIDTH, D3
        MOVE.W  #SCRHEIGH, D4

        MOVE.W  #87, D0
        TRAP    #15

        ; --- TEXT ---
        UTILFILL #0

        UTILTEXT DEATHSTRING, #SCRWIDTH/2-230, #SCRHEIGH/3

        UTILTEXT SUSSERTOD, #SCRWIDTH/2-230, #SCRHEIGH/2

        TRAP    #SCRTRAP                ; SHOW GRAPHICS
        JSR     LOOSE