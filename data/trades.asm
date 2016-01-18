TradeMons: ; 71b7b (1c:5b7b)
; givemonster, getmonster, textstring, nickname (11 bytes), 14 bytes total
IF DEF(_RED)
	db VILEPLUME, BULBASAUR, 0,"BULBASAUR@@" ; Route 11
	db ABRA,      MIME_JR,   0,"MIME JR.@@@" ; Route 2
	db BUTTERFREE,BEEDRILL,  2,"CHIKUCHIKU@" ; Unused
	db PONYTA,    SEEL,      0,"SEEL@@@@@@@" ; Cinnabar Island
	db CLOYSTER,  SQUIRTLE,  2,"SQUIRTLE@@@" ; Vermilion City
	db LICKITUNG, SLOWPOKE,  0,"SLOWPOKE@@@" ; Route 18
	db SHUPPET,   SPIRITOMB, 1,"SPIRITOMB@@" ; Cerulean City
	db KADABRA,   GRAVELER,  1,"GRAVELER@@@" ; Cinnabar Island
	db VIBRAVA,   DRUDDIGON, 2,"DRUDDIGON@@" ; Cinnabar Island
	db ARCANINE,  CHARMANDER,2,"CHARMANDER@" ; Route 5
ENDC
IF DEF(_BLUE)
	db VICTREEBEL,BULBASAUR, 0,"BULBASAUR@@" ; Route 11
	db ABRA,      MIME_JR,   0,"MIME JR.@@@" ; Route 2
	db BUTTERFREE,BEEDRILL,  2,"CHIKUCHIKU@" ; Unused
	db PONYTA,    SEEL,      0,"SEEL@@@@@@@" ; Cinnabar Island
	db STARMIE,   SQUIRTLE,  2,"SQUIRTLE@@@" ; Vermilion City
	db LICKITUNG, SLOWPOKE,  0,"SLOWPOKE@@@" ; Route 18
	db GOLETT,    SPIRITOMB, 1,"SPIRITOMB@@" ; Cerulean City
	db KADABRA,   BOLDORE,   1,"BOLDORE@@@@" ; Cinnabar Island
	db VIBRAVA,   DRUDDIGON, 2,"DRUDDIGON@@" ; Cinnbar Island
	db NINETALES, CHARMANDER,2,"CHARMANDER@" ; Route 5
ENDC