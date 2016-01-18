Route5Object: ; 0x545a3 (size=47)
	db $a ; border block

	db $5 ; warps
	db $1d, $a, $3, ROUTE_5_GATE
	db $1d, $9, $2, ROUTE_5_GATE
	db $21, $a, $0, ROUTE_5_GATE
	db $1b, $11, $0, PATH_ENTRANCE_ROUTE_5
	db $15, $a, $0, BATTLE_FACTORY

	db $2 ; signs
	db $1d, $11, $2 ; Route5Text1
	db $15, $7, $3 ; Route5Text3

	db $1 ; people
	db SPRITE_GUARD, $16 + 4, $a + 4, $ff, $d0, $1 ; person

	; warp-to
	EVENT_DISP ROUTE_5_WIDTH, $1d, $a ; ROUTE_5_GATE
	EVENT_DISP ROUTE_5_WIDTH, $1d, $9 ; ROUTE_5_GATE
	EVENT_DISP ROUTE_5_WIDTH, $21, $a ; ROUTE_5_GATE
	EVENT_DISP ROUTE_5_WIDTH, $1b, $11 ; PATH_ENTRANCE_ROUTE_5
	EVENT_DISP ROUTE_5_WIDTH, $15, $a ; BATTLE_FACTORY
