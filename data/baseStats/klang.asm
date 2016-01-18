KlangBaseStats: ; 38432 (e:4432)
db DEX_KLANG; pokedex id
db 60 ; base hp
db 80 ; base attack
db 95 ; base defense
db 50 ; base speed
db 85 ; base special
db STEEL ; species type 1
db STEEL ; species type 2
db 60 ; catch rate
db 134 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/klang.pic",0,1
ELSE
INCBIN "pic/bmon/klang.pic",0,1
ENDC
dw KlangPicFront
dw KlangPicBack
; attacks known at lvl 0
db VICEGRIP
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10100000
db %01000011
db %10000000
db %11000000
db %10000000
db %00011000
db %01000011
db BANK(KlangPicFront)