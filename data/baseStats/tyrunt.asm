TyruntBaseStats: ; 38432 (e:4432)
db DEX_TYRUNT; pokedex id
db 58 ; base hp
db 89 ; base attack
db 77 ; base defense
db 48 ; base speed
db 45 ; base special
db ROCK ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 72 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tyrunt.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/tyrunt.pic",0,1 ; 66, sprite dimensions
ENDC
dw TyruntPicFront
dw TyruntPicBack
; attacks known at lvl 0
db TAIL_WHIP
db TACKLE
db 0
db 0
db 0 ; growth rate
; learnset
db %11100000
db %00000011
db %00000000
db %11001110
db %10000000
db %10001001
db %00100010
db BANK(TyruntPicFront)