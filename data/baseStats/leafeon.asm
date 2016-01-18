LeafeonBaseStats: ; 3924e (e:524e)
db DEX_LEAFEON ; pokedex id
db 65 ; base hp
db 110 ; base attack
db 130 ; base defense
db 65 ; base speed
db 60 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/leafeon.pic",0,1
ELSE
INCBIN "pic/bmon/leafeon.pic",0,1
ENDC
dw LeafeonPicFront
dw LeafeonPicBack
; attacks known at lvl 0
db TACKLE
db SAND_ATTACK
db QUICK_ATTACK
db RAZOR_LEAF
db 0 ; growth rate
; learnset
db %10100100
db %01000011
db %00110000
db %11000000
db %11010001
db %00001000
db %01100010
db BANK(LeafeonPicFront)
