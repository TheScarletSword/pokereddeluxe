TrapinchBaseStats: ; 38432 (e:4432)
db DEX_TRAPINCH; pokedex id
db 45 ; base hp
db 100 ; base attack
db 45 ; base defense
db 10 ; base speed
db 45 ; base special
db GROUND ; species type 1
db GROUND ; species type 2
db 255 ; catch rate
db 73 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/trapinch.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/trapinch.pic",0,1 ; 55, sprite dimensions
ENDC
dw TrapinchPicFront
dw TrapinchPicBack
; attacks known at lvl 0
db BITE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10100010
db %01000011
db %00000000
db %11001110
db %10000000
db %10001000
db %00100010
db BANK(TrapinchPicFront)