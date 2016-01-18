; enables direct burning for Will-o-Wisp (the same way Thunder Wave would work, or Toxic)
BurnEffect_: ; 52601 (14:6601)
	ld hl, wEnemyMonStatus ; wcfe9
	ld de, W_PLAYERMOVETYPE ; wcfd5
	ld a, [H_WHOSETURN] ; $fff3
	and a
	jp z, .asm_52613
	ld hl, wBattleMonStatus ; wBattleMonStatus
	ld de, W_ENEMYMOVETYPE ; wcfcf

.asm_52613
	call CheckTargetSubstitute2
	jr nz, .asm_52666 ; can't burn a substitute target
	ld a, [hl]
	and a
	jr nz, .asm_52659
	ld a, [de]
	cp $14
	jr nz, .asm_5262a
	ld b, h
	ld c, l
	inc bc
	ld a, [bc]
	cp $14
	jr z, .asm_52666
	inc bc
	ld a, [bc]
	cp $14
	jr z, .asm_52666
.asm_5262a
	push hl
	callab MoveHitTest
	pop hl
	ld a, [W_MOVEMISSED] ; W_MOVEMISSED
	and a
	jr nz, .asm_52659
	set 4, [hl]
	callab HalveAttackDueToBurn
	ld c, $1e
	call DelayFrames
	callab Func_3fba8
	ld hl, PrintBurnedText
	ld b, BANK(PrintMayNotAttackText)
	jp Bankswitch
.asm_52659
	ld c, $32
	call DelayFrames
	ld hl, PrintDidntAffectText
	ld b, BANK(PrintDidntAffectText)
	jp Bankswitch
.asm_52666
	ld c, $32
	call DelayFrames
	ld hl, PrintDoesntAffectText
	ld b, BANK(PrintDoesntAffectText)
	jp Bankswitch