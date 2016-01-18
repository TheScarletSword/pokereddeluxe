ExeggutorBaseStats: ; 38f06 (e:4f06)
db DEX_EXEGGUTOR ; pokedex id
db 95 ; base hp
db 95 ; base attack
db 85 ; base defense
db 55 ; base speed
db 125 ; base special
db GRASS ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 212 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/exeggutor.pic",0,1
ELSE
INCBIN "pic/bmon/exeggutor.pic",0,1
ENDC
dw ExeggutorPicFront
dw ExeggutorPicBack
; attacks known at lvl 0
db BARRAGE
db HYPNOSIS
db 0
db 0
db 5 ; growth rate
; learnset
db %00100000
db %01000011
db %00110000
db %11010000
db %00001001
db %01101000
db %00100010
db BANK(ExeggutorPicFront)
