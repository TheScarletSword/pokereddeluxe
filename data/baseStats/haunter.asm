HaunterBaseStats: ; 38dee (e:4dee)
db DEX_HAUNTER ; pokedex id
db 45 ; base hp
db 50 ; base attack
db 45 ; base defense
db 95 ; base speed
db 115 ; base special
db GHOST ; species type 1
db POISON ; species type 2
db 90 ; catch rate
db 126 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/haunter.pic",0,1
ELSE
INCBIN "pic/bmon/haunter.pic",0,1
ENDC
dw HaunterPicFront
dw HaunterPicBack
; attacks known at lvl 0
db LICK
db CONFUSE_RAY
db NIGHT_SHADE
db 0
db 3 ; growth rate
; learnset
db %00100000
db %00000000
db %10011000
db %11110001
db %00001010
db %01101011
db %00000010
db BANK(HaunterPicFront)
