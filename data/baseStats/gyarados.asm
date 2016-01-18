GyaradosBaseStats: ; 391fa (e:51fa)
db DEX_GYARADOS ; pokedex id
db 95 ; base hp
db 125 ; base attack
db 79 ; base defense
db 81 ; base speed
db 100 ; base special
db WATER ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 214 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/gyarados.pic",0,1
ELSE
INCBIN "pic/bmon/gyarados.pic",0,1
ENDC
dw GyaradosPicFront
dw GyaradosPicBack
; attacks known at lvl 0
IF DEF(_YELLOW)
db TACKLE
db 0
db 0
db 0
ELSE
db BITE
db DRAGON_RAGE
db LEER
db HYDRO_PUMP
ENDC
db 5 ; growth rate
; learnset
db %10100000
db %01110111
db %10000000
db %11000001
db %10100001
db %00001001
db %00110010
db BANK(GyaradosPicFront)
