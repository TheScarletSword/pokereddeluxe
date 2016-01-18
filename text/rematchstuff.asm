; unchanged from TPP anniversary original
RematchPrompt::
	text "Rematch this"
	line "trainer?"
	done

_EndRematchBattle_Brock::
	text "I took"
	line "you for granted."
	prompt
	
_EndRematchBattle_Misty::
	text "Wow!"
	line "You're too much!"
	prompt
	
_EndRematchBattle_LtSurge::
	text "Whoa!"
	para "You're the real"
	line "deal, kid!"
	prompt
	
_EndRematchBattle_Erika::
	text "Oh!"
	line "I concede defeat."

	para "You are remarkably"
	line "strong."
	prompt
	
_EndRematchBattle_Sabrina::
	text "I'm"
	line "shocked!"
	cont "But, a loss is a"
	cont "loss."
	para "I admit I didn't"
	line "work hard enough"
	cont "to win!"
	prompt

_EndRematchBattle_Blaine::
	text "I have"
	line "burnt out!"
	prompt

_EndRematchBattle_LeaguePC::
	text ""
	prompt
	
_LeaguePCBeforeText::
	text "WELCOME TO GYM"
	line "NO. 8."
	
	para "I AM A COMPUTER"
	line "INSTALLED BY"
	cont "BLAINE TO ALLOW"
	cont "TRAINERS TO STILL"
	cont "GET THEIR 8TH"
	cont "BADGES WHILE"
	cont "THE LEAGUE LOOKS"
	cont "FOR A NEW GYM"
	cont "LEADER."
	
	para "MY SIMULATED TEAM"
	line "CONSISTS OF AN"
	cont "OPTIMAL VERSION"
	cont "OF THE PREVIOUS"
	cont "LEADER'S TEAM."
	
	para "IT SEEMS YOU WOULD"
	line "LIKE A REMATCH."
	
	para "SHALL I INITIATE"
	line "BATTLE.EXE?"
	done
	
_LeaguePCYesText::
	text "BATTLE.EXE -D"
	line "GYM8LEADER.DAT"
	done
	
_LeaguePCNoText::
	text "CANCEL.EXE"
	done
	
_LeaguePCAfterText::
	text "THAT WAS AN"
	line "OPTIMAL BATTLE"
	cont "INDEED."
	
	para "THIS UNIT MUST"
	line "GO INTO SLEEP"
	cont "MODE."
	
	para "I WISH YOU"
	line "PROSPERITY IN"
	cont "COMPLETING YOUR"
	cont "END GOAL."
	
	para "LOGOFF.EXE"
	done

_OakPreBattleText::
	text $52, ", I've"
	line "watched you from"
	cont "the beginning of"
	cont "your journey."
	
	para "And I must say,"
	line "it is truly"
	cont "astonishing how"
	cont "you've managed to"
	cont "discover and tame"
	cont "every single"
	cont "#MON!"
	
	para "Now that you are a"
	line "#MON MASTER,"
	cont "you must prove to"
	cont "me that you are"
	cont "deserving of"
	cont "that title."
	
	para "Please, ", $52, ","
	line "do not hold back"
	cont "on this one."
	
	para "Let us begin!"
	done
	
_OakVictorySpeech::
	text "Wow, I'm"
	line "speechless!"
	
	para "I guess you're as"
	line "good as they say"
	cont "you are!"
	prompt

_HallofFameRoomText1_tehurn::
	text "Congratulations,"
	line $52, ", you and"
	cont "your #MON are"
	cont "#MON MASTERs!"
	done