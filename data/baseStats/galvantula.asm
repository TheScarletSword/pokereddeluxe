GalvantulaBaseStats: ; 38432 (e:4432)
db DEX_GALVANTULA; pokedex id
db 70 ; base hp
db 77 ; base attack
db 60 ; base defense
db 108 ; base speed
db 97 ; base special
db BUG ; species type 1
db ELECTRIC ; species type 2
db 75 ; catch rate
db 165 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/galvantula.pic",0,1
ELSE
INCBIN "pic/bmon/galvantula.pic",0,1
ENDC
dw GalvantulaPicFront
dw GalvantulaPicBack
; attacks known at lvl 0
db STRING_SHOT
db LEECH_LIFE
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %10011000
db %11000001
db %11010001
db %00011000
db %01000110
db BANK(GalvantulaPicFront)