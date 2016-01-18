ClefableBaseStats: ; 387b2 (e:47b2)
db DEX_CLEFABLE ; pokedex id
db 95 ; base hp
db 70 ; base attack
db 73 ; base defense
db 60 ; base speed
db 95 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 25 ; catch rate
db 129 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/clefable.pic",0,1
ELSE
INCBIN "pic/bmon/clefable.pic",0,1
ENDC
dw ClefablePicFront
dw ClefablePicBack
; attacks known at lvl 0
db SING
db DOUBLESLAP
db MINIMIZE
db METRONOME
db 4 ; growth rate
; learnset
db %10110001
db %01110111
db %11100111
db %11110001
db %10100101
db %00111000
db %01100011
db BANK(ClefablePicFront)
