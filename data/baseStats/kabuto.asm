KabutoBaseStats: ; 39312 (e:5312)
db DEX_KABUTO ; pokedex id
db 30 ; base hp
db 80 ; base attack
db 90 ; base defense
db 55 ; base speed
db 45 ; base special
db ROCK ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 119 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/kabuto.pic",0,1
ELSE
INCBIN "pic/bmon/kabuto.pic",0,1
ENDC
dw KabutoPicFront
dw KabutoPicBack
; attacks known at lvl 0
db SCRATCH
db HARDEN
db AQUA_JET
db 0
db 0 ; growth rate
; learnset
db %10100000
db %00110111
db %00000000
db %11000000
db %00000001
db %00001000
db %00010010
db BANK(KabutoPicFront)
