SmoochumBaseStats: ; 39152 (e:5152)
db DEX_SMOOCHUM ; pokedex id
db 45 ; base hp
db 30 ; base attack
db 15 ; base defense
db 65 ; base speed
db 65 ; base special
db ICE ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 87 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/smoochum.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/smoochum.pic",0,1 ; 55, sprite dimensions
ENDC
dw SmoochumPicFront
dw SmoochumPicBack
; attacks known at lvl 0
db POUND
db LICK
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00110111
db %00000111
db %11010000
db %10000101
db %00101000
db %00000010
db BANK(SmoochumPicFront)
