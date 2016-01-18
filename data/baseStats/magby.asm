MagbyBaseStats: ; 3918a (e:518a)
db DEX_MAGBY ; pokedex id
db 45 ; base hp
db 75 ; base attack
db 37 ; base defense
db 83 ; base speed
db 70 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 45 ; catch rate
db 117 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/magby.pic",0,1
ELSE
INCBIN "pic/bmon/magby.pic",0,1
ENDC
dw MagbyPicFront
dw MagbyPicBack
; attacks known at lvl 0
db EMBER
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00001011
db %00000111
db %11010000
db %10100100
db %00101000
db %00100010
db BANK(MagbyPicFront)
