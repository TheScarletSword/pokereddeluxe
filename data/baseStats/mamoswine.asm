MamoswineBaseStats: ; 38432 (e:4432)
db DEX_MAMOSWINE; pokedex id
db 110 ; base hp
db 130 ; base attack
db 80 ; base defense
db 80 ; base speed
db 70 ; base special
db ICE ; species type 1
db GROUND ; species type 2
db 50 ; catch rate
db 207 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/mamoswine.pic",0,1
ELSE
INCBIN "pic/bmon/mamoswine.pic",0,1
ENDC
dw MamoswinePicFront
dw MamoswinePicBack
; attacks known at lvl 0
db TACKLE
db HORN_ATTACK
db PECK
db 0
db 5 ; growth rate
; learnset
db %10100000
db %01110011
db %00000000
db %11001110
db %10000000
db %10001000
db %00100010
db BANK(MamoswinePicFront)