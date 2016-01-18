ElectabuzzBaseStats: ; 3916e (e:516e)
db DEX_ELECTABUZZ ; pokedex id
db 65 ; base hp
db 83 ; base attack
db 57 ; base defense
db 105 ; base speed
db 85 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 45 ; catch rate
db 156 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/electabuzz.pic",0,1
ELSE
INCBIN "pic/bmon/electabuzz.pic",0,1
ENDC
dw ElectabuzzPicFront
dw ElectabuzzPicBack
; attacks known at lvl 0
db QUICK_ATTACK
db LEER
db LOW_KICK
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01000011
db %10000111
db %11010001
db %11000101
db %00111000
db %01100010
db BANK(ElectabuzzPicFront)
