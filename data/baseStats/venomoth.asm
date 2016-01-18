VenomothBaseStats: ; 3891e (e:491e)
db DEX_VENOMOTH ; pokedex id
db 70 ; base hp
db 65 ; base attack
db 60 ; base defense
db 90 ; base speed
db 90 ; base special
db BUG ; species type 1
db POISON ; species type 2
db 75 ; catch rate
db 138 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/venomoth.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/venomoth.pic",0,1 ; 77, sprite dimensions
ENDC
dw VenomothPicFront
dw VenomothPicBack
; attacks known at lvl 0
db TACKLE
db DISABLE
db SUPERSONIC
db CONFUSION
db 0 ; growth rate
; learnset
db %00100010
db %01000011
db %00110000
db %11010000
db %01000011
db %00101000
db %00000010
db BANK(VenomothPicFront)
