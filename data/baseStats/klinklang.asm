KlinklangBaseStats: ; 38432 (e:4432)
db DEX_KLINKLANG; pokedex id
db 60 ; base hp
db 100 ; base attack
db 115 ; base defense
db 90 ; base speed
db 85 ; base special
db STEEL ; species type 1
db STEEL ; species type 2
db 30 ; catch rate
db 185 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/klinklang.pic",0,1
ELSE
INCBIN "pic/bmon/klinklang.pic",0,1
ENDC
dw KlinklangPicFront
dw KlinklangPicBack
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
db %11000001
db %10000000
db %00011000
db %01000011
db BANK(KlinklangPicFront)