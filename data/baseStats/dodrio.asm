DodrioBaseStats: ; 38d0e (e:4d0e)
db DEX_DODRIO ; pokedex id
db 60 ; base hp
db 110 ; base attack
db 70 ; base defense
db 100 ; base speed
db 60 ; base special
db NORMAL ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 158 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/dodrio.pic",0,1
ELSE
INCBIN "pic/bmon/dodrio.pic",0,1
ENDC
dw DodrioPicFront
dw DodrioPicBack
; attacks known at lvl 0
db PECK
db GROWL
db FURY_ATTACK
db 0
db 0 ; growth rate
; learnset
db %10101000
db %01000011
db %00000000
db %11000000
db %10000001
db %00001100
db %00001011
db BANK(DodrioPicFront)
