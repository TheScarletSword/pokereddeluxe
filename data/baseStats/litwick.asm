LitwickBaseStats: ; 38432 (e:4432)
db DEX_LITWICK; pokedex id
db 50 ; base hp
db 30 ; base attack
db 55 ; base defense
db 20 ; base speed
db 65 ; base special
db GHOST ; species type 1
db FIRE ; species type 2
db 190 ; catch rate
db 55 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/litwick.pic",0,1
ELSE
INCBIN "pic/bmon/litwick.pic",0,1
ENDC
dw LitwickPicFront
dw LitwickPicBack
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
db BANK(LitwickPicFront)