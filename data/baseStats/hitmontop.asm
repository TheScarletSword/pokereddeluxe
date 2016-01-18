HitmontopBaseStats: ; 38f76 (e:4f76)
db DEX_HITMONTOP ; pokedex id
db 50 ; base hp
db 95 ; base attack
db 95 ; base defense
db 70 ; base speed
db 35 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 138 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/hitmontop.pic",0,1
ELSE
INCBIN "pic/bmon/hitmontop.pic",0,1
ENDC
dw HitmontopPicFront
dw HitmontopPicBack
; attacks known at lvl 0
db ROLLING_KICK
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %00000111
db %11001000
db %11000100
db %00001000
db %00100010
db BANK(HitmontopPicFront)
