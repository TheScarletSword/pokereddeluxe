ArcanineBaseStats: ; 38a36 (e:4a36)
db DEX_ARCANINE ; pokedex id
db 90 ; base hp
db 110 ; base attack
db 80 ; base defense
db 95 ; base speed
db 80 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 75 ; catch rate
db 213 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/arcanine.pic",0,1
ELSE
INCBIN "pic/bmon/arcanine.pic",0,1
ENDC
dw ArcaninePicFront
dw ArcaninePicBack
; attacks known at lvl 0
db ROAR
db EMBER
db LEER
db TAKE_DOWN
db 5 ; growth rate
; learnset
db %10100000
db %01001011
db %00000000
db %11001000
db %11100001
db %00001000
db %00000010
db BANK(ArcaninePicFront)
