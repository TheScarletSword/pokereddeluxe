CharizardBaseStats: ; 3846a (e:446a)
db DEX_CHARIZARD ; pokedex id
db 78 ; base hp
db 84 ; base attack
db 78 ; base defense
db 100 ; base speed
db 85 ; base special
db FIRE ; species type 1
db FLYING ; species type 2
db 45 ; catch rate
db 209 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/charizard.pic",0,1
ELSE
INCBIN "pic/bmon/charizard.pic",0,1
ENDC
dw CharizardPicFront
dw CharizardPicBack
; attacks known at lvl 0
db SCRATCH
db GROWL
db EMBER
db LEER
db 3 ; growth rate
; learnset
db %10111101
db %01001011
db %00000111
db %11001110
db %11100011
db %00001000
db %00101110
db BANK(CharizardPicFront)
