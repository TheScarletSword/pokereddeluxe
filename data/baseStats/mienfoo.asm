MienfooBaseStats: ; 38432 (e:4432)
db DEX_MIENFOO; pokedex id
db 45 ; base hp
db 85 ; base attack
db 50 ; base defense
db 65 ; base speed
db 50 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 180 ; catch rate
db 70 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mienfoo.pic",0,1
ELSE
INCBIN "pic/bmon/mienfoo.pic",0,1
ENDC
dw MienfooPicFront
dw MienfooPicBack
; attacks known at lvl 0
db POUND
db 0
db 0
db 0
db 3 ; growth rate
; learnset
db %10110111
db %00000011
db %01001111
db %11001000
db %11000000
db %10001000
db %00100010
db BANK(MienfooPicFront)