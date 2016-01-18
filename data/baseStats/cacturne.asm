CacturneBaseStats: ; 38432 (e:4432)
db DEX_CACTURNE; pokedex id
db 70 ; base hp
db 115 ; base attack
db 60 ; base defense
db 55 ; base speed
db 115 ; base special
db GRASS ; species type 1
db DARK ; species type 2
db 60 ; catch rate
db 177 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/cacturne.pic",0,1
ELSE
INCBIN "pic/bmon/cacturne.pic",0,1
ENDC
dw CacturnePicFront
dw CacturnePicBack
; attacks known at lvl 0
db POISON_STING
db LEER
db 0
db 0
db 3 ; growth rate
; learnset
db %10110101
db %01000011
db %01111111
db %11000000
db %10000001
db %00001001
db %01100110
db BANK(CacturnePicFront)