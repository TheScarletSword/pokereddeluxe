RockTunnelPokecenterScript: ; 493ba (12:53ba)
	call Func_22fa
	jp EnableAutoTextBoxDrawing

RockTunnelPokecenterTextPointers: ; 493c0 (12:53c0)
	dw RockTunnelPokecenterText1
	dw RockTunnelPokecenterText2
	dw RockTunnelPokecenterText3
	dw RockTunnelPokecenterText4
	dw RockTunnelPokecenterText5

RockTunnelPokecenterText1: ; 493c8 (12:53c8)
	db $ff

RockTunnelPokecenterText2: ; 493c9 (12:53c9)
	TX_FAR _RockTunnelPokecenterText1
	db "@"

RockTunnelPokecenterText3: ; 493ce (12:53ce)
	TX_FAR _RockTunnelPokecenterText3
	db "@"

RockTunnelPokecenterText4: ; 493d3 (12:53d3)
	db $f6

RockTunnelPokecenterText5: ; 49651 (12:5651)
	db $8
	ld a, [wRoamingFlag]
	bit 6, a
	jr nz, .AmuletCoinExplain
	ld a, 20 ; pokemon needed
	ld [$ffdb], a
	ld a, AMULET_COIN ; oak's aide reward
	ld [$ffdc], a
	ld [wd11e], a
	call GetItemName
	ld hl, wcd6d
	ld de, wcc5b
	ld bc, $000d
	call CopyData
	predef OaksAideScript ; call oak's aide script
	ld a, [$ffdb]
	cp $1
	jr nz, .finish
	ld hl, wRoamingFlag
	set 6, [hl]
.AmuletCoinExplain
	ld hl, RockTunnelPokecenterTextAmuletCoin
	call PrintText
.finish
	jp TextScriptEnd

RockTunnelPokecenterTextAmuletCoin: ; 4968c (12:568c)
	TX_FAR _RockTunnelPokecenterTextAmuletCoin
	db "@"