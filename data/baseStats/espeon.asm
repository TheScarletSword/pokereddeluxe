EspeonBaseStats: ; 3924e (e:524e)
db DEX_ESPEON ; pokedex id
db 65 ; base hp
db 65 ; base attack
db 60 ; base defense
db 110 ; base speed
db 130 ; base special
db PSYCHIC ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 197 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/espeon.pic",0,1
ELSE
INCBIN "pic/bmon/espeon.pic",0,1
ENDC
dw EspeonPicFront
dw EspeonPicBack
; attacks known at lvl 0
db TACKLE
db SAND_ATTACK
db QUICK_ATTACK
db CONFUSION
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %00000000
db %11110000
db %11000001
db %00101000
db %01000110
db BANK(EspeonPicFront)
