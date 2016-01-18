MoonMonsB1:
	db $0A
	IF DEF(_RED)
		db 8,PARAS
		db 7,PARAS
		db 7,PARAS
		db 8,PARAS
		db 9,PARAS
		db 10,PARAS
		db 10,PARAS
		db 11,PARAS
		db 9,PARAS
		db 9,PARAS
	ENDC
	IF DEF(_BLUE)
		db 8,ZUBAT
		db 7,ZUBAT
		db 7,ZUBAT
		db 8,ZUBAT
		db 9,ZUBAT
		db 10,ZUBAT
		db 10,ZUBAT
		db 11,ZUBAT
		db 9,ZUBAT
		db 9,PARAS
	ENDC
	db $00

