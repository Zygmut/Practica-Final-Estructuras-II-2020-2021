; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   :
; HISTORY  :
; =============================================================================

; POSITION
PLAYERX     DS.W    1   ; PLAYER X COORDINATE
PLAYERY     DS.W    1   ; PLAYER Y COORDINATE

KEYX        DS.W    1   ; KEY X COORDINATE
KEYY        DS.W    1   ; KEY Y COORDINATE

STAIRSX     DS.W    1   ; STAIRS X COORDINATE
STAIRSY     DS.W    1   ; STAIRS Y COORDINATE

STACUR      DS.W    1   ; CURRENT STATE
STANEXT     DS.W    1   ; NEXT STATE 

; BOOLEAN
KEYOBTEINED DC.W    0   ; "BOOLEAN" VALUE, SELF EXPLANATORY 

DEATHTEXT2  DC.W    0   ; "BOOLEAN" DEATH STRING SHOW 

; ARRAY 
RNGXINDEX   DS.W    1   ; INDEX FOR THE X COORDINATE ON THE PSEUDO RANDOM GENERATOR
RNGYINDEX   DS.W    1   ; INDEX FOR THE Y COORDINATE ON THE PSEUDO RANDOM GENERATOR

LEVEL       DC.W    0   ; LEVEL COUNTER

; AUDIO
AUDIOACCSND DS.B    1   ; ACCEPT NEW SOUNDS 
            DS.W    0




