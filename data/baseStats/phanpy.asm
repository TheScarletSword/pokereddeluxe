PhanpyBaseStats: ; 38432 (e:4432)
db DEX_PHANPY; pokedex id
db 90 ; base hp
db 60 ; base attack
db 60 ; base defense
db 40 ; base speed
db 40 ; base special
db GROUND ; species type 1
db GROUND ; species type 2
db 120 ; catch rate
db 124 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/phanpy.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/phanpy.pic",0,1 ; 66, sprite dimensions
ENDC
dw PhanpyPicFront
dw PhanpyPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00000011
db %00000000
db %11000110
db %10000000
db %10001000
db %00100010
db BANK(PhanpyPicFront)