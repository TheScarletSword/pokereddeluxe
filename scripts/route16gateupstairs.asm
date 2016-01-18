Route16GateUpstairsScript: ; 4980b (12:580b)
	jp DisableAutoTextBoxDrawing

Route16GateUpstairsTextPointers: ; 4980e (12:580e)
	dw Route16GateUpstairsText1
	dw Route16GateUpstairsText2
	dw Route16GateUpstairsText3
	dw Route16GateUpstairsText4
	dw Route16GateUpstairsText5

Route16GateUpstairsText1: ; 49816 (12:5816)
	db $08 ; asm
	ld hl, Route16GateUpstairsText_49820
	call PrintText
	jp TextScriptEnd

Route16GateUpstairsText_49820: ; 49820 (12:5820)
	TX_FAR _Route16GateUpstairsText_49820
	db "@"

Route16GateUpstairsText2: ; 49825 (12:5825)
	db $08 ; asm
	ld hl, Route16GateUpstairsText_4982f
	call PrintText
	jp TextScriptEnd

Route16GateUpstairsText_4982f: ; 4982f (12:582f)
	TX_FAR _Route16GateUpstairsText_4982f
	db "@"

Route16GateUpstairsText3: ; 49834 (12:5834)
	db $8
	ld hl, Route16GateUpstairsText_4983b
	jp Route12GateUpstairsScript_495c9

Route16GateUpstairsText_4983b: ; 4983b (12:583b)
	TX_FAR _Route16GateUpstairsText_4983b
	db "@"

Route16GateUpstairsText4: ; 49840 (12:5840)
	db $8
	ld hl, Route16GateUpstairsText_49847 ; $5847
	jp Route12GateUpstairsScript_495c9

Route16GateUpstairsText_49847: ; 49847 (12:5847)
	TX_FAR _Route16GateUpstairsText_49847
	db "@"

Route16GateUpstairsText5: ; 49651 (12:5651)
	db $8
	ld a, [wRoamingFlag]
	bit 1, a
	jr nz, .LuckyEggExplain
	ld a, 40 ; pokemon needed
	ld [$ffdb], a
	ld a, LUCKY_EGG ; oak's aide reward
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
	set 1, [hl]
.LuckyEggExplain
	ld hl, Route16GateUpstairsTextLuckyEgg
	call PrintText
.finish
	jp TextScriptEnd

Route16GateUpstairsTextLuckyEgg: ; 4968c (12:568c)
	TX_FAR _Route16GateUpstairsTextLuckyEgg
	db "@"