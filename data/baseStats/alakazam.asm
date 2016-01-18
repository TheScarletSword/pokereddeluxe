AlakazamBaseStats: ; 38ade (e:4ade)
db DEX_ALAKAZAM ; pokedex id
db 55 ; base hp
db 50 ; base attack
db 45 ; base defense
db 120 ; base speed
db 135 ; base special
db PSYCHIC ; species type 1
db PSYCHIC ; species type 2
db 50 ; catch rate
db 186 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/alakazam.pic",0,1
ELSE
INCBIN "pic/bmon/alakazam.pic",0,1
ENDC
dw AlakazamPicFront
dw AlakazamPicBack
; attacks known at lvl 0
db TELEPORT
db CONFUSION
db DISABLE
db 0
db 3 ; growth rate
; learnset
db %10110001
db %01000011
db %01000111
db %11111000
db %10000101
db %00111000
db %01000011
db BANK(AlakazamPicFront)
