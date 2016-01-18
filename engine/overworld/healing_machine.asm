AnimateHealingMachine: ; 70433 (1c:4433)
	xor a
	call PlayMusic
	
	ld de, PokeCenterFlashingMonitorAndHealBall ; $44b7
	ld hl, vChars0 + $7c0
	ld bc, (BANK(PokeCenterFlashingMonitorAndHealBall) << 8) + $03
	call CopyVideoData
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	ld a, [rOBP1] ; $ff49
	push af
	ld a, $e0
	nop
	nop
	ld hl, wOAMBuffer + $84
	ld de, PokeCenterOAMData ; $44d7
	call Func_70503
	
	
	ld a, [wPartyCount] ; wPartyCount
	ld b, a
.asm_7046e
	call Func_70503
	ld a, RBSFX_02_4a
	call PlaySound
	ld c, $1e
	call DelayFrames
	dec b
	jr nz, .asm_7046e
	ld a, [wc0ef]
	cp $1f
	ld [wc0f0], a
	jr nz, .asm_70495
	ld a, $ff
	ld [wc0ee], a
	call PlaySound
	ld a, 0 ; BANK(Music_PkmnHealed)
	ld [wc0ef], a
.asm_70495
	ld a, MUSIC_PKMN_HEALED
	ld [wc0ee], a
	call PlayMusic
	ld d, %01110100
	call Func_704f3
	
.loop
	ld a, [Channel1MusicID]
	and a
	jr nz, .loop
	
	ld c, $20
	call DelayFrames
	pop af
	ld [rOBP1], a ; $ff49
	pop hl
	pop af
	ld [hl], a
	
	
	jp UpdateSprites

PokeCenterFlashingMonitorAndHealBall: ; 704b7 (1c:44b7)
	INCBIN "gfx/pokecenter_ball.2bpp"

; Pokeball sprites for the pokecenter
; HAXed to use palette 4
PokeCenterOAMData: ; 704d7 (1c:44d7)
	db $24,$34,$7C,$14 ; heal machine monitor
	db $2B,$30,$7D,$14 ; pokeballs 1-6
	db $2B,$38,$7D,$34
	db $30,$30,$7D,$14
	db $30,$38,$7D,$34
	db $35,$30,$7D,$14
	db $35,$38,$7D,$34

Func_704f3: ; 704f3 (1c:44f3)
	ld b, $8
.asm_704f5
	ld a, [rOBP1] ; $ff49
	xor d
	ld [rOBP1], a ; $ff49
	ld c, $a
	call DelayFrames
	dec b
	jr nz, .asm_704f5
	ret

Func_70503: ; 70503 (1c:4503)
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ret
