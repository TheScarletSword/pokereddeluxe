RoggenrolaBaseStats: ; 38432 (e:4432)
db DEX_ROGGENROLA ; pokedex id
db 55 ; base hp
db 75 ; base attack
db 85 ; base defense
db 15 ; base speed
db 25 ; base special
db ROCK ; species type 1
db ROCK ; species type 2
db 255 ; catch rate
db 56 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/roggenrola.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/roggenrola.pic",0,1 ; 55, sprite dimensions
ENDC
dw RoggenrolaPicFront
dw RoggenrolaPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10100000
db %00000011
db %00000000
db %11000110
db %10001000
db %11001000
db %00100010
db BANK(RoggenrolaPicFront)
