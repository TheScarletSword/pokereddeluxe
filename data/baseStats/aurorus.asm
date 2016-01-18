AurorusBaseStats: ; 38432 (e:4432)
db DEX_AURORUS; pokedex id
db 123 ; base hp
db 77 ; base attack
db 72 ; base defense
db 58 ; base speed
db 99 ; base special
db ROCK ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 104 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/aurorus.pic",0,1
ELSE
INCBIN "pic/bmon/aurorus.pic",0,1
ENDC
dw AurorusPicFront
dw AurorusPicBack
; attacks known at lvl 0
db GROWL
db MIST
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01110111
db %10000000
db %11010111
db %10000000
db %00111001
db %01000010
db BANK(AurorusPicFront)