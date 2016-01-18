; this is a neat little workaround to the problem present in sanky's crystal audio engine hack - that is, trading mons will delete your save file
; this saving routine is ONLY called after a trade is completed

SaveSAVLink:: ;$770a
	call SaveSAVLinktoSRAM      ;$7848
	hlCoord 1, 13
	ld bc,$0412
	call ClearScreenArea ; clear area 4x12 starting at 13,1
	hlCoord 1, 14
	ld de,NowSavingStringLink
	call PlaceString
	ld c,$78
	call DelayFrames
	ld hl,GameSavedTextLink
	call PrintText
	ld a, RBSFX_02_5d ;sound for saved game
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld c,$1e
	ret

NowSavingStringLink:
	db "Now saving...@"

GameSavedTextLink: ; 73782 (1c:7782)
	TX_FAR _GameSavedText
	db "@"

SaveSAVLinktoSRAM2: ; 7380f (1c:780f)
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
	ld hl, wPartyCount
	ld de, $af2c
	ld bc, wPokedexOwned - wPartyCount
	call CopyData
	ld hl, wPokedexOwned ; pokédex only
	ld de, $a5a3
	ld bc, $26
	call CopyData
	ld hl, $a598
	ld bc, $f8b
	call SAVCheckSumLink
	ld [$b523], a
	xor a
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamEnable], a
	ret

SaveSAVLinktoSRAM: ; 73848 (1c:7848)
	ld a, $2
	ld [wd088], a
	
	ld a, 1
	ld [wHaltAudio], a
	
	call SaveSAVLinktoSRAM2
	
	ld a, 0
	ld [wHaltAudio], a
	
	ret

SAVCheckSumLink: ; 73856 (1c:7856)
;Check Sum (result[1 byte] is complemented)
	ld d, $0
.loop
	ld a, [hli]
	add d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ld a, d
	cpl
	ret