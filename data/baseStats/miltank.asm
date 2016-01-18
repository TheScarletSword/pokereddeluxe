MiltankBaseStats: ; 38432 (e:4432)
db DEX_MILTANK; pokedex id
db 95 ; base hp
db 80 ; base attack
db 105 ; base defense
db 100 ; base speed
db 70 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/miltank.pic",0,1
ELSE
INCBIN "pic/bmon/miltank.pic",0,1
ENDC
dw MiltankPicFront
dw MiltankPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 5 ; growth rate
; learnset
db %10110001
db %01110111
db %10100111
db %11000111
db %10000100
db %00011000
db %00110010
db BANK(MiltankPicFront)