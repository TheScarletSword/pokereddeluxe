CryogonalBaseStats: ; 38432 (e:4432)
db DEX_CRYOGONAL; pokedex id
db 70 ; base hp
db 50 ; base attack
db 30 ; base defense
db 105 ; base speed
db 135 ; base special
db ICE ; species type 1
db ICE ; species type 2
db 25 ; catch rate
db 170 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/cryogonal.pic",0,1
ELSE
INCBIN "pic/bmon/cryogonal.pic",0,1
ENDC
dw CryogonalPicFront
dw CryogonalPicBack
; attacks known at lvl 0
db BIND
db MIST
db HAZE
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01110000
db %00100000
db %11000000
db %00000011
db %01001000
db %00000010
db BANK(CryogonalPicFront)