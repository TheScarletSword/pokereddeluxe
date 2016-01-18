LampentBaseStats: ; 38432 (e:4432)
db DEX_LAMPENT; pokedex id
db 60 ; base hp
db 40 ; base attack
db 60 ; base defense
db 55 ; base speed
db 95 ; base special
db GHOST ; species type 1
db FIRE ; species type 2
db 90 ; catch rate
db 130 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/lampent.pic",0,1
ELSE
INCBIN "pic/bmon/lampent.pic",0,1
ENDC
dw LampentPicFront
dw LampentPicBack
; attacks known at lvl 0
db EMBER
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %00100000
db %00001000
db %00000000
db %11010000
db %00100010
db %00101011
db %01000010
db BANK(LampentPicFront)