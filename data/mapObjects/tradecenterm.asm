TradeCenterMObject: ; 0x4fd87 (size=10)
	db $e ; border block

	db $0 ; warps

	db $0 ; signs

	db $2 ; people
	db SPRITE_RED, $2 + 4, $2 + 4, $ff, $0, $1 ; person
	db SPRITE_CABLE_CLUB_WOMAN, $1 + 4, $9 + $4, $ff, $d0, $2 ; inverse on/off switch
