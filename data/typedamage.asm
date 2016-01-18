; split from core.asm due to lack of space, edited to accomodate inverse mode
TypeEffects:
; is this the normal type chart?
    ld hl, TypeEffectsNormal
    push af
    ld a, [wRoamingFlag]
    bit 5, a
; if bit 5 is set in wRoamingFlag, load the Inverse Type chart instead
; bit 5 can only be set at the start of the game, see oakspeech.asm in the engine folder
    jr nz, .TypeEffectsInverse
    pop af
    ret
.TypeEffectsInverse
    pop af
    ld hl, TypeEffectsInverse
    ret

; function to adjust the base damage of an attack to account for type effectiveness
AdjustDamageForMoveType: ; 3e3a5 (f:63a5)
; values for player turn
	ld hl,wBattleMonType
	ld a,[hli]
	ld b,a    ; b = type 1 of attacker
	ld c,[hl] ; c = type 2 of attacker
	ld hl,wEnemyMonType
	ld a,[hli]
	ld d,a    ; d = type 1 of defender
	ld e,[hl] ; e = type 2 of defender
	ld a,[W_PLAYERMOVETYPE]
	ld [wd11e],a
	ld a,[H_WHOSETURN]
	and a
	jr z,.next
; values for enemy turn
	ld hl,wEnemyMonType
	ld a,[hli]
	ld b,a    ; b = type 1 of attacker
	ld c,[hl] ; c = type 2 of attacker
	ld hl,wBattleMonType
	ld a,[hli]
	ld d,a    ; d = type 1 of defender
	ld e,[hl] ; e = type 2 of defender
	ld a,[W_ENEMYMOVETYPE]
	ld [wd11e],a
.next
	ld a,[wd11e] ; move type
	cp b ; does the move type match type 1 of the attacker?
	jr z,.sameTypeAttackBonus
	cp c ; does the move type match type 2 of the attacker?
	jr z,.sameTypeAttackBonus
	jr .skipSameTypeAttackBonus
.sameTypeAttackBonus
; if the move type matches one of the attacker's types
	ld hl,W_DAMAGE + 1
	ld a,[hld]
	ld h,[hl]
	ld l,a    ; hl = damage
	ld b,h
	ld c,l    ; bc = damage
	srl b
	rr c      ; bc = floor(0.5 * damage)
	add hl,bc ; hl = floor(1.5 * damage)
; store damage
	ld a,h
	ld [W_DAMAGE],a
	ld a,l
	ld [W_DAMAGE + 1],a
	ld hl,wd05b
	set 7,[hl]
.skipSameTypeAttackBonus
	ld a,[wd11e]
	ld b,a ; b = move type
	call TypeEffects
.loop
	ld a,[hli] ; a = "attacking type" of the current type pair
	cp a,$ff
	jr z,.done
	cp b ; does move type match "attacking type"?
	jr nz,.nextTypePair
	ld a,[hl] ; a = "defending type" of the current type pair
	cp d ; does type 1 of defender match "defending type"?
	jr z,.matchingPairFound
	cp e ; does type 2 of defender match "defending type"?
	jr z,.matchingPairFound
	jr .nextTypePair
.matchingPairFound
; if the move type matches the "attacking type" and one of the defender's types matches the "defending type"
	push hl
	push bc
	inc hl
	ld a,[wd05b]
	and a,$80
	ld b,a
	ld a,[hl] ; a = damage multiplier
	ld [H_MULTIPLIER],a
	add b
	ld [wd05b],a
	xor a
	ld [H_MULTIPLICAND],a
	ld hl,W_DAMAGE
	ld a,[hli]
	ld [H_MULTIPLICAND + 1],a
	ld a,[hld]
	ld [H_MULTIPLICAND + 2],a
	call Multiply
	ld a,10
	ld [H_DIVISOR],a
	ld b,$04
	call Divide
	ld a,[H_QUOTIENT + 2]
	ld [hli],a
	ld b,a
	ld a,[H_QUOTIENT + 3]
	ld [hl],a
	or b ; is damage 0?
	jr nz,.skipTypeImmunity
.typeImmunity
; if damage is 0, make the move miss
	inc a
	ld [W_MOVEMISSED],a
.skipTypeImmunity
	pop bc
	pop hl
.nextTypePair
	inc hl
	inc hl
	jp .loop
.done
	ret

; function to tell how effective the type of an enemy attack is on the player's current pokemon
; modified to take dual types into effect
; the result is stored in [wd11e]
; ($00 immune; $02 or $05 NVE; $0a neutral; $14 or $28 SE)
; as far is can tell, this is only used once in some AI code to help decide which move to use
AIGetTypeEffectiveness: ; 3e449 (f:6449)
	ld a,[W_ENEMYMOVETYPE]
	ld d,a                 ; d = type of enemy move
	ld hl,wBattleMonType
	ld b,[hl]              ; b = type 1 of player's pokemon
	ld a,10
	ld [H_MULTIPLIER],a           ; initialize [wd11e] to neutral effectiveness
	call TypeEffects
.loop
	ld a,[hli]
	cp a,$ff
	jr z, .start2
	cp d                   ; match the type of the move
	jr nz,.nextTypePair1
	ld a,[hli]
	cp b                   ; match with type 1 of pokemon
	jr z,.match
	jr .nextTypePair2
.nextTypePair1
	inc hl
.nextTypePair2
	inc hl
	jr .loop
.match
	ld a,[hl]
	ld [H_MULTIPLIER],a           ; store damage multiplier
.start2
    ld hl,wBattleMonType+1
    ld a,[hl]
    cp b
    jr nz,.checksecondtype
    ld a, [H_MULTIPLIER]
    ld [wd11e], a
 	ret
.checksecondtype
    ld b,[hl]
    xor a
    ld [H_MULTIPLICAND],a
    ld [H_MULTIPLICAND+1],a
    ld a,10
    ld [H_MULTIPLICAND+2],a
    call TypeEffects
.loop2
    ld a,[hli]
    cp a,$ff
    jr z,.multandret
    cp d ; match the type
    jr nz, .nextTypePair3
    ld a,[hli]
    cp b ; match with type 2 of pokemon
    jr z,.match2
    jr .nextTypePair4
.nextTypePair3
    inc hl
.nextTypePair4
    inc hl
    jr .loop2
.match2
    ld a,[hl]
    ld [H_MULTIPLICAND+2],a
.multandret
    call Multiply
    ld a, 10
    ld [H_DIVISOR], a
    ld b, 4
    call Divide
    ld a, [H_QUOTIENT+3]
    ld [wd11e], a
    ret

INCLUDE "data/type_effects.asm"
INCLUDE "data/type_effects_inverse.asm"