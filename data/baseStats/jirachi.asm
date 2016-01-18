JirachiBaseStats: ; 38432 (e:4432)
db DEX_JIRACHI; pokedex id
db 100 ; base hp
db 100 ; base attack
db 100 ; base defense
db 100 ; base speed
db 100 ; base special
db STEEL ; species type 1
db PSYCHIC ; species type 2
db 3 ; catch rate
db 215 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/jirachi.pic",0,1
ELSE
INCBIN "pic/bmon/jirachi.pic",0,1
ENDC
dw JirachiPicFront
dw JirachiPicBack
; attacks known at lvl 0
db CONFUSION
db 0
db 0
db 0
db 5 ; growth rate
; learnset
db %10100000
db %01000111
db %11000000
db %11110001
db %01000101
db %00111000
db %01000011
db BANK(JirachiPicFront)