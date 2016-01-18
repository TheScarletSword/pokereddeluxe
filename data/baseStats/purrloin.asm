PurrloinBaseStats: ; 38432 (e:4432)
db DEX_PURRLOIN; pokedex id
db 41 ; base hp
db 50 ; base attack
db 37 ; base defense
db 66 ; base speed
db 50 ; base special
db DARK ; species type 1
db DARK ; species type 2
db 255 ; catch rate
db 56 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/purrloin.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/purrloin.pic",0,1 ; 66, sprite dimensions
ENDC
dw PurrloinPicFront
dw PurrloinPicBack
; attacks known at lvl 0
db SCRATCH
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10100000
db %10000011
db %00000000
db %11000000
db %11000000
db %00011001
db %00000110
db BANK(PurrloinPicFront)