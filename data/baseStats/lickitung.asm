LickitungBaseStats: ; 38f92 (e:4f92)
db DEX_LICKITUNG ; pokedex id
db 90 ; base hp
db 55 ; base attack
db 75 ; base defense
db 30 ; base speed
db 60 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 45 ; catch rate
db 127 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/lickitung.pic",0,1
ELSE
INCBIN "pic/bmon/lickitung.pic",0,1
ENDC
dw LickitungPicFront
dw LickitungPicBack
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
db BANK(LickitungPicFront)
