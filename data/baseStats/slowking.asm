SlowkingBaseStats: ; 38c82 (e:4c82)
db DEX_SLOWKING ; pokedex id
db 95 ; base hp
db 75 ; base attack
db 80 ; base defense
db 30 ; base speed
db 110 ; base special
db WATER ; species type 1
db PSYCHIC ; species type 2
db 70 ; catch rate
db 164 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/slowking.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/slowking.pic",0,1 ; 77, sprite dimensions
ENDC
dw SlowkingPicFront
dw SlowkingPicBack
; attacks known at lvl 0
db CONFUSION
db DISABLE
db HEADBUTT
db 0
db 0 ; growth rate
; learnset
db %10110001
db %11110111
db %01000111
db %11011110
db %11100001
db %00111000
db %01110011
db BANK(SlowkingPicFront)
