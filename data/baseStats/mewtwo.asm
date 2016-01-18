MewtwoBaseStats: ; 3942a (e:542a)
db DEX_MEWTWO ; pokedex id
db 106 ; base hp
db 110 ; base attack
db 90 ; base defense
db 130 ; base speed
db 154 ; base special
db PSYCHIC ; species type 1
db PSYCHIC ; species type 2
db 3 ; catch rate
db 220 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mewtwo.pic",0,1
ELSE
INCBIN "pic/bmon/mewtwo.pic",0,1
ENDC
dw MewtwoPicFront
dw MewtwoPicBack
; attacks known at lvl 0
db CONFUSION
db DISABLE
db SWIFT
db PSYCHIC_M
db 5 ; growth rate
; learnset
db %10110001
db %11110111
db %11101111
db %11010001
db %10101101
db %00111000
db %01100011
db BANK(MewtwoPicFront)
