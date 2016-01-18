ReadBattleTentTrainer:
	ld a, 50
	ld [W_CURENEMYLVL],a
	ld a, [wBTClass]
	ld hl, BTTrainerClassList + 2 ; Team selector
	ld bc, 3
	call AddNTimes
	ld a, [hl]
	and a
	jr z, .anyTeam
	dec a
	ld hl, BTMonList
	ld bc, 8
	call AddNTimes ; now hl points to the specific team
	ld b, 3
.SpecificTeam
	push hl
	push bc
	call Random
	and 7
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wcf91],a
	ld a,1
	ld [wcc49],a
	call AddPartyMon
	pop bc
	pop hl
	dec b
	jr nz, .SpecificTeam
	ret
.anyTeam
	ld hl, BTMonList
	ld b, 3
.anyTeamLoop
	push hl
	push bc
	call Random
	and 63
	ld c, a ; max = 63
	ld a, [hRandomSub]
	bit 7, a
	jr z, .skipinc
	inc c ; max = 64
.skipinc
	and 7
	add c
	ld c, a ; max = 71
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wcf91],a
	ld a,1
	ld [wcc49],a
	call AddPartyMon
	pop bc
	pop hl
	dec b
	jr nz, .anyTeamLoop
	ret
