
text   EQUS "db $00," ; Start writing text.
next   EQUS "db $4e," ; Move a line down.
line   EQUS "db $4f," ; Start writing at the bottom line.
para   EQUS "db $51," ; Start a new paragraph.
cont   EQUS "db $55," ; Scroll to the next line.
done   EQUS "db $57"  ; End a text box.
prompt EQUS "db $58"  ; Prompt the player to end a text box (initiating some other event).

page   EQUS "db $49,"     ; Start a new Pokedex page.
dex    EQUS "db $5f, $50" ; End a Pokedex entry.


percent EQUS "* $ff / 100"

lx: MACRO ; r, hi, lo
	ld \1, (\2) << 8 + ((\3) & $ff)
	ENDM


; Constant enumeration is useful for monsters, items, moves, etc.
const_def: MACRO
const_value = 0
ENDM

const: MACRO
\1 EQU const_value
const_value = const_value + 1
ENDM


homecall: MACRO
	ld a, [H_LOADEDROMBANK]
	push af
	ld a, BANK(\1)
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	call \1
	pop af
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	ENDM

callba: MACRO
	ld b, BANK(\1)
	ld hl, \1
	call Bankswitch
	ENDM

callab: MACRO
	ld hl, \1
	ld b, BANK(\1)
	call Bankswitch
	ENDM

farcall EQUS "callba"

jpba: MACRO
	ld b, BANK(\1)
	ld hl, \1
	jp Bankswitch
	ENDM

;\1 = r
;\2 = X
;\3 = Y
coord: MACRO
	ld \1, wTileMap + 20 * \3 + \2
	ENDM


;\1 = X
;\2 = Y
hlCoord: MACRO
	ld hl, wTileMap + 20 * \2 + \1
	ENDM

;\1 = X
;\2 = Y
deCoord: MACRO
	ld de, wTileMap + 20 * \2 + \1
	ENDM

;\1 = X
;\2 = Y
bcCoord: MACRO
	ld bc, wTileMap + 20 * \2 + \1
	ENDM

;\1 = X
;\2 = Y
aCoord: MACRO
	ld a, [wTileMap + 20 * \2 + \1]
	ENDM

;\1 = X
;\2 = Y
Coorda: MACRO
	ld [wTileMap + 20 * \2 + \1], a
	ENDM

;\1 = X
;\2 = Y
dwCoord: MACRO
	dw wTileMap + 20 * \2 + \1
	ENDM

;\1 = Map Width
;\2 = Rows above (Y-blocks)
;\3 = X movement (X-blocks)
EVENT_DISP: MACRO
	dw (wOverworldMap + 7 + (\1) + ((\1) + 6) * ((\2) >> 1) + ((\3) >> 1)) ; Ev.Disp
	db \2,\3	;Y,X
	ENDM

FLYWARP_DATA: MACRO
	EVENT_DISP \1,\2,\3
	db ((\2) & $01)	;sub-block Y
	db ((\3) & $01)	;sub-block X
	ENDM

; external map entry macro
EMAP: MACRO ; emap x-coordinate,y-coordinate,textpointer
; the appearance of towns and routes in the town map, indexed by map id
	; nybble: y-coordinate
	; nybble: x-coordinate
	; word  : pointer to map name
	db (\1 + (\2 << 4))
	dw \3
	ENDM

; internal map entry macro
IMAP: MACRO ; imap mapid_less_than,x-coordinate,y-coordinate,textpointer
; the appearance of buildings and dungeons in the town map
	; byte  : maximum map id subject to this rule
	; nybble: y-coordinate
	; nybble: x-coordinate
	; word  : pointer to map name
	db \1
	db \2 + \3 << 4
	dw \4
	ENDM

; tilesets' headers macro
tileset: MACRO
	db BANK(\2)   ; BANK(GFX)
	dw \1, \2, \3 ; Block, GFX, Coll
	db \4, \5, \6 ; counter tiles
	db \7         ; grass tile
	db \8         ; permission (indoor, cave, outdoor)
	ENDM

INDOOR  EQU 0
CAVE    EQU 1
OUTDOOR EQU 2

; macro for two nibbles
dn: MACRO
	db (\1 << 4 | \2)
	ENDM

; macro for putting a byte then a word
dbw: MACRO
	db \1
	dw \2
	ENDM

bigdw: MACRO ; big-endian word
        dw ((\1)/$100) + (((\1)&$ff)*$100)
        ENDM

dt: MACRO ; three-byte (big-endian)
        db (\1 >> 16) & $ff
        db (\1 >> 8) & $ff
        db \1 & $ff
        ENDM

; data format macros
RGB: MACRO
	dw (\3 << 10 | \2 << 5 | \1)
	ENDM

; text macros
TX_NUM: MACRO
; print a big-endian decimal number.
; \1: address to read from
; \2: number of bytes to read
; \3: number of digits to display
	db $09
	dw \1
	db \2 << 4 | \3
	ENDM

TX_FAR: MACRO
	db $17
	dw \1
	db BANK(\1)
	ENDM

; text engine command $1
TX_RAM: MACRO
; prints text to screen
; \1: RAM address to read from
	db $1
	dw \1
	ENDM

TX_BCD: MACRO
	db $2
	dw \1
	db \2
	ENDM

; Predef macro.
add_predef: MACRO
\1Predef::
	db BANK(\1)
	dw \1
	ENDM

predef_id: MACRO
	ld a, (\1Predef - PredefPointers) / 3
	ENDM

predef: MACRO
	predef_id \1
	call Predef
	ENDM

predef_jump: MACRO
	predef_id \1
	jp Predef
	ENDM


add_tx_pre: MACRO
\1_id:: dw \1
ENDM

tx_pre_id: MACRO
	ld a, (\1_id - TextPredefs) / 2
ENDM

tx_pre: MACRO
	tx_pre_id \1
	call PrintPredefTextID
ENDM

tx_pre_jump: MACRO
	tx_pre_id \1
	jp PrintPredefTextID
ENDM


;1_channel	EQU $00
;2_channels	EQU $40
;3_channels	EQU $80
;4_channels	EQU $C0

CH0		EQU 0
CH1		EQU 1
CH2		EQU 2
CH3		EQU 3
CH4		EQU 4
CH5		EQU 5
CH6		EQU 6
CH7		EQU 7

unknownsfx0x10: MACRO
	db $dd ; soundinput
	db \1
ENDM

unknownsfx0x20: MACRO
    ; noise/sound
    db \1
	;db $20 | \1
	db \2
	db \3
	db \4
ENDM

unknownnoise0x20: MACRO
	db  \1 ; | $20
	db \2
	db \3
ENDM


;format: instrument length (in 16ths)
snare1: MACRO
	db $B0 | (\1 - 1)
	db $01
ENDM

snare2: MACRO
	db $B0 | (\1 - 1)
	db $02
ENDM

snare3: MACRO
	db $B0 | (\1 - 1)
	db $03
ENDM

snare4: MACRO
	db $B0 | (\1 - 1)
	db $04
ENDM

snare5: MACRO
	db $B0 | (\1 - 1)
	db $05
ENDM

triangle1: MACRO
	db $B0 | (\1 - 1)
	db $06
ENDM

triangle2: MACRO
	db $B0 | (\1 - 1)
	db $07
ENDM

snare6: MACRO
	db $B0 | (\1 - 1)
	db $08
ENDM

snare7: MACRO
	db $B0 | (\1 - 1)
	db $09
ENDM

snare8: MACRO
	db $B0 | (\1 - 1)
	db $0A
ENDM

snare9: MACRO
	db $B0 | (\1 - 1)
	db $0B
ENDM

cymbal1: MACRO
	db $B0 | (\1 - 1)
	db $0C
ENDM

cymbal2: MACRO
	db $B0 | (\1 - 1)
	db $0D
ENDM

cymbal3: MACRO
	db $B0 | (\1 - 1)
	db $0E
ENDM

mutedsnare1: MACRO
	db $B0 | (\1 - 1)
	db $0F
ENDM

triangle3: MACRO
	db $B0 | (\1 - 1)
	db $10
ENDM

mutedsnare2: MACRO
	db $B0 | (\1 - 1)
	db $11
ENDM

mutedsnare3: MACRO
	db $B0 | (\1 - 1)
	db $12
ENDM

mutedsnare4: MACRO
	db $B0 | (\1 - 1)
	db $13
ENDM

duty: MACRO
	;db $EC
	db $db
	db \1
ENDM

;format: rest length (in 16ths)
rest: MACRO
	db $C0 | (\1 - 1)
ENDM

executemusic: MACRO
	togglesfx
ENDM

;\1 (byte) = connected map id
;\2 (byte) = connected map width
;\3 (byte) = connected map height
;\4 (byte) = x movement of connection strip
;\5 (byte) = connection strip offset
;\6 (byte) = width of connection strip
;\7 (word) = connected map blocks pointer
NORTH_MAP_CONNECTION: MACRO
	db \1 ; map id
	dw \7 + (\2 * (\3 - 3)) + \5; "Connection Strip" location
	dw wOverworldMap + 3 + \4 ; current map position
	db \6 ; width of connection strip
	db \2 ; map width
	db (\3 * 2) - 1 ; y alignment (y coordinate of player when entering map)
	db (\4 - \5) * -2 ; x alignment (x coordinate of player when entering map)
	dw wOverworldMap + 1 + (\3 * (\2 + 6)) ; window (position of the upper left block after entering the map)
ENDM

;\1 (byte)  = connected map id
;\2 (byte)  = connected map width
;\3 (byte)  = x movement of connection strip
;\4 (byte)  = connection strip offset
;\5 (byte)  = width of connection strip
;\6 (word)  = connected map blocks pointer
;\7 (byte)  = current map width
;\8 (byte) = current map height
SOUTH_MAP_CONNECTION: MACRO
	db \1 ; map id
	dw \6 + \4 ; "Conection Strip" location
	dw wOverworldMap + 3 + (\8 + 3) * (\7 + 6) + \3 ; current map positoin
	db \5 ; width of connection strip
	db \2 ; map width
	db 0  ; y alignment (y coordinate of player when entering map)
	db (\3 - \4) * -2 ; x alignment (x coordinate of player when entering map)
	dw wOverworldMap + 7 + \2 ; window (position of the upper left block after entering the map)
ENDM

;\1 (byte)  = connected map id
;\2 (byte)  = connected map width
;\3 (byte)  = y movement of connection strip
;\4 (byte)  = connection strip offset
;\5 (byte)  = height of connection strip
;\6 (word)  = connected map blocks pointer
;\7 (byte)  = current map width
EAST_MAP_CONNECTION: MACRO
	db \1 ; map id
	dw \6 + (\2 * \4) ; "Connection Strip" location
	dw wOverworldMap - 3 + (\7 + 6) * (\3 + 4) ; current map position
	db \5 ; height of connection strip
	db \2 ; map width
	db (\3 - \4) * -2 ; y alignment
	db 0 ; x alignment
	dw wOverworldMap + 7 + \2 ; window (position of the upper left block after entering the map)
ENDM

;\1 (byte)  = connected map id
;\2 (byte)  = connected map width
;\3 (byte)  = y movement of connection strip
;\4 (byte)  = connection strip offset
;\5 (byte)  = height of connection strip
;\6 (word)  = connected map blocks pointer
;\7 (byte)  = current map width
WEST_MAP_CONNECTION: MACRO
	db \1 ; map id
	dw \6 + (\2 * \4) + \2 - 3 ; "Connection Strip" location
	dw wOverworldMap + (\7 + 6) * (\3 + 3) ; current map position
	db \5 ; height of connection strip
	db \2 ; map width
	db (\3 - \4) * -2 ; y alignment
	db (\2 * 2) - 1 ; x alignment
	dw wOverworldMap + 6 + (2 * \2) ; window (position of the upper left block after entring the map)
ENDM

inc_section: MACRO
    SECTION \1, ROMX
    include \1
ENDM

lda: MACRO
    ld a, \2
    ld \1, a
ENDM

; HandleRematch macro
rematch: MACRO
	ld de, \1
	ld a, (\2 << 4) | \3
	ld [wRemFuncArg], a
	call HandleRematch
ENDM

rematchafter: MACRO
	ld de, \1
	ld a, (\2 << 4) | \3
	ld [wRemFuncArg], a
	call HandleRematchAfter
ENDM

overwriteroster: MACRO
	ld a, [$ff8c]
	ld d, a
	ld e, \1
	rst OverwriteRoster
ENDM

ORG: MACRO
	SECTION "ORG\@",ROMX[\2],BANK[\1]
	ENDM
CALL_INDIRECT: MACRO
	ld b, BANK(\1)
	ld hl, \1
	rst $18
ENDM