FuchsiaHouse2Object: ; 0x75180 (size=45)
	db $17 ; border block

	db $2 ; warps
	db $7, $4, $3, $ff
	db $7, $5, $3, $ff

	db $2 ; signs
	db $3, $4, $4 ; FuchsiaHouse2Text4
	db $3, $5, $5 ; FuchsiaHouse2Text5

	db $3 ; people
	db SPRITE_WARDEN, $3 + 4, $2 + 4, $ff, $ff, $1 ; person
IF DEF(_RED)
	db SPRITE_OMANYTE, $3 + 4, $8 + 4, $ff, $ff, ITEM | $2, JAW_FOSSIL
ENDC
IF DEF(_BLUE)
	db SPRITE_OMANYTE, $3 + 4, $8 + 4, $ff, $ff, ITEM | $2, SAIL_FOSSIL
ENDC
	db SPRITE_BOULDER, $4 + 4, $8 + 4, $ff, BOULDER_MOVEMENT_BYTE_2, $3 ; person

	; warp-to
	EVENT_DISP FUCHSIA_HOUSE_2_WIDTH, $7, $4
	EVENT_DISP FUCHSIA_HOUSE_2_WIDTH, $7, $5
