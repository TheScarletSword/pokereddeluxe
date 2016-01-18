PanchamBaseStats: ; 38432 (e:4432)
db DEX_PANCHAM ; pokedex id
db 67 ; base hp
db 82 ; base attack
db 62 ; base defense
db 43 ; base speed
db 46 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 220 ; catch rate
db 70 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/pancham.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/pancham.pic",0,1 ; 66, sprite dimensions
ENDC
dw PanchamPicFront
dw PanchamPicBack
; attacks known at lvl 0
db TACKLE
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
db %10110101
db %00000011
db %01001111
db %11001000
db %11000101
db %10001001
db %00110110
db BANK(PanchamPicFront)
