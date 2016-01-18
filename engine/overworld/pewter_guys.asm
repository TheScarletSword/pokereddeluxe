; primarily edited to disable the guy that brings you to brock's gym
PewterGuys: ; 37ca1 (d:7ca1)
	ld hl, wSimulatedJoypadStatesEnd
	ld a, [wSimulatedJoypadStatesIndex]
	dec a ; this decrement causes it to overwrite the last byte before $FF in the list
	ld [wSimulatedJoypadStatesIndex], a
	ld d, 0
	ld e, a
	add hl, de
	ld d, h
	ld e, l
	ld hl, PointerTable_37ce6
	ld a, [wd12f]
	add a
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [W_YCOORD]
	ld b, a
	ld a, [W_XCOORD]
	ld c, a
.asm_37cc7
	ld a, [hli]
	cp b
	jr nz, .asm_37ce1
	ld a, [hli]
	cp c
	jr nz, .asm_37ce2
	ld a, [hli]
	ld h, [hl]
	ld l, a
.asm_37cd2
	ld a, [hli]
	cp $ff
	ret z
	ld [de], a
	inc de
	ld a, [wSimulatedJoypadStatesIndex]
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	jr .asm_37cd2
.asm_37ce1
	inc hl
.asm_37ce2
	inc hl
	inc hl
	jr .asm_37cc7

PointerTable_37ce6: ; 37ce6 (d:7ce6)
	dw PewterMuseumGuyCoords

; these are the four coordinates of the spaces below, above, to the left and
; to the right of the museum guy, and pointers to different movements for
; the player to make to get positioned before the main movement.
PewterMuseumGuyCoords: ; 37cea (d:7cea)
	db 18, 27
	dw .down
	db 16, 27
	dw .up
	db 17, 26
	dw .left
	db 17, 28
	dw .right

.down
	db $40, $40, $ff
.up
	db $10, $20, $ff
.left
	db $40, $10, $ff
.right
	db $40, $20, $ff