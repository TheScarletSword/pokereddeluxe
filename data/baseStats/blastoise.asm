BlastoiseBaseStats: ; 384be (e:44be)
db DEX_BLASTOISE ; pokedex id
db 79 ; base hp
db 83 ; base attack
db 100 ; base defense
db 78 ; base speed
db 85 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 210 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/blastoise.pic",0,1
ELSE
INCBIN "pic/bmon/blastoise.pic",0,1
ENDC
dw BlastoisePicFront
dw BlastoisePicBack
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db BUBBLE
db WATER_GUN
db 3 ; growth rate
; learnset
db %10110001
db %01110111
db %00000111
db %11001110
db %10000001
db %00001001
db %00110010
db BANK(BlastoisePicFront)
