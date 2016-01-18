GengarBaseStats: ; 38e0a (e:4e0a)
db DEX_GENGAR ; pokedex id
db 60 ; base hp
db 65 ; base attack
db 60 ; base defense
db 110 ; base speed
db 130 ; base special
db GHOST ; species type 1
db POISON ; species type 2
db 45 ; catch rate
db 190 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/gengar.pic",0,1
ELSE
INCBIN "pic/bmon/gengar.pic",0,1
ENDC
dw GengarPicFront
dw GengarPicBack
; attacks known at lvl 0
db LICK
db CONFUSE_RAY
db NIGHT_SHADE
db 0
db 3 ; growth rate
; learnset
db %10110001
db %01000011
db %11011111
db %11110001
db %10001110
db %01101011
db %00100010
db BANK(GengarPicFront)
