; expanded to accomodate new encounter themes, see PlayTrainerMusic in home.asm

FemaleTrainerList:: ; 3434 (0:3434)
	db $c8+LASS
	db $c8+JR__TRAINER_F
	db $FF

EvilTrainerList:: ; 3439 (0:3439)
	db $c8+BIKER
	db $c8+CUE_BALL
	db $c8+BURGLAR
	db $c8+GAMBLER
	db $c8+ROCKER
	db $c8+CHIEF
	db $c8+SCIENTIST
	db $c8+GIOVANNI
	db $c8+ROCKET
	db $FF

PokemaniacTrainerList::
	db $c8+POKEMANIAC
	db $c8+CHANNELER
	db $c8+TAMER
	db $c8+SUPER_NERD
	db $c8+JUGGLER_X
	db $c8+JUGGLER
	db $FF


BeautyTrainerList::
	db $c8+BEAUTY
	db $c8+COOLTRAINER_F
	db $FF

JrTrainerList::
	db $c8+FISHER
	db $c8+SWIMMER
	db $c8+JR__TRAINER_M
	db $c8+COOLTRAINER_M
	db $c8+BUG_CATCHER
	db $FF