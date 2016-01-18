BlisseyBaseStats: ; 3901e (e:501e)
db DEX_BLISSEY ; pokedex id
db 255 ; base hp
db 10 ; base attack
db 10 ; base defense
db 55 ; base speed
db 135 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 30 ; catch rate
db 255 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/blissey.pic",0,1
ELSE
INCBIN "pic/bmon/blissey.pic",0,1
ENDC
dw BlisseyPicFront
dw BlisseyPicBack
; attacks known at lvl 0
db POUND
db TAIL_WHIP
db 0
db 0
db 4 ; growth rate
; learnset
db %10110001
db %01111111
db %11100111
db %11110001
db %10100101
db %00111000
db %01100011
db BANK(BlisseyPicFront)
