JolteonBaseStats: ; 39286 (e:5286)
db DEX_JOLTEON ; pokedex id
db 65 ; base hp
db 65 ; base attack
db 60 ; base defense
db 130 ; base speed
db 110 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 45 ; catch rate
db 197 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/jolteon.pic",0,1
ELSE
INCBIN "pic/bmon/jolteon.pic",0,1
ENDC
dw JolteonPicFront
dw JolteonPicBack
; attacks known at lvl 0
db TACKLE
db SAND_ATTACK
db QUICK_ATTACK
db THUNDERSHOCK
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %10000000
db %11000001
db %11000001
db %00011000
db %01000010
db BANK(JolteonPicFront)
