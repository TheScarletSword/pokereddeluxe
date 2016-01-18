ChandelureBaseStats: ; 38432 (e:4432)
db DEX_CHANDELURE; pokedex id
db 60 ; base hp
db 55 ; base attack
db 90 ; base defense
db 80 ; base speed
db 145 ; base special
db GHOST ; species type 1
db FIRE ; species type 2
db 45 ; catch rate
db 234 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/chandelure.pic",0,1
ELSE
INCBIN "pic/bmon/chandelure.pic",0,1
ENDC
dw ChandelurePicFront
dw ChandelurePicBack
; attacks known at lvl 0
db SMOG
db CONFUSE_RAY
db 0
db 0
db 3 ; growth rate
; learnset
db %00100000
db %01001000
db %00000000
db %11010000
db %00100010
db %00101011
db %01000010
db BANK(ChandelurePicFront)