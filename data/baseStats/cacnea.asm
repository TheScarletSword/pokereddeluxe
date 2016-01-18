CacneaBaseStats: ; 38432 (e:4432)
db DEX_CACNEA; pokedex id
db 50 ; base hp
db 85 ; base attack
db 40 ; base defense
db 35 ; base speed
db 85 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 190 ; catch rate
db 97 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/cacnea.pic",0,1
ELSE
INCBIN "pic/bmon/cacnea.pic",0,1
ENDC
dw CacneaPicFront
dw CacneaPicBack
; attacks known at lvl 0
db POISON_STING
db LEER
db 0
db 0
db 3 ; growth rate
; learnset
db %10110101
db %00000011
db %01111111
db %11000000
db %10000001
db %00001001
db %01100110
db BANK(CacneaPicFront)