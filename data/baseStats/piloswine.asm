PiloswineBaseStats: ; 38432 (e:4432)
db DEX_PILOSWINE; pokedex id
db 100 ; base hp
db 100 ; base attack
db 80 ; base defense
db 50 ; base speed
db 60 ; base special
db ICE ; species type 1
db GROUND ; species type 2
db 75 ; catch rate
db 160 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/piloswine.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/piloswine.pic",0,1 ; 77, sprite dimensions
ENDC
dw PiloswinePicFront
dw PiloswinePicBack
; attacks known at lvl 0
db TACKLE
db HORN_ATTACK
db PECK
db 0
db 5 ; growth rate
; learnset
db %10100000
db %01110011
db %00000000
db %11001110
db %10000000
db %10001000
db %00100010
db BANK(PiloswinePicFront)