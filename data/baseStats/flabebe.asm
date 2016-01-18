FlabebeBaseStats: ; 38432 (e:4432)
db DEX_FLABEBE; pokedex id
db 44 ; base hp
db 38 ; base attack
db 39 ; base defense
db 42 ; base speed
db 61 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 225 ; catch rate
db 61 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/flabebe.pic",0,1
ELSE
INCBIN "pic/bmon/flabebe.pic",0,1
ENDC
dw FlabebePicFront
dw FlabebePicBack
; attacks known at lvl 0
db TACKLE
db VINE_WHIP
db 0
db 0
db 0 ; growth rate
; learnset
db %00100000
db %00000011
db %00110000
db %11110000
db %01000001
db %00101000
db %01000010
db BANK(FlabebePicFront)