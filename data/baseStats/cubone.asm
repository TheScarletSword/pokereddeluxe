CuboneBaseStats: ; 38f22 (e:4f22)
db DEX_CUBONE ; pokedex id
db 50 ; base hp
db 50 ; base attack
db 95 ; base defense
db 35 ; base speed
db 50 ; base special
db GROUND ; species type 1
db GROUND ; species type 2
db 190 ; catch rate
db 87 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/cubone.pic",0,1
ELSE
INCBIN "pic/bmon/cubone.pic",0,1
ENDC
dw CubonePicFront
dw CubonePicBack
; attacks known at lvl 0
db BONE_CLUB
db GROWL
db 0
db 0
db 0 ; growth rate
; learnset
db %10110101
db %00110111
db %00000111
db %11001110
db %10100000
db %00001000
db %00100010
db BANK(CubonePicFront)
