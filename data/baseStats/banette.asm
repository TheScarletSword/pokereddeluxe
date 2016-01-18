BanetteBaseStats: ; 38432 (e:4432)
db DEX_BANETTE; pokedex id
db 64 ; base hp
db 115 ; base attack
db 65 ; base defense
db 65 ; base speed
db 83 ; base special
db GHOST ; species type 1
db GHOST ; species type 2
db 45 ; catch rate
db 179 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/banette.pic",0,1
ELSE
INCBIN "pic/bmon/banette.pic",0,1
ENDC
dw BanettePicFront
dw BanettePicBack
; attacks known at lvl 0
db NIGHT_SHADE
db 0
db 0
db 0
db 4 ; growth rate
; learnset
db %00100000
db %01000000
db %10000000
db %11110001
db %00000110
db %00111011
db %01000010
db BANK(BanettePicFront)