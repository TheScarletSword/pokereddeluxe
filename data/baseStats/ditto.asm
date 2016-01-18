DittoBaseStats: ; 39232 (e:5232)
db DEX_DITTO ; pokedex id
db 48 ; base hp
db 48 ; base attack
db 48 ; base defense
db 48 ; base speed
db 48 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 35 ; catch rate
db 61 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/ditto.pic",0,1
ELSE
INCBIN "pic/bmon/ditto.pic",0,1
ENDC
dw DittoPicFront
dw DittoPicBack
; attacks known at lvl 0
db TRANSFORM
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %00000000
db %00000000
db %00000000
db %00000000
db %00000000
db %00000000
db %00000000
db BANK(DittoPicFront)
