TangelaBaseStats: ; 3903a (e:503a)
db DEX_TANGELA ; pokedex id
db 65 ; base hp
db 55 ; base attack
db 115 ; base defense
db 60 ; base speed
db 100 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 45 ; catch rate
db 166 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tangela.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/tangela.pic",0,1 ; 66, sprite dimensions
ENDC
dw TangelaPicFront
dw TangelaPicBack
; attacks known at lvl 0
db CONSTRICT
db BIND
db 0
db 0
db 0 ; growth rate
; learnset
db %10100100
db %01000011
db %00110000
db %11000000
db %10000000
db %00001000
db %00000110
db BANK(TangelaPicFront)
