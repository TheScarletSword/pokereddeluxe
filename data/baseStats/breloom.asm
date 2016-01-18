BreloomBaseStats: ; 38432 (e:4432)
db DEX_BRELOOM; pokedex id
db 60 ; base hp
db 130 ; base attack
db 80 ; base defense
db 70 ; base speed
db 60 ; base special
db GRASS ; species type 1
db FIGHTING ; species type 2
db 90 ; catch rate
db 165 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/breloom.pic",0,1
ELSE
INCBIN "pic/bmon/breloom.pic",0,1
ENDC
dw BreloomPicFront
dw BreloomPicBack
; attacks known at lvl 0
db ABSORB
db TACKLE
db 0
db 0
db 7 ; growth rate
; learnset
db %10110101
db %01000011
db %01110111
db %11000000
db %10000001
db %00001000
db %00100110
db BANK(BreloomPicFront)