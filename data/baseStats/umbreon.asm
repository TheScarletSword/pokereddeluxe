UmbreonBaseStats: ; 3924e (e:524e)
db DEX_UMBREON ; pokedex id
db 95 ; base hp
db 65 ; base attack
db 110 ; base defense
db 65 ; base speed
db 95 ; base special
db DARK ; species type 1
db DARK ; species type 2
db 45 ; catch rate
db 197 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/umbreon.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/umbreon.pic",0,1 ; 77, sprite dimensions
ENDC
dw UmbreonPicFront
dw UmbreonPicBack
; attacks known at lvl 0
db TACKLE
db SAND_ATTACK
db QUICK_ATTACK
db BITE
db 0 ; growth rate
; learnset
db %10100000
db %01000011
db %00000000
db %11010000
db %11000001
db %00101001
db %01000110
db BANK(UmbreonPicFront)
