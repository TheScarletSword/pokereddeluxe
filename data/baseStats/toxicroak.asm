ToxicroakBaseStats: ; 38432 (e:4432)
db DEX_TOXICROAK; pokedex id
db 83 ; base hp
db 106 ; base attack
db 65 ; base defense
db 85 ; base speed
db 65 ; base special
db POISON ; species type 1
db FIGHTING ; species type 2
db 75 ; catch rate
db 181 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/toxicroak.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/toxicroak.pic",0,1 ; 77, sprite dimensions
ENDC
dw ToxicroakPicFront
dw ToxicroakPicBack
; attacks known at lvl 0
db POISON_STING
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01000011
db %01001111
db %11001110
db %10010000
db %00001001
db %00100110
db BANK(ToxicroakPicFront)