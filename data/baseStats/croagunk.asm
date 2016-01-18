CroagunkBaseStats: ; 38432 (e:4432)
db DEX_CROAGUNK; pokedex id
db 48 ; base hp
db 61 ; base attack
db 40 ; base defense
db 50 ; base speed
db 40 ; base special
db POISON ; species type 1
db FIGHTING ; species type 2
db 140 ; catch rate
db 83 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/croagunk.pic",0,1
ELSE
INCBIN "pic/bmon/croagunk.pic",0,1
ENDC
dw CroagunkPicFront
dw CroagunkPicBack
; attacks known at lvl 0
db POISON_STING
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %01001111
db %11001110
db %10010000
db %00001001
db %00100010
db BANK(CroagunkPicFront)