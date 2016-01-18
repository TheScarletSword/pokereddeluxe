NumelBaseStats: ; 38432 (e:4432)
db DEX_NUMEL; pokedex id
db 60 ; base hp
db 60 ; base attack
db 40 ; base defense
db 35 ; base speed
db 65 ; base special
db FIRE ; species type 1
db GROUND ; species type 2
db 255 ; catch rate
db 88 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/numel.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/numel.pic",0,1 ; 66, sprite dimensions
ENDC
dw NumelPicFront
dw NumelPicBack
; attacks known at lvl 0
db GROWL
db TACKLE
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00001011
db %00000000
db %11001110
db %10101000
db %11001000
db %00100010
db BANK(NumelPicFront)