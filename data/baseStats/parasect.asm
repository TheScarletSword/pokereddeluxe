ParasectBaseStats: ; 388e6 (e:48e6)
db DEX_PARASECT ; pokedex id
db 60 ; base hp
db 95 ; base attack
db 80 ; base defense
db 30 ; base speed
db 80 ; base special
db BUG ; species type 1
db GRASS ; species type 2
db 75 ; catch rate
db 128 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/parasect.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/parasect.pic",0,1 ; 77, sprite dimensions
ENDC
dw ParasectPicFront
dw ParasectPicBack
; attacks known at lvl 0
db SCRATCH
db STUN_SPORE
db LEECH_LIFE
db 0
db 0 ; growth rate
; learnset
db %10100100
db %01000011
db %00110000
db %11001000
db %10010001
db %00001000
db %00000110
db BANK(ParasectPicFront)
