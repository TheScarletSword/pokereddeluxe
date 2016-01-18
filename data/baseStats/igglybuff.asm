IgglybuffBaseStats: ; 38806 (e:4806)
db DEX_IGGLYBUFF ; pokedex id
db 90 ; base hp
db 30 ; base attack
db 15 ; base defense
db 15 ; base speed
db 40 ; base special
db NORMAL ; species type 1
db FAIRY ; species type 2
db 170 ; catch rate
db 39 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/igglybuff.pic",0,1
ELSE
INCBIN "pic/bmon/igglybuff.pic",0,1
ENDC
dw IgglybuffPicFront
dw IgglybuffPicBack
; attacks known at lvl 0
db SING
db 0
db 0
db 0
db 4 ; growth rate
; learnset
db %10110001
db %00110111
db %10100111
db %11110001
db %10100001
db %00111000
db %01100011
db BANK(IgglybuffPicFront)
