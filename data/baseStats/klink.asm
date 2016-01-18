KlinkBaseStats: ; 38432 (e:4432)
db DEX_KLINK; pokedex id
db 40 ; base hp
db 55 ; base attack
db 70 ; base defense
db 30 ; base speed
db 60 ; base special
db STEEL ; species type 1
db STEEL ; species type 2
db 130 ; catch rate
db 60 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/klink.pic",0,1
ELSE
INCBIN "pic/bmon/klink.pic",0,1
ENDC
dw KlinkPicFront
dw KlinkPicBack
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
db BANK(KlinkPicFront)