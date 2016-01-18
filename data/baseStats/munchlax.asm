MunchlaxBaseStats: ; 39366 (e:5366)
db DEX_MUNCHLAX ; pokedex id
db 135 ; base hp
db 85 ; base attack
db 40 ; base defense
db 5 ; base speed
db 40 ; base special
db NORMAL ; species type 1
db NORMAL ; species type 2
db 50 ; catch rate
db 94 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/munchlax.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/munchlax.pic",0,1 ; 77, sprite dimensions
ENDC
dw MunchlaxPicFront
dw MunchlaxPicBack
; attacks known at lvl 0
db LICK
db METRONOME
db TACKLE
db 0
db 5 ; growth rate
; learnset
db %10110001
db %10010111
db %10100111
db %11010010
db %10101101
db %10101000
db %00110010
db BANK(MunchlaxPicFront)
