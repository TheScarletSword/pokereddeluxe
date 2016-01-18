CloysterBaseStats: ; 38db6 (e:4db6)
db DEX_CLOYSTER ; pokedex id
db 50 ; base hp
db 95 ; base attack
db 180 ; base defense
db 70 ; base speed
db 85 ; base special
db WATER ; species type 1
db ICE ; species type 2
db 60 ; catch rate
db 203 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/cloyster.pic",0,1
ELSE
INCBIN "pic/bmon/cloyster.pic",0,1
ENDC
dw CloysterPicFront
dw CloysterPicBack
; attacks known at lvl 0
db WITHDRAW
db SUPERSONIC
db CLAMP
db AURORA_BEAM
db 5 ; growth rate
; learnset
db %00100000
db %01110111
db %00001000
db %11000000
db %01001001
db %01001000
db %00010011
db BANK(CloysterPicFront)
