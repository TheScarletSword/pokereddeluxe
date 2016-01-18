DeinoBaseStats: ; 38432 (e:4432)
db DEX_DEINO ; pokedex id
db 52 ; base hp
db 65 ; base attack
db 50 ; base defense
db 38 ; base speed
db 45 ; base special
db DARK ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 60 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/deino.pic",0,1
ELSE
INCBIN "pic/bmon/deino.pic",0,1
ENDC
dw DeinoPicFront
dw DeinoPicBack
; attacks known at lvl 0
db TACKLE
db DRAGON_RAGE
db 0
db 0
db 5 ; growth rate
; learnset
db %10100000
db %00000111
db %00000000
db %11000000
db %10000001
db %00001001
db %00100010
db BANK(DeinoPicFront)
