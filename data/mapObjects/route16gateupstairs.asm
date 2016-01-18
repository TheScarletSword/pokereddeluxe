Route16GateUpstairsObject: ; 0x4984c (size=30)
	db $a ; border block

	db $1 ; warps
	db $7, $7, $8, ROUTE_16_GATE_1F

	db $2 ; signs
	db $2, $1, $3 ; Route16GateUpstairsText3
	db $2, $6, $4 ; Route16GateUpstairsText4

IF CHALLENGE_MODE_PLUS
	db $2 ; people ; Lucky Egg is unobtainable
	db SPRITE_YOUNG_BOY, $2 + 4, $4 + 4, $ff, $ff, $1 ; person
	db SPRITE_LITTLE_GIRL, $5 + 4, $2 + 4, $fe, $2, $2 ; person
ELSE
; Normal Mode / Standard Challenge Mode
	db $3 ; people
	db SPRITE_YOUNG_BOY, $2 + 4, $4 + 4, $ff, $ff, $1 ; person
	db SPRITE_LITTLE_GIRL, $5 + 4, $2 + 4, $fe, $2, $2 ; person
	db SPRITE_OAK_AIDE, $4 + 4, $5 + 4, $ff, $d0, $5
ENDC

	; warp-to
	EVENT_DISP ROUTE_16_GATE_2F_WIDTH, $7, $7 ; ROUTE_16_GATE_1F
