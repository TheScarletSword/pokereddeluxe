GolettBaseStats: ; 38432 (e:4432)
db DEX_GOLETT; pokedex id
db 59 ; base hp
db 74 ; base attack
db 50 ; base defense
db 35 ; base speed
db 35 ; base special
db GROUND ; species type 1
db GHOST ; species type 2
db 190 ; catch rate
db 61 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/golett.pic",0,1
ELSE
INCBIN "pic/bmon/golett.pic",0,1
ENDC
dw GolettPicFront
dw GolettPicBack
; attacks known at lvl 0
db POUND
db DEFENSE_CURL
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00010011
db %01000111
db %11010110
db %10000010
db %10001000
db %01101010
db BANK(GolettPicFront)