MagmortarBaseStats: ; 3918a (e:518a)
db DEX_MAGMORTAR ; pokedex id
db 75 ; base hp
db 95 ; base attack
db 67 ; base defense
db 83 ; base speed
db 125 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 30 ; catch rate
db 199 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/magmortar.pic",0,1
ELSE
INCBIN "pic/bmon/magmortar.pic",0,1
ENDC
dw MagmortarPicFront
dw MagmortarPicBack
; attacks known at lvl 0
db EMBER
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01001011
db %10000111
db %11010110
db %10100100
db %00101000
db %00100010
db BANK(MagmortarPicFront)
