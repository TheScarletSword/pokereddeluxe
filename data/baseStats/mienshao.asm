MienshaoBaseStats: ; 38432 (e:4432)
db DEX_MIENSHAO; pokedex id
db 65 ; base hp
db 125 ; base attack
db 60 ; base defense
db 105 ; base speed
db 60 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 179 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mienshao.pic",0,1
ELSE
INCBIN "pic/bmon/mienshao.pic",0,1
ENDC
dw MienshaoPicFront
dw MienshaoPicBack
; attacks known at lvl 0
db POUND
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10110111
db %01000011
db %01001111
db %11001000
db %11000000
db %10001000
db %00100010
db BANK(MienshaoPicFront)