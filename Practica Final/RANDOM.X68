; =============================================================================
; TITLE    : PSEUDO-RANDOM NUMBER GENERATOR
; AUTHOR   : RUBEN PALMER PEREZ 
; COMMENTS : VERY LAZY AND STUPID "ALGORITHM" IMPLEMENTED.
; HISTORY  : 
; =============================================================================

; -----------------------------------------------------------------------------
RNDINIT
; INITIALIZES RANDOM NUMBER GENERATOR
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CLR     (RNGXINDEX)
            CLR     (RNGYINDEX)

            RTS
; -----------------------------------------------------------------------------
RNGX
; PROVIDES A PSEUDO-RANDOM BYTE
; INPUT    - NONE
; OUTPUT   - D0.L RANDOM VALUE (ONLY BYTE)
; MODIFIES - NONE (ASIDE OF OUTPUT)
; -----------------------------------------------------------------------------
            MOVE.L  A0,-(A7)

            LEA     XVALUES, A0
            CLR.L   D0
            
            MOVE.B  (RNGXINDEX), D0
            LSL.W   #1, D0     
            ADD.W   D0, A0
            MOVE.W  (A0), D0
            ADDQ.B  #1, (RNGXINDEX)
            CMP     #$0C00, (RNGXINDEX)
            BNE     .NOVERFLOW     
            CLR     (RNGXINDEX)
.NOVERFLOW            
            MOVE.L  (A7)+, A0
            RTS
; -----------------------------------------------------------------------------
RNGY
; PROVIDES A PSEUDO-RANDOM BYTE
; INPUT    - NONE
; OUTPUT   - D0.L RANDOM VALUE (ONLY BYTE)
; MODIFIES - NONE (ASIDE OF OUTPUT)
; -----------------------------------------------------------------------------
            MOVE.L  A0,-(A7)

            LEA     YVALUES, A0
            CLR.L   D0
            
            MOVE.B  (RNGYINDEX), D0
            LSL.W   #1, D0  
            ADD.W   D0, A0
            MOVE.W  (A0), D0
            ADDQ.B  #1, (RNGYINDEX)
            CMP     #$E100, (RNGYINDEX)
            BNE     .NOVERFLOW
            CLR     (RNGYINDEX)
.NOVERFLOW
            MOVE.L  (A7)+, A0
            RTS

; UPDATE RANDOM VALUES TO HAVE ONLY CENTER VALUES OF THE "GRID"
