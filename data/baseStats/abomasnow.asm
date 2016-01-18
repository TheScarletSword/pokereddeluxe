AbomasnowBaseStats: ; 38432 (e:4432)
db DEX_ABOMASNOW; pokedex id
db 90 ; base hp
db 92 ; base attack
db 75 ; base defense
db 60 ; base speed
db 85 ; base special
db GRASS ; species type 1
db ICE ; species type 2
db 60 ; catch rate
db 214 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/abomasnow.pic",0,1
ELSE
INCBIN "pic/bmon/abomasnow.pic",0,1
ENDC
dw AbomasnowPicFront
dw AbomasnowPicBack
; attacks known at lvl 0
db LEER
db 0
db 0
db 0
db 5 ; growth rate
; learnset
db %10110101
db %01110011
db %00110111
db %11000110
db %10000001
db %00001000
db %00100010
db BANK(AbomasnowPicFront)