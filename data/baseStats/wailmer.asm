WailmerBaseStats: ; 38432 (e:4432)
db DEX_WAILMER; pokedex id
db 130 ; base hp
db 70 ; base attack
db 35 ; base defense
db 60 ; base speed
db 70 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 125 ; catch rate
db 137 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/wailmer.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/wailmer.pic",0,1 ; 66, sprite dimensions
ENDC
dw WailmerPicFront
dw WailmerPicBack
; attacks known at lvl 0
db SPLASH
db 0
db 0
db 0
db 7 ; growth rate
; learnset
db %10100000
db %00110111
db %00000000
db %11000110
db %10001000
db %00001000
db %00110010
db BANK(WailmerPicFront)