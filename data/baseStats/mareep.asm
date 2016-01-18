MareepBaseStats: ; 38432 (e:4432)
db DEX_MAREEP; pokedex id
db 55 ; base hp
db 40 ; base attack
db 40 ; base defense
db 35 ; base speed
db 65 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 235 ; catch rate
db 59 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mareep.pic",0,1
ELSE
INCBIN "pic/bmon/mareep.pic",0,1
ENDC
dw MareepPicFront
dw MareepPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db 0
db 0
db 5 ; growth rate
; learnset
db %10100000
db %00000011
db %10000000
db %11000001
db %11000001
db %00011000
db %01000010
db BANK(MareepPicFront)