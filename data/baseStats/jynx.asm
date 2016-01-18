JynxBaseStats: ; 39152 (e:5152)
db DEX_JYNX ; pokedex id
db 65 ; base hp
db 50 ; base attack
db 35 ; base defense
db 95 ; base speed
db 95 ; base special
db ICE ; species type 1
db PSYCHIC ; species type 2
db 45 ; catch rate
db 137 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/jynx.pic",0,1
ELSE
INCBIN "pic/bmon/jynx.pic",0,1
ENDC
dw JynxPicFront
dw JynxPicBack
; attacks known at lvl 0
db POUND
db LOVELY_KISS
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01110111
db %01000111
db %11010000
db %10000101
db %00101000
db %00000010
db BANK(JynxPicFront)
