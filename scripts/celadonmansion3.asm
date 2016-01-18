CeladonMansion3Script: ; 48790 (12:4790)
	jp EnableAutoTextBoxDrawing

CeladonMansion3TextPointers: ; 48793 (12:4793)
	dw ProgrammerText
	dw GraphicArtistText
	dw WriterText
	dw DirectorText
	dw GameFreakPCText1
	dw GameFreakPCText2
	dw GameFreakPCText3
	dw GameFreakSignText

ProgrammerText: ; 487a3 (12:47a3)
	TX_FAR _ProgrammerText
	db "@"

GraphicArtistText: ; 487a8 (12:47a8)
	TX_FAR _GraphicArtistText
	db "@"

WriterText: ; 487ad (12:47ad)
	TX_FAR _WriterText
	db "@"

DirectorText: ; 487b2 (12:47b2)
	db $08 ; asm
	ld a, [W_DEXCOMPLETED]
	and a
; if your dex is already completed, prevent charm and diploma from being handed out again
	jr nz, .DexAlreadyCompleted
	; check pokédex
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wd11e]
	cp 252
; do they have 252 pokemon?
; if so, give them the charm and the diploma
	jr nc, .CompletedDex
	ld hl, .GameDesigner
	jr .done
.CompletedDex
	ld hl, .CompletedDexText
	jr .done
.DexAlreadyCompleted
	ld hl, .PostCompletedDexText
.done
	call PrintText
	jp TextScriptEnd

.GameDesigner ; 487d0 (12:47d0)
	TX_FAR _GameDesignerText
	db "@"

.PostCompletedDexText ; 487d0 (12:47d0)
	TX_FAR _PostCompletedDexText
	db "@"

.CompletedDexText
	TX_FAR _CompletedDexText
	db $6
	db $8 ; asm
	lda b, SHINY_CHARM
	ld c, 1
	call GiveItem
	jr nc, .BagFull
	ld hl, ReceivedShinyCharmText
	call PrintText
	callab DisplayDiploma
	ld a, HS_MEW
	ld [wcc4d], a
	predef ShowObject
	ld a, HS_JIRACHI
	ld [wcc4d], a
	predef ShowObject
; unlock Mew and Jirachi
	ld a, 1
	ld [W_DEXCOMPLETED], a
	ld hl, wRoamingFlag
	set DIPLOMASEEN, [hl]
; set this flag as it is a requirement for Oak
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd
.BagFull
	ld hl, ShinyCharmNoRoomText
	call PrintText
	jp TextScriptEnd

GameFreakPCText1: ; 487eb (12:47eb)
	TX_FAR _CeladonMansion3Text5
	db "@"

GameFreakPCText2: ; 487f0 (12:47f0)
	TX_FAR _CeladonMansion3Text6
	db "@"

GameFreakPCText3: ; 487f5 (12:47f5)
	TX_FAR _CeladonMansion3Text7
	db "@"

GameFreakSignText: ; 487fa (12:47fa)
	TX_FAR _CeladonMansion3Text8
	db "@"

ReceivedShinyCharmText:
	TX_FAR _ReceivedShinyCharmText
	db $12, "@"

ShinyCharmNoRoomText:
	TX_FAR _ShinyCharmNoRoomText
	db "@"