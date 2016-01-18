DragonairBaseStats: ; 393f2 (e:53f2)
db DEX_DRAGONAIR ; pokedex id
db 61 ; base hp
db 84 ; base attack
db 65 ; base defense
db 70 ; base speed
db 70 ; base special
db DRAGON ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 144 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/dragonair.pic",0,1
ELSE
INCBIN "pic/bmon/dragonair.pic",0,1
ENDC
dw DragonairPicFront
dw DragonairPicBack
; attacks known at lvl 0
db WRAP
db LEER
db THUNDER_WAVE
db 0
db 5 ; growth rate
; learnset
db %11100000
db %00110111
db %10000000
db %11000001
db %11100001
db %00011000
db %00010010
db BANK(DragonairPicFront)
