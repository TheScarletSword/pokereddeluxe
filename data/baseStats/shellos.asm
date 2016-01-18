ShellosBaseStats: ; 38432 (e:4432)
db DEX_SHELLOS; pokedex id
db 76 ; base hp
db 48 ; base attack
db 48 ; base defense
db 34 ; base speed
db 57 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 190 ; catch rate
db 73 ; base exp yield
IF GEN_2_SPRITES
IF DEF(_RED)
INCBIN "pic/gsmon/shellosred.pic",0,1 ; 55, sprite dimensions
ENDC
IF DEF(_BLUE)
INCBIN "pic/gsmon/shellos.pic",0,1 ; 55, sprite dimensions
ENDC
ELSE
IF DEF(_RED)
INCBIN "pic/bmon/shellosred.pic",0,1 ; 55, sprite dimensions
ENDC
IF DEF(_BLUE)
INCBIN "pic/bmon/shellos.pic",0,1 ; 55, sprite dimensions
ENDC
ENDC
dw ShellosPicFront
dw ShellosPicBack
; attacks known at lvl 0
db HARDEN
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00110111
db %00000000
db %11001110
db %10000000
db %10001000
db %01110010
db BANK(ShellosPicFront)