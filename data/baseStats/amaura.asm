AmauraBaseStats: ; 38432 (e:4432)
db DEX_AMAURA; pokedex id
db 77 ; base hp
db 59 ; base attack
db 50 ; base defense
db 46 ; base speed
db 67 ; base special
db ROCK ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 72 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/amaura.pic",0,1
ELSE
INCBIN "pic/bmon/amaura.pic",0,1
ENDC
dw AmauraPicFront
dw AmauraPicBack
; attacks known at lvl 0
db GROWL
db MIST
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00110111
db %10000000
db %11010111
db %10000000
db %00111001
db %01000010
db BANK(AmauraPicFront)