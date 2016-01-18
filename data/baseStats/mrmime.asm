MrMimeBaseStats: ; 3911a (e:511a)
db DEX_MR_MIME ; pokedex id
db 40 ; base hp
db 45 ; base attack
db 65 ; base defense
db 90 ; base speed
db 100 ; base special
db PSYCHIC ; species type 1
db FAIRY ; species type 2
db 45 ; catch rate
db 136 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mr.mime.pic",0,1 ; 66, sprite dimensions
ELSE
INCBIN "pic/bmon/mr.mime.pic",0,1 ; 66, sprite dimensions
ENDC
dw MrMimePicFront
dw MrMimePicBack
; attacks known at lvl 0
db CONFUSION
db BARRIER
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %01000011
db %11100111
db %11110001
db %10000101
db %00111000
db %01000010
db BANK(MrMimePicFront)
