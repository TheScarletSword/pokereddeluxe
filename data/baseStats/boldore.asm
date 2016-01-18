BoldoreBaseStats: ; 38432 (e:4432)
db DEX_BOLDORE ; pokedex id
db 70 ; base hp
db 105 ; base attack
db 105 ; base defense
db 20 ; base speed
db 40 ; base special
db ROCK ; species type 1
db ROCK ; species type 2
db 120 ; catch rate
db 137 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/boldore.pic",0,1
ELSE
INCBIN "pic/bmon/boldore.pic",0,1
ENDC
dw BoldorePicFront
dw BoldorePicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10100000
db %00000011
db %00000000
db %11000110
db %10001000
db %11001000
db %00100010
db BANK(BoldorePicFront)
