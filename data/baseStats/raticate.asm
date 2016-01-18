RaticateBaseStats: ; 385f2 (e:45f2)
db DEX_RATICATE ; pokedex id
db 55 ; base hp
db 81 ; base attack
db 60 ; base defense
db 97 ; base speed
db 50 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 90 ; catch rate
db 116 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/raticate.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/raticate.pic",0,1 ; 66, sprite dimensions
ENDC
dw RaticatePicFront
dw RaticatePicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db QUICK_ATTACK
db 0
db 0 ; growth rate
; learnset
db %10100100
db %01110111
db %10000000
db %11001001
db %11000000
db %00001000
db %00000010
db BANK(RaticatePicFront)
