LiepardBaseStats: ; 38432 (e:4432)
db DEX_LIEPARD; pokedex id
db 64 ; base hp
db 88 ; base attack
db 50 ; base defense
db 106 ; base speed
db 88 ; base special
db DARK ; species type 1
db DARK ; species type 2
db 90 ; catch rate
db 156 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/liepard.pic",0,1
ELSE
INCBIN "pic/bmon/liepard.pic",0,1
ENDC
dw LiepardPicFront
dw LiepardPicBack
; attacks known at lvl 0
db SCRATCH
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %11000011
db %00000000
db %11000000
db %11000000
db %00011001
db %00000110
db BANK(LiepardPicFront)