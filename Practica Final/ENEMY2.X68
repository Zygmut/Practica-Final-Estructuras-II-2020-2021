ENEMYINIT
        MOVEM.L D0-D1/A0, -(A7)
        MOVE.W  (LEVEL), D1
        BEQ     .END
        SUBQ    #1, D1
        MOVE.W  ENEMYPOSV, A0
        
        ;CREATES ALL ENEMY POSITIONS
.LOOP   
        JSR     RNGX
        CMP.W   (PLAYERX), D0   ;CHECK IF THE ENEMY IS ON THE PLAYER, STAIRS O KEY
        BEQ     .LOOP
        CMP.W   (STAIRSX), D0
        BEQ     .LOOP
        CMP.W   (KEYX), D0
        BEQ     .LOOP
        MOVE.W  D0, (A0)
        ADD.W   #1, A0      ; NEXT VALUE
.INVALIDY
        JSR     RNGY
        CMP.W   (PLAYERY), D0
        BEQ     .INVALIDY
        CMP.W   (STAIRSY), D0
        BEQ     .INVALIDY
        CMP.W   (KEYY), D0
        BEQ     .INVALIDY
        MOVE.W  D0, (A0)
        ADD.W   #1, A0      ; NEXT VALUE
        DBRA    D1, .LOOP  

.END    
        MOVEM.L (A7)+, D0-D1/A0
        RTS

ENEMYUPDT
        MOVEM.L D0-D1/A0, -(A7)
        MOVE.W  (LEVEL), D1 ; ITERATOR OF ENEMIES 
        BEQ     .END
        SUBQ    #1, D1
        MOVE.W  ENEMYPOSV, A0
        
.LOOP   
        MOVE.W  (A0), D0
        CMP.W   #$FF, D0    ; VOID VALUE 
        BEQ     .END
                            ; THIS AND NEXT VALUES ARE COORDINATES
        CMP.W   (PLAYERX), D0
        BNE     .END
        ADD.W   #1, A0      ; ADVANCE TO NEXT ARRAY VALUE
        MOVE.W  (A0), D0
        CMP.W   (PLAYERY), D0
        ADD.W   #1, A0      ; PREPARE FOR NEXT ARRAY VALUE 
        BNE     .END

        ; PLAYER HAS THE SAME POSITION AS THIS ENEMY
        JSR     PLAYERINIT  ; "DEATH"  
        BRA     .END

        DBRA    D1, .LOOP  

.END    
        MOVEM.L (A7)+, D0-D1/A0
        RTS

ENEMYPLOT
        MOVEM.L D0-D5/A0, -(A7)
        MOVE.W  (LEVEL), D5 ; ITERATOR OF ENEMIES 
        BEQ     .END
        SUBQ    #1, D5
        MOVE.W  ENEMYPOSV, A0

        MOVE.B  #80, D0                     ; SET PEN CALL
        MOVE.L  #TILEDETA, D1               ; SET PEN COLOR
        TRAP    #15                         
            
        ADDQ.W  #1, D0                      ; SET FILL CALL
        MOVE.L  #TILEDETA, D1               ; SET FILL COLOR
        TRAP    #15        
        
.LOOP   
        MOVE.W  (A0), D1                    ; X COORDINATE ON D1
        CMP.W   #$FF, D1     
        BEQ     .END                        ; VOID VALUE
        ADD.W   #1, A0

        MOVE.W (A0), D2                     ; Y COORDINATE 

        MOVE.W  D1, D3
        MOVE.W  D2, D4

        SUB.W   #TILEDIM/2, D1              ; SET TOP LEFT CORNER
        SUB.W   #TILEDIM/2, D2              ; SET TOP LEFT CORNER 
        ADD.W   #TILEDIM/2, D4              ; SET LOW RIGHT CORNER
        ADD.W   #TILEDIM/2, D3              ; SET LOW RIGHT CORNER

        MOVE.W  #87, D0                     ; REASSURE THAT D0 HAS RIGHT COMMAND
        TRAP    #15

        DBRA    D5, .LOOP  

.END    
        MOVEM.L (A7)+, D0-D1/A0
        RTS
