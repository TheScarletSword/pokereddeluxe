TyrogueBaseStats: ; 38f76 (e:4f76)
db DEX_TYROGUE ; pokedex id
db 35 ; base hp
db 35 ; base attack
db 35 ; base defense
db 35 ; base speed
db 35 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 75 ; catch rate
db 91 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tyrogue.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/tyrogue.pic",0,1 ; 77, sprite dimensions
ENDC
dw TyroguePicFront
dw TyroguePicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %00000111
db %11000000
db %11000100
db %00001000
db %00100010
db BANK(TyroguePicFront)
