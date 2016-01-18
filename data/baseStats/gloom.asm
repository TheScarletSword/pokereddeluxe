GloomBaseStats: ; 38892 (e:4892)
db DEX_GLOOM ; pokedex id
db 60 ; base hp
db 65 ; base attack
db 70 ; base defense
db 40 ; base speed
db 85 ; base special
db GRASS ; species type 1
db POISON ; species type 2
db 120 ; catch rate
db 132 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/gloom.pic",0,1
ELSE
INCBIN "pic/bmon/gloom.pic",0,1
ENDC
dw GloomPicFront
dw GloomPicBack
; attacks known at lvl 0
db ABSORB
db POISONPOWDER
db STUN_SPORE
db 0
db 3 ; growth rate
; learnset
db %00100100
db %00000011
db %01110000
db %11100000
db %00000001
db %00001000
db %00000110
db BANK(GloomPicFront)
