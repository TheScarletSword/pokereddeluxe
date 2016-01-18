ButterfreeBaseStats: ; 38512 (e:4512)
db DEX_BUTTERFREE ; pokedex id
db 60 ; base hp
db 45 ; base attack
db 50 ; base defense
db 70 ; base speed
db 90 ; base special
db BUG ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 160 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/butterfree.pic",0,1
ELSE
INCBIN "pic/bmon/butterfree.pic",0,1
ENDC
dw ButterfreePicFront
dw ButterfreePicBack
; attacks known at lvl 0
db CONFUSION
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %00100010
db %01000011
db %00110000
db %11010000
db %01000011
db %00101000
db %01000010
db BANK(ButterfreePicFront)
