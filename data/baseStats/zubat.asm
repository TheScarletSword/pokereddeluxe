ZubatBaseStats: ; 3883e (e:483e)
db DEX_ZUBAT ; pokedex id
db 40 ; base hp
db 45 ; base attack
db 35 ; base defense
db 55 ; base speed
db 40 ; base special
db POISON ; species type 1
db FLYING ; species type 2
db 255 ; catch rate
db 54 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/zubat.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/zubat.pic",0,1 ; 55, sprite dimensions
ENDC
dw ZubatPicFront
dw ZubatPicBack
; attacks known at lvl 0
db LEECH_LIFE
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %00101010
db %00001011
db %00010000
db %11000000
db %01000010
db %00001001
db %00000010
db BANK(ZubatPicFront)