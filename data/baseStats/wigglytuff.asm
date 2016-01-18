WigglytuffBaseStats: ; 38822 (e:4822)
db DEX_WIGGLYTUFF ; pokedex id
db 140 ; base hp
db 70 ; base attack
db 45 ; base defense
db 45 ; base speed
db 85 ; base special
db NORMAL ; species type 1
db FAIRY ; species type 2
db 50 ; catch rate
db 109 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/wigglytuff.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/wigglytuff.pic",0,1 ; 66, sprite dimensions
ENDC
dw WigglytuffPicFront
dw WigglytuffPicBack
; attacks known at lvl 0
db SING
db DISABLE
db DEFENSE_CURL
db DOUBLESLAP
db 4 ; growth rate
; learnset
db %10110001
db %01110111
db %11100111
db %11110001
db %10100001
db %00111000
db %01100011
db BANK(WigglytuffPicFront)
