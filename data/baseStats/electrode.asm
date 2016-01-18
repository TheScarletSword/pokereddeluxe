ElectrodeBaseStats: ; 38ece (e:4ece)
db DEX_ELECTRODE ; pokedex id
db 60 ; base hp
db 50 ; base attack
db 70 ; base defense
db 140 ; base speed
db 80 ; base special
db ELECTRIC ; species type 1
db ELECTRIC ; species type 2
db 60 ; catch rate
db 150 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/electrode.pic",0,1
ELSE
INCBIN "pic/bmon/electrode.pic",0,1
ENDC
dw ElectrodePicFront
dw ElectrodePicBack
; attacks known at lvl 0
db TACKLE
db SCREECH
db SONICBOOM
db 0
db 0 ; growth rate
; learnset
db %00100000
db %01000001
db %10000000
db %11000001
db %11001001
db %01011000
db %01000010
db BANK(ElectrodePicFront)
