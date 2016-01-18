WeezingBaseStats: ; 38fca (e:4fca)
db DEX_WEEZING ; pokedex id
db 65 ; base hp
db 90 ; base attack
db 120 ; base defense
db 60 ; base speed
db 85 ; base special
db POISON ; species type 1
db POISON ; species type 2
db 60 ; catch rate
db 173 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/weezing.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/weezing.pic",0,1 ; 77, sprite dimensions
ENDC
dw WeezingPicFront
dw WeezingPicBack
; attacks known at lvl 0
db TACKLE
db SMOG
db POISON_GAS
db SLUDGE
db 0 ; growth rate
; learnset
db %00100000
db %01000000
db %10000000
db %11000001
db %00101000
db %01001001
db %00000010
db BANK(WeezingPicFront)
