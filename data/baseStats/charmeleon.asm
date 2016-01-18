CharmeleonBaseStats: ; 3844e (e:444e)
db DEX_CHARMELEON ; pokedex id
db 58 ; base hp
db 64 ; base attack
db 58 ; base defense
db 80 ; base speed
db 65 ; base special
db FIRE ; species type 1
db FIRE ; species type 2
db 45 ; catch rate
db 142 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/charmeleon.pic",0,1
ELSE
INCBIN "pic/bmon/charmeleon.pic",0,1
ENDC
dw CharmeleonPicFront
dw CharmeleonPicBack
; attacks known at lvl 0
db SCRATCH
db GROWL
db EMBER
db 0
db 3 ; growth rate
; learnset
db %10110101
db %00001011
db %00000111
db %11001000
db %11100001
db %00001000
db %00100110
db BANK(CharmeleonPicFront)
