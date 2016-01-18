OddishBaseStats: ; 38876 (e:4876)
db DEX_ODDISH ; pokedex id
db 45 ; base hp
db 50 ; base attack
db 55 ; base defense
db 30 ; base speed
db 75 ; base special
db GRASS ; species type 1
db POISON ; species type 2
db 255 ; catch rate
db 78 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/oddish.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/oddish.pic",0,1 ; 55, sprite dimensions
ENDC
dw OddishPicFront
dw OddishPicBack
; attacks known at lvl 0
db ABSORB
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %00100100
db %00000011
db %00110000
db %11100000
db %00000001
db %00001000
db %00000110
db BANK(OddishPicFront)
