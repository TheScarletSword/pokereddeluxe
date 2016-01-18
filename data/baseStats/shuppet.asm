ShuppetBaseStats: ; 38432 (e:4432)
db DEX_SHUPPET; pokedex id
db 44 ; base hp
db 75 ; base attack
db 35 ; base defense
db 45 ; base speed
db 63 ; base special
db GHOST ; species type 1
db GHOST ; species type 2
db 225 ; catch rate
db 97 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/shuppet.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/shuppet.pic",0,1 ; 55, sprite dimensions
ENDC
dw ShuppetPicFront
dw ShuppetPicBack
; attacks known at lvl 0
db NIGHT_SHADE
db 0
db 0
db 0
db 4 ; growth rate
; learnset
db %00100000
db %00000000
db %10000000
db %11110001
db %00000010
db %00111011
db %01000010
db BANK(ShuppetPicFront)