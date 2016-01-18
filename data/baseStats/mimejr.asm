MimeJrBaseStats: ; 3911a (e:511a)
db DEX_MIME_JR ; pokedex id
db 20 ; base hp
db 25 ; base attack
db 45 ; base defense
db 60 ; base speed
db 70 ; base special
db PSYCHIC ; species type 1
db FAIRY ; species type 2
db 145 ; catch rate
db 78 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mimejr.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/mimejr.pic",0,1 ; 77, sprite dimensions
ENDC
dw MimeJrPicFront
dw MimeJrPicBack
; attacks known at lvl 0
db CONFUSION
db BARRIER
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %00000011
db %10100111
db %11110001
db %10000101
db %00111000
db %01000010
db BANK(MimeJrPicFront)
