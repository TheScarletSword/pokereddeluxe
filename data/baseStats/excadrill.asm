ExcadrillBaseStats: ; 38432 (e:4432)
db DEX_EXCADRILL; pokedex id
db 110 ; base hp
db 135 ; base attack
db 60 ; base defense
db 88 ; base speed
db 50 ; base special
db GROUND ; species type 1
db STEEL ; species type 2
db 60 ; catch rate
db 178 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/excadrill.pic",0,1
ELSE
INCBIN "pic/bmon/excadrill.pic",0,1
ENDC
dw ExcadrillPicFront
dw ExcadrillPicBack
; attacks known at lvl 0
db SCRATCH
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %11100100
db %01000011
db %00001111
db %11001110
db %10010000
db %10001000
db %00100110
db BANK(ExcadrillPicFront)