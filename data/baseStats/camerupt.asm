CameruptBaseStats: ; 38432 (e:4432)
db DEX_CAMERUPT; pokedex id
db 70 ; base hp
db 100 ; base attack
db 70 ; base defense
db 40 ; base speed
db 105 ; base special
db FIRE ; species type 1
db GROUND ; species type 2
db 150 ; catch rate
db 175 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/camerupt.pic",0,1
ELSE
INCBIN "pic/bmon/camerupt.pic",0,1
ENDC
dw CameruptPicFront
dw CameruptPicBack
; attacks known at lvl 0
db GROWL
db TACKLE
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01001011
db %00000000
db %11001110
db %10101000
db %11001000
db %00100010
db BANK(CameruptPicFront)