TropiusBaseStats: ; 38432 (e:4432)
db DEX_TROPIUS; pokedex id
db 99 ; base hp
db 68 ; base attack
db 83 ; base defense
db 51 ; base speed
db 87 ; base special
db GRASS ; species type 1
db FLYING ; species type 2
db 200 ; catch rate
db 169 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tropius.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/tropius.pic",0,1 ; 77, sprite dimensions
ENDC
dw TropiusPicFront
dw TropiusPicBack
; attacks known at lvl 0
db LEER
db GUST
db 0
db 0
db 5 ; growth rate
; learnset
db %10101110
db %01000011
db %00110000
db %11000110
db %10000011
db %00001100
db %00101110
db BANK(TropiusPicFront)