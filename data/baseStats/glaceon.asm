GlaceonBaseStats: ; 3924e (e:524e)
db DEX_GLACEON ; pokedex id
db 65 ; base hp
db 60 ; base attack
db 110 ; base defense
db 65 ; base speed
db 130 ; base special
db ICE ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 196 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/glaceon.pic",0,1
ELSE
INCBIN "pic/bmon/glaceon.pic",0,1
ENDC
dw GlaceonPicFront
dw GlaceonPicBack
; attacks known at lvl 0
db TACKLE
db SAND_ATTACK
db QUICK_ATTACK
db 0
db 0 ; growth rate
; learnset
db %10100000
db %01110111
db %00000000
db %11000000
db %11000001
db %00001000
db %00100010
db BANK(GlaceonPicFront)
