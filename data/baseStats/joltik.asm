JoltikBaseStats: ; 38432 (e:4432)
db DEX_JOLTIK; pokedex id
db 50 ; base hp
db 47 ; base attack
db 50 ; base defense
db 65 ; base speed
db 57 ; base special
db BUG ; species type 1
db ELECTRIC ; species type 2
db 190 ; catch rate
db 64 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/joltik.pic",0,1
ELSE
INCBIN "pic/bmon/joltik.pic",0,1
ENDC
dw JoltikPicFront
dw JoltikPicBack
; attacks known at lvl 0
db STRING_SHOT
db LEECH_LIFE
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00000011
db %10011000
db %11000000
db %11010001
db %00011000
db %01000110
db BANK(JoltikPicFront)