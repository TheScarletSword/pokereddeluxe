BattleFactoryObject:
	db $0f ; border tile
 
	db $2 ; warps
	db $F, $6, $4, $ff
	db $F, $7, $4, $ff
 
	db 8 ; signs
	db $b, $4, $8
	db $d, $4, $9
	db $4, $a, $b
	db $4, $e, $c
	db $8, $a, $c
	db $8, $e, $c
	db $c, $a, $c
	db $c, $e, $b

	db 8 ; people
	db SPRITE_OAK, $5 + 4, $5 + 4, $ff, $d0, $1 ; person
	db SPRITE_NURSE, $5 + 4, $4 + 4, $ff, $d0, $2 ; person
	db SPRITE_OAK_AIDE, $5 + 4, $3 + 4, $ff, $d0, $3 ; person
	db SPRITE_BLACK_HAIR_BOY_1, $5 + 4, $e + 4, $ff, $d1, $4 ; person
	db SPRITE_LASS, $9 + 4, $a + 4, $ff, $d1, $5 ; person
	db SPRITE_ROCKER, $9 + 4, $e + 4, $ff, $d1, $6 ; person
	db SPRITE_BLACK_HAIR_BOY_1, $d + 4, $a + 4, $ff, $d1, $7 ; person
	db SPRITE_OAK_AIDE, $2 + 4, $f + 4, $ff, $d0, $10 ; person
 
 	; warp-to
	EVENT_DISP BATTLE_FACTORY_WIDTH, $F, $6
	EVENT_DISP BATTLE_FACTORY_WIDTH, $F, $7
