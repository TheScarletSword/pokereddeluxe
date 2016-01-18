SwinubBaseStats: ; 38432 (e:4432)
db DEX_SWINUB; pokedex id
db 50 ; base hp
db 50 ; base attack
db 40 ; base defense
db 50 ; base speed
db 30 ; base special
db ICE ; species type 1
db GROUND ; species type 2
db 225 ; catch rate
db 78 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/swinub.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/swinub.pic",0,1 ; 55, sprite dimensions
ENDC
dw SwinubPicFront
dw SwinubPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 5 ; growth rate
; learnset
db %10100000
db %00110011
db %00000000
db %11001110
db %10000000
db %10001000
db %00100010
db BANK(SwinubPicFront)