SigilyphBaseStats: ; 38432 (e:4432)
db DEX_SIGILYPH; pokedex id
db 72 ; base hp
db 58 ; base attack
db 80 ; base defense
db 97 ; base speed
db 103 ; base special
db PSYCHIC ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 172 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/sigilyph.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/sigilyph.pic",0,1 ; 77, sprite dimensions
ENDC
dw SigilyphPicFront
dw SigilyphPicBack
; attacks known at lvl 0
db GUST
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %00101010
db %01011011
db %00100000
db %11110000
db %11000011
db %00111111
db %01001011
db BANK(SigilyphPicFront)
