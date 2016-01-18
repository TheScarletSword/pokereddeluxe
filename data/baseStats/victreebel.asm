VictreebelBaseStats: ; 38b86 (e:4b86)
db DEX_VICTREEBEL	 ; pokedex id
db 80 ; base hp
db 105 ; base attack
db 65 ; base defense
db 70 ; base speed
db 100 ; base special
db GRASS ; species type 1
db POISON ; species type 2
db 45 ; catch rate
db 191 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/victreebel.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/victreebel.pic",0,1 ; 77, sprite dimensions
ENDC
dw VictreebelPicFront
dw VictreebelPicBack
; attacks known at lvl 0
db SLEEP_POWDER
db STUN_SPORE
db ACID
db RAZOR_LEAF
db 3 ; growth rate
; learnset
db %10100100
db %01000011
db %00110000
db %11000000
db %00000001
db %00001000
db %00000110
db BANK(VictreebelPicFront)
