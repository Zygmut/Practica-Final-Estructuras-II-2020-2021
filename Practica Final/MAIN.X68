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
            INCLUDE "LIFE.X68"              ; LIFE MANAGER

; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF

            ; TO DO : ADD YOUR GAME INITIALIZATION HERE
            JSR     RNDINIT
            JSR     PLAYERINIT
            JSR     KEYINIT
            JSR     STAIRSINIT
            JSR     ENEMYINIT
            JSR     LIFEINIT
            
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            ; TO DO : ADD YOUR GAME UPDATE HERE
            
            JSR     PLAYERUPDT
            JSR     KEYUPDT
            JSR     STAIRSUPDT
            JSR     ENEMYUPDT
            JSR     LIFEUPDT
; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO : ADD YOUR GAME PLOT HERE
            
            JSR     MAPPLOT
            JSR     PLAYERPLOT
            JSR     KEYPLOT
            JSR     STAIRSPLOT
            JSR     ENEMYPLOT
            

            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP                   ; MAIN LOOP

; --- DEATH -------------------------------------------------------------------
LOOSE
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
