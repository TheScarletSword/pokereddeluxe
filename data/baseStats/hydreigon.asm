HydreigonBaseStats: ; 38432 (e:4432)
db DEX_HYDREIGON ; pokedex id
db 92 ; base hp
db 105 ; base attack
db 90 ; base defense
db 98 ; base speed
db 125 ; base special
db DARK ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 218 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/hydreigon.pic",0,1
ELSE
INCBIN "pic/bmon/hydreigon.pic",0,1
ENDC
dw HydreigonPicFront
dw HydreigonPicBack
; attacks known at lvl 0
db TACKLE
db DRAGON_RAGE
db 0
db 0
db 5 ; growth rate
; learnset
db %10101000
db %01001111
db %00000000
db %11000000
db %10100011
db %00001001
db %00111011
db BANK(HydreigonPicFront)