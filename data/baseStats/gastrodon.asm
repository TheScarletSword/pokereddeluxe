GastrodonBaseStats: ; 38432 (e:4432)
db DEX_GASTRODON; pokedex id
db 111 ; base hp
db 83 ; base attack
db 68 ; base defense
db 39 ; base speed
db 92 ; base special
db WATER ; species type 1
db GROUND ; species type 2
db 75 ; catch rate
db 176 ; base exp yield
IF GEN_2_SPRITES
IF DEF(_RED)
INCBIN "pic/gsmon/gastrodonred.pic",0,1
ENDC
IF DEF(_BLUE)
INCBIN "pic/gsmon/gastrodon.pic",0,1
ENDC
ELSE
IF DEF(_RED)
INCBIN "pic/bmon/gastrodonred.pic",0,1
ENDC
IF DEF(_BLUE)
INCBIN "pic/bmon/gastrodon.pic",0,1
ENDC
ENDC
dw GastrodonPicFront
dw GastrodonPicBack
; attacks known at lvl 0
db HARDEN
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01110111
db %00000000
db %11001110
db %10000000
db %10001000
db %01110010
db BANK(GastrodonPicFront)