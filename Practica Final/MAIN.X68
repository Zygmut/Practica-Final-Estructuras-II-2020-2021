; =============================================================================
; TITLE    : EXAMPLE GAME (MAIN PROGRAM)
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : 10-OCT-2020 - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================
            OPT     MEX
            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "UTIL.X68"              ; UTILITY MANAGER
            INCLUDE "RANDOM.X68"            ; PSEUDO - RANDOM GENERATOR
            INCLUDE "AGENTLST.X68"          ; AGENT MANAGER
            INCLUDE "PLAYER.X68"            ; PLAYER MANAGER
            INCLUDE "MAP.X68"               ; MAP MANAGER
            INCLUDE "KEY.X68"               ; KEY MANAGER
            INCLUDE "STAIRS.X68"            ; STAIR MANAGER 
            INCLUDE "ENEMY.X68"             ; ENEMY MANAGER
            INCLUDE "MISC.X68"              ; MISCELLANEOUS MANAGER
            INCLUDE "STATES.X68"            ; STATES MANAGER
            

; --- INITIALIZE --------------------------------------------------------------

START                       ; INITIALIZE SYSTEM-RELATED STUFF
            JSR     SYSINIT 
            JSR     STAINIT
            
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            JSR     STAUPD
; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            JSR     STAPLOT
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
