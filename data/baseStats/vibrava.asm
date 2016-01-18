VibravaBaseStats: ; 38432 (e:4432)
db DEX_VIBRAVA; pokedex id
db 50 ; base hp
db 70 ; base attack
db 50 ; base defense
db 70 ; base speed
db 50 ; base special
db GROUND ; species type 1
db DRAGON ; species type 2
db 120 ; catch rate
db 126 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/vibrava.pic",0,1 ; 77, sprite dimensions
ELSE
INCBIN "pic/bmon/vibrava.pic",0,1 ; 77, sprite dimensions
ENDC
dw VibravaPicFront
dw VibravaPicBack
; attacks known at lvl 0
db BITE
db SONICBOOM
db 0
db 0
db 3 ; growth rate
; learnset
db %10101010
db %01001011
db %00100000
db %11001110
db %10000010
db %10001000
db %00101010
db BANK(VibravaPicFront)