SquirtleBaseStats: ; 38486 (e:4486)
db DEX_SQUIRTLE ; pokedex id
db 44 ; base hp
db 48 ; base attack
db 65 ; base defense
db 43 ; base speed
db 50 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 66 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/squirtle.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/squirtle.pic",0,1 ; 55, sprite dimensions
ENDC
dw SquirtlePicFront
dw SquirtlePicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db 0
db 0
db 3 ; growth rate
; learnset
db %10110001
db %00110111
db %00000111
db %11001000
db %10000001
db %00001000
db %00110010
db BANK(SquirtlePicFront)
