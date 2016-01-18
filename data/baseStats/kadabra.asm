KadabraBaseStats: ; 38ac2 (e:4ac2)
db DEX_KADABRA ; pokedex id
db 40 ; base hp
db 35 ; base attack
db 30 ; base defense
db 105 ; base speed
db 120 ; base special
db PSYCHIC ; species type 1
db PSYCHIC ; species type 2
db 100 ; catch rate
db 145 ; base exp yield
IF GEN_2_SPRITES
INCBIN "pic/gsmon/kadabra.pic",0,1
ELSE
INCBIN "pic/bmon/kadabra.pic",0,1
ENDC
dw KadabraPicFront
dw KadabraPicBack
; attacks known at lvl 0
db TELEPORT
db CONFUSION
db DISABLE
db 0
db 3 ; growth rate
; learnset
db %10110001
db %00000011
db %01000111
db %11111000
db %10000101
db %00111000
db %01000011
db BANK(KadabraPicFront)
