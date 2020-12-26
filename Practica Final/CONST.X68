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
			DC.W	$220, $120, $1C0, $140, $160, $80, $A0, $1E0, $180, $140 
            DC.W    $100, $E0, $1A0, $160, $220, $200, $C0, $60, $1C0, $120    
			DC.W    $140, $160, $60, $100, $E0, $120, $1E0, $1A0, $A0, $1C0
            DC.W    $220, $C0, $80, $200, $180, $100, $80, $220, $1C0, $1E0
			DC.W    $E0, $120, $60, $160, $200, $C0, $140, $A0, $180, $1A0   

YVALUES		DC.W	$B0, $150, $30, $10, $F0, $70, $90, $50, $D0, $190
			DC.W	$1D0, $130, $170, $1B0, $110, $170, $F0, $110, $10
            DC.W    $50, $70, $150, $1D0, $130, $D0, $30, $90, $190, $B0
			DC.W    $D0, $130, $90, $70, $150, $10, $1B0, $50, $30, $B0
            DC.W    $110, $170, $F0, $190, $1D0, $1B0, $130, $190, $10, $1B0
			DC.W    $B0, $D0, $110, $50, $F0, $1D0, $170, $150, $90, $30