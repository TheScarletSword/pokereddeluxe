GoldeenBaseStats: ; 390aa (e:50aa)
db DEX_GOLDEEN ; pokedex id
db 45 ; base hp
db 67 ; base attack
db 60 ; base defense
db 63 ; base speed
db 50 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 225 ; catch rate
db 111 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/goldeen.pic",0,1
ELSE
INCBIN "pic/bmon/goldeen.pic",0,1
ENDC
dw GoldeenPicFront
dw GoldeenPicBack
; attacks known at lvl 0
db PECK
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %01100000
db %00110111
db %00001000
db %11000000
db %11000000
db %00001000
db %00010010
db BANK(GoldeenPicFront)
