FlygonBaseStats: ; 38432 (e:4432)
db DEX_FLYGON; pokedex id
db 80 ; base hp
db 100 ; base attack
db 80 ; base defense
db 100 ; base speed
db 80 ; base special
db GROUND ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 197 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/flygon.pic",0,1
ELSE
INCBIN "pic/bmon/flygon.pic",0,1
ENDC
dw FlygonPicFront
dw FlygonPicBack
; attacks known at lvl 0
db BITE
db SONICBOOM
db 0
db 0
db 3 ; growth rate
; learnset
db %10101010
db %01001011
db %00100000
db %11001110
db %10100010
db %10001000
db %00101010
db BANK(FlygonPicFront)