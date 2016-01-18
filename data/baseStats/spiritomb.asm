SpiritombBaseStats: ; 38432 (e:4432)
db DEX_SPIRITOMB; pokedex id
db 50 ; base hp
db 92 ; base attack
db 108 ; base defense
db 35 ; base speed
db 92 ; base special
db GHOST ; species type 1
db DARK ; species type 2
db 100 ; catch rate
db 168 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/spiritomb.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/spiritomb.pic",0,1 ; 77, sprite dimensions
ENDC
dw SpiritombPicFront
dw SpiritombPicBack
; attacks known at lvl 0
db CONFUSE_RAY
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01000000
db %00000000
db %11010000
db %00000010
db %00101011
db %01000010
db BANK(SpiritombPicFront)