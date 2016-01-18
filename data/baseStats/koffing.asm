KoffingBaseStats: ; 38fae (e:4fae)
db DEX_KOFFING ; pokedex id
db 40 ; base hp
db 65 ; base attack
db 95 ; base defense
db 35 ; base speed
db 60 ; base special
db POISON ; species type 1
db POISON ; species type 2
db 190 ; catch rate
db 114 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/koffing.pic",0,1
ELSE
INCBIN "pic/bmon/koffing.pic",0,1
ENDC
dw KoffingPicFront
dw KoffingPicBack
; attacks known at lvl 0
db TACKLE
db SMOG
db POISON_GAS
db 0
db 0 ; growth rate
; learnset
db %00100000
db %00000000
db %10000000
db %11000001
db %00101000
db %01001001
db %00000010
db BANK(KoffingPicFront)
