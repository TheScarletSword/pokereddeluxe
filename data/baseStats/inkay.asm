InkayBaseStats: ; 38432 (e:4432)
db DEX_INKAY; pokedex id
db 53 ; base hp
db 54 ; base attack
db 53 ; base defense
db 45 ; base speed
db 46 ; base special
db DARK ; species type 1
db PSYCHIC ; species type 2
db 190 ; catch rate
db 58 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/inkay.pic",0,1
ELSE
INCBIN "pic/bmon/inkay.pic",0,1
ENDC
dw InkayPicFront
dw InkayPicBack
; attacks known at lvl 0
db TACKLE
db PECK
db CONSTRICT
db 0
db 0 ; growth rate
; learnset
db %10100000
db %10000111
db %10000000
db %11010000
db %10000001
db %10101011
db %01000111
db BANK(InkayPicFront)