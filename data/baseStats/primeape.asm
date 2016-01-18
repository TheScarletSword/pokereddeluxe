PrimeapeBaseStats: ; 389fe (e:49fe)
db DEX_PRIMEAPE ; pokedex id
db 65 ; base hp
db 105 ; base attack
db 60 ; base defense
db 95 ; base speed
db 60 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 75 ; catch rate
db 149 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/primeape.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/primeape.pic",0,1 ; 77, sprite dimensions
ENDC
dw PrimeapePicFront
dw PrimeapePicBack
; attacks known at lvl 0
db LEER
db KARATE_CHOP
db FURY_SWIPES
db LOW_KICK
db 0 ; growth rate
; learnset
db %10110001
db %11000011
db %10001111
db %11001001
db %11000100
db %10001000
db %00100010
db BANK(PrimeapePicFront)
