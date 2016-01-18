StarmieBaseStats: ; 390fe (e:50fe)
db DEX_STARMIE ; pokedex id
db 60 ; base hp
db 75 ; base attack
db 85 ; base defense
db 115 ; base speed
db 100 ; base special
db WATER ; species type 1
db PSYCHIC ; species type 2
db 60 ; catch rate
db 207 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/starmie.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/starmie.pic",0,1 ; 66, sprite dimensions
ENDC
dw StarmiePicFront
dw StarmiePicBack
; attacks known at lvl 0
db TACKLE
db WATER_GUN
db HARDEN
db 0
db 5 ; growth rate
; learnset
db %00100000
db %01110111
db %10000000
db %11110001
db %11000001
db %00111000
db %01010011
db BANK(StarmiePicFront)
