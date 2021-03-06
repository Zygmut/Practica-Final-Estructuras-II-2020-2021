;-----------------------------------------------------------
SHADDERPLOT
; DES	:	PLOTS THE TORCH SHADDER ON CENTERED ON THE PLAYER
; IN	:	NONE
; OUT	:	NONE
; MOD	:	NONE
;-----------------------------------------------------------
            MOVEM.L D0-D4, -(A7)

            UTILPEN #TILEDDARK
            UTILFILL #TILEDDARK


            CLR     D1                          ; LEFT BORDER
            CLR     D2           
            MOVE.W  (PLAYERX), D3       
            MOVE.W  (TORCHRANGE), D5
            MULU.W  #TILEDIM, D5
            ADD.W   #(TILEDIM/2), D5      
            SUB.W   D5, D3
            MOVE.W  #SCRHEIGH, D4
            MOVE.W  #87, D0
            TRAP    #15

                                                ; RIGHT BORDER
              
            MOVE.W  (PLAYERX), D1   
            MOVE.W  (TORCHRANGE), D5
            MULU.W  #TILEDIM, D5
            ADD.W   #(TILEDIM/2), D5 
            ADD.W   D5, D1
            MOVE.W  #SCRWIDTH, D3
            MOVE.W  #87, D0
            TRAP    #15

                                               ; TOP BORDER
              
            CLR     D1
            CLR     D2
            MOVE.W  #SCRWIDTH, D3
            MOVE.W  (PLAYERY), D4 
            MOVE.W  (TORCHRANGE), D5
            MULU.W  #TILEDIM, D5
            ADD.W   #(TILEDIM/2), D5          
            SUB.W   D5, D4     
           
            MOVE.W  #SCRWIDTH, D3
            MOVE.W  #87, D0
            TRAP    #15

                                               ; BOTTOM BORDER
            MOVE.W  (PLAYERY), D2
            MOVE.W  (TORCHRANGE), D5
            MULU.W  #TILEDIM, D5
            ADD.W   #(TILEDIM/2), D5           
            ADD.W   D5, D2     
            MOVE.W  #SCRWIDTH, D3
            MOVE.W  #SCRHEIGH, D4
            MOVE.W  #87, D0
            TRAP    #15

            MOVEM.L (A7)+, D0-D4
            RTS
