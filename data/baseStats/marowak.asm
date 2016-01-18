MarowakBaseStats: ; 38f3e (e:4f3e)
db DEX_MAROWAK ; pokedex id
db 60 ; base hp
db 80 ; base attack
db 110 ; base defense
db 45 ; base speed
db 80 ; base special
db GROUND ; species type 1
db GROUND ; species type 2
db 75 ; catch rate
db 124 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/marowak.pic",0,1
ELSE
INCBIN "pic/bmon/marowak.pic",0,1
ENDC
dw MarowakPicFront
dw MarowakPicBack
; attacks known at lvl 0
db BONE_CLUB
db TAIL_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %10110101
db %01110111
db %00000111
db %11001110
db %10100000
db %00001000
db %00100010
db BANK(MarowakPicFront)
