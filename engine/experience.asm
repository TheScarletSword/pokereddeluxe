; calculates the level a mon should be based on its current exp
CalcLevelFromExperience: ; 58f43 (16:4f43)
	ld a, [wcf98]
	ld [wd0b5], a
	call GetMonHeader
	ld d, $1 ; init level to 1
.loop
	inc d ; increment level
	call CalcExperience
	push hl
	ld hl, wcfa8 ; current exp
; compare exp needed for level d with current exp
	ld a, [H_MULTIPLICAND + 2]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [H_MULTIPLICAND + 1]
	ld c, a
	ld a, [hld]
	sbc c
	ld a, [H_MULTIPLICAND]
	ld c, a
	ld a, [hl]
	sbc c
	pop hl
	jr nc, .loop ; if exp needed for level d is not greater than exp, try the next level
	dec d ; since the exp was too high on the last loop iteration, go back to the previous value and return
	ret

ERRATIC     EQU 6
FLUCTUATING EQU 7

; calculates the amount of experience needed for level d
CalcExperience: ; 58f6a (16:4f6a)
	ld a, [W_MONHGROWTHRATE]
	cp ERRATIC
	jp z, .erratic
	cp FLUCTUATING
	jp z, .fluctuating
	add a
	add a
	ld c, a
	ld b, $0
	ld hl, GrowthRateTable
	add hl, bc
	call CalcDSquared
	ld a, d
	ld [H_MULTIPLIER], a ; $ff99
	call Multiply
	ld a, [hl]
	and $f0
	swap a
	ld [H_MULTIPLIER], a ; $ff99
	call Multiply
	ld a, [hli]
	and $f
	ld [H_DIVISOR], a ; $ff99
	ld b, $4
	call Divide
	ld a, [H_MULTIPLICAND] ; $ff96 (aliases: H_NUMTOPRINT)
	push af
	ld a, [H_MULTIPLICAND+1]
	push af
	ld a, [H_MULTIPLICAND+2]
	push af
	call CalcDSquared
	ld a, [hl]
	and $7f
	ld [H_MULTIPLIER], a ; $ff99
	call Multiply
	ld a, [H_MULTIPLICAND] ; $ff96 (aliases: H_NUMTOPRINT)
	push af
	ld a, [H_MULTIPLICAND+1]
	push af
	ld a, [H_MULTIPLICAND+2]
	push af
	ld a, [hli]
	push af
	xor a
	ld [H_MULTIPLICAND], a ; $ff96
	ld [H_MULTIPLICAND+1], a
	ld a, d
	ld [H_MULTIPLICAND+2], a
	ld a, [hli]
	ld [H_MULTIPLIER], a
	call Multiply
	ld b, [hl]
	ld a, [H_MULTIPLICAND+2]
	sub b
	ld [H_MULTIPLICAND+2], a
	ld b, $0
	ld a, [H_MULTIPLICAND+1]
	sbc b
	ld [H_MULTIPLICAND+1], a
	ld a, [H_MULTIPLICAND] ; $ff96
	sbc b
	ld [H_MULTIPLICAND], a ; $ff96
	pop af
	and $80
	jr nz, .subtractSquaredTerm ; check sign
	pop bc
	ld a, [H_MULTIPLICAND+2]
	add b
	ld [H_MULTIPLICAND+2], a
	pop bc
	ld a, [H_MULTIPLICAND+1]
	adc b
	ld [H_MULTIPLICAND+1], a
	pop bc
	ld a, [H_MULTIPLICAND]
	adc b
	ld [H_MULTIPLICAND], a
	jr .addCubedTerm
.subtractSquaredTerm
	pop bc
	ld a, [H_MULTIPLICAND+2]
	sub b
	ld [H_MULTIPLICAND+2], a
	pop bc
	ld a, [H_MULTIPLICAND+1]
	sbc b
	ld [H_MULTIPLICAND+1], a
	pop bc
	ld a, [H_MULTIPLICAND]
	sbc b
	ld [H_MULTIPLICAND], a
.addCubedTerm
	pop bc
	ld a, [H_MULTIPLICAND+2]
	add b
	ld [H_MULTIPLICAND+2], a
	pop bc
	ld a, [H_MULTIPLICAND+1]
	adc b
	ld [H_MULTIPLICAND+1], a
	pop bc
	ld a, [H_MULTIPLICAND]
	adc b
	ld [H_MULTIPLICAND], a
	ret

.erratic
    ld hl, ErraticEXP
    jr .lookup
.fluctuating
    ld hl, FluctuatingEXP
.lookup
    push de
    dec d
    ld e, d
    ld d, 0
    add hl, de
    add hl, de
    add hl, de
    ld a, [hli]
	ld [H_MULTIPLICAND], a
    ld a, [hli]
	ld [H_MULTIPLICAND+1], a
    ld a, [hli]
	ld [H_MULTIPLICAND+2], a
	pop de
	ret

; calculates d*d
CalcDSquared: ; 59010 (16:5010)
	xor a
	ld [H_MULTIPLICAND], a ; $ff96 (aliases: H_NUMTOPRINT)
	ld [H_MULTIPLICAND+1], a
	ld a, d
	ld [H_MULTIPLICAND+2], a
	ld [H_MULTIPLIER], a ; $ff99 (aliases: H_DIVISOR, H_REMAINDER, H_POWEROFTEN)
	jp Multiply

; each entry has the following scheme:
; %AAAABBBB %SCCCCCCC %DDDDDDDD %EEEEEEEE
; resulting in
;  (a*n^3)/b + sign*c*n^2 + d*n - e
; where sign = -1 <=> S=1
GrowthRateTable: ; 5901d (16:501d)
	db $11,$00,$00,$00 ; medium fast      n^3
	db $34,$0A,$00,$1E ; (unused?)    3/4 n^3 + 10 n^2         - 30
	db $34,$14,$00,$46 ; (unused?)    3/4 n^3 + 20 n^2         - 70
	db $65,$8F,$64,$8C ; medium slow: 6/5 n^3 - 15 n^2 + 100 n - 140
	db $45,$00,$00,$00 ; fast:        4/5 n^3
	db $54,$00,$00,$00 ; slow:        5/4 n^3

ErraticEXP:
    dt 0
    dt 15
    dt 52
    dt 122
    dt 237
    dt 406
    dt 637
    dt 942
    dt 1326
    dt 1800
    dt 2369
    dt 3041
    dt 3822
    dt 4719
    dt 5737
    dt 6881
    dt 8155
    dt 9564
    dt 11111
    dt 12800
    dt 14632
    dt 16610
    dt 18737
    dt 21012
    dt 23437
    dt 26012
    dt 28737
    dt 31610
    dt 34632
    dt 37800
    dt 41111
    dt 44564
    dt 48155
    dt 51881
    dt 55737
    dt 59719
    dt 63822
    dt 68041
    dt 72369
    dt 76800
    dt 81326
    dt 85942
    dt 90637
    dt 95406
    dt 100237
    dt 105122
    dt 110052
    dt 115015
    dt 120001
    dt 125000
    dt 131324
    dt 137795
    dt 144410
    dt 151165
    dt 158056
    dt 165079
    dt 172229
    dt 179503
    dt 186894
    dt 194400
    dt 202013
    dt 209728
    dt 217540
    dt 225443
    dt 233431
    dt 241496
    dt 249633
    dt 257834
    dt 267406
    dt 276458
    dt 286328
    dt 296358
    dt 305767
    dt 316074
    dt 326531
    dt 336255
    dt 346965
    dt 357812
    dt 367807
    dt 378880
    dt 390077
    dt 400293
    dt 411686
    dt 423190
    dt 433572
    dt 445239
    dt 457001
    dt 467489
    dt 479378
    dt 491346
    dt 501878
    dt 513934
    dt 526049
    dt 536557
    dt 548720
    dt 560922
    dt 571333
    dt 583539
    dt 591882
    dt 600000 

FluctuatingEXP:
    dt 0
    dt 4
    dt 13
    dt 32
    dt 65
    dt 112
    dt 178
    dt 276
    dt 393
    dt 540
    dt 745
    dt 967
    dt 1230
    dt 1591
    dt 1957
    dt 2457
    dt 3046
    dt 3732
    dt 4526
    dt 5440
    dt 6482
    dt 7666
    dt 9003
    dt 10506
    dt 12187
    dt 14060
    dt 16140
    dt 18439
    dt 20974
    dt 23760
    dt 26811
    dt 30146
    dt 33780
    dt 37731
    dt 42017
    dt 46656
    dt 50653
    dt 55969
    dt 60505
    dt 66560
    dt 71677
    dt 78533
    dt 84277
    dt 91998
    dt 98415
    dt 107069
    dt 114205
    dt 123863
    dt 131766
    dt 142500
    dt 151222
    dt 163105
    dt 172697
    dt 185807
    dt 196322
    dt 210739
    dt 222231
    dt 238036
    dt 250562
    dt 267840
    dt 281456
    dt 300293
    dt 315059
    dt 335544
    dt 351520
    dt 373744
    dt 390991
    dt 415050
    dt 433631
    dt 459620
    dt 479600
    dt 507617
    dt 529063
    dt 559209
    dt 582187
    dt 614566
    dt 639146
    dt 673863
    dt 700115
    dt 737280
    dt 765275
    dt 804997
    dt 834809
    dt 877201
    dt 908905
    dt 954084
    dt 987754
    dt 1035837
    dt 1071552
    dt 1122660
    dt 1160499
    dt 1214753
    dt 1254796
    dt 1312322
    dt 1354652
    dt 1415577
    dt 1460276
    dt 1524731
    dt 1571884
    dt 1640000 
