ShroomishBaseStats: ; 38432 (e:4432)
db DEX_SHROOMISH; pokedex id
db 60 ; base hp
db 40 ; base attack
db 60 ; base defense
db 35 ; base speed
db 60 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 255 ; catch rate
db 65 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/shroomish.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/shroomish.pic",0,1 ; 66, sprite dimensions
ENDC
dw ShroomishPicFront
dw ShroomishPicBack
; attacks known at lvl 0
db ABSORB
db TACKLE
db 0
db 0
db 7 ; growth rate
; learnset
db %10100100
db %00000011
db %00110000
db %11000000
db %10000001
db %00001000
db %00000010
db BANK(ShroomishPicFront)