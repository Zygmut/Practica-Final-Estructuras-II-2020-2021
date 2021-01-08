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

            RTS

STAMMU
; STATE MAIN MENU UPDATE
            BTST.B  #KBDBITF1, (KBDEDGE)    ; SPACE
            BEQ     .END
            MOVE.W  #STAGP, (STANEXT)
.END        RTS

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
            CLR.L   D1
            MOVE.W  #((80-20)/2)<<8|25, D1
            MOVE.B  #11, D0
            TRAP    #15
            LEA     NEXTSTR, A1
            MOVE.W  #13, D0
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
            JSR     PLAYERUPDT
            JSR     KEYUPDT
            JSR     STAIRSUPDT
            JMP     AGLUPDT

STAGPP
; STAGE PLOT
            JSR     MAPPLOT
            JSR     PLAYERPLOT
            JSR     KEYPLOT
            JSR     STAIRSPLOT
            JSR     MISCPLOT
            JMP     AGLPLOT

STADMI
; STATE DEATH MENU INIT

            RTS

STADMU
; STATE DEATH MENU UPDATE

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

       
        MOVE.W  #1, (DEATHTEXT2)    ; ENABLE DEATH TEXT
        CLR.L   D1
        MOVE.W  #((80-58)/2)<<8|7, D1
        MOVE.B  #11, D0
        TRAP    #15
        LEA     SUSSERTOD, A1
        MOVE.W  #13, D0
        TRAP    #15
        MOVEM.L (A7)+,D0-D4/A1
        RTS

*~Font size~10~
*~Tab type~1~
*~Tab size~4~
