LaprasBaseStats: ; 39216 (e:5216)
db DEX_LAPRAS ; pokedex id
db 130 ; base hp
db 85 ; base attack
db 80 ; base defense
db 60 ; base speed
db 95 ; base special
db WATER ; species type 1
db ICE ; species type 2
db 45 ; catch rate
db 219 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/lapras.pic",0,1
ELSE
INCBIN "pic/bmon/lapras.pic",0,1
ENDC
dw LaprasPicFront
dw LaprasPicBack
; attacks known at lvl 0
db WATER_GUN
db GROWL
db ICE_SHARD
db 0
db 5 ; growth rate
; learnset
db %11100000
db %01110111
db %10100000
db %11010001
db %10000001
db %00101000
db %00110010
db BANK(LaprasPicFront)
