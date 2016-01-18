SkarmoryBaseStats: ; 38432 (e:4432)
db DEX_SKARMORY; pokedex id
db 65 ; base hp
db 80 ; base attack
db 140 ; base defense
db 70 ; base speed
db 70 ; base special
db STEEL ; species type 1
db FLYING ; species type 2
db 25 ; catch rate
db 168 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/skarmory.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/skarmory.pic",0,1 ; 77, sprite dimensions
ENDC
dw SkarmoryPicFront
dw SkarmoryPicBack
; attacks known at lvl 0
db LEER
db PECK
db 0
db 0
db 5 ; growth rate
; learnset
db %00101110
db %00000011
db %00000000
db %11000000
db %11010010
db %10001100
db %01001110
db BANK(SkarmoryPicFront)