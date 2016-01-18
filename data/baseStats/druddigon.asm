DruddigonBaseStats: ; 38432 (e:4432)
db DEX_DRUDDIGON; pokedex id
db 77 ; base hp
db 120 ; base attack
db 90 ; base defense
db 48 ; base speed
db 90 ; base special
db DRAGON ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 173 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/druddigon.pic",0,1
ELSE
INCBIN "pic/bmon/druddigon.pic",0,1
ENDC
dw DruddigonPicFront
dw DruddigonPicBack
; attacks known at lvl 0
db LEER
db SCRATCH
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01001011
db %00000111
db %11001110
db %10000011
db %10001001
db %00110110
db BANK(DruddigonPicFront)