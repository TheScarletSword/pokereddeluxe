TangrowthBaseStats: ; 3903a (e:503a)
db DEX_TANGROWTH ; pokedex id
db 85 ; base hp
db 75 ; base attack
db 125 ; base defense
db 50 ; base speed
db 110 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 30 ; catch rate
db 211 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tangrowth.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/tangrowth.pic",0,1 ; 77, sprite dimensions
ENDC
dw TangrowthPicFront
dw TangrowthPicBack
; attacks known at lvl 0
db CONSTRICT
db BIND
db 0
db 0
db 0 ; growth rate
; learnset
db %10100100
db %01000011
db %00111000
db %11000010
db %10000000
db %00001000
db %00100110
db BANK(TangrowthPicFront)
