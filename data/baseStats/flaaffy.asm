FlaaffyBaseStats: ; 38432 (e:4432)
db DEX_FLAAFFY; pokedex id
db 70 ; base hp
db 55 ; base attack
db 55 ; base defense
db 45 ; base speed
db 80 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 120 ; catch rate
db 117 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/flaaffy.pic",0,1
ELSE
INCBIN "pic/bmon/flaaffy.pic",0,1
ENDC
dw FlaaffyPicFront
dw FlaaffyPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db 0
db 0
db 5 ; growth rate
; learnset
db %10110001
db %00000011
db %10000000
db %11000001
db %11000001
db %00011000
db %01100010
db BANK(FlaaffyPicFront)