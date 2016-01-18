DrilburBaseStats: ; 38432 (e:4432)
db DEX_DRILBUR; pokedex id
db 60 ; base hp
db 85 ; base attack
db 40 ; base defense
db 68 ; base speed
db 30 ; base special
db GROUND ; species type 1
db GROUND ; species type 2
db 120 ; catch rate
db 66 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/drilbur.pic",0,1
ELSE
INCBIN "pic/bmon/drilbur.pic",0,1
ENDC
dw DrilburPicFront
dw DrilburPicBack
; attacks known at lvl 0
db SCRATCH
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %11100100
db %00000011
db %00001111
db %11001110
db %10010000
db %10001000
db %00100110
db BANK(DrilburPicFront)