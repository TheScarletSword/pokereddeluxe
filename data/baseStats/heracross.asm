HeracrossBaseStats: ; 38432 (e:4432)
db DEX_HERACROSS ; pokedex id
db 80 ; base hp
db 125 ; base attack
db 75 ; base defense
db 85 ; base speed
db 40 ; base special
db BUG ; species type 1
db FIGHTING ; species type 2
db 45 ; catch rate
db 200 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/heracross.pic",0,1
ELSE
INCBIN "pic/bmon/heracross.pic",0,1
ENDC
dw HeracrossPicFront
dw HeracrossPicBack
; attacks known at lvl 0
db TACKLE
db LEER
db 0
db 0
db 5 ; growth rate
; learnset
db %11110101
db %01000011
db %00000111
db %11000010
db %10010000
db %00001000
db %00100110
db BANK(HeracrossPicFront)
