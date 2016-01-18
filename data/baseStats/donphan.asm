DonphanBaseStats: ; 38432 (e:4432)
db DEX_DONPHAN; pokedex id
db 90 ; base hp
db 120 ; base attack
db 120 ; base defense
db 50 ; base speed
db 60 ; base special
db GROUND ; species type 1
db GROUND ; species type 2
db 60 ; catch rate
db 189 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/donphan.pic",0,1
ELSE
INCBIN "pic/bmon/donphan.pic",0,1
ENDC
dw DonphanPicFront
dw DonphanPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db HORN_ATTACK
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %00001000
db %11000110
db %10000000
db %10001000
db %00100010
db BANK(DonphanPicFront)