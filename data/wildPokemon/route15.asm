Route15Mons:
	db $0F
	IF DEF(_RED)
		db 24,ODDISH
		db 26,HAPPINY
		db 23,PIDGEY
		db 26,VENONAT
		db 22,ODDISH
		db 28,SKORUPI
		db 26,SKORUPI
		db 30,GLOOM
		db 28,PIDGEOTTO
		db 30,CROAGUNK
	ENDC

	IF DEF(_BLUE)
		db 24,BELLSPROUT
		db 26,HAPPINY
		db 23,PIDGEY
		db 26,VENONAT
		db 22,BELLSPROUT
		db 28,CROAGUNK
		db 26,CROAGUNK
		db 30,WEEPINBELL
		db 28,PIDGEOTTO
		db 30,SKORUPI
	ENDC

	db $00
