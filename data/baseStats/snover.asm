SnoverBaseStats: ; 38432 (e:4432)
db DEX_SNOVER; pokedex id
db 60 ; base hp
db 62 ; base attack
db 50 ; base defense
db 40 ; base speed
db 60 ; base special
db GRASS ; species type 1
db ICE ; species type 2
db 120 ; catch rate
db 131 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/snover.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/snover.pic",0,1 ; 55, sprite dimensions
ENDC
dw SnoverPicFront
dw SnoverPicBack
; attacks known at lvl 0
db LEER
db 0
db 0
db 0
db 5 ; growth rate
; learnset
db %10110101
db %00110011
db %00110111
db %11000000
db %10000001
db %00001000
db %00000010
db BANK(SnoverPicFront)