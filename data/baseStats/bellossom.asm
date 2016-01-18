BellossomBaseStats: ; 388ae (e:48ae)
db DEX_BELLOSSOM ; pokedex id
db 75 ; base hp
db 80 ; base attack
db 95 ; base defense
db 50 ; base speed
db 100 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 45 ; catch rate
db 184 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/bellossom.pic",0,1
ELSE
INCBIN "pic/bmon/bellossom.pic",0,1
ENDC
dw BellossomPicFront
dw BellossomPicBack
; attacks known at lvl 0
db STUN_SPORE
db SLEEP_POWDER
db ABSORB
db PETAL_DANCE
db 3 ; growth rate
; learnset
db %00100100
db %01000011
db %01110000
db %11100000
db %00000001
db %00001000
db %00000110
db BANK(BellossomPicFront)
