VileplumeBaseStats: ; 388ae (e:48ae)
db DEX_VILEPLUME ; pokedex id
db 75 ; base hp
db 80 ; base attack
db 85 ; base defense
db 50 ; base speed
db 100 ; base special
db GRASS ; species type 1
db POISON ; species type 2
db 45 ; catch rate
db 184 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/vileplume.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/vileplume.pic",0,1 ; 77, sprite dimensions
ENDC
dw VileplumePicFront
dw VileplumePicBack
; attacks known at lvl 0
db STUN_SPORE
db SLEEP_POWDER
db ACID
db PETAL_DANCE
db 3 ; growth rate
; learnset
db %10100100
db %01000011
db %01110000
db %11100000
db %00000001
db %00001000
db %00000110
db BANK(VileplumePicFront)
