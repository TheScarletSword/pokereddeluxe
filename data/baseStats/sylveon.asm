SylveonBaseStats: ; 3924e (e:524e)
db DEX_SYLVEON ; pokedex id
db 95 ; base hp
db 65 ; base attack
db 65 ; base defense
db 60 ; base speed
db 130 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/sylveon.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/sylveon.pic",0,1 ; 77, sprite dimensions
ENDC
dw SylveonPicFront
dw SylveonPicBack
; attacks known at lvl 0
db TACKLE
db SAND_ATTACK
db QUICK_ATTACK
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %00000000
db %11110000
db %11000001
db %00101000
db %01000110
db BANK(SylveonPicFront)
