ElekidBaseStats: ; 3916e (e:516e)
db DEX_ELEKID ; pokedex id
db 45 ; base hp
db 63 ; base attack
db 37 ; base defense
db 95 ; base speed
db 55 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 45 ; catch rate
db 106 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/elekid.pic",0,1
ELSE
INCBIN "pic/bmon/elekid.pic",0,1
ENDC
dw ElekidPicFront
dw ElekidPicBack
; attacks known at lvl 0
db QUICK_ATTACK
db LEER
db LOW_KICK
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %10000111
db %11010001
db %11000101
db %00111000
db %01100010
db BANK(ElekidPicFront)
