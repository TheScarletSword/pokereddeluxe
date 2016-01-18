TyrantrumBaseStats: ; 38432 (e:4432)
db DEX_TYRANTRUM; pokedex id
db 82 ; base hp
db 121 ; base attack
db 119 ; base defense
db 71 ; base speed
db 69 ; base special
db ROCK ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 182 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/tyrantrum.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/tyrantrum.pic",0,1 ; 77, sprite dimensions
ENDC
dw TyrantrumPicFront
dw TyrantrumPicBack
; attacks known at lvl 0
db TAIL_WHIP
db TACKLE
db 0
db 0
db 0 ; growth rate
; learnset
db %11100000
db %01000011
db %00000000
db %11001110
db %10000000
db %10001001
db %00100010
db BANK(TyrantrumPicFront)