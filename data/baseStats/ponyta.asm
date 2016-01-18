PonytaBaseStats: ; 38c2e (e:4c2e)
db DEX_PONYTA ; pokedex id
db 50 ; base hp
db 85 ; base attack
db 55 ; base defense
db 90 ; base speed
db 65 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 190 ; catch rate
db 152 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/ponyta.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/ponyta.pic",0,1 ; 66, sprite dimensions
ENDC
dw PonytaPicFront
dw PonytaPicBack
; attacks known at lvl 0
db EMBER
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %11100000
db %00001011
db %00000000
db %11000000
db %11100001
db %00001000
db %00000010
db BANK(PonytaPicFront)
