; nearly completely untouched from shanty's original text

_BattleFactoryText2::
	text "Hello, ", $52, "!"

	para "Would you like to"
	line "select a team for"
	cont "your upcoming"
	cont "challenge?"
	done

_BattleFactoryReward1::
	text $52, "!"

	para "I have a reward"
	line "to give you for"
	cont "your success in"
	cont "your most recent"
	cont "BATTLE FACTORY"
	cont "session!"
	prompt

_BattleFactoryNoRoom::
	text "You don't have"
	line "room for this!"

	para "You need to make"
	line "room and claim"
	cont "your reward"
	cont "before starting"
	cont "another session."
	done

_BattleFactoryText3::
	text "Alright, let me"
	line "bring up your"
	cont "choices."

	para "..."
	line "..."

	para "Please select 3"
	line "#MON from the"
	cont "list."
	done

_BattleFactoryReward2::
	text $52, " received"
	line "@"
	TX_RAM $cf4b
	text "!@@"

_BattleFactoryText4::
	text "Ok, just talk to"
	line "me again when you"
	cont "are ready."
	done

_MakeRoomInBoxText::
	text "I'm sorry."

	para "You need to make"
	line "room in your PC"
	cont "box, so we can"
	cont "hold your #MON"
	cont "for you during"
	cont "the challenge."

	para "Try switching to"
	line "an empty box at"
	cont "a PC."
	done


_FinishedPickingMonsText::
	text "You're all set!"

	para "Speak with the"
	line "receptionist next"
	cont "to me when you're"
	cont "ready to start"
	cont "your challenge."
	done

_BattleFactoryWinsText::
	text "CURRENT WINNING"
	line "STREAK: @"
	TX_NUM W_CURSTREAK, 1, 3
	text " "
	done

_BattleFactoryBestText::
	text "BEST WINNING"
	line "STREAK: @"
	TX_NUM W_BESTSTREAK, 1, 3
	text " "
	done

_SwapText::
	text "Do you want to"
	line "swap #MON?"
	done

_PickEnemyMonText::
	text "Which #MON"
	line "will you take?"
	done

_PickPlayerMonText::
	text "Which #MON"
	line "will you drop?"
	done

_SwapCompleteText::
	text "Swap completed!"
	prompt

_SwapAreYouSureText::
	text "Are you sure you"
	line "you don't want to"
	cont "swap #MON?"
	done

_SwapAreYouSureText2::
	text "Are you sure you"
	line "want to take a"
	cont "different #MON"
	cont "from your"
	cont "opponent?"
	done

_BeatSevenTrainersText::
	text "Congratulations!"

	para "You won seven"
	line "battles in a row!"

	para "You have been"
	line "promoted to"
	cont "class @"
	TX_NUM W_CURCLASS, 1, 3
	text "!"
	prompt

_AlreadyStartedText::
	text "You already"
	line "selected your"
	cont "#MON team."

	para "Please speak with"
	line "the battle"
	cont "receptionist next"
	cont "to me to begin"
	cont "your challenge."
	done

_NotStartedText::
	text "I am the battle"
	line "receptionist."

	para "To begin your"
	line "challenge, you"
	cont "must first select"
	cont "your team by"
	cont "speaking with the"
	cont "BATTLE FACTORY"
	cont "administrator who"
	cont "is standing next"
	cont "to me!"
	done

_ReadyBattleText::
	text "Are you ready to"
	line "start your next"
	cont "battle challenge,"
	cont $52, "?"
	done

_NotYetText::
	text "No problem."

	para "Just talk to me"
	line "again when you"
	cont "are ready."
	done

_StartNowText::
	text "Your current win"
	line "streak is @"
	TX_NUM W_CURSTREAK, 1, 3
	text "."

	para "I wish you the"
	line "best of luck!"
	done

_BattleLoadingText::
	text "CURRENT WINNING"
	line "STREAK: @"
	TX_NUM W_CURSTREAK, 1, 3
	text "..."

	para "INITIALIZING"
	line "BATTLE..."
	cont "OPPONENT FOUND..."
	cont "BEGIN BATTLE..."
	done

_SpecialStartNowText::
	text "Your current win"
	line "streak is @"
	TX_NUM W_CURSTREAK, 1, 3
	text "."

	para "..."
	line "..."

	para "I just received"
	line "word that one of"
	cont "the BATTLE"
	cont "FACTORY HEADs"
	cont "wishes to take"
	cont "you on in battle!"

	para "Don't be too"
	line "intimidated!"

	para "Good luck,"
	line $52, "!"
	done

_GuideIntro::
	text "I'm the BATTLE"
	line "FACTORY guide!"

	para "Should I explain"
	line "how this place"
	cont "works?"
	done

_GuideText::
	text "Alrighty then!"

	para "The concept of a"
	line "BATTLE FACTORY"
	cont "originated in the"
	cont "HOENN region many"
	cont "years ago."

	para "The general idea"
	line "is fairly simple."

	para "Rather than using"
	line "your own #MON"
	cont "team, you rent a"
	cont "team of three"
	cont "#MON from us!"

	para "With that team"
	line "you fight against"
	cont "other trainers"
	cont "who also rented"
	cont "their teams from"
	cont "us."

	para "When you defeat a"
	line "trainer, you may"
	cont "swap one of their"
	cont "#MON with one"
	cont "of your own."

	para "If you defeat 7"
	line "trainers in a"
	cont "row, you will be"
	cont "promoted to the"
	cont "next class."

	para "You will rent a"
	line "brand new team"
	cont "each time you"
	cont "are promoted, and"
	cont "higher classes"
	cont "contain tougher"
	cont "#MON!"

	para "If you're good"
	line "enough, you might"
	cont "confront some"
	cont "very special"
	cont "opponents, and"
	cont "if you beat them,"
	cont "you'll earn some"
	cont "fabulous items!"

	para "If you ever lose,"
	line "you'll start all"
	cont "over, so don't"
	cont "lose!"

	para "To get started,"
	line "first speak with"
	cont "the administrator"
	cont "to rent your"
	cont "#MON team."

	para "Then, speak with"
	line "the receptionist"
	cont "to schedule all"
	cont "of your battles."

	para "Go get 'em,"
	line "champ!"
	done

_GuideNoText::
	text "Phew!"

	para "Now I don't have"
	line "talk as much!"
	done

_DefText1::
	TX_RAM W_TRAINERNAME
	text ": Oh,"
	line "rats!"
	prompt

_DefText2::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "guess I'm just"
	cont "going to go eat"
	cont "now..."
	prompt

_DefText3::
; i might remove this for the sake of being professional maybe
	TX_RAM W_TRAINERNAME
	text ": I"
	line "should have"
	cont "trained DIGIMON"
	cont "instead."
	prompt

_DefText4::
	TX_RAM W_TRAINERNAME
	text ": No!"
	line "Foiled again!"
	prompt

_DefText5::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "just got lucky"
	cont "with your picks!"
	prompt

_DefText6::
	TX_RAM W_TRAINERNAME
	text ": My"
	line "streak is ruined!"
	prompt

_DefText7::
	TX_RAM W_TRAINERNAME
	text ": Wah"
	line "Wah Wahhhh..."
	prompt

_DefText8::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "don't like you."
	prompt

_DefText9::
	TX_RAM W_TRAINERNAME
	text ": Now"
	line "I have to start"
	cont "over again..."
	prompt

_DefText10::
	TX_RAM W_TRAINERNAME
	text ": And"
	line "now I'm sad. :("
	prompt

_DefText11::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "had something in"
	cont "my eye!"
	prompt

_DefText12::
	TX_RAM W_TRAINERNAME
	text ": Huh?"
	line "I don't want to"
	cont "start over!"
	prompt

_DefText13::
	TX_RAM W_TRAINERNAME
	text ": I'll"
	line "beat you next"
	cont "time!"
	prompt

_DefText14::
	TX_RAM W_TRAINERNAME
	text ": This"
	line "game is so cheap!"
	prompt

_DefText15::
	TX_RAM W_TRAINERNAME
	text ": Ugh."
	line "I guess it's back"
	cont "to the old grind."
	prompt

_DefText16::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "tried so hard,"
	cont "and got so far!"
	prompt

_DefText17::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "just broke my"
	cont "heart!"
	prompt

_DefText18::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "was actually sort"
	cont "of attached to"
	cont "those #MON."
	prompt

_DefText19::
	TX_RAM W_TRAINERNAME
	text ": I'll"
	line "admit that you're"
	cont "better than I am."
	prompt

_DefText20::
	TX_RAM W_TRAINERNAME
	text ": What"
	line "a waste..."
	prompt

_DefText21::
	TX_RAM W_TRAINERNAME
	text ": Just"
	line "leave me alone!"
	prompt

_DefText22::
	TX_RAM W_TRAINERNAME
	text ": This"
	line "always happens to"
	cont "me!"
	prompt

_DefText23::
	TX_RAM W_TRAINERNAME
	text ": I'm"
	line "blown away!"
	prompt

_DefText24::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "must have"
	cont "cheated!"
	prompt

_DefText25::
	TX_RAM W_TRAINERNAME
	text ": Man!"
	line "This is the"
	cont "worst!"
	prompt

_DefText26::
	TX_RAM W_TRAINERNAME
	text ": The"
	line "odds were in your"
	cont "favor."
	prompt

_DefText27::
	TX_RAM W_TRAINERNAME
	text ": No,"
	line "no, noooooo!"
	prompt

_DefText28::
	TX_RAM W_TRAINERNAME
	text ": I'm"
	line "going to go cry"
	cont "in the corner!."
	prompt

_DefText29::
	TX_RAM W_TRAINERNAME
	text ":"
	line "Really? Get out"
	cont "of here!"
	prompt

_DefText30::
	TX_RAM W_TRAINERNAME
	text ": If I"
	line "had a nickel for"
	cont "every time this"
	cont "has happened..."
	prompt

_DefText31::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "burned me..."
	prompt

_DefText32::
	TX_RAM W_TRAINERNAME
	text ": That"
	line "was a clutch"
	cont "performance!"
	prompt

_DefText33::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "beat me!"
	prompt

_DefText34::
	TX_RAM W_TRAINERNAME
	text ": Next"
	line "time, I'll make"
	cont "it further!"
	prompt

_DefText35::
	TX_RAM W_TRAINERNAME
	text ":"
	line "Sometimes, losing"
	cont "is a good thing."
	prompt

_DefText36::
	TX_RAM W_TRAINERNAME
	text ": I'm"
	line "amateur at best."
	prompt

_DefText37::
	TX_RAM W_TRAINERNAME
	text ": How"
	line "are you so good?"
	prompt

_DefText38::
	TX_RAM W_TRAINERNAME
	text ": An"
	line "excellent match,"
	cont "that was!"
	prompt

_DefText39::
	TX_RAM W_TRAINERNAME
	text ":"
	line "Wait, what?"
	prompt

_DefText40::
	TX_RAM W_TRAINERNAME
	text ": Who"
	line "designed this"
	cont "lame system!"
	prompt

_DefText41::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "don't enjoy"
	cont "losing!"
	prompt

_DefText42::
	TX_RAM W_TRAINERNAME
	text ": Can"
	line "you teach me"
	cont "your ways?"
	prompt

_DefText43::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "see what you"
	cont "did there!"
	prompt

_DefText44::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "blinded me with"
	cont "SCIENCE!"
	prompt

_DefText45::
	TX_RAM W_TRAINERNAME
	text ": I'll"
	line "be back to fight"
	cont "you again!"
	prompt

_DefText46::
	TX_RAM W_TRAINERNAME
	text ": Don't"
	line "cross my path"
	cont "again!"
	prompt

_DefText47::
	TX_RAM W_TRAINERNAME
	text ":"
	line "Tartar Sauce!"
	prompt

_DefText48::
	TX_RAM W_TRAINERNAME
	text ": NO!"
	prompt

_DefText49::
	TX_RAM W_TRAINERNAME
	text ": GAH!"
	prompt

_DefText50::
	TX_RAM W_TRAINERNAME
	text ": And"
	line "now depression"
	cont "sets in..."
	prompt

_DefText51::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "need to improve"
	cont "my luck!"
	prompt

_DefText52::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "like the HOENN"
	cont "BATTLE FACTORY"
	cont "more..."
	prompt

_DefText53::
	TX_RAM W_TRAINERNAME
	text ": If"
	line "only REVIVEs"
	cont "were allowed."
	prompt

_DefText54::
	TX_RAM W_TRAINERNAME
	text ": I"
	line "won!"

	para "Oh wait, no you"
	line "won..."
	prompt

_DefText55::
	TX_RAM W_TRAINERNAME
	text ": The"
	line "pain of defeat"
	cont "goes deep."
	prompt

_DefText56::
	TX_RAM W_TRAINERNAME
	text ": My"
	line "mom says I'm the"
	cont "best trainer!"
	prompt

_DefText57::
	TX_RAM W_TRAINERNAME
	text ": I'm"
	line "better at the"
	cont "BATTLE TOWER."
	prompt

_DefText58::
	TX_RAM W_TRAINERNAME
	text ": Oh"
	line "man!"

	para "I thought I still"
	line "had more #MON!"
	prompt

_DefText59::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "smell.  I don't"
	cont "want to smell you"
	cont "later."
	prompt

_DefText60::
	TX_RAM W_TRAINERNAME
	text ": Why"
	line "don't you pick on"
	cont "someone your own"
	cont "size!"
	prompt

; special trainers defeated texts

_BrockDefText::
	TX_RAM W_TRAINERNAME
	text ": You"
	line "have some real"
	cont "potential."

	para "There are many"
	line "other FACTORY"
	cont "HEADs waiting for"
	cont "you to challenge"
	cont "them!"
	prompt

_KogaDefText::
	TX_RAM W_TRAINERNAME
	text ": Aha!"
	line "A worthy opponent"
	cont "indeed!"

	para "My ninja ways"
	line "were no match for"
	cont "your nimble ways"
	cont "in battle!"

	para "The road ahead"
	line "is tougher, yet!"
	prompt

_BlaineDefText::
	TX_RAM W_TRAINERNAME
	text ": When"
	line "you're hot, you're"
	cont "hot!"

	para "I was not!"

	para "Go beat the rest"
	line "of the bots!"
	prompt

_GioDefText::
	TX_RAM W_TRAINERNAME
	text ": Heh."
	line "I haven't been"
	cont "pushed like that"
	cont "in ages."

	para "You're alright,"
	line "kid."

	para "You'd make a"
	line "great ROCKET!"
	prompt

_LoreleiDefText::
	TX_RAM W_TRAINERNAME
	text ": Ice"
	line "must run through"
	cont "your veins with"
	cont "a chilling"
	cont "victory like"
	cont "that!"

	para "You've had an"
	line "IN-credible run"
	cont "so far!"
	prompt

_LanceDefText::
	TX_RAM W_TRAINERNAME
	text ": Hm."
	line "You certainly"
	cont "have a deep"
	cont "understanding of"
	cont "#MON."

	para "Only one HEAD"
	line "remains in your"
	cont "path."
	prompt

_OakDefText::
	TX_RAM W_TRAINERNAME
	text ": Aha!"
	line "I always knew you"
	cont "you had the heart"
	cont "of a #MON"
	cont "master!"

	para "You've done quite"
	line "an amazing thing"
	cont "just now!"

	para "It just so"
	line "happens that I"
	cont "run this BATTLE"
	cont "FACTORY, and you"
	cont "just climbed to"
	cont "the very top!"

	para "You can keep"
	line "going, but you"
	cont "should probably"
	cont "go play outside"
	cont "instead!"

	para "..."

	para "VICTORY"
	prompt

_EmptyComputerText::
	text "BATTLE FACTORY OS"
	line "IDLE..."
	done

_UsedComputerText::
	text "A raging battle"
	line "is going on in"
	cont "the computer!"
	done

_BattleFactoryText9::
	text "..."
	line "..."

	para "(This person is"
	line "concentrating.)"
	done

_BattleFactoryTextA::
	text "I just swapped my"
	line "DROWZEE for a"
	cont "CHARMELEON!"
	done

_BattleFactoryTextB::
	text "My best streak is"
	line "32 wins in a row."

	para "I managed to beat"
	line "BROCK, and KOGA!"
	done

_BattleFactoryTextC::
	text "Grrr..."

	para "I was unlucky"
	line "with the first"
	cont "#MON I could"
	cont "pick."
	done

_ComputerDoneText::
	text "BATTLE SESSION"
	line "COMPLETE..."

	para "Your #MON have"
	line "been returned."
	done

_SpecialOpponentText::
	text "CURRENT WINNING"
	line "STREAK: @"
	TX_NUM W_CURSTREAK, 1, 3
	db $0, "..."

	para "INITIALIZING"
	line "BATTLE..."
	cont "OPPONENT FOUND..."
	cont "FACTORY HEAD"
	cont "DETECTED..."
	cont "BEGIN BATTLE..."
	done

_CantUseMoveNowText::
	text "You can't use this"
	line "now because you're"
	cont "competing in the"
	cont "BATTLE FACTORY."
	prompt


_CantUseItemsNowText::
	text "You can't use"
	line "items now because"
	cont "you're competing"
	cont "in the BATTLE"
	cont "FACTORY."
	prompt

_PlayerBlackedOutBattleFactory::
	text "All your #MON"
	line "have fainted!"
	
	para "Your win streak"
	line "has been reset"
	cont "to 0!"

	para "Better luck next"
	line "time!"
	prompt

_CantLeaveText::
	text "You can't leave"
	line "because you"
	cont "started the"
	cont "BATTLE FACTORY"
	cont "challenge!"

	para "Talk to the"
	line "receptionist to"
	cont "begin battling!"
	done

_BattleFactoryTextInverse::
	text "Would you like to"
	line "change your"
	cont "INVERSE MODE"
	cont "setting for this"
	cont "this challenge?"
	done

_BattleFactoryTextInverseOn::
	text "You have turned"
	line "INVERSE MODE on."
	
	para "It will be turned"
	line "off automatically"
	cont "when your BATTLE"
	cont "FACTORY challenge"
	cont "is completed."
	cont ""
	done

_BattleFactoryTextInverseOff::
	text "You have turned"
	line "INVERSE MODE off."

	para "It will be turned"
	line "on automatically"
	cont "when your BATTLE"
	cont "FACTORY challenge"
	cont "is completed."
	cont ""
	done