TentacruelBaseStats: ; 38bbe (e:4bbe)
db DEX_TENTACRUEL ; pokedex id
db 80 ; base hp
db 70 ; base attack
db 65 ; base defense
db 100 ; base speed
db 120 ; base special
db WATER ; species type 1
db POISON ; species type 2
db 60 ; catch rate
db 205 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tentacruel.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/tentacruel.pic",0,1 ; 66, sprite dimensions
ENDC
dw TentacruelPicFront
dw TentacruelPicBack
; attacks known at lvl 0
db ACID
db SUPERSONIC
db WRAP
db 0
db 5 ; growth rate
; learnset
db %00100100
db %01110111
db %00011000
db %11100000
db %10000001
db %00001000
db %00010110
db BANK(TentacruelPicFront)
