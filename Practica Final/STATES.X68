; =============================================================================
; TITLE    : GAME STATE MANAGEMENT
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : XX-XXX-201X - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #-1,(STACUR)            ; INVALID STATE, JUST TO FORCE INIT
            MOVE.W  #0,(STANEXT)            ; INITIAL STATE
            RTS

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.INITBL     DC.L    STAMMI,STAGPI,STADMI
.UPDTBL     DC.L    STAMMU,STAGPU,STADMU

; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.PLTTBL     DC.L    STAMMP,STAGPP,STADMP

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS
STAMMI
; STATE MAIN MENU INIT
            MOVE.L  D0, -(A7)
            MOVE.W  #7, D0
            JSR     AGLFKIL
            MOVE.L  (A7)+, D0
            CLR     (LEVEL)
            CLR     (TORCHSHADDER)
            MOVE.W  #3, TORCHRANGE
            RTS

STAMMU
; STATE MAIN MENU UPDATE
            MOVEM.L D0-D3, -(A7)

            MOVE.W  #60, D0
            MOVE.W  #%00010010, D1  ; ACTIVATE MOUSE IRQ TO MOUSE DOWN AND UP
            TRAP    #15
            
        
            MOVE.W  #61, D0
            CLR     D1
            TRAP    #15             
        
            CMP.B   #0, D0          ; CHECK IF LEFT BUTTON OF MOUSE IS PRESSED
            BEQ     .END            ; NOT PRESSED
            MOVE.L  D1, D3
            LSR.L   #8, D3
            LSR.L   #8, D3

            CMP.W    #(BUTTONY-BUTTONHEIGH), D3
            BLE     .END
            CMP.W   #(BUTTONY+BUTTONHEIGH), D3 
            BGE     .END
            
            
            ; RIGHT X COORDINATE 
            
            CMP.W   #(BUTTONX1-BUTTONWIDTH), D1    ; X COORDINATE
            BLE     .X2
            CMP.W   #(BUTTONX1+BUTTONWIDTH), D1   
            BGE     .X2
            ; EASY
            MOVE.W  #STAGP, (STANEXT)
            BRA     .END

.X2         CMP.W   #(BUTTONX2-BUTTONWIDTH), D1    ; X COORDINATE
            BLE     .END
            CMP.W   #(BUTTONX2+BUTTONWIDTH), D1   
            BGE     .END
            ; NORMAL
            MOVE.W  #1, (TORCHSHADDER)
            MOVE.W  #STAGP, (STANEXT)
.END        
            MOVEM.L (A7)+, D0-D3
            RTS

STAMMP
; STATE MAIN MENU PLOT
            MOVEM.L D0-D1/A1, -(A7)
            MOVE.W  #((80-24)/2)<<8|5, D1
            MOVE.B  #11, D0
            TRAP    #15
            LEA     TITLESTRING, A1
            MOVE.W  #13, D0
            TRAP    #15

            CLR.L   D1
            MOVE.W  #((80-22)/2)<<8|7, D1
            MOVE.B  #11, D0
            TRAP    #15
            LEA     SUBTITLESTR, A1
            MOVE.W  #13, D0
            TRAP    #15

            CLR.L   D1
            MOVE.W  #((80-22)/2)<<8|8, D1
            MOVE.B  #11, D0
            TRAP    #15
            LEA     BECARESTR, A1
            MOVE.W  #13, D0
            TRAP    #15

            

            BTST.B  #4, (SCRCYCCT)  ; TIMER 
            BEQ     .END
            
            
            UTILFILL #$00000000
            UTILPEN #$00FFFFFF
            MOVE.W  #BUTTONX1, D1
            MOVE.W  #BUTTONY, D2
            MOVE.W  D1, D3
            MOVE.W  D2, D4 
            SUB.W   #BUTTONWIDTH/2, D1              ; SET TOP LEFT CORNER
            SUB.W   #BUTTONHEIGH/2, D2              ; SET TOP LEFT CORNER 
            ADD.W   #BUTTONWIDTH/2, D3              ; SET LOW RIGHT CORNER
            ADD.W   #BUTTONHEIGH/2, D4              ; SET LOW RIGHT CORNER

            MOVE.W  #87, D0
            TRAP    #15                             ; DRAW RECTANGLE

            LEA     EASYSTR, A1
            MOVE.W  #BUTTONX1-16, D1
            MOVE.W  #BUTTONY-7, D2

            MOVE.W  #95, D0
            TRAP    #15

            ; END
            UTILFILL #$00000000
            UTILPEN #$00FFFFFF
            MOVE.W  #BUTTONX2, D1
            MOVE.W  #BUTTONY, D2
            MOVE.W  D1, D3
            MOVE.W  D2, D4 
            SUB.W   #BUTTONWIDTH/2, D1              ; SET TOP LEFT CORNER
            SUB.W   #BUTTONHEIGH/2, D2              ; SET TOP LEFT CORNER 
            ADD.W   #BUTTONWIDTH/2, D3              ; SET LOW RIGHT CORNER
            ADD.W   #BUTTONHEIGH/2, D4              ; SET LOW RIGHT CORNER

            MOVE.W  #87, D0
            TRAP    #15                             ; DRAW RECTANGLE

            LEA     NORMALSTR, A1
            MOVE.W  #BUTTONX2-22, D1
            MOVE.W  #BUTTONY-7, D2

            MOVE.W  #95, D0
            TRAP    #15
.END    
            MOVEM.L (A7)+, D0-D1/A1
           ;  UTILTEXT NEXTSTR, #SCRWIDTH/2, #SCRHEIGH-30
            RTS

STAGPI
; STAGE INIT
            JSR     RNDINIT
            JSR     PLAYERINIT
            JSR     KEYINIT
            JMP     STAIRSINIT
           

STAGPU
; STAGE UPDATE
            
            CMP.W   #8, (LEVEL)
            BEQ     .CP1
            CMP.W   #15, (LEVEL)
            BEQ     .CP2

.CLASS      JSR     PLAYERUPDT
            JSR     KEYUPDT
            JSR     STAIRSUPDT
            JMP     AGLUPDT
.CP1
            MOVE.W #2, (TORCHRANGE)
            BRA    .CLASS
.CP2
            MOVE.W #1, (TORCHRANGE)
            BRA     .CLASS
STAGPP
; STAGE PLOT
            JSR     MAPPLOT
            JSR     PLAYERPLOT
            JSR     KEYPLOT
            JSR     STAIRSPLOT
            
            JSR     AGLPLOT
            CMP     #0, (TORCHSHADDER)
            BEQ     .END
            JSR     SHADDERPLOT
            
.END        
            JSR     MISCPLOT
            RTS

STADMI
; STATE DEATH MENU INIT

            RTS

STADMU
; STATE DEATH MENU UPDATE
            MOVEM.L D0-D3, -(A7)

            MOVE.W  #60, D0
            MOVE.W  #%00010010, D1  ; ACTIVATE MOUSE IRQ TO MOUSE DOWN AND UP
            TRAP    #15
            
        
            MOVE.W  #61, D0
            CLR     D1
            TRAP    #15             
        
            CMP.B   #0, D0          ; CHECK IF LEFT BUTTON OF MOUSE IS PRESSED
            BEQ     .END            ; NOT PRESSED
            MOVE.L  D1, D3
            LSR.L   #8, D3
            LSR.L   #8, D3

            CMP.W    #(BUTTONY-BUTTONHEIGH), D3
            BLE     .END
            CMP.W   #(BUTTONY+BUTTONHEIGH), D3 
            BGE     .END
            
            
            ; RIGHT X COORDINATE 
            
            CMP.W   #(BUTTONX1-BUTTONWIDTH), D1    ; X COORDINATE
            BLE     .X2
            CMP.W   #(BUTTONX1+BUTTONWIDTH), D1   
            BGE     .X2
            ; RETRY
            MOVE.W  #STAMM, (STANEXT)
            BRA     .END

.X2         CMP.W   #(BUTTONX2-BUTTONWIDTH), D1    ; X COORDINATE
            BLE     .END
            CMP.W   #(BUTTONX2+BUTTONWIDTH), D1   
            BGE     .END
            ; EXIT

            JSR     LOOSE
.END        
            MOVEM.L (A7)+, D0-D3
            RTS

STADMP
; STATE DEATH MENU PLOT
        MOVEM.L D0-D4/A1, -(A7)
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
        MOVE.W  #((80-34)/2)<<8|5, D1
        MOVE.B  #11, D0
        TRAP    #15
        LEA     DEATHSTRING, A1
        MOVE.W  #13, D0
        TRAP    #15

       
        MOVE.W  #1, (DEATHTEXT2)    
        CLR.L   D1
        MOVE.W  #((80-58)/2)<<8|7, D1
        MOVE.B  #11, D0
        TRAP    #15
        LEA     SUSSERTOD, A1
        MOVE.W  #13, D0
        TRAP    #15

        ; BUTTONS
        BTST.B  #4, (SCRCYCCT)  ; TIMER 
        BEQ     .END
        ; RETRY
        UTILFILL #$00000000
        UTILPEN #$00FFFFFF
        MOVE.W  #BUTTONX1, D1
        MOVE.W  #BUTTONY, D2
        MOVE.W  D1, D3
        MOVE.W  D2, D4 
        SUB.W   #BUTTONWIDTH/2, D1              ; SET TOP LEFT CORNER
        SUB.W   #BUTTONHEIGH/2, D2              ; SET TOP LEFT CORNER 
        ADD.W   #BUTTONWIDTH/2, D3              ; SET LOW RIGHT CORNER
        ADD.W   #BUTTONHEIGH/2, D4              ; SET LOW RIGHT CORNER

        MOVE.W  #87, D0
        TRAP    #15                             ; DRAW RECTANGLE

        LEA     RETRYSTR, A1
        MOVE.W  #BUTTONX1-19, D1
        MOVE.W  #BUTTONY-7, D2

        MOVE.W  #95, D0
        TRAP    #15
        
        ; END
        UTILFILL #$00000000
        UTILPEN #$00FFFFFF
        MOVE.W  #BUTTONX2, D1
        MOVE.W  #BUTTONY, D2
        MOVE.W  D1, D3
        MOVE.W  D2, D4 
        SUB.W   #BUTTONWIDTH/2, D1              ; SET TOP LEFT CORNER
        SUB.W   #BUTTONHEIGH/2, D2              ; SET TOP LEFT CORNER 
        ADD.W   #BUTTONWIDTH/2, D3              ; SET LOW RIGHT CORNER
        ADD.W   #BUTTONHEIGH/2, D4              ; SET LOW RIGHT CORNER

        MOVE.W  #87, D0
        TRAP    #15                             ; DRAW RECTANGLE

        LEA     EXITSTR, A1
        MOVE.W  #BUTTONX2-16, D1
        MOVE.W  #BUTTONY-7, D2

        MOVE.W  #95, D0
        TRAP    #15
.END  
        MOVEM.L (A7)+,D0-D4/A1
        RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
