WailordBaseStats: ; 38432 (e:4432)
db DEX_WAILORD; pokedex id
db 170 ; base hp
db 90 ; base attack
db 45 ; base defense
db 60 ; base speed
db 90 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 60 ; catch rate
db 206 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/wailord.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/wailord.pic",0,1 ; 77, sprite dimensions
ENDC
dw WailordPicFront
dw WailordPicBack
; attacks known at lvl 0
db SPLASH
db 0
db 0
db 0
db 7 ; growth rate
; learnset
db %10100000
db %01110111
db %00000000
db %11000110
db %10001000
db %00001000
db %00110010
db BANK(WailordPicFront)