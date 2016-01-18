GigalithBaseStats: ; 38432 (e:4432)
db DEX_GIGALITH ; pokedex id
db 85 ; base hp
db 135 ; base attack
db 130 ; base defense
db 25 ; base speed
db 60 ; base special
db ROCK ; species type 1
db ROCK ; species type 2
db 45 ; catch rate
db 185 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/gigalith.pic",0,1
ELSE
INCBIN "pic/bmon/gigalith.pic",0,1
ENDC
dw GigalithPicFront
dw GigalithPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10100000
db %01000011
db %00100000
db %11000110
db %10001000
db %11001000
db %00100010
db BANK(GigalithPicFront)
