SkorupiBaseStats: ; 38432 (e:4432)
db DEX_SKORUPI; pokedex id
db 40 ; base hp
db 50 ; base attack
db 90 ; base defense
db 65 ; base speed
db 55 ; base special
db POISON ; species type 1
db BUG ; species type 2
db 120 ; catch rate
db 114 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/skorupi.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/skorupi.pic",0,1 ; 55, sprite dimensions
ENDC
dw SkorupiPicFront
dw SkorupiPicBack
; attacks known at lvl 0
db BITE
db POISON_STING
db LEER
db PIN_MISSILE
db 5 ; growth rate
; learnset
db %10100100
db %00000011
db %00001000
db %11001000
db %10010000
db %00001001
db %00100110
db BANK(SkorupiPicFront)