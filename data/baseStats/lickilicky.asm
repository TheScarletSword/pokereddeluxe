LickilickyBaseStats: ; 38f92 (e:4f92)
db DEX_LICKILICKY ; pokedex id
db 110 ; base hp
db 85 ; base attack
db 95 ; base defense
db 50 ; base speed
db 80 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 30 ; catch rate
db 193 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/lickilicky.pic",0,1
ELSE
INCBIN "pic/bmon/lickilicky.pic",0,1
ENDC
dw LickilickyPicFront
dw LickilickyPicBack
; attacks known at lvl 0
db WRAP
db SUPERSONIC
db LICK
db 0
db 0 ; growth rate
; learnset
db %10110101
db %01110111
db %10000111
db %11000111
db %10100000
db %00001000
db %00110110
db BANK(LickilickyPicFront)
