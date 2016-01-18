GolurkBaseStats: ; 38432 (e:4432)
db DEX_GOLURK; pokedex id
db 89 ; base hp
db 124 ; base attack
db 80 ; base defense
db 55 ; base speed
db 55 ; base special
db GROUND ; species type 1
db GHOST ; species type 2
db 90 ; catch rate
db 169 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/golurk.pic",0,1
ELSE
INCBIN "pic/bmon/golurk.pic",0,1
ENDC
dw GolurkPicFront
dw GolurkPicBack
; attacks known at lvl 0
db POUND
db DEFENSE_CURL
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01010011
db %01000111
db %11010110
db %10000010
db %10001000
db %01101010
db BANK(GolurkPicFront)