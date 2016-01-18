KabutopsBaseStats: ; 3932e (e:532e)
db DEX_KABUTOPS ; pokedex id
db 60 ; base hp
db 115 ; base attack
db 105 ; base defense
db 80 ; base speed
db 70 ; base special
db ROCK ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 201 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/kabutops.pic",0,1
ELSE
INCBIN "pic/bmon/kabutops.pic",0,1
ENDC
dw KabutopsPicFront
dw KabutopsPicBack
; attacks known at lvl 0
db SCRATCH
db HARDEN
db AQUA_JET
db ABSORB
db 0 ; growth rate
; learnset
db %10110110
db %01110111
db %00000101
db %11000000
db %10010001
db %00001000
db %00010010
db BANK(KabutopsPicFront)
