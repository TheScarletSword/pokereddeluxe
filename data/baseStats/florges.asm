FlorgesBaseStats: ; 38432 (e:4432)
db DEX_FLORGES; pokedex id
db 78 ; base hp
db 65 ; base attack
db 68 ; base defense
db 75 ; base speed
db 112 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/florges.pic",0,1
ELSE
INCBIN "pic/bmon/florges.pic",0,1
ENDC
dw FlorgesPicFront
dw FlorgesPicBack
; attacks known at lvl 0
db SWIFT
db PETAL_DANCE
db MOONBLAST
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01000011
db %00110000
db %11110000
db %01000101
db %00101000
db %01000010
db BANK(FlorgesPicFront)