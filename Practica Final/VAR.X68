; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   :
; HISTORY  :
; =============================================================================


PLAYERX     DS.W    1   ; PLAYER X COORDINATE
PLAYERY     DS.W    1   ; PLAYER Y COORDINATE

KEYX        DS.W    1   ; KEY X COORDINATE
KEYY        DS.W    1   ; KEY Y COORDINATE

STAIRSX     DS.W    1   ; STAIRS X COORDINATE
STAIRSY     DS.W    1   ; STAIRS Y COORDINATE

STACUR      DS.W    1   ; CURRENT STATE
STANEXT     DS.W    1   ; NEXT STATE 

KEYOBTEINED DC.W    0   ; "BOOLEAN" VALUE, SELF EXPLANATORY 

; NOKEYTIMER  DS.W    1

RNGXINDEX   DS.W    1   ; INDEX FOR THE X COORDINATE ON THE PSEUDO RANDOM GENERATOR
RNGYINDEX   DS.W    1   ; INDEX FOR THE Y COORDINATE ON THE PSEUDO RANDOM GENERATOR

LEVEL       DC.W    0   ; LEVEL COUNTER






