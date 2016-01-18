AmpharosBaseStats: ; 38432 (e:4432)
db DEX_AMPHAROS; pokedex id
db 90 ; base hp
db 75 ; base attack
db 85 ; base defense
db 55 ; base speed
db 115 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 45 ; catch rate
db 194 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/ampharos.pic",0,1
ELSE
INCBIN "pic/bmon/ampharos.pic",0,1
ENDC
dw AmpharosPicFront
dw AmpharosPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db 0
db 0
db 5 ; growth rate
; learnset
db %10110001
db %01000011
db %10000111
db %11000001
db %11000001
db %00011000
db %01100010
db BANK(AmpharosPicFront)