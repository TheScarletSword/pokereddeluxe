; super rod data
; format: map, pointer to fishing group
SuperRodData: ; e919 (3:6919)
	dbw PALLET_TOWN, FishingGroup1
	dbw VIRIDIAN_CITY, FishingGroup1
	dbw CERULEAN_CITY, FishingGroup3
	dbw VERMILION_CITY, FishingGroup4
	dbw CELADON_CITY, FishingGroup5
	dbw FUCHSIA_CITY, FishingGroup10
	dbw CINNABAR_ISLAND, FishingGroup8
	dbw ROUTE_4, FishingGroup3
	dbw ROUTE_6, FishingGroup4
	dbw ROUTE_10, FishingGroup5
	dbw ROUTE_11, FishingGroup4
	dbw ROUTE_12, FishingGroup7
	dbw ROUTE_13, FishingGroup7
	dbw ROUTE_17, FishingGroup7
	dbw ROUTE_18, FishingGroup7
	dbw ROUTE_19, FishingGroup8
	dbw ROUTE_20, FishingGroup8
	dbw ROUTE_21, FishingGroup8
	dbw ROUTE_22, FishingGroup2
	dbw ROUTE_23, FishingGroup9
	dbw ROUTE_24, FishingGroup3
	dbw ROUTE_25, FishingGroup3
	dbw CERULEAN_GYM, FishingGroup3
	dbw VERMILION_DOCK, FishingGroup4
;XXX syntax errors on the rest?
	dbw $A1, FishingGroup8 ; SEAFOAM_ISLANDS_4
	dbw $A2, FishingGroup8 ; SEAFOAM_ISLANDS_5
	dbw SAFARI_ZONE_EAST, FishingGroup6
	dbw $DA, FishingGroup6 ; SAFARI_ZONE_NORTH
	dbw SAFARI_ZONE_WEST, FishingGroup6
	dbw $DC, FishingGroup6 ; SAFARI_ZONE_CENTER
	dbw $E2, FishingGroup9 ; UNKNOWN_DUNGEON_2
	dbw $E3, FishingGroup9 ; UNKNOWN_DUNGEON_3
	dbw $E4, FishingGroup9 ; UNKNOWN_DUNGEON_1
	db $FF

; fishing groups
; number of monsters, followed by level/monster pairs
FishingGroup1: ; e97d (3:697d)
	db 2
	db 25,TENTACOOL
	db 25,POLIWAG

FishingGroup2: ; e982 (3:6982)
	db 2
	db 25,GOLDEEN
	db 25,POLIWAG

FishingGroup3: ; e987 (3:6987)
	db 3
	IF DEF(_RED)
	db 25,SLOWPOKE
	ENDC
	IF DEF(_BLUE)
	db 25,PSYDUCK
	ENDC
	db 25,GOLDEEN
	db 25,KRABBY

FishingGroup4: ; e98e (3:698e)
	db 2
	db 25,KRABBY
	IF DEF(_RED)
	db 25,SHELLDER
	ENDC
	IF DEF(_BLUE)
	db 25,STARYU
	ENDC

FishingGroup5: ; e993 (3:6993)
	db 2
	db 35,POLIWHIRL
	IF DEF(_RED)
	db 25,SLOWPOKE
	ENDC
	IF DEF(_BLUE)
	db 25,PSYDUCK
	ENDC


FishingGroup6: ; e998 (3:6998)
	db 3
	db 25,KRABBY
	IF DEF(_RED)
	db 25,SLOWPOKE
	db 25,SHELLOS
	ENDC
	IF DEF(_BLUE)
	db 25,PSYDUCK
	db 25,DRATINI
	ENDC

FishingGroup7: ; e9a1 (3:69a1)
	db 4
	db 25,TENTACOOL
	db 25,KRABBY
	db 25,GOLDEEN
	db 25,MAGIKARP

FishingGroup8: ; e9aa (3:69aa)
	db 3
	IF DEF(_RED)
	db 25,SHELLDER
	ENDC
	IF DEF(_BLUE)
	db 25,STARYU
	ENDC
	db 25,HORSEA
	db 25,GOLDEEN

FishingGroup9: ; e9b3 (3:69b3)
	db 4
	IF DEF(_RED)
	db 38,SLOWBRO
	ENDC
	IF DEF(_BLUE)
	db 38,GOLDUCK
	ENDC
	db 38,SEAKING
	db 38,KINGLER
	db 38,SEADRA

FishingGroup10: ; e9bc (3:69bc)
	db 4
	db 38,SEAKING
	db 25,KRABBY
	db 25,GOLDEEN
	db 35,GYARADOS
