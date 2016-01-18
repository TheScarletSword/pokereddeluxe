PsyduckBaseStats: ; 389aa (e:49aa)
db DEX_PSYDUCK ; pokedex id
db 50 ; base hp
db 52 ; base attack
db 48 ; base defense
db 55 ; base speed
db 50 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 190 ; catch rate
db 80 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/psyduck.pic",0,1 ; 55, sprite dimensions
ELSE
INCBIN "pic/bmon/psyduck.pic",0,1 ; 55, sprite dimensions
ENDC
dw PsyduckPicFront
dw PsyduckPicBack
; attacks known at lvl 0
db SCRATCH
db 0
db 0
db 0
db 0 ; growth rate
; learnset
db %10110001
db %10110111
db %00000111
db %11001000
db %11000000
db %00001000
db %00110010
db BANK(PsyduckPicFront)
