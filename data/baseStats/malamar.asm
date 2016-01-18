MalamarBaseStats: ; 38432 (e:4432)
db DEX_MALAMAR; pokedex id
db 86 ; base hp
db 92 ; base attack
db 88 ; base defense
db 73 ; base speed
db 75 ; base special
db DARK ; species type 1
db PSYCHIC ; species type 2
db 80 ; catch rate
db 169 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/malamar.pic",0,1
ELSE
INCBIN "pic/bmon/malamar.pic",0,1
ENDC
dw MalamarPicFront
dw MalamarPicBack
; attacks known at lvl 0
db TACKLE
db PECK
db CONSTRICT
db 0
db 0 ; growth rate
; learnset
db %10100000
db %11000111
db %10000000
db %11010000
db %10000001
db %10101011
db %01000111
db BANK(MalamarPicFront)