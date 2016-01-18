DrapionBaseStats: ; 38432 (e:4432)
db DEX_DRAPION; pokedex id
db 70 ; base hp
db 90 ; base attack
db 110 ; base defense
db 95 ; base speed
db 75 ; base special
db POISON ; species type 1
db DARK ; species type 2
db 45 ; catch rate
db 204 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/drapion.pic",0,1
ELSE
INCBIN "pic/bmon/drapion.pic",0,1
ENDC
dw DrapionPicFront
dw DrapionPicBack
; attacks known at lvl 0
db BITE
db POISON_STING
db LEER
db PIN_MISSILE
db 5 ; growth rate
; learnset
db %10100100
db %01000011
db %00001111
db %11001000
db %10010000
db %00001001
db %00100110
db BANK(DrapionPicFront)