ClefairyBaseStats: ; 38796 (e:4796)
db DEX_CLEFAIRY ; pokedex id
db 70 ; base hp
db 45 ; base attack
db 48 ; base defense
db 35 ; base speed
db 60 ; base special
db FAIRY ; species type 1
db FAIRY ; species type 2
db 150 ; catch rate
db 68 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/clefairy.pic",0,1
ELSE
INCBIN "pic/bmon/clefairy.pic",0,1
ENDC
dw ClefairyPicFront
dw ClefairyPicBack
; attacks known at lvl 0
db POUND
db GROWL
db 0
db 0
db 4 ; growth rate
; learnset
db %10110001
db %00110111
db %11100111
db %11110001
db %10100101
db %00111000
db %01100011
db BANK(ClefairyPicFront)
