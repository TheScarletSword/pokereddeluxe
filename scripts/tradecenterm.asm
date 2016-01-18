TradeCenterMScript: ; 4fd7d (13:7d7d)
	jp BattleCenterMScript

TradeCenterMTextPointers: ; 4fd80 (13:7d80)
	dw TradeCenterMText1
	dw TradeCenterMText2

TradeCenterMText1: ; 4fd82 (13:7d82)
	TX_FAR _TradeCenterMText1
	db "@"

TradeCenterMText2:
	db $8
	ld a, [wRoamingFlag]
	bit 5, a
	jr nz, .InverseModeOff ; switches Inverse off if it's already set
	ld hl, TradeCenterMTextInverseOn
	call PrintText
	ld hl, wRoamingFlag
	set 5, [hl] ; Switches inverse on (temporarily, as we're in the Battle Center)
	jp TextScriptEnd
.InverseModeOff
	ld hl, TradeCenterMTextInverseOff
	call PrintText
	ld hl, wRoamingFlag
	res 5, [hl] ; Switches Inverse off (temporarily)
	jp TextScriptEnd

TradeCenterMTextInverseOn:
	TX_FAR _TradeCenterMTextInverseOn
	db "@"

TradeCenterMTextInverseOff:
	TX_FAR _TradeCenterMTextInverseOff
	db "@"