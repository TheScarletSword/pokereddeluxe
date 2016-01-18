PrizeDifferentMenuPtrs: ; 52843 (14:6843)
	dw PrizeMenuMon1Entries
	dw PrizeMenuMon1Cost

	dw PrizeMenuMon2Entries
	dw PrizeMenuMon2Cost

	dw PrizeMenuTMsEntries
	dw PrizeMenuTMsCost

NoThanksText: ; 5284f (14:684f)
	db "NO THANKS@"

PrizeMenuMon1Entries: ; 52859 (14:6859)
	db DITTO
IF DEF(_RED)
	db ELEKID
ENDC
IF DEF(_BLUE)
	db MAGBY
ENDC
	db TYROGUE
	db "@"
PrizeMenuMon1Cost: ; 5285d (14:685d)
	db $05,$00
	db $15,$00
	db $22,$50
	db "@"

PrizeMenuMon2Entries: ; 52864 (14:6864)
IF DEF(_RED)
	db DRATINI
ENDC
IF DEF(_BLUE)
	db DEINO
ENDC
	db EEVEE
	db PORYGON
	db "@"
PrizeMenuMon2Cost: ; 52868 (14:6868)
	db $20,$00
	db $25,$00
	db $55,$99
	db "@"

PrizeMenuTMsEntries: ; 5286f (14:686f)
	db TM_23
	db TM_15
	db TM_10
	db "@"
PrizeMenuTMsCost: ; 52873 (14:6873)
	db $22,$00 ; 2200 Coins
	db $55,$00 ; 5500 Coins
	db $33,$00 ; 3300 Coins
	db "@"
