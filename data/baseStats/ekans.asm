EkansBaseStats: ; 38646 (e:4646)
db DEX_EKANS ; pokedex id
db 35 ; base hp
db 60 ; base attack
db 44 ; base defense
db 55 ; base speed
db 40 ; base special
db POISON ; species type 1
db POISON ; species type 2
db 255 ; catch rate
db 62 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/ekans.pic",0,1
ELSE
INCBIN "pic/bmon/ekans.pic",0,1
ENDC
dw EkansPicFront
dw EkansPicBack
; attacks known at lvl 0
db WRAP
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00000011
db %00011000
db %11001110
db %10000000
db %10001001
db %00100010
db BANK(EkansPicFront)
