FloetteBaseStats: ; 38432 (e:4432)
db DEX_FLOETTE; pokedex id
db 54 ; base hp
db 45 ; base attack
db 47 ; base defense
db 52 ; base speed
db 75 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 120 ; catch rate
db 130 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/floette.pic",0,1
ELSE
INCBIN "pic/bmon/floette.pic",0,1
ENDC
dw FloettePicFront
dw FloettePicBack
; attacks known at lvl 0
db TACKLE
db VINE_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %00100000
db %00000011
db %00110000
db %11110000
db %01000001
db %00101000
db %01000010
db BANK(FloettePicFront)