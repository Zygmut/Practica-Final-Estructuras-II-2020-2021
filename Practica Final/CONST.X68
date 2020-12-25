; =============================================================================
; TITLE    : GAME CONSTANTS
; AUTHOR   :
; HISTORY  :
; =============================================================================
CUBCOS    EQU     45                ;LONG OF ONE SIDE OF THE CUBE
CUBCOLP   EQU     $00CCE0EA         ; COLOR OF THE CUBE

;   TILE

TILEDIM     EQU     32         ; TILE SET DIMENSIONS && PLAYER SPEED

TILEDARK    EQU     $00745B6D  ; TILE SET DARK COLOR 
TILELIGH    EQU     $00CCE0EA  ; TILE SET LIGHT COLOR
TILEDETA    EQU     $00A38099  ; TILE SET DETAIL COLOR

NOKEYSTRING DC.W   'YOU DO NOT HAVE ANY KEYS', 0

XVALUES		DC.W	$80, $1E0, $200, $1A0, $C0, $A0, $180, $E0, $60, $100
			DC.W	$220, $120, $1C0, $140, $160

YVALUES		DC.W	$B0, $150, $30, $10, $F0, $70, $90, $50, $D0, $190
			DC.W	$1D0, $130, $170, $1B0, $110

