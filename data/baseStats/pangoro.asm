PangoroBaseStats: ; 38432 (e:4432)
db DEX_PANGORO ; pokedex id
db 95 ; base hp
db 124 ; base attack
db 78 ; base defense
db 58 ; base speed
db 69 ; base special
db FIGHTING ; species type 1
db DARK ; species type 2
db 65 ; catch rate
db 173 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/pangoro.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/pangoro.pic",0,1 ; 77, sprite dimensions
ENDC
dw PangoroPicFront
dw PangoroPicBack
; attacks known at lvl 0
db TACKLE
db LEER
db 0
db 0
db 0 ; growth rate
; learnset
db %10110101
db %01000011
db %01001111
db %11001110
db %11010101
db %10001001
db %00110110
db BANK(PangoroPicFront)
