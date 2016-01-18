SeadraBaseStats: ; 3908e (e:508e)
db DEX_SEADRA ; pokedex id
db 55 ; base hp
db 65 ; base attack
db 95 ; base defense
db 85 ; base speed
db 95 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 75 ; catch rate
db 155 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/seadra.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/seadra.pic",0,1 ; 66, sprite dimensions
ENDC
dw SeadraPicFront
dw SeadraPicBack
; attacks known at lvl 0
db BUBBLE
db SMOKESCREEN
db 0
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01110111
db %00000000
db %11000000
db %11000000
db %00001000
db %00010010
db BANK(SeadraPicFront)
