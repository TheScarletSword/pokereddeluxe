SteelixBaseStats: ; 38e26 (e:4e26)
db DEX_STEELIX ; pokedex id
db 75 ; base hp
db 85 ; base attack
db 200 ; base defense
db 30 ; base speed
db 55 ; base special
db STEEL ; species type 1
db GROUND ; species type 2
db 25 ; catch rate
db 196 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/steelix.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/steelix.pic",0,1 ; 77, sprite dimensions
ENDC
dw SteelixPicFront
dw SteelixPicBack
; attacks known at lvl 0
db TACKLE
db SCREECH
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00000011
db %00000000
db %11001110
db %10001000
db %11001001
db %00100010
db BANK(SteelixPicFront)
