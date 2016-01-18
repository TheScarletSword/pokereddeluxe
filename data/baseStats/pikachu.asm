PikachuBaseStats: ; 3867e (e:467e)
db DEX_PIKACHU ; pokedex id
db 35 ; base hp
db 55 ; base attack
db 40 ; base defense
db 90 ; base speed
db 50 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 190 ; catch rate
db 82 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/pikachu.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/pikachu.pic",0,1 ; 55, sprite dimensions
ENDC
dw PikachuPicFront
dw PikachuPicBack
; attacks known at lvl 0
db THUNDERSHOCK
db GROWL
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %10000011
db %10000101
db %11000001
db %11000001
db %00011000
db %01011010
db BANK(PikachuPicFront)
