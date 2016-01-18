MagikarpBaseStats: ; 391de (e:51de)
db DEX_MAGIKARP ; pokedex id
db 20 ; base hp
db 10 ; base attack
db 55 ; base defense
db 80 ; base speed
db 20 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 255 ; catch rate
db 20 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/magikarp.pic",0,1
ELSE
INCBIN "pic/bmon/magikarp.pic",0,1
ENDC
dw MagikarpPicFront
dw MagikarpPicBack
; attacks known at lvl 0
db SPLASH
db 0
db 0
db 0
db 5 ; growth rate
; learnset
db %00000000
db %00000000
db %00000000
db %00000000
db %00000000
db %00000000
db %00000000
db BANK(MagikarpPicFront)
