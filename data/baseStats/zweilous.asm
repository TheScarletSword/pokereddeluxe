ZweilousBaseStats: ; 38432 (e:4432)
db DEX_ZWEILOUS ; pokedex id
db 72 ; base hp
db 85 ; base attack
db 70 ; base defense
db 58 ; base speed
db 65 ; base special
db DARK ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 147 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/zweilous.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/zweilous.pic",0,1 ; 77, sprite dimensions
ENDC
dw ZweilousPicFront
dw ZweilousPicBack
; attacks known at lvl 0
db TACKLE
db DRAGON_RAGE
db 0
db 0
db 5 ; growth rate
; learnset
db %10100000
db %00000111
db %00000000
db %11000000
db %10000001
db %00001001
db %00100010
db BANK(ZweilousPicFront)