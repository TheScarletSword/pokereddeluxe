DrowzeeBaseStats: ; 38e42 (e:4e42)
db DEX_DROWZEE ; pokedex id
db 60 ; base hp
db 48 ; base attack
db 45 ; base defense
db 42 ; base speed
db 90 ; base special
db PSYCHIC ; species type 1
db PSYCHIC ; species type 2
db 190 ; catch rate
db 102 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/drowzee.pic",0,1
ELSE
INCBIN "pic/bmon/drowzee.pic",0,1
ENDC
dw DrowzeePicFront
dw DrowzeePicBack
; attacks known at lvl 0
db POUND
db HYPNOSIS
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %01000111
db %11110000
db %10000101
db %00111010
db %01000011
db BANK(DrowzeePicFront)
