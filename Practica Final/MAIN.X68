; =============================================================================
; TITLE    : EXAMPLE GAME (MAIN PROGRAM)
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : 10-OCT-2020 - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "RANDOM.X68"            ; PSEUDO - RANDOM GENERATOR
            INCLUDE "PLAYER.X68"            ; PLAYER MANAGER
            INCLUDE "MAP.X68"               ; MAP MANAGER
            INCLUDE "KEY.X68"               ; KEY MANAGER
            INCLUDE "STAIRS.X68"            ; STAIR MANAGER 
            INCLUDE "ENEMY.X68"             ; ENEMY MANAGER

; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF

            ; TO DO : ADD YOUR GAME INITIALIZATION HERE
            JSR     RNDINIT
            JSR     PLAYERINIT
            JSR     KEYINIT
            JSR     STAIRSINIT
            JSR     ENEMYINIT
            
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            ; TO DO : ADD YOUR GAME UPDATE HERE
            
            JSR     PLAYERUPDT
            JSR     KEYUPDT
            JSR     STAIRSUPDT
            JSR     ENEMYUPDT
; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO : ADD YOUR GAME PLOT HERE
            CMP.W   #0, (PLAYERL)
            BEQ     .DEATH

            JSR     LIVEPLOT
            JSR     MAPPLOT
            JSR     PLAYERPLOT
            JSR     KEYPLOT
            JSR     STAIRSPLOT
            JSR     ENEMYPLOT

            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP                   ; MAIN LOOP

; --- DEATH -------------------------------------------------------------------
.DEATH      ; PLAYER HAS 0 LIVES
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

            LEA     SUSSERTODST, A1
            MOVE.W  #SCRWIDTH/2-230, D1             ; CENTER 
            MOVE.W  #SCRHEIGH/2, D2             ; CENTER

            MOVE.W  #95, D0
            TRAP    #15

            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
