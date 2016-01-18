MagmarBaseStats: ; 3918a (e:518a)
db DEX_MAGMAR ; pokedex id
db 65 ; base hp
db 95 ; base attack
db 57 ; base defense
db 93 ; base speed
db 100 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 45 ; catch rate
db 167 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/magmar.pic",0,1
ELSE
INCBIN "pic/bmon/magmar.pic",0,1
ENDC
dw MagmarPicFront
dw MagmarPicBack
; attacks known at lvl 0
db EMBER
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01001011
db %00000111
db %11010000
db %10100100
db %00101000
db %00100010
db BANK(MagmarPicFront)
