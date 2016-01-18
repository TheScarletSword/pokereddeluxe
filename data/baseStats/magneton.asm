MagnetonBaseStats: ; 38cba (e:4cba)
db DEX_MAGNETON ; pokedex id
db 50 ; base hp
db 60 ; base attack
db 95 ; base defense
db 70 ; base speed
db 120 ; base special
db ELECTRIC ; species type 1
db STEEL ; species type 2
db 60 ; catch rate
db 161 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/magneton.pic",0,1
ELSE
INCBIN "pic/bmon/magneton.pic",0,1
ENDC
dw MagnetonPicFront
dw MagnetonPicBack
; attacks known at lvl 0
db TACKLE
db SONICBOOM
db THUNDERSHOCK
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01000011
db %10000000
db %11000001
db %01000001
db %00011000
db %01000010
db BANK(MagnetonPicFront)
