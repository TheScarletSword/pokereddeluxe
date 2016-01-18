HitmonleeBaseStats: ; 38f5a (e:4f5a)
db DEX_HITMONLEE ; pokedex id
db 50 ; base hp
db 120 ; base attack
db 53 ; base defense
db 87 ; base speed
db 35 ; base special
db FIGHTING ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 139 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/hitmonlee.pic",0,1
ELSE
INCBIN "pic/bmon/hitmonlee.pic",0,1
ENDC
dw HitmonleePicFront
dw HitmonleePicBack
; attacks known at lvl 0
db DOUBLE_KICK
db MEDITATE
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %00001111
db %11000000
db %11000100
db %00001000
db %00100010
db BANK(HitmonleePicFront)
