Func_39680: ; 39680 (e:5680)
	ld a, [H_WHOSETURN] ; $fff3
	and a
	ld a, [wd060]
	ld hl, wBattleMonAttack + 1
	jr z, .asm_39691
	ld a, [wd065]
	ld hl, wEnemyMonAttack + 1
.asm_39691
	ld c, $4
	ld b, a
.asm_39694
	srl b
	call c, Func_3969f
	inc hl
	inc hl
	dec c
	ret z
	jr .asm_39694

Func_3969f: ; 3969f (e:569f)
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	rl a
	ld [hli], a
	ret

Func_396a7: ; 396a7 (e:56a7)
	ld a, [H_WHOSETURN] ; $fff3
	and a
	ld a, [wd061]
	ld hl, wBattleMonAttack
	jr z, .asm_396b8
	ld a, [wd066]
	ld hl, wEnemyMonAttack
.asm_396b8
	ld c, $4
	ld b, a
.asm_396bb
	srl b
	call c, Func_396c6
	inc hl
	inc hl
	dec c
	ret z
	jr .asm_396bb

Func_396c6: ; 396c6 (e:56c6)
	ld a, [hl]
	srl a
	ld [hli], a
	rr [hl]
	or [hl]
	jr nz, .asm_396d1
	ld [hl], $1
.asm_396d1
	dec hl
	ret

_ScrollTrainerPicAfterBattle: ; 396d3 (e:56d3)
; Load the enemy trainer's pic and scrolls it into
; the screen from the right.
	xor a
	ld [wEnemyMonSpecies2], a
	ld b, $1
	call GoPAL_SET
	callab _LoadTrainerPic
	hlCoord 19, 0
	ld c, $0
.asm_396e9
	inc c
	ld a, c
	cp $7
	ret z
	ld d, $0
	push bc
	push hl
.asm_396f2
	call Func_39707
	inc hl
	ld a, $7
	add d
	ld d, a
	dec c
	jr nz, .asm_396f2
	ld c, $4
	call DelayFrames
	pop hl
	pop bc
	dec hl
	jr .asm_396e9

Func_39707: ; 39707 (e:5707)
	push hl
	push de
	push bc
	ld e, $7
.asm_3970c
	ld [hl], d
	ld bc, $14
	add hl, bc
	inc d
	dec e
	jr nz, .asm_3970c
	pop bc
	pop de
	pop hl
	ret

; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves: ; 39719 (e:5719)
	ld a, $14 ; changed to give us more breathing room
	ld hl, wHPBarMaxHP  ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
	ld a, [W_ENEMYDISABLEDMOVE] ; forbid disabled move (if any)
	swap a
	and $f
	jr z, .noMoveDisabled
	ld hl, wHPBarMaxHP
	dec a
	ld c, a
	ld b, $0
	add hl, bc    ; advance pointer to forbidden move
	ld [hl], $50  ; forbid (highly discourage) disabled move
.noMoveDisabled
	ld hl, TrainerClassMoveChoiceModifications ; 589B
	ld a, [W_TRAINERCLASS]
	ld b, a
.loopTrainerClasses
	dec b
	jr z, .readTrainerClassData
.loopTrainerClassData
	ld a, [hli]
	and a
	jr nz, .loopTrainerClassData
	jr .loopTrainerClasses
.readTrainerClassData
	ld a, [hl]
	and a
	jp z, .useOriginalMoveSet
	push hl
.nextMoveChoiceModification
	pop hl
	ld a, [hli]
	and a
	jr z, .loopFindMinimumEntries
	push hl
	ld hl, AIMoveChoiceModificationFunctionPointers ; $57a3
	dec a
	add a
	ld c, a
	ld b, $0
	add hl, bc    ; skip to pointer
	ld a, [hli]   ; read pointer into hl
	ld h, [hl]
	ld l, a
	ld de, .nextMoveChoiceModification  ; set return address
	push de
	jp [hl]       ; execute modification function
.loopFindMinimumEntries ; all entries will be decremented sequentially until one of them is zero
	ld hl, wHPBarMaxHP  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, $4
.loopDecrementEntries
	ld a, [de]
	inc de
	and a
	jr z, .loopFindMinimumEntries
	dec [hl]
	jr z, .minimumEntriesFound
	inc hl
	dec c
	jr z, .loopFindMinimumEntries
	jr .loopDecrementEntries
.minimumEntriesFound
	ld a, c
.loopUndoPartialIteration ; undo last (partial) loop iteration
	inc [hl]
	dec hl
	inc a
	cp $5
	jr nz, .loopUndoPartialIteration
	ld hl, wHPBarMaxHP  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, $4
.filterMinimalEntries ; all minimal entries now have value 1. All other slots will be disabled (move set to 0)
	ld a, [de]
	and a
	jr nz, .moveExisting ; 0x3978a $1
	ld [hl], a
.moveExisting
	ld a, [hl]
	dec a
	jr z, .slotWithMinimalValue
	xor a
	ld [hli], a     ; disable move slot
	jr .next
.slotWithMinimalValue
	ld a, [de]
	ld [hli], a     ; enable move slot
.next
	inc de
	dec c
	jr nz, .filterMinimalEntries
	ld hl, wHPBarMaxHP    ; use created temporary array as move set
	ret
.useOriginalMoveSet
	ld hl, wEnemyMonMoves    ; use original move set
	ret

AIMoveChoiceModificationFunctionPointers: ; 397a3 (e:57a3)
	dw AIMoveChoiceModification1
	dw AIMoveChoiceModification2
	dw AIMoveChoiceModification3
	dw SmartAI ; SmartAI code ahead by dabomstew

; discourages moves that cause no damage but only a status ailment if player's mon already has one
AIMoveChoiceModification1: ; 397ab (e:57ab)
	ld a, [wBattleMonStatus]
	and a
	jr z,.confusionCheck ; return if no status ailment on player's mon
	ld hl, wBuffer - 1  ; temp move selection array (-1 byte offest)
	ld de, wEnemyMonMoves  ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	jr z,.confusionCheck ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	jr z,.confusionCheck ; no more moves in move set
	inc de
	call ReadMove
	ld a, [W_ENEMYMOVEPOWER]
	and a
	jr nz, .nextMove
	ld a, [W_ENEMYMOVEEFFECT]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .nextMove
	ld a, [hl]
	add $20 ; heavily discourage move
	ld [hl], a
	jr .nextMove

.confusionCheck
	ld a,[W_PLAYERBATTSTATUS1]
	bit Confused,a
	jr z,.digOrFlyCheck
	ld hl,ConfusionMoves
	ld b,$20
	call AlterMovePriorityArray
	ld a,[W_PLAYERBATTSTATUS1]
.digOrFlyCheck
	bit Invulnerable,a
	jr z,.usingChargingMoveCheck
	ld a,[wEnemyMonSpeed]
	ld b,a
	ld a,[wEnemyMonSpeed+1]
	ld c,a
	ld a,[wBattleMonSpeed]
	ld d,a
	ld a,[wBattleMonSpeed+1]
	ld e,a
	
	ld a,d
	cp b
	jr c,.faster
	ld a,e
	cp c
	jr nc,.usingChargingMoveCheck
.faster
	ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.invLoop
    dec b
    jr z, .bideCheck
    inc hl
    ld a, [de]
    and a
    jr z, .bideCheck
    inc de
    call ReadMove
	ld a, [W_ENEMYMOVEPOWER]
	cp 10
    jr c, .invLoop
    ld a, [W_ENEMYMOVEEFFECT]
    cp MIRROR_MOVE_EFFECT
	jr c, .invLoop
	cp PAY_DAY_EFFECT
	jr c, .foundusablemove
	cp ATTACK_UP2_EFFECT
	jr c, .invLoop
	cp HEAL_EFFECT
	jr c, .foundusablemove
	push hl
	push de
	push bc
	ld hl,UsableMoveEffectsDuringFlyOrDig
	ld de,$1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .invLoop
.foundusablemove
	ld a,[hl]
	add -8
	ld [hl],a
	jr .invLoop
.usingChargingMoveCheck
	ld a,[W_PLAYERBATTSTATUS1]
	bit ChargingUp,a
	jr z, .bideCheck
	call Random
	cp $c0
	ld hl,DigOrFlyMoves
	ld b,-16
	jr c,.digorfly
	ld hl,ParalyzeBurnOrSleepMoves
.digorfly
	call AlterMovePriorityArray
	ld a,[W_PLAYERBATTSTATUS1]
.bideCheck
	bit StoringEnergy,a
	jr z,.mistCheck
	ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.doesDamageLoop
    dec b
    jr z, .mistCheck
    inc hl
    ld a, [de]
    and a
    jr z, .mistCheck
    inc de
    call ReadMove
	ld a, [W_ENEMYMOVEPOWER]
	cp 10
	jr nc,.discourageDamagingMove
	ld a, [W_ENEMYMOVEEFFECT]
	cp SPECIAL_DAMAGE_EFFECT
	jr nz,.doesDamageLoop
.discourageDamagingMove
	ld a,[hl]
	add $20
	ld [hl],a
	jr .doesDamageLoop
.mistCheck
	ld a,[W_PLAYERBATTSTATUS2]
	bit ProtectedByMist,a
	jr z, .substituteCheck
	ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.statLoweringMoveLoop
    dec b
    jr z, .substituteCheck
    inc hl
    ld a, [de]
    and a
    jr z, .substituteCheck
    inc de
    call ReadMove
	ld a,[W_ENEMYMOVEEFFECT]
	ld c,-8
	cp ATTACK_DOWN1_EFFECT
	jr c,.statLoweringMoveLoop
	cp CONVERSION_EFFECT
	jr c,.foundStatLoweringMove
	cp HAZE_EFFECT
	jr z,.foundHazeEffect
	cp ATTACK_DOWN2_EFFECT
	jr c,.statLoweringMoveLoop
	cp LIGHT_SCREEN_EFFECT
	jr nc,.statLoweringMoveLoop
.foundStatLoweringMove
	ld c,$20
.foundHazeEffect
	ld a,[hl]
	add c
	ld [hl],a
	jr .statLoweringMoveLoop
.substituteCheck
	ld a,[W_PLAYERBATTSTATUS2]
	bit HasSubstituteUp,a
	jr z,.seededCheck
	ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.doesNotEffectSubstituteLoop
    dec b
    jr z, .seededCheck
    inc hl
    ld a, [de]
    and a
    jr z, .seededCheck
    inc de
    call ReadMove
	cp ATTACK_DOWN1_EFFECT
	jr c,.doesNotEffectSubstituteLoop
	cp CONVERSION_EFFECT
	jr c,.foundNonAffectingMove
	cp ATTACK_DOWN2_EFFECT
	jr c,.doesNotEffectSubstituteLoop
	cp LIGHT_SCREEN_EFFECT
	jr c,.foundNonAffectingMove
	cp CONFUSION_EFFECT
	jr z,.foundNonAffectingMove
	cp POISON_EFFECT
	jr z,.foundNonAffectingMove
	cp PARALYZE_EFFECT
	jr nz,.doesNotEffectSubstituteLoop
.foundNonAffectingMove
	ld a,[hl]
	add $20
	ld [hl],a
	jr .doesNotEffectSubstituteLoop
.seededCheck
	ld a,[W_PLAYERBATTSTATUS2]
	bit Seeded,a
	jr z,.lightScreenCheck
	ld a,LEECH_SEED
	ld [W_AIBUFFER1],a
	ld b,$20
	call AlterMovePriority
.lightScreenCheck
	ld a,[W_PLAYERBATTSTATUS3]
	bit HasLightScreenUp,a
	jr z,.reflectCheck
	ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.discourageSpecialMovesLoop
    dec b
    jr z, .reflectCheck
    inc hl
    ld a, [de]
    and a
    jr z, .reflectCheck
    inc de
    call ReadMove
	ld a,[W_ENEMYMOVETYPE]
	cp FIRE
	jr c,.discourageSpecialMovesLoop
	ld a,[hl]
	add $8
	ld [hl],a
	jr .discourageSpecialMovesLoop
.reflectCheck
	ld a,[W_PLAYERBATTSTATUS3]
	bit HasReflectUp,a
	jr z,.enemySubstituteCheck
	ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.discouragePhysicalMovesLoop
    dec b
    jr z,.enemySubstituteCheck
    inc hl
    ld a, [de]
    and a
    jr z,.enemySubstituteCheck
    inc de
    call ReadMove
	ld a,[W_ENEMYMOVETYPE]
	cp FIRE
	jr nc,.discouragePhysicalMovesLoop
	ld a,[hl]
	add $8
	ld [hl],a
	jr .discouragePhysicalMovesLoop

.enemySubstituteCheck
	ld a,[W_ENEMYBATTSTATUS2]
	bit HasSubstituteUp,a
	ret z
	ld a,SUBSTITUTE
	ld [W_AIBUFFER1],a
	ld b,$10
	jp AlterMovePriority
	

ConfusionMoves:
	db SUPERSONIC
	db CONFUSE_RAY
	db $ff

StatusAilmentMoveEffects ; 57e2
	db $01 ; some sleep effect?
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db $FF

UsableMoveEffectsDuringFlyOrDig:
	db HAZE_EFFECT
	db BIDE_EFFECT
	db SWITCH_AND_TELEPORT_EFFECT
	db FLY_EFFECT
	db MIST_EFFECT
	db FOCUS_ENERGY_EFFECT ; Kappa
	db LIGHT_SCREEN_EFFECT
	db REFLECT_EFFECT
	db SUBSTITUTE_EFFECT
	db MIMIC_EFFECT
	db METRONOME_EFFECT ; Kappa
	db DISABLE_EFFECT
	db $ff

DigOrFlyMoves:
	db DIG
	db FLY
	db $ff
	
ParalyzeBurnOrSleepMoves:
	db STUN_SPORE
	db THUNDER_WAVE
	db GLARE
	db SING
	db SLEEP_POWDER
	db HYPNOSIS
	db LOVELY_KISS
	db SPORE
	db WILL_O_WISP
	db $ff
	
SmartAI:
; damaging move priority on turn 3+
    ld a, [wccd5]
    cp $2
    jr c, .healingcheck
    ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.damageloop
    dec b
    jr z, .healingcheck
    inc hl
    ld a, [de]
    and a
    jr z, .healingcheck
    inc de
    call ReadMove
    ld a, [W_ENEMYMOVEPOWER]
	and a
    jr z, .damageloop
; encourage by 2
    dec [hl]
    dec [hl]
    jr .damageloop
; healing moves?
.healingcheck
    ld a, [wEnemyMonMaxHP]
    and a
    jr z, .noscale
    ld b, a
    ld a, [wEnemyMonMaxHP+1]
    srl b
    rr a
    ld b, a
    ld a, [wEnemyMonHP]
    ld c, a
    ld a, [wEnemyMonHP+1]
    srl c
    rr a
    ld c, a
    jr .realhealcheck
.noscale
    ld a, [wEnemyMonMaxHP+1]
    ld b, a
    ld a, [wEnemyMonHP+1]
    ld c, a
.realhealcheck
    push bc
	srl b
    ld a, c
    cp b
    ld hl, HealingMoves
    jr nc, .debuffhealingmoves
	ld b, -8
    call Random
    ld a, [hRandomAdd]
    cp $C0 ; 3/4 chance
    jr nc, .explosioncheck
    jr .applyhealingchange
.debuffhealingmoves
    ld b, 10
.applyhealingchange
    call AlterMovePriorityArray
.explosioncheck
	pop bc
	sra c
	sra c
	ld a,c
	cp b ; HP 1/4 of total HP?
	ld hl, ExplosionMoves
	jr nc, .debuffexplosionmoves
	ld b, -8
	call Random
	cp $c0 ; 3/4 chance
	jr nc, .superfangcheck
	jr .applyexplosionchange
.debuffexplosionmoves
	ld b, 10
.applyexplosionchange
	call AlterMovePriorityArray
.superfangcheck
	ld a,SUPER_FANG
	ld [W_AIBUFFER1],a
	ld a,[wEnemyMonHP]
	ld b,a
	ld a,[wEnemyMonHP+1]
	ld c,a
	ld h,b
	ld l,c
	add hl,bc ; scale current HP x4
	add hl,bc
	add hl,bc
	ld c,l
	ld b,h
	
	ld a,[wEnemyMonMaxHP]
	ld d,a
	ld a,[wEnemyMonMaxHP+1]
	ld e,a
	ld h,d
	ld l,e
	add hl,de ; scale total HP x3
	add hl,de
	ld e,l
	ld d,h
	
	ld a,d ; wEnemyMonHPMax
	cp b ; is 4 * current HP greater than 3 * max HP?
	jr nc,.curHPgreater
	ld a,e
	cp c
	ld b,$20
	jr c,.curHPnotgreater
.curHPgreater
	ld b,-5
	call Random
	cp $c0
	jr nc,.dreameatercheck
.curHPnotgreater
	call AlterMovePriority
	
.dreameatercheck
    ld a, [wBattleMonStatus]
    and SLP
    ld a, DREAM_EATER
    ld [W_AIBUFFER1], a
    jr z, .debuffdreameater
    ld b, -1
    jr .applydreameater
.debuffdreameater
    ld b, 20
.applydreameater
    call AlterMovePriority
.effectivenesscheck
; encourage any damaging move with SE; slightly discourage any NVE move but not by as much
    ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld b, NUM_MOVES + 1
.seloop
    dec b
    jr z, .selfbuffcheck
    inc hl
    ld a, [de]
    and a
    jr z, .selfbuffcheck
    inc de
    call ReadMove
    ld a, [W_ENEMYMOVEEFFECT]
    cp SUPER_FANG_EFFECT
    jr z, .seloop
    cp SPECIAL_DAMAGE_EFFECT
    jr z, .seloop
    ld a, [W_ENEMYMOVEPOWER]
	cp 10
    jr c, .seloop
    push hl
	push bc
	push de
	callab AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
    ld a, [wd11e]
    cp 10
    jr z, .seloop
    jr c, .nvemove
; strongly encourage (SE)
    rept 4
    dec [hl]
    endr
    cp $15
    jr c, .seloop
; strongly encourage 4x SE even more
    rept 3
    dec [hl]
    endr
    jr .seloop
.nvemove
; slightly discourage
    inc [hl]
    and a
    jr nz, .seloop
; strongly discourage immunity
    ld a, [hl]
    add 50
    ld [hl], a
    jr .seloop
.selfbuffcheck
; 50% chance to encourage self-buff or status on turn 1/2
    ld a, [wccd5]
    cp $2
    ret nc
    call Random
    ld a, [hRandomAdd]
    cp $80
    ret nc
    ld hl, MehStatusMoves
    ld b, -3
    call AlterMovePriorityArray
    ld hl, LightBuffStatusMoves
    ld b, -5
    call AlterMovePriorityArray
    ld hl, HeavyBuffStatusMoves
    ld b, -6
    call AlterMovePriorityArray
    ret
    
MehStatusMoves:
    db GROWL
    db DISABLE
    db MIST
    db HARDEN
    db WITHDRAW
    db DEFENSE_CURL
    db TAIL_WHIP
    db LEER
    db $FF
    
LightBuffStatusMoves:
    db GROWTH
    db MEDITATE
    db AGILITY
    db MINIMIZE
    db DOUBLE_TEAM
    db REFLECT
    db LIGHT_SCREEN
    db BARRIER
    db SUBSTITUTE
    db POISONPOWDER
    db STRING_SHOT
    db SCREECH
    db SMOKESCREEN
    db POISON_GAS
    db FLASH
    db SHARPEN
    db SAND_ATTACK
    db COSMIC_POWER
    db FAKE_TEARS
    db ROCK_POLISH
    db METAL_SOUND
    db $FF

HeavyBuffStatusMoves:
    db SWORDS_DANCE
    db AMNESIA
    db SING
    db SLEEP_POWDER
    db HYPNOSIS
    db LOVELY_KISS
    db SPORE
    db STUN_SPORE
    db THUNDER_WAVE
    db GLARE
    db CONFUSE_RAY
    db SUPERSONIC
    db GEAR_GRIND
    db WILL_O_WISP
    db $FF
    
HealingMoves:
    db REST
    db RECOVER
    db SOFTBOILED
    db MOONLIGHT
    db ROOST
    db SYNTHESIS
    db $FF

ExplosionMoves:
	db EXPLOSION
	db SELFDESTRUCT
	db $FF
	

AlterMovePriority:
; look for move in W_AIBUFFER in wEnemyMonMoves
; [W_AIBUFFER1] = move
; b = priority change
    ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld c, NUM_MOVES+1
.moveloop
    dec c
    jr z,.done
	inc hl
    ld a, [de]
    and a
    jr z,.done
    inc de
    push bc
    ld b, a
    ld a, [W_AIBUFFER1]
    cp b
    pop bc
    jr nz, .moveloop
    ld a, [hl]
    add b
    ld [hl], a
.done
    ret
    
AlterMovePriorityArray:
; find if the enemy mon's moveset has a move in move array hl
; hl = move array
; b = priority change
    ld a, h
    ld [W_AIBUFFER1], a
    ld a, l
    ld [W_AIBUFFER2], a
    ld hl, wBuffer - 1
    ld de, wEnemyMonMoves
    ld c, NUM_MOVES+1
.moveloop
    dec c
    ret z
    inc hl
    ld a, [de]
    and a
    ret z
    inc de
    push hl
	push de
	push bc
    ld b, a
    ld a, [W_AIBUFFER1]
    ld h, a
    ld a, [W_AIBUFFER2]
    ld l, a
    ld a, b
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
    jr nc, .moveloop
    ld a, [hl]
    add b
    ld [hl], a
    ret

; slightly encourage moves with specific effects
AIMoveChoiceModification2: ; 397e7 (e:57e7)
	ld a, [wccd5]
	cp $1
	ret nz
	ld hl, wBuffer - 1  ; temp move selection array (-1 byte offest)
	ld de, wEnemyMonMoves  ; enemy moves
	ld b, $5
.nextMove
	dec b
	ret z         ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z         ; no more moves in move set
	inc de
	call ReadMove
	ld a, [W_ENEMYMOVEEFFECT]
	cp ATTACK_UP1_EFFECT
	jr c, .nextMove
	cp BIDE_EFFECT
	jr c, .preferMove
	cp ATTACK_UP2_EFFECT
	jr c, .nextMove
	cp POISON_EFFECT
	jr c, .preferMove
	jr .nextMove
.preferMove
	dec [hl]       ; slighly encourage this move
	jr .nextMove

; encourages moves that are effective against the player's mon
AIMoveChoiceModification3: ; 39817 (e:5817)
	ld hl, wBuffer - 1  ; temp move selection array (-1 byte offest)
	ld de, wEnemyMonMoves  ; enemy moves
	ld b, $5
.nextMove
	dec b
	ret z         ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z         ; no more moves in move set
	inc de
	call ReadMove
	ld a, [W_ENEMYMOVEPOWER]
	and a
	jr z, .nextMove ; don't encourage status moves that are "super-effective"
	push hl
	push bc
	push de
	callab AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wd11e]
	cp $10
	jr z, .nextMove
	jr c, .notEffectiveMove
	dec [hl]       ; slighly encourage this move
	jr .nextMove
.notEffectiveMove  ; discourages non-effective moves if better moves are available
	push hl
	push de
	push bc
	ld a, [W_ENEMYMOVETYPE]
	ld d, a
	ld hl, wEnemyMonMoves  ; enemy moves
	ld b, NUM_MOVES + 1
	ld c, $0
.loopMoves
	dec b
	jr z, .done
	ld a, [hli]
	and a
	jr z, .done
	call ReadMove
	ld a, [W_ENEMYMOVEEFFECT]
	cp SUPER_FANG_EFFECT
	jr z, .betterMoveFound      ; Super Fang is considered to be a better move
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .betterMoveFound      ; any special damage moves are considered to be better moves
	cp FLY_EFFECT
	jr z, .betterMoveFound      ; Fly is considered to be a better move
	ld a, [W_ENEMYMOVETYPE]
	cp d
	jr z, .loopMoves
	ld a, [W_ENEMYMOVEPOWER]
	and a
	jr nz, .betterMoveFound      ; damaging moves of a different type are considered to be better moves
	jr .loopMoves
.betterMoveFound
	ld c, a
.done
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jr z, .nextMove
	inc [hl]       ; slighly discourage this move
	jr .nextMove
AIMoveChoiceModification4: ; 39883 (e:5883)
	ret

ReadMove: ; 39884 (e:5884)
	push hl
	push de
	push bc
	dec a
	call LoadHLMoves
	ld bc,6
	call AddNTimes
	ld de,W_ENEMYMOVENUM
	call CopyData
	pop bc
	pop de
	pop hl
	ret

; move choice modification methods that are applied for each trainer class
; 0 is sentinel value
TrainerClassMoveChoiceModifications: ; 3989b (e:589b)
IF CHALLENGE_MODE
	db 1,4,0  ; YOUNGSTER
	db 1,4,0  ; BUG CATCHER
	db 1,4,0  ; LASS
	db 1,4,0  ; SAILOR
	db 1,4,0  ; JR__TRAINER_M
	db 1,4,0  ; JR__TRAINER_F
	db 1,4,0  ; POKEMANIAC
	db 1,4,0  ; SUPER_NERD
	db 1,4,0  ; HIKER
	db 1,4,0  ; BIKER
	db 1,4,0  ; BURGLAR
	db 1,4,0  ; ENGINEER
	db 1,4,0  ; JUGGLER_X
	db 1,4,0  ; FISHER
	db 1,4,0  ; SWIMMER
	db 1,4,0  ; CUE_BALL
	db 1,4,0  ; GAMBLER
	db 1,4,0  ; BEAUTY
	db 1,4,0  ; PSYCHIC_TR
	db 1,4,0  ; ROCKER
	db 1,4,0  ; JUGGLER
	db 1,4,0  ; TAMER
	db 1,4,0  ; BIRD_KEEPER
	db 1,4,0  ; BLACKBELT
	db 1,4,0  ; SONY1
	db 1,4,0  ; PROF_OAK
	db 1,4,0  ; CHIEF
	db 1,4,0  ; SCIENTIST
	db 1,4,0  ; GIOVANNI
	db 1,4,0  ; ROCKET
	db 1,4,0  ; COOLTRAINER_M
	db 1,4,0  ; COOLTRAINER_F
	db 1,4,0  ; BRUNO
	db 1,4,0  ; BROCK
	db 1,4,0  ; MISTY
	db 1,4,0  ; LT__SURGE
	db 1,4,0  ; ERIKA
	db 1,4,0  ; KOGA
	db 1,4,0  ; BLAINE
	db 1,4,0  ; SABRINA
	db 1,4,0  ; GENTLEMAN
	db 1,4,0  ; SONY2
	db 1,4,0  ; SONY3
	db 1,4,0  ; LORELEI
	db 1,4,0  ; CHANNELER
	db 1,4,0  ; AGATHA
	db 1,4,0  ; LANCE
	db 1,4,0  ; LEAGUES_PC
	db 1,4,0  ; HEAD_BROCK
	db 1,4,0  ; HEAD_KOGA
	db 1,4,0  ; HEAD_BLAINE
	db 1,4,0  ; HEAD_ROCKET
	db 1,4,0  ; HEAD_LORELEI
	db 1,4,0  ; HEAD_LANCE
	db 1,4,0  ; HEAD_OAK
ELSE
; Normal Mode
	db 1,0    ; YOUNGSTER
	db 1,0    ; BUG CATCHER
	db 1,0    ; LASS
	db 1,0    ; SAILOR
	db 1,0    ; JR__TRAINER_M
	db 1,0    ; JR__TRAINER_F
	db 1,3,0  ; POKEMANIAC
	db 1,3,0  ; SUPER_NERD
	db 1,0    ; HIKER
	db 1,0    ; BIKER
	db 1,2,0  ; BURGLAR
	db 1,0    ; ENGINEER
	db 1,2,0  ; JUGGLER_X
	db 1,0    ; FISHER
	db 1,0    ; SWIMMER
	db 1,0    ; CUE_BALL
	db 1,0    ; GAMBLER
	db 1,0    ; BEAUTY
	db 1,3,0  ; PSYCHIC_TR
	db 1,0    ; ROCKER
	db 1,0    ; JUGGLER
	db 1,0    ; TAMER
	db 1,0    ; BIRD_KEEPER
	db 1,0    ; BLACKBELT
	db 1,4,0  ; SONY1
	db 1,4,0  ; PROF_OAK
	db 1,3,0  ; CHIEF
	db 1,3,0  ; SCIENTIST
	db 1,4,0  ; GIOVANNI
	db 1,0    ; ROCKET
	db 1,3,0  ; COOLTRAINER_M
	db 1,3,0  ; COOLTRAINER_F
	db 1,4,0  ; BRUNO
	db 1,4,0  ; BROCK
	db 1,4,0  ; MISTY
	db 1,4,0  ; LT__SURGE
	db 1,4,0  ; ERIKA
	db 1,4,0  ; KOGA
	db 1,4,0  ; BLAINE
	db 1,4,0  ; SABRINA
	db 1,3,0  ; GENTLEMAN
	db 1,4,0  ; SONY2
	db 1,4,0  ; SONY3
	db 1,4,0  ; LORELEI
	db 1,0    ; CHANNELER
	db 1,4,0  ; AGATHA
	db 1,4,0  ; LANCE
	db 1,4,0  ; LEAGUES_PC
	db 1,4,0  ; HEAD_BROCK
	db 1,4,0  ; HEAD_KOGA
	db 1,4,0  ; HEAD_BLAINE
	db 1,4,0  ; HEAD_ROCKET
	db 1,4,0  ; HEAD_LORELEI
	db 1,4,0  ; HEAD_LANCE
	db 1,4,0  ; HEAD_OAK
ENDC

; two separate money pointers is my fix to the amulet coin issue
; not the most effective way to do it but whatever
TrainerPicAndMoneyPointers: ; 39914 (e:5914)
; trainer pic pointers and base money.
; money received after battle = base money × level of highest-level enemy mon
	dw YoungsterPic
	db 0,$15,0

	dw BugCatcherPic
	db 0,$10,0

	dw LassPic
	db 0,$15,0

	dw SailorPic
	db 0,$30,0

	dw JrTrainerMPic
	db 0,$20,0

	dw JrTrainerFPic
	db 0,$20,0

	dw PokemaniacPic
	db 0,$50,0

	dw SuperNerdPic
	db 0,$25,0

	dw HikerPic
	db 0,$35,0

	dw BikerPic
	db 0,$20,0

	dw BurglarPic
	db 0,$90,0

	dw EngineerPic
	db 0,$50,0

	dw JugglerPic
	db 0,$35,0

	dw FisherPic
	db 0,$35,0

	dw SwimmerPic
	db 0,$05,0

	dw CueBallPic
	db 0,$25,0

	dw GamblerPic
	db 0,$70,0

	dw BeautyPic
	db 0,$70,0

	dw PsychicPic
	db 0,$10,0

	dw RockerPic
	db 0,$25,0

	dw JugglerPic
	db 0,$35,0

	dw TamerPic
	db 0,$40,0

	dw BirdKeeperPic
	db 0,$25,0

	dw BlackbeltPic
	db 0,$25,0

	dw Rival1Pic
	db 0,$35,0

	dw ProfOakPic
	db 0,$99,0

	dw ChiefPic
	db 0,$30,0

	dw ScientistPic
	db 0,$50,0

	dw GiovanniPic
	db 0,$99,0

	dw RocketPic
	db 0,$30,0

	dw CooltrainerMPic
	db 0,$35,0

	dw CooltrainerFPic
	db 0,$35,0

	dw BrunoPic
	db 0,$99,0

	dw BrockPic
	db 0,$99,0

	dw MistyPic
	db 0,$99,0

	dw LtSurgePic
	db 0,$99,0

	dw ErikaPic
	db 0,$99,0

	dw KogaPic
	db 0,$99,0

	dw BlainePic
	db 0,$99,0

	dw SabrinaPic
	db 0,$99,0

	dw GentlemanPic
	db 0,$70,0

	dw Rival2Pic
	db 0,$65,0

	dw Rival3Pic
	db 0,$99,0

	dw LoreleiPic
	db 0,$99,0

	dw ChannelerPic
	db 0,$30,0

	dw AgathaPic
	db 0,$99,0

	dw LancePic
	db 0,$99,0

	dw LeaguePCPic
	db 0,$99,0

	dw HeadBrockPic
	db 0,0,0
	
	dw HeadKogaPic
	db 0,0,0

	dw HeadBlainePic
	db 0,0,0

	dw HeadGiovanniPic
	db 0,0,0

	dw HeadLoreleiPic
	db 0,0,0

	dw HeadLancePic
	db 0,0,0

	dw HeadProfOakPic
	db 0,0,0

TrainerPicAndMoneyPointers2: ; 39914 (e:5914)
; trainer pic pointers and base money.
; money received after battle = base money × level of highest-level enemy mon
	dw YoungsterPic
	db 0,$2A,0

	dw BugCatcherPic
	db 0,$20,0

	dw LassPic
	db 0,$2A,0

	dw SailorPic
	db 0,$60,0

	dw JrTrainerMPic
	db 0,$40,0

	dw JrTrainerFPic
	db 0,$40,0

	dw PokemaniacPic
	db 0,$A0,0

	dw SuperNerdPic
	db 0,$4A,0

	dw HikerPic
	db 0,$6A,0

	dw BikerPic
	db 0,$40,0

	dw BurglarPic
	db 0,$FF,0

	dw EngineerPic
	db 0,$A0,0

	dw JugglerPic
	db 0,$6A,0

	dw FisherPic
	db 0,$6A,0

	dw SwimmerPic
	db 0,$0A,0

	dw CueBallPic
	db 0,$4A,0

	dw GamblerPic
	db 0,$E0,0

	dw BeautyPic
	db 0,$E0,0

	dw PsychicPic
	db 0,$20,0

	dw RockerPic
	db 0,$4A,0

	dw JugglerPic
	db 0,$6A,0

	dw TamerPic
	db 0,$80,0

	dw BirdKeeperPic
	db 0,$4A,0

	dw BlackbeltPic
	db 0,$4A,0

	dw Rival1Pic
	db 0,$6A,0

	dw ProfOakPic
	db 0,$FF,0

	dw ChiefPic
	db 0,$60,0

	dw ScientistPic
	db 0,$A0,0

	dw GiovanniPic
	db 0,$FF,0

	dw RocketPic
	db 0,$60,0

	dw CooltrainerMPic
	db 0,$6A,0

	dw CooltrainerFPic
	db 0,$6A,0

	dw BrunoPic
	db 0,$FF,0

	dw BrockPic
	db 0,$FF,0

	dw MistyPic
	db 0,$FF,0

	dw LtSurgePic
	db 0,$FF,0

	dw ErikaPic
	db 0,$FF,0

	dw KogaPic
	db 0,$FF,0

	dw BlainePic
	db 0,$FF,0

	dw SabrinaPic
	db 0,$FF,0

	dw GentlemanPic
	db 0,$E0,0

	dw Rival2Pic
	db 0,$CA,0

	dw Rival3Pic
	db 0,$FF,0

	dw LoreleiPic
	db 0,$FF,0

	dw ChannelerPic
	db 0,$60,0

	dw AgathaPic
	db 0,$FF,0

	dw LancePic
	db 0,$FF,0

	dw LeaguePCPic
	db 0,$FF,0

	dw HeadBrockPic
	db 0,0,0
	
	dw HeadKogaPic
	db 0,0,0

	dw HeadBlainePic
	db 0,0,0

	dw HeadGiovanniPic
	db 0,0,0

	dw HeadLoreleiPic
	db 0,0,0

	dw HeadLancePic
	db 0,0,0

	dw HeadProfOakPic
	db 0,0,0

INCLUDE "text/trainer_names.asm"

Func_39b87: ; 39b87 (e:5b87)
	ld hl, wd0dc
	ld de, wd0e1
	ld b, $0
.asm_39b8f
	ld a, [hli]
	and a
	jr z, .asm_39bc1
	push hl
	ld [wd0b5], a
	ld a, BANK(MoveNames)
	ld [wPredefBank], a
	ld a, MOVE_NAME
	ld [W_LISTTYPE], a
	call GetName
	ld hl, wcd6d
.asm_39ba7
	ld a, [hli]
	cp $50
	jr z, .asm_39bb0
	ld [de], a
	inc de
	jr .asm_39ba7
.asm_39bb0
	ld a, b
	ld [wcd6c], a
	inc b
	ld a, $4e
	ld [de], a
	inc de
	pop hl
	ld a, b
	cp $4
	jr z, .asm_39bd1
	jr .asm_39b8f
.asm_39bc1
	ld a, "-"
	ld [de], a
	inc de
	inc b
	ld a, b
	cp $4
	jr z, .asm_39bd1
	ld a, $4e
	ld [de], a
	inc de
	jr .asm_39bc1
.asm_39bd1
	ld a, "@"
	ld [de], a
	ret

Func_39bd5: ; 39bd5 (e:5bd5)
	ld a, [wd11b]
	cp $1
	jr nz, .asm_39be6
	ld hl, wEnemyPartyCount ; wEnemyPartyCount
	ld de, wEnemyMonOT ; wd9ac OT names of other player
	ld a, $6
	jr .asm_39c18
.asm_39be6
	cp $4
	jr nz, .calcAttackStat4
	ld hl, wPartyCount ; wPartyCount
	ld de, wPartyMonOT ; wd273
	ld a, $5
	jr .asm_39c18
.calcAttackStat4
	cp $5
	jr nz, .asm_39c02
	ld hl, wStringBuffer2 + 11
	ld de, MonsterNames ; $421e
	ld a, $1
	jr .asm_39c18
.asm_39c02
	cp $2
	jr nz, .asm_39c10
	ld hl, wNumBagItems ; wNumBagItems
	ld de, ItemNames ; $472b
	ld a, $4
	jr .asm_39c18
.asm_39c10
	ld hl, wStringBuffer2 + 11
	ld de, ItemNames ; $472b
	ld a, ITEM_NAME
.asm_39c18
	ld [W_LISTTYPE], a
	ld a, l
	ld [wcf8b], a
	ld a, h
	ld [wcf8c], a
	ld a, e
	ld [wcf8d], a
	ld a, d
	ld [wcf8e], a
	ld bc, ItemPrices ; $4608
	ld a, c
	ld [wcf8f], a
	ld a, b
	ld [wcf90], a
	ret

Func_39c37: ; 39c37 (e:5c37)
	ld hl, wPartySpecies
	ld a, [wcc49]
	and a
	jr z, .asm_39c4b
	dec a
	jr z, .asm_39c48
	ld hl, wBoxSpecies
	jr .asm_39c4b
.asm_39c48
	ld hl, wEnemyPartyMons
.asm_39c4b
	ld d, $0
	add hl, de
	ld a, [hl]
	ld [wcf91], a
	ret

ReadTrainer: ; 39c53 (e:5c53)

; don't change any moves in a link battle
	ld a,[W_ISLINKBATTLE]
	and a
	ret nz

; set [wEnemyPartyCount] to 0, [wEnemyPartyMons] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl,wEnemyPartyCount
	xor a
	ld [hli],a
	dec a
	ld [hl],a

	; check if we are in battle tent since we need a random pokemon data
	ld a,[W_CURMAP]
	cp BATTLE_TENT
	jr nz, .notBT
	callba ReadBattleTentTrainer
	jp .FinishUp

; get the pointer to trainer data for this class
.notBT
	ld a,[W_CUROPPONENT]
	sub $C9 ; convert value from pokemon to trainer
	add a,a
	ld hl,TrainerDataPointers
	ld c,a
	ld b,0
	add hl,bc ; hl points to trainer class
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[W_TRAINERNO]
	ld b,a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z,.IterateTrainer
.inner
	ld a,[hli]
	and a
	jr nz,.inner
	jr .outer

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
; elseif the first byte of trainer data is FE
; - levels are set accordng to player's max level in party
; - the second byte is the minimum level
; - each pair of bytes is [levels below][pokemon id]
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	ld a,[hli]
	cp $FF ; is the trainer special?
	jr z,.SpecialTrainer ; if so, check for special moves
	cp $FE ; does trainer have levels related to player's pokemon?
	jr z,.MaxPlayerLevelTrainer
	ld [W_CURENEMYLVL],a
.LoopTrainerData
	ld a,[hli]
	and a ; have we reached the end of the trainer data?
	jp z,.FinishUp
	ld [wcf91],a ; write species somewhere (XXX why?)
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData

;ShantyTown's scale trainer level code
;you have no idea how useful this is for reverse badge runs tbh
.MaxPlayerLevelTrainer
	ld a, [hli]
	ld b, a ; b contains minimum base level for pokemon
	call GetMaxLevelInParty ; register a contains max level
	cp b
	jr c, .GotMinLevel
	ld b, a
.GotMinLevel
; b contains min level
	ld a, [hli]
	and a ; reached end of pokemon list?
	jp z, .AddCustomMoves
	push bc
	; a contains level offset from base level
	add a, b
	cp 2
	jr nc, .checkHigh
	ld a, 2
	jr .loadLevel
.checkHigh
	cp 155
	jr c, .check100
	ld a, 2
	jr .loadLevel
.check100
	cp 101
	jr c, .loadLevel
	ld a, 100
.loadLevel
	ld [W_CURENEMYLVL], a
	ld a, [hli] ; a contain pokemon id
	ld [$CF91], a
	ld a,1
	ld [$CC49], a
	push hl
	call AddPartyMon
	pop hl
	pop bc
	jr .GotMinLevel

.SpecialTrainer
; if this code is being run:
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
	ld a,[hli]
	and a ; have we reached the end of the trainer data?
	jr z,.AddCustomMoves
	ld [W_CURENEMYLVL],a
	ld a,[hli]
	ld [wcf91],a
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	jr .SpecialTrainer
.AddCustomMoves
	ld hl, TeamMoves
.ReadEntry
	ld a,[hli]
	cp a, $ff
	jr z, .FinishUp
	ld b, a
	ld a, [W_CUROPPONENT]
	sub $c8
	cp a, b
	jr nz, .NextEntry
	ld a, [hli]
	ld b, a
	ld a, [W_TRAINERNO]
	cp a, b
	jr nz, .NextEntry
.MoveLoop
	ld a, [hli] ; Which Pokemon?
	and a
	jr z, .FinishUp
	dec a       ; Decrease so we aren't adding too many times
	push af     ; hang on to this for later
	ld a, [hli] ; get slot number
	dec a       ; decrease so we aren't adding too many times
	ld b, 0
	ld c, a
	pop af      ; get the Pokemon count back
	push hl     ; Don't lose our place
	ld hl, wEnemyMon1Moves
	add hl,bc   ; bc has the slot number
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	push hl     ; hold on to the address to load this move
	pop de      ; put it in de
	pop hl      ; get our place in the move data back
	ld a, [hli] ; get the move to store
	ld [de], a  ; store it
	jr .MoveLoop
.NextEntry
	ld a, [hli]
	and a
	jr z, .ReadEntry
	jr .NextEntry
; Original routine continues here
.FinishUp ; XXX this needs documenting
	xor a       ; clear D079-D07B
	ld de,wd079
	ld [de],a
	inc de
	ld [de],a
	inc de
	ld [de],a
	ld a,[W_CURENEMYLVL]
	ld b,a
.LastLoop
	ld hl,wd047
	ld c,2
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz,.LastLoop
	ret

; more level scaling code
GetMaxLevelInParty:
; returns max level in register a
	push bc
	push hl
	push de
	ld a, [wPartyCount]
	ld d, a
	ld bc, 44
	ld hl, wPartyMon1Level
	ld a, [hl]
	ld e, a
	; keep track of max in e
.loop
	ld a, [hl]
	cp e
	jr c, .smaller
	; update max
	ld e, a
.smaller
	add hl, bc
	dec d
	jr nz, .loop
	ld a, e 
	pop de
	pop hl
	pop bc
	ret


INCLUDE "data/trainer_moves.asm"

INCLUDE "data/trainer_parties.asm"

TrainerAI: ; 3a52e (e:652e)
;XXX called at 34964, 3c342, 3c398
	and a
	ld a,[W_ISINBATTLE]
	dec a
	ret z ; if not a trainer, we're done here
	ld a, [W_CURMAP]
	cp BATTLE_TENT
	ret z ; if we are in battle tent, we are done
	ld a,[W_ISLINKBATTLE]
	cp 4
	ret z
	; battl factory
	ld a, [W_INCHALLENGE]
	and a
	jr z, .normalBattle
	ld hl, BattleFactoryAIPointers
	jr .gotAIPointer
.normalBattle
	ld a,[W_TRAINERCLASS] ; what trainer class is this?
	dec a
	ld c,a
	ld b,0
	ld hl,TrainerAIPointers
	add hl,bc
	add hl,bc
	add hl,bc
.gotAIPointer
	ld a,[wAICount]
	and a
	ret z ; if no AI uses left, we're done here
	inc hl
	inc a
	jr nz,.getpointer
	dec hl
	ld a,[hli]
	ld [wAICount],a
.getpointer
	ld a,[hli]
	ld h,[hl]
	ld l,a
	call Random
	jp [hl]

BattleFactoryAIPointers:
	dbw 3,GenericAI


TrainerAIPointers: ; 3a55c (e:655c)
; one entry per trainer class
; first byte, number of times (per Pokémon) it can occur
; next two bytes, pointer to AI subroutine for trainer class
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,JugglerAI ; juggler_x
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,JugglerAI ; juggler
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 1,BlackbeltAI ; blackbelt
	dbw 3,GenericAI
	dbw 2,Sony3AI ; prof oak
	dbw 3,GenericAI ; chief
	dbw 3,GenericAI
	dbw 1,GiovanniAI ; giovanni
	dbw 3,GenericAI
	dbw 3,CooltrainerMAI ; cooltrainerm
	dbw 1,CooltrainerFAI ; cooltrainerf
	dbw 1,BrunoAI ; bruno
	dbw 3,BrockAI ; brock
	dbw 1,MistyAI ; misty
	dbw 1,LtSurgeAI ; surge
	dbw 1,ErikaAI ; erika
	dbw 1,KogaAI ; koga
	dbw 1,BlaineAI ; blaine
	dbw 3,SabrinaAI ; sabrina
	dbw 3,GenericAI
	dbw 1,Sony2AI ; sony2
	dbw 1,Sony3AI ; sony3
	dbw 1,LoreleiAI ; lorelei
	dbw 3,GenericAI
	dbw 1,AgathaAI ; agatha
	dbw 1,LanceAI ; lance
	dbw 1,GiovanniAI ; giovanni sim
	dbw 3,GenericAI ; factory head
	dbw 3,GenericAI ; factory head
	dbw 3,GenericAI ; factory head
	dbw 3,GenericAI ; factory head
	dbw 3,GenericAI ; factory head
	dbw 3,GenericAI ; factory head
	dbw 3,GenericAI ; factory head

JugglerAI: ; 3a5e9 (e:65e9)
	cp $20
	ret nc
	jp Func_3a72a

BlackbeltAI: ; 3a5ef (e:65ef)
	cp $FF
	ret nc
	jp AIUseXAttack

IF CHALLENGE_MODE
GiovanniAI: ; 3a5f5 (e:65f5)
	cp $C0
	ret nc
	ld a,5
	call Func_3a7cf
	ret nc
	jp AIUseMaxPotion

CooltrainerMAI: ; 3a5fb (e:65fb)
; if his active monster has a status condition, use a full restore
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullRestore

CooltrainerFAI: ; 3a601 (e:6601)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore

BrockAI: ; 3a614 (e:6614)
; if his active monster has a status condition, use a full heal
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullRestore

MistyAI: ; 3a61c (e:661c)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseSuperPotion

LtSurgeAI: ; 3a622 (e:6622)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseSuperPotion

ErikaAI: ; 3a628 (e:6628)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseHyperPotion

KogaAI: ; 3a634 (e:6634)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseHyperPotion

BlaineAI: ; 3a63a (e:663a)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseMaxPotion

SabrinaAI: ; 3a640 (e:6640)
; if her active monster has a status condition, use a full restore
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullRestore

Sony2AI: ; 3a64c (e:664c)
	cp $20
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseHyperPotion

Sony3AI: ; 3a658 (e:6658)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore

LoreleiAI: ; 3a664 (e:6664)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore

BrunoAI: ; 3a670 (e:6670)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore

AgathaAI: ; 3a676 (e:6676)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore
ELSE
; Normal Mode
GiovanniAI: ; 3a5f5 (e:65f5)
	cp $C0
	ret nc
	ld a,5
	call Func_3a7cf
	ret nc
	jp AIUseHyperPotion

CooltrainerMAI: ; 3a5fb (e:65fb)
; if his active monster has a status condition, use a full restore
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullRestore

CooltrainerFAI: ; 3a601 (e:6601)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseMaxPotion

BrockAI: ; 3a614 (e:6614)
; if his active monster has a status condition, use a full heal
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

MistyAI: ; 3a61c (e:661c)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUsePotion

LtSurgeAI: ; 3a622 (e:6622)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUsePotion

ErikaAI: ; 3a628 (e:6628)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseSuperPotion

KogaAI: ; 3a634 (e:6634)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseSuperPotion

BlaineAI: ; 3a63a (e:663a)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseHyperPotion

SabrinaAI: ; 3a640 (e:6640)
; if her active monster has a status condition, use a full heal
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

Sony2AI: ; 3a64c (e:664c)
	cp $20
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseSuperPotion

Sony3AI: ; 3a658 (e:6658)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore

LoreleiAI: ; 3a664 (e:6664)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseMaxPotion

BrunoAI: ; 3a670 (e:6670)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseMaxPotion

AgathaAI: ; 3a676 (e:6676)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseMaxPotion
ENDC

LanceAI: ; 3a687 (e:6687)
	cp $C0
	ret nc
	ld a,3
	call Func_3a7cf
	ret nc
	jp AIUseFullRestore

GenericAI: ; 3a693 (e:6693)
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount: ; 3a695 (e:6695)
	ld hl,wAICount
	dec [hl]
	scf
	ret

Func_3a69b: ; 3a69b (e:669b)
	ld a,RBSFX_02_3e
	jp PlaySoundWaitForCurrent

AIUseFullRestore: ; 3a6a0 (e:66a0)
	call AICureStatus

	ld a,FULL_RESTORE
	ld [wcf05],a
	ld de,wHPBarOldHP
	ld hl,wEnemyMonHP + 1
	ld a,[hld]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld hl,wEnemyMonMaxHP + 1
	ld a,[hld]
	ld [de],a
	inc de
	ld [wHPBarMaxHP],a
	ld [wEnemyMonHP + 1],a
	ld a,[hl]
	ld [de],a
	ld [wHPBarMaxHP+1],a
	ld [wEnemyMonHP],a
	jr Func_3a718

AIUseMaxPotion: ; 3a6d6 (e:66d6)
; enemy trainer heals his monster with a max potion
	ld a,MAX_POTION
	ld [wcf05],a
	ld de,wHPBarOldHP
	ld hl,wEnemyMonHP + 1
	ld a,[hld]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld hl,wEnemyMonMaxHP + 1
	ld a,[hld]
	ld [de],a
	inc de
	ld [wHPBarMaxHP],a
	ld [wEnemyMonHP + 1],a
	ld a,[hl]
	ld [de],a
	ld [wHPBarMaxHP+1],a
	ld [wEnemyMonHP],a
	jr Func_3a718

AIUsePotion: ; 3a6ca (e:66ca)
; enemy trainer heals his monster with a potion
	ld a,POTION
	ld b,20
	jr AIRecoverHP

AIUseSuperPotion: ; 3a6d0 (e:66d0)
; enemy trainer heals his monster with a super potion
	ld a,SUPER_POTION
	ld b,50
	jr AIRecoverHP

AIUseHyperPotion: ; 3a6d6 (e:66d6)
; enemy trainer heals his monster with a hyper potion
	ld a,HYPER_POTION
	ld b,200
	; fallthrough

AIRecoverHP: ; 3a6da (e:66da)
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [wcf05],a
	ld hl,wEnemyMonHP + 1
	ld a,[hl]
	ld [wHPBarOldHP],a
	add b
	ld [hld],a
	ld [wHPBarNewHP],a
	ld a,[hl]
	ld [wHPBarOldHP+1],a
	ld [wHPBarNewHP+1],a
	jr nc,.next
	inc a
	ld [hl],a
	ld [wHPBarNewHP+1],a
.next
	inc hl
	ld a,[hld]
	ld b,a
	ld de,wEnemyMonMaxHP + 1
	ld a,[de]
	dec de
	ld [wHPBarMaxHP],a
	sub b
	ld a,[hli]
	ld b,a
	ld a,[de]
	ld [wHPBarMaxHP+1],a
	sbc b
	jr nc,Func_3a718
	inc de
	ld a,[de]
	dec de
	ld [hld],a
	ld [wHPBarNewHP],a
	ld a,[de]
	ld [hl],a
	ld [wHPBarNewHP+1],a
	; fallthrough

Func_3a718: ; 3a718 (e:6718)
	call AIPrintItemUse_
	hlCoord 2, 2
	xor a
	ld [wListMenuID],a
	predef UpdateHPBar_Hook
	jp DecrementAICount

Func_3a72a: ; 3a72a (e:672a)
	ld a,[wEnemyPartyCount]
	ld c,a
	ld hl,wEnemyMon1HP

	ld d,0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
.loop
	ld a,[hli]
	ld b,a
	ld a,[hld]
	or b
	jr z,.Fainted ; has monster fainted?
	inc d
.Fainted
	push bc
	ld bc,$2C
	add hl,bc
	pop bc
	dec c
	jr nz,.loop

	ld a,d ; how many available monsters are there?
	cp 2 ; don't bother if only 1 or 2
	jp nc,SwitchEnemyMon
	and a
	ret

SwitchEnemyMon: ; 3a74b (e:674b)

; prepare to withdraw the active monster: copy hp, number, and status to roster

	ld a,[wEnemyMonPartyPos]
	ld hl,wEnemyMon1HP
	ld bc,wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d,h
	ld e,l
	ld hl,wEnemyMonHP
	ld bc,4
	call CopyData

	ld hl, AIBattleWithdrawText
	call PrintText

	ld a,1
	ld [wd11d],a
	callab EnemySendOut
	xor a
	ld [wd11d],a

	ld a,[W_ISLINKBATTLE]
	cp 4
	ret z
	scf
	ret

AIBattleWithdrawText: ; 3a781 (e:6781)
	TX_FAR _AIBattleWithdrawText
	db "@"

AIUseFullHeal: ; 3a786 (e:6786)
	call Func_3a69b
	call AICureStatus
	ld a,FULL_HEAL
	jp AIPrintItemUse

AICureStatus: ; 3a791 (e:6791)
; cures the status of enemy's active pokemon
	ld a,[wEnemyMonPartyPos]
	ld hl,wEnemyMon1Status
	ld bc,wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl],a ; clear status in enemy team roster
	ld [wEnemyMonStatus],a ; clear status of active enemy
	ld hl,W_ENEMYBATTSTATUS3
	res 0,[hl]
	ret

AIUseXAccuracy: ; 0x3a7a8 unused
	call Func_3a69b
	ld hl,W_ENEMYBATTSTATUS2
	set 0,[hl]
	ld a,X_ACCURACY
	jp AIPrintItemUse

AIUseGuardSpec: ; 3a7b5 (e:67b5)
	call Func_3a69b
	ld hl,W_ENEMYBATTSTATUS2
	set 1,[hl]
	ld a,GUARD_SPEC_
	jp AIPrintItemUse

AIUseDireHit: ; 0x3a7c2 unused
	call Func_3a69b
	ld hl,W_ENEMYBATTSTATUS2
	set 2,[hl]
	ld a,DIRE_HIT
	jp AIPrintItemUse

Func_3a7cf: ; 3a7cf (e:67cf)
	ld [H_DIVISOR],a
	ld hl,wEnemyMonMaxHP
	ld a,[hli]
	ld [H_DIVIDEND],a
	ld a,[hl]
	ld [H_DIVIDEND + 1],a
	ld b,2
	call Divide
	ld a,[H_QUOTIENT + 3]
	ld c,a
	ld a,[H_QUOTIENT + 2]
	ld b,a
	ld hl,wEnemyMonHP + 1
	ld a,[hld]
	ld e,a
	ld a,[hl]
	ld d,a
	ld a,d
	sub b
	ret nz
	ld a,e
	sub c
	ret

AIUseXAttack: ; 3a7f2 (e:67f2)
	ld b,$A
	ld a,X_ATTACK
	jr AIIncreaseStat

AIUseXDefend: ; 3a7f8 (e:67f8)
	ld b,$B
	ld a,X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed: ; 3a7fe (e:67fe)
	ld b,$C
	ld a,X_SPEED
	jr AIIncreaseStat

AIUseXSpecial: ; 3a804 (e:6804)
	ld b,$D
	ld a,X_SPECIAL
	; fallthrough

AIIncreaseStat: ; 3a808 (e:6808)
	ld [wcf05],a
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl,W_ENEMYMOVEEFFECT
	ld a,[hld]
	push af
	ld a,[hl]
	push af
	push hl
	ld a,$AF
	ld [hli],a
	ld [hl],b
	callab StatModifierUpEffect
	pop hl
	pop af
	ld [hli],a
	pop af
	ld [hl],a
	jp DecrementAICount

AIPrintItemUse: ; 3a82c (e:682c)
	ld [wcf05],a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_: ; 3a835 (e:6835)
; print "x used [wcf05] on z!"
	ld a,[wcf05]
	ld [wd11e],a
	call GetItemName
	ld hl, AIBattleUseItemText
	jp PrintText

AIBattleUseItemText: ; 3a844 (e:6844)
	TX_FAR _AIBattleUseItemText
	db "@"

DrawAllPokeballs: ; 3a849 (e:6849)
	call LoadPartyPokeballGfx
	call SetupOwnPartyPokeballs
	ld a, [W_ISINBATTLE] ; W_ISINBATTLE
	dec a
	ret z ; return if wild pokémon
	jp SetupEnemyPartyPokeballs

DrawEnemyPokeballs: ; 0x3a857
	call LoadPartyPokeballGfx
	jp SetupEnemyPartyPokeballs

LoadPartyPokeballGfx: ; 3a85d (e:685d)
	ld de, PokeballTileGraphics ; $697e
	ld hl, vSprites + $310
	ld bc, (BANK(PokeballTileGraphics) << 8) + $04
	jp CopyVideoData

SetupOwnPartyPokeballs: ; 3a869 (e:6869)
	call PlacePlayerHUDTiles
	ld hl, wPartyMon1
	ld de, wPartyCount ; wPartyCount
	call SetupPokeballs
	ld a, $60
	ld hl, W_BASECOORDX ; wd081
	ld [hli], a
	ld [hl], a
	ld a, $8
	ld [wTrainerEngageDistance], a
	ld hl, wOAMBuffer
	jp Func_3a8e1

SetupEnemyPartyPokeballs: ; 3a887 (e:6887)
	call PlaceEnemyHUDTiles
	ld hl, wEnemyMons
	ld de, wEnemyPartyCount ; wEnemyPartyCount
	call SetupPokeballs
	ld hl, W_BASECOORDX ; wd081
	ld a, $48
	ld [hli], a
	ld [hl], $20
	ld a, $f8
	ld [wTrainerEngageDistance], a
	ld hl, wOAMBuffer + PARTY_LENGTH * 4
	jp Func_3a8e1

SetupPokeballs: ; 0x3a8a6
	ld a, [de]
	push af
	ld de, wBuffer
	ld c, PARTY_LENGTH
	ld a, $34 ; empty pokeball
.emptyloop
	ld [de], a
	inc de
	dec c
	jr nz, .emptyloop ; 0x3a8b2 $fb
	pop af
	ld de, wBuffer
.monloop
	push af
	call PickPokeball
	inc de
	pop af
	dec a
	jr nz, .monloop
	ret

PickPokeball: ; 3a8c2 (e:68c2)
	inc hl
	ld a, [hli]
	and a
	jr nz, .alive
	ld a, [hl]
	and a
	ld b, $33 ; crossed ball (fainted)
	jr z, .done_fainted
.alive
	inc hl
	inc hl
	ld a, [hl] ; status
	and a
	ld b, $32 ; black ball (status)
	jr nz, .done
	dec b ; regular ball
	jr .done
.done_fainted
	inc hl
	inc hl
.done
	ld a, b
	ld [de], a
	ld bc, $0028 ; rest of mon struct
	add hl, bc
	ret

Func_3a8e1: ; 3a8e1 (e:68e1)
	ld de, wHPBarMaxHP
	ld c, PARTY_LENGTH
.asm_3a8e6
	ld a, [W_BASECOORDY] ; wd082
	ld [hli], a
	ld a, [W_BASECOORDX] ; wd081
	ld [hli], a
	ld a, [de]
	ld [hli], a
	xor a
	ld [hli], a
	ld a, [W_BASECOORDX] ; wd081
	ld b, a
	ld a, [wTrainerEngageDistance]
	add b
	ld [W_BASECOORDX], a ; wd081
	inc de
	dec c
	jr nz, .asm_3a8e6
	ret

PlacePlayerHUDTiles: ; 3a902 (e:6902)
	ld hl, PlayerBattleHUDGraphicsTiles ; $6916
	ld de, wTrainerFacingDirection
	ld bc, $3
	call CopyData
	hlCoord 18, 10
	ld de, rIE ; $ffff
	jr PlaceHUDTiles

PlayerBattleHUDGraphicsTiles: ; 3a916 (e:6916)
; The tile numbers for specific parts of the battle display for the player's pokemon
	db $73 ; unused ($73 is hardcoded into the routine that uses these bytes)
	db $77 ; lower-right corner tile of the HUD
	db $6F ; lower-left triangle tile of the HUD

PlaceEnemyHUDTiles: ; 3a919 (e:6919)
	ld hl, EnemyBattleHUDGraphicsTiles ; $692d
	ld de, wTrainerFacingDirection
	ld bc, $3
	call CopyData
	hlCoord 1, 2
	ld de, $1
	jp EnemyHealthBarUpdated
	jr PlaceHUDTiles

EnemyBattleHUDGraphicsTiles: ; 3a92d (e:692d)
; The tile numbers for specific parts of the battle display for the enemy
	db $73 ; unused ($73 is hardcoded in the routine that uses these bytes)
	db $74 ; lower-left corner tile of the HUD
	db $78 ; lower-right triangle tile of the HUD

PlaceHUDTiles: ; 3a930 (e:6930)
	ld [hl], $73
HealthBarUpdateDone:	
	ld bc, $14
	add hl, bc
	ld a, [wTrainerScreenY]
	ld [hl], a
	ld a, $8
.asm_3a93c
	add hl, de
	ld [hl], $76
	dec a
	jr nz, .asm_3a93c
	add hl, de
	ld a, [wTrainerScreenX]
	ld [hl], a
	ret

SetupPlayerAndEnemyPokeballs: ; 3a948 (e:6948)
	call LoadPartyPokeballGfx
	ld hl, wPartyMon1Species ; wPartyMon1Species (aliases: wPartyMon1)
	ld de, wPartyCount ; wPartyCount
	call SetupPokeballs
	ld hl, W_BASECOORDX ; wd081
	ld a, $50
	ld [hli], a
	ld [hl], $40
	ld a, $8
	ld [wTrainerEngageDistance], a
	ld hl, wOAMBuffer
	call Func_3a8e1
	ld hl, wEnemyMons ; wEnemyMon1Species
	ld de, wEnemyPartyCount ; wEnemyPartyCount
	call SetupPokeballs
	ld hl, W_BASECOORDX ; wd081
	ld a, $50
	ld [hli], a
	ld [hl], $68
	ld hl, wOAMBuffer + $18
	jp Func_3a8e1

; four tiles: pokeball, black pokeball (status ailment), crossed out pokeball (faited) and pokeball slot (no mon)
PokeballTileGraphics:: ; 3a97e (e:697e)
	INCBIN "gfx/pokeball.2bpp"
