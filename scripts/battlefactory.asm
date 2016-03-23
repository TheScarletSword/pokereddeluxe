; original battle factory code by shantytown
; for the most part this is unchanged except when we get down to the actual parties and sets used
; there are also some minor fixes to fit in this hack
BattleFactoryTextPointers:
	dw BattleFactoryText1
	dw BattleFactoryReceptionist
	dw BattleFactoryGuide
	dw BattleFactoryText9
	dw BattleFactoryTextA
	dw BattleFactoryTextB
	dw BattleFactoryTextC
	dw BattleFactoryWinsText
	dw BattleFactoryBestText
	dw BattleLoadingText
	dw EmptyComputerText
	dw UsedComputerText
	dw ComputerDoneText
	dw SpecialOpponentText
	dw CantLeaveText
	dw BattleFactoryTextD

BattleFactoryScript:
	call EnableAutoTextBoxDrawing
	ld hl, BattleFactoryScriptPointers
	ld a, [W_BATTLEFACTORYCURSCRIPT]
 	jp CallFunctionInTable

BattleFactoryScriptPointers:
	dw BattleFactoryScript0
	dw BattleFactoryScript1
	dw BattleFactoryScript2
	dw BattleFactoryScript3
 
BattleFactoryScript0:
	; is player trying to leave after picking mons?
	ld a, [W_INCHALLENGE]
	and a
	jr z, .afterExitCheck
	ld a, [W_YCOORD]
	cp $e
	jr nz, .afterExitCheck
	ld a, [W_XCOORD]
	cp $6
	jr c, .afterExitCheck
	cp $8
	jr nc, .afterExitCheck
	; display text and force up
	ld a, $f
	ld [H_DOWNARROWBLINKCNT2], a ; $FF00+$8c
	call DisplayTextID
	; move player one space down
	xor a
	ld [hJoyHeld], a
	ld a, $ff ; disable all buttons
	ld [wJoyIgnore], a
	ld a, D_UP
	ld [$ccd3],a ; base address of simulated button presses
	xor a
	ld [$cd39],a
	inc a
	ld [$cd38],a ; index of current simulated button press
	ld hl,$d730
	set 7,[hl]
	ret
.afterExitCheck
	ld a, [W_STARTBATTLE]
	and a
	ret z
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, $ccd3
	ld de, FactoryMovementData
	call DecodeRLEList
	dec a
	ld [$cd38], a
	call StartSimulatingJoypadStates
	ld a, 1
	ld [W_BATTLEFACTORYCURSCRIPT], a
	ret

BattleFactoryScript1:
	ld a, [$cd38]
	and a
	ret nz
	call Delay3
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $a
	ld [$ff00+$8c], a
	call DisplayTextID
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld a, 2
	ld [W_BATTLEFACTORYCURSCRIPT], a
	ret

BattleFactoryScript2:
	call FightTrainer
	ld a, [W_CURSTREAK]
	and a
	jr nz, .wonBattle
	ld a, 3
	ld [W_BATTLEFACTORYCURSCRIPT], a
	ret
.wonBattle
	ld a, [W_INCHALLENGE]
	cp $1
	jr z, .stillGoing
	ld a, 3
	ld [W_BATTLEFACTORYCURSCRIPT], a
	ret
.stillGoing
	ld a, [W_CURSTREAK]
	ld c, 0
.divisionLoop7
	cp 7
	jr c, .divisionDone7
	sub 7
	inc c
	jr .divisionLoop7
.divisionDone7
	cp 6
	jr nz, .normalTrainer
	ld a, c
	cp 9
	jr nc, .normalTrainer
	cp 2
	jr c, .normalTrainer
	ld a, $e
	ld [$ff00+$8c], a
	jr .displayText
.normalTrainer
	ld a, $a
	ld [$ff00+$8c], a
.displayText
	call DisplayTextID
	call Delay3
	ld a, 2
	ld [W_BATTLEFACTORYCURSCRIPT], a
	ret

FactoryMovementData:
	db $40, 1 ; right x4
	db $10, 6 ; up x1
	db $FF

BattleFactoryScript3:
	call UpdateSprites
	ld a, $d
	ld [$ff00+$8c], a
	call DisplayTextID
	; return mons in box to player
.clearloop
	ld a, [wPartyCount]
	cp $0
	jr z, .doneClearing
	xor a
	ld [wWhichPokemon], a
	ld [$cf95], a
	call RemovePokemon
	jr .clearloop
.doneClearing
	ld a, [W_FOSSILMON] ; num stored in box
	ld b, a
.returnLoop
	push bc
	xor a
	ld [$cf95], a
	ld a, [W_NUMINBOX]
	dec a
	ld [wWhichPokemon], a
	ld hl, W_NUMINBOX + 1
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [$cf91], a ; save mon id

	call Func_3a68
	ld a, $1
	ld [$cf95], a
	call RemovePokemon
	pop bc
	dec b
	jr nz, .returnLoop
	ld a, 0
	ld [W_BATTLEFACTORYCURSCRIPT], a
	ret


BattleLoadingText:
	TX_FAR _BattleLoadingText
	db "@"

BattleFactoryRewards:
	db LUXURY_BALL, RARE_CANDY, SHINY_BALL, LINK_STONE, SHINY_BALL, OLD_AMBER, MASTER_BALL 

BattleFactoryReward1:
 	TX_FAR _BattleFactoryReward1
 	db "@"

BattleFactoryNoRoom:
 	TX_FAR _BattleFactoryNoRoom
 	db "@"

BattleFactoryReward2:
 	TX_FAR _BattleFactoryReward2
 	db "@"

BattleFactoryText1: ; (17:656c)
	db $08 ; asm
	ld a, [W_INCHALLENGE]
	cp $1
	jr nz, .giveItem
	ld hl, AlreadyStartedText
	call PrintText
	jp TextScriptEnd
.giveItem
	; is the player supposed to get an item?
	ld a, [W_FACTORY_REWARD]
	and a
	jr z, .askToStart
	ld hl, BattleFactoryReward1
	call PrintText
	; figure out which item to give
	ld a, [W_CURSTREAK]
	sub 21
	ld c, 0
.giveItemLoop
	cp 7
	jr c, .afterGiveItemLoop
	sub 7
	inc c
	jr .giveItemLoop
.afterGiveItemLoop
	; c contains reward index
	ld b, 0
	ld hl, BattleFactoryRewards
	add hl, bc ; hl contains pointer to item id
	ld a, [hl] ; a contains reward item id
	ld c, 1
	ld b, a
	call GiveItem
	jr nc, .BagFull
	ld hl, BattleFactoryReward2
	call PrintText
	xor a
	ld [W_FACTORY_REWARD], a
	jp TextScriptEnd
.BagFull
	ld hl, BattleFactoryNoRoom
	call PrintText
	jp TextScriptEnd
.askToStart
	ld hl, BattleFactoryText2
	call PrintText
	call YesNoChoice
	ld a, [$cc26]
	and a
	jr z, .saidYes
	ld hl, BattleFactoryText4
	call PrintText
	jp TextScriptEnd
.saidYes:
	ld a, [wPartyCount]
	ld [W_FOSSILMON], a
	call StoreMonsInPC
	and a
	jr z, .storedMonsInBox
	ld hl, MakeRoomInBoxText
	call PrintText
	jp TextScriptEnd
.storedMonsInBox
	ld hl, BattleFactoryTextInverse
	call PrintText
	call YesNoChoice
	ld a, [$cc26]
	and a
	jr nz, .saidNo
	call BattleFactoryTextE
.saidNo
	ld hl, BattleFactoryText3
	call PrintText
	call FillMonChoices
	call SaveScreenTilesToBuffer2
	xor a 
	ld [W_NUM_RENTED_MONS], a
	call ShowFactoryMon
	call RemoveUnrentedMonsFromPC
	call LoadScreenTilesFromBuffer2
	call UpdateSprites
	ld hl, FinishedPickingMonsText
	call PrintText
	ld a, $1
	ld [W_INCHALLENGE], a
	jp TextScriptEnd

StoreMonsInPC:
	; returns 0 in a if successful
	; check if there are enough spots in the box for the player's party
	ld a, [W_NUMINBOX]
	ld b, a
	ld a, [wPartyCount]
	add a, b
	add 6 ; 6 factory mons to choose
	cp 20 + 1 ; Is (partymons + boxmons + 6) > 20?
	jr c, .roomInBox
	; return 1 in a
	ld a, 1
	ret
.roomInBox
	; store all party mons in box
	ld a, [wPartyCount]
	and a
	jr z, .doneStoringMons
	xor a
	ld [wWhichPokemon], a
	inc a
	ld [$cf95], a ; a = 1
	ld a, [wPartySpecies]
	ld [$cf91], a
	call Func_3a68 ; store mon in box
	xor a
	ld [$cf95], a
	call RemovePokemon
	jr .roomInBox
.doneStoringMons
	xor a
	ret

RemoveUnrentedMonsFromPC:
	ld b, 3
.loop
	push bc
	; remove the 3 unchosen mons
	xor a
	ld [wWhichPokemon], a
	ld a, $1
	ld [$cf95], a
	call RemovePokemon
	pop bc
	dec b
	ret z
	jr .loop


FightTrainer:
	call PickTrainerClass
	add $C8 ; add $c8 to trainer class id
	ld [W_CUROPPONENT], a ; $d059
	call Delay3
	ld hl, W_OPTIONS ; $d355
	set 6, [hl] ; no switching pokemon
; added sanky's trainer id fix here
	ld a, 1
	ld [wIsTrainerBattle], a
	ld a, $2c
	call Predef ; indirect jump to Func_3ef18 (3ef18 (f:6f18)) Runs the battle.
	ld a, $7
	call Predef ; healparty
	call AfterBattle
	ret

PickTrainerClass:
	; is it a special battle?
	ld a, [W_CURSTREAK]
.divisionLoop3
	cp 7
	jr c, .divisionDone3
	sub 7
	jr .divisionLoop3
.divisionDone3
	cp 6
	jr z, .specialTrainer
.normalTrainer
	call Random
	cp 29 ; length of NormalTrainerClasses
	jr nc, .normalTrainer ; is Random result isn't a valid index
	ld hl, NormalTrainerClasses
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret
.specialTrainer
	ld a, [W_CURCLASS]
	cp 2 ; first class to have special trainers at the end
	jr c, .noSpecialTrainer
	cp 9 ; last class to have special trainers at the end (+1)
	jr nc, .noSpecialTrainer
	ld hl, SpecialTrainerClasses
	sub 2 ; subtract first class to have special trainers
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret
.noSpecialTrainer
	jr .normalTrainer

NormalTrainerClasses:
; list of trainers that can appear in normal factory battles
	db YOUNGSTER    
	db BUG_CATCHER  
	db LASS         
	db SAILOR       
	db JR__TRAINER_M
	db JR__TRAINER_F
	db POKEMANIAC   
	db SUPER_NERD   
	db HIKER        
	db BIKER        
	db BURGLAR      
	db ENGINEER     
	db JUGGLER_X    
	db FISHER       
	db SWIMMER      
	db CUE_BALL     
	db GAMBLER      
	db BEAUTY       
	db PSYCHIC_TR   
	db ROCKER       
	db JUGGLER      
	db TAMER        
	db BIRD_KEEPER  
	db BLACKBELT    
	db SCIENTIST    
	db COOLTRAINER_M
	db COOLTRAINER_F
	db CHANNELER
	db GENTLEMAN

SpecialTrainerClasses:
; these are the "factory heads" in order
; they appear every 7 battles starting at 21 straight victories
	db BROCK ; 2 (class in which you encounter them)
	db KOGA ; 3
	db BLAINE ; 4
	db GIOVANNI ; 5
	db LORELEI ; 6
	db LANCE ; 7
	db PROF_OAK ; 8

InitTrainer:
; set [wEnemyPartyCount] to 0, [$D89D] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl,wEnemyPartyCount
	xor a
	ld [hli],a
	dec a
	ld [hl],a
	ld a, [W_CURCLASS]
	cp 2 ; first class for special trainers
	jp c, .normalTrainerPicks ; is there even a chance for special trainer?
	cp 9
	jp nc, .normalTrainerPicks ; is it past the last special trainer class?
	ld a, [W_CURSTREAK] ; see if this is the last battle
.divisionLoop4
	cp 7
	jp c, .doneDividing4
	sub 7
	jr .divisionLoop4
.doneDividing4
	cp 6
	jr nz, .normalTrainerPicks ; is it the last battle?
	push hl
	push bc
	call SpecialPickMons
	pop bc
	pop hl
	jr .FinishUp
.normalTrainerPicks
	ld b, 3
.monLoop
	call PickMon
	ld hl, wEnemyPartyCount
	ld e, [hl]
	inc hl
.checkTrainerSafePick
	cp [hl]
	jr z, .monLoop
	inc hl
	dec e
	jr nz, .checkTrainerSafePick
	ld hl, wPartySpecies
	ld e, 3
.checkSafePick
	cp [hl]
	jr z, .monLoop
	inc hl
	dec e
	jr nz, .checkSafePick
.safePick	
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	push hl
	push bc
	call AddPartyMon
	pop bc
	pop hl
	dec b
	jr nz, .monLoop
.FinishUp ; XXX this needs documenting
	xor a       ; clear D079-D07B
	ld de,$D079
	ld [de],a
	inc de
	ld [de],a
	inc de
	ld [de],a
	ld a,[W_CURENEMYLVL]
	ld b,a
.LastLoop
	ld hl,$D047
	ld c,2
	push bc
	ld a,$B
	call Predef
	pop bc
	inc de
	inc de
	dec b
	jr nz,.LastLoop
 	ret

AfterBattle:
; unsets sanky's trainer id fix
	xor a
	ld [wIsTrainerBattle], a
	call GBPalWhiteOutWithDelay3
	call PlayDefaultMusic
	ld hl, $cfc4
	ld a, [hl]
	push af
	push hl
	res 0, [hl]
	xor a
	ld [$d72d], a
	dec a
	ld [$d42f], a
	call LoadMapData
	ld b, BANK(ClearVariablesAfterLoadingMapData)
	ld hl, ClearVariablesAfterLoadingMapData
	call Bankswitch ; indirect jump to Func_c335 (c335 (3:4335))
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	pop hl
	pop af
	ld [hl], a
	call GBFadeInFromWhite
 	ret
 	
; loads data of some trainer on the current map and plays pre-battle music
; a contains trainer class
; [hl] contains a list of trainer's mons
EngageMapTrainer2: ; 336a (0:336a)
	ld [wEngagedTrainerClass], a
	ld a, [hl]     ; load trainer mon set
	ld [wEnemyMonAttackMod], a ; $cd2e
	jp PlayTrainerMusic

BattleFactoryReceptionist:
	db $08 ; asm
	ld a, [W_INCHALLENGE]
	cp $1
	jr z, .battleTrainer
	ld hl, NotStartedText
	call PrintText
	jr .endReceptionist
.battleTrainer
	ld hl, ReadyBattleText
	call PrintText
	call YesNoChoice
	ld a, [$cc26]
	and a
	jr z, .saidStartBattle
	ld hl, NotYetText
	call PrintText
	jr .endReceptionist
.saidStartBattle
	ld a, [W_CURCLASS]
	cp 2
	jr c, .normalGoodLuckText
	cp 9
	jr nc, .normalGoodLuckText
	ld a, [W_CURSTREAK]
.divisionLoop5
	cp 7
	jr c, .divisionDone5
	sub 7
	jr .divisionLoop5
.divisionDone5
	cp 6
	jr nz, .normalGoodLuckText
	ld hl, SpecialStartNowText
	call PrintText
	jr .setStartFlag
.normalGoodLuckText
	ld hl, StartNowText
	call PrintText
.setStartFlag
	ld a, $1
	ld [W_STARTBATTLE], a
.endReceptionist
	jp TextScriptEnd

BattleFactoryGuide:
	db $08 ; asm
	ld hl, GuideIntro
	call PrintText
	call YesNoChoice
	ld a, [$cc26]
	and a
	jr z, .saidYesGuide
	ld hl, GuideNoText
	call PrintText
	jr .doneGuide
.saidYesGuide
	ld hl, GuideText
	call PrintText
.doneGuide
	jp TextScriptEnd

BattleFactoryText2:
	TX_FAR _BattleFactoryText2
 	db "@"

BattleFactoryText3:
	TX_FAR _BattleFactoryText3
	db "@"

BattleFactoryText4:
	TX_FAR _BattleFactoryText4
	db "@"

MakeRoomInBoxText:
	TX_FAR _MakeRoomInBoxText
	db "@"

FinishedPickingMonsText:
	TX_FAR _FinishedPickingMonsText
	db "@"

BattleFactoryWinsText:
	TX_FAR _BattleFactoryWinsText
	db "@"

BattleFactoryBestText:
	TX_FAR _BattleFactoryBestText
	db "@"

AlreadyStartedText:
	TX_FAR _AlreadyStartedText
	db "@"

NotStartedText:
	TX_FAR _NotStartedText
	db "@"

ReadyBattleText:
	TX_FAR _ReadyBattleText
	db "@"

NotYetText:
	TX_FAR _NotYetText
	db "@"

StartNowText:
	TX_FAR _StartNowText
	db "@"

SpecialStartNowText:
	TX_FAR _SpecialStartNowText
	db "@"

GuideIntro:
	TX_FAR _GuideIntro
	db "@"

GuideText:
	TX_FAR _GuideText
	db "@"

GuideNoText:
	TX_FAR _GuideNoText
	db "@"

EmptyComputerText:
	TX_FAR _EmptyComputerText
	db "@"

UsedComputerText:
	TX_FAR _UsedComputerText
	db "@"

BattleFactoryText9:
	TX_FAR _BattleFactoryText9
	db "@"

BattleFactoryTextA:
	TX_FAR _BattleFactoryTextA
	db "@"

BattleFactoryTextB:
	TX_FAR _BattleFactoryTextB
	db "@"

BattleFactoryTextC:
	TX_FAR _BattleFactoryTextC
	db "@"

ComputerDoneText:
	TX_FAR _ComputerDoneText
	db "@"

SpecialOpponentText:
	TX_FAR _SpecialOpponentText
	db "@"

CantLeaveText:
	TX_FAR _CantLeaveText
	db "@"

ClearParty: ; not used
; clears all pokemon from party
.clearloop
	ld a, [wPartyCount]
	cp $0
	jr z, .doneClearing
	xor a
	ld [wWhichPokemon], a
	ld [$cf95], a
	call RemovePokemon
	jr .clearloop
.doneClearing
	ret

FillMonChoices:
; places 6 random pokemon
	ld d, 0 ; num mons placed
	ld b, 6 ; num mons to place
.fillLoop
 	call PickMon
	ld e, a
 	ld hl, W_NUMINBOX+1
	ld c, d
.notPickedLoop
	ld a, c
	and a
	jr z, .safePick
	ld a, e
	cp [hl]
	jp z, .fillLoop
	inc hl
	dec c
	jr .notPickedLoop
.safePick
	ld a, e
	ld [$cf91], a
	ld a, 100 ; mon level
	ld [$d127], a
	push de
	call FillMonData
	pop de
	inc d
	dec b
	jp nz, .fillLoop
	ret

LASDDF:
	db $78, $78, $7a, $77

PickMon:
; randomly chooses a mon
; mon id stored in a
	push bc
	push de
	push hl
	ld b, 0
	ld a, [W_CURCLASS]
	cp 9
	jr c, .haveCorrectClass
	ld a, 8 ; last class
.haveCorrectClass	
	ld c, a
	sla c ; multiply by 2
	ld hl, MonClassPointers
	add hl, bc ; hl contains class pointer
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	ld h, d
	ld l, e
	ld a, [hli] ; num mons in class list
	ld b, a
.getValidRandom
	call Random
	cp b
	jr c, .gotValidRandom
	jr .getValidRandom
.gotValidRandom
	push de
	ld c, a
	ld b, 0
	ld d, 5
.addingLoop
	add hl, bc
	dec d
	jr z, .finishedAdding
	jr .addingLoop
.finishedAdding
	pop de
	; hl now contains pointer to [mon id][moves_pointer]
	ld a, [hli] ; a contains mon id
	ld d, a
.readMoves
	ld a, [hli]
	ld [W_MOVE1], a
	ld a, [hli]
	ld [W_MOVE2], a
	ld a, [hli]
	ld [W_MOVE3], a
	ld a, [hl]
	ld [W_MOVE4], a
.done
	ld a, d ; place mon id in a
	pop hl
	pop de
	pop bc
	ret

SpecialPickMons:
	ld a, [W_TRAINERCLASS]
	ld hl, SpecialPickMonsFunctionPointers
	ld c, 3
	ld b, 0
.searchLoop2
	cp [hl]
	jp z, .foundPickPointer
	add hl, bc
	jr .searchLoop2
.foundPickPointer
	inc hl
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a ; de contains PickMons pointer
	ld h, d
	ld l, e
	jp [hl] ; jump to the PickMons function

SpecialPickMonsFunctionPointers:
	dbw HEAD_BROCK,   BrockPickMons
	dbw HEAD_KOGA,    KogaPickMons
	dbw HEAD_BLAINE,  BlainePickMons
	dbw HEAD_ROCKET,  GioPickMons
	dbw HEAD_LORELEI, LoreleiPickMons
	dbw HEAD_LANCE,   LancePickMons
	dbw HEAD_OAK,     OakPickMons

; all of these are edited
BrockPickMons:
; vulpix, onix, magnemite/geodude
	ld a, VULPIX
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, FLAMETHROWER
	ld [W_MOVE1], a
	ld a, CONFUSE_RAY
	ld [W_MOVE2], a
	ld a, QUICK_ATTACK
	ld [W_MOVE3], a
	ld a, DOUBLE_TEAM
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, ONIX
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, ROCK_THROW
	ld [W_MOVE1], a
	ld a, DIG
	ld [W_MOVE2], a
	ld a, SLAM
	ld [W_MOVE3], a
	ld a, SCREECH
	ld [W_MOVE4], a
	call AddPartyMon
	call Random
	cp 128
	jr c, .secondMon
	ld a, MAGNEMITE
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, THUNDERSHOCK
	ld [W_MOVE1], a
	ld a, THUNDER_WAVE
	ld [W_MOVE2], a
	ld a, SWIFT
	ld [W_MOVE3], a
	ld a, SUPERSONIC
	ld [W_MOVE4], a
	call AddPartyMon
	ret
.secondMon
	ld a, GEODUDE
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, EXPLOSION
	ld [W_MOVE1], a
	ld a, ROCK_THROW
	ld [W_MOVE2], a
	ld a, STRENGTH
	ld [W_MOVE3], a
	ld a, HARDEN
	ld [W_MOVE4], a
	call AddPartyMon
	ret

KogaPickMons:
	ld a, WEEZING
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, SLUDGE
	ld [W_MOVE1], a
	ld a, SELFDESTRUCT
	ld [W_MOVE2], a
	ld a, TOXIC
	ld [W_MOVE3], a
	ld a, SMOKESCREEN
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, CROBAT
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, WING_ATTACK
	ld [W_MOVE1], a
	ld a, LEECH_LIFE
	ld [W_MOVE2], a
	ld a, TOXIC
	ld [W_MOVE3], a
	ld a, CONFUSE_RAY
	ld [W_MOVE4], a
	call AddPartyMon
	call Random
	cp 64
	jr c, .secondMon
	ld a, VENOMOTH
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, PSYWAVE
	ld [W_MOVE1], a
	ld a, TOXIC
	ld [W_MOVE2], a
	ld a, SLEEP_POWDER
	ld [W_MOVE3], a
	ld a, POISONPOWDER
	ld [W_MOVE4], a
	call AddPartyMon
	ret
.secondMon
	ld a, SCYTHER
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, SLASH
	ld [W_MOVE1], a
	ld a, SWORDS_DANCE
	ld [W_MOVE2], a
	ld a, DOUBLE_TEAM
	ld [W_MOVE3], a
	ld a, TOXIC
	ld [W_MOVE4], a
	call AddPartyMon
	ret

BlainePickMons:
	ld a, NINETALES
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, FIRE_BLAST
	ld [W_MOVE1], a
	ld a, CONFUSE_RAY
	ld [W_MOVE2], a
	ld a, AMNESIA
	ld [W_MOVE3], a
	ld a, DIG
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, RHYPERIOR
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, EARTHQUAKE
	ld [W_MOVE1], a
	ld a, ROCK_SLIDE
	ld [W_MOVE2], a
	ld a, TAKE_DOWN
	ld [W_MOVE3], a
	ld a, FIRE_BLAST
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, MAGMORTAR
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, FIRE_BLAST
	ld [W_MOVE1], a
	ld a, CONFUSE_RAY
	ld [W_MOVE2], a
	ld a, SMOKESCREEN
	ld [W_MOVE3], a
	ld a, PSYCHIC_M
	ld [W_MOVE4], a
	call AddPartyMon
	ret

GioPickMons:
	ld a, KANGASKHAN
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, MEGA_PUNCH
	ld [W_MOVE1], a
	ld a, EARTHQUAKE
	ld [W_MOVE2], a
	ld a, DIZZY_PUNCH
	ld [W_MOVE3], a
	ld a, SUBMISSION
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, RHYPERIOR
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, EARTHQUAKE
	ld [W_MOVE1], a
	ld a, MEGAHORN
	ld [W_MOVE2], a
	ld a, TAKE_DOWN
	ld [W_MOVE3], a
	ld a, FISSURE
	ld [W_MOVE4], a
	call AddPartyMon
	call Random
	cp 128
	jr c, .secondMon
	ld a, NIDOKING
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, POISON_JAB
	ld [W_MOVE1], a
	ld a, TOXIC
	ld [W_MOVE2], a
	ld a, SURF
	ld [W_MOVE3], a
	ld a, ICE_BEAM
	ld [W_MOVE4], a
	call AddPartyMon
	ret
.secondMon
	ld a, NIDOQUEEN
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, EARTHQUAKE
	ld [W_MOVE1], a
	ld a, SUPERPOWER
	ld [W_MOVE2], a
	ld a, ROCK_SLIDE
	ld [W_MOVE3], a
	ld a, TOXIC
	ld [W_MOVE4], a
	call AddPartyMon
	ret

LoreleiPickMons:
	ld a, CRYOGONAL
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, BLIZZARD
	ld [W_MOVE1], a
	ld a, NIGHT_SLASH
	ld [W_MOVE2], a
	ld a, REFLECT
	ld [W_MOVE3], a
	ld a, ACID_ARMOR
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, LAPRAS
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, ICE_BEAM
	ld [W_MOVE1], a
	ld a, SURF
	ld [W_MOVE2], a
	ld a, THUNDERBOLT
	ld [W_MOVE3], a
	ld a, SING
	ld [W_MOVE4], a
	call AddPartyMon
	call Random
	cp 128
	jr c, .secondMon
	ld a, CLOYSTER
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, TOXIC
	ld [W_MOVE1], a
	ld a, BLIZZARD
	ld [W_MOVE2], a
	ld a, CLAMP
	ld [W_MOVE3], a
	ld a, DOUBLE_TEAM
	ld [W_MOVE4], a
	call AddPartyMon
	ret
.secondMon
	ld a, JYNX
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, ICE_BEAM
	ld [W_MOVE1], a
	ld a, LOVELY_KISS
	ld [W_MOVE2], a
	ld a, PSYCHIC
	ld [W_MOVE3], a
	ld a, DOUBLE_TEAM
	ld [W_MOVE4], a
	call AddPartyMon
	ret

LancePickMons:
	ld a, DRAGONITE
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, HURRICANE
	ld [W_MOVE1], a
	ld a, ROOST
	ld [W_MOVE2], a
	ld a, SURF
	ld [W_MOVE3], a
	ld a, DRAGON_RUSH
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, AERODACTYL
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, WING_ATTACK
	ld [W_MOVE1], a
	ld a, IRON_HEAD
	ld [W_MOVE2], a
	ld a, ANCIENTPOWER
	ld [W_MOVE3], a
	ld a, OMINOUS_WIND
	ld [W_MOVE4], a
	call AddPartyMon
	ld a, HYDREIGON
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, FIRE_BLAST
	ld [W_MOVE1], a
	ld a, DRAGON_PULSE
	ld [W_MOVE2], a
	ld a, SURF
	ld [W_MOVE3], a
	ld a, CRUNCH
	ld [W_MOVE4], a
	call AddPartyMon
	ret

OakPickMons:
	ld a, TAUROS
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, EARTHQUAKE
	ld [W_MOVE1], a
	ld a, DOUBLE_EDGE
	ld [W_MOVE2], a
	ld a, BLIZZARD
	ld [W_MOVE3], a
	ld a, BODY_SLAM	
	ld [W_MOVE4], a
	call AddPartyMon
	call Random
	cp 86
	jr c, .secondMon
	cp 172
	jr c, .thirdMon
	ld a, SLOWKING
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, PSYCHIC_M
	ld [W_MOVE1], a
	ld a, AMNESIA
	ld [W_MOVE2], a
	ld a, THUNDER_WAVE
	ld [W_MOVE3], a
	ld a, SURF
	ld [W_MOVE4], a
	call AddPartyMon
	jr .lastMon
.secondMon
	ld a, MAGMORTAR
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, FIRE_BLAST
	ld [W_MOVE1], a
	ld a, EARTHQUAKE
	ld [W_MOVE2], a
	ld a, THUNDERBOLT
	ld [W_MOVE3], a
	ld a, PSYCHIC
	ld [W_MOVE4], a
	call AddPartyMon
	jr .lastMon
.thirdMon
	ld a, DRAGONITE
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, HURRICANE
	ld [W_MOVE1], a
	ld a, BODY_SLAM
	ld [W_MOVE2], a
	ld a, DRAGON_RUSH
	ld [W_MOVE3], a
	ld a, ROOST
	ld [W_MOVE4], a
	call AddPartyMon
.lastMon
	call Random
	cp 86
	jr c, .pickBlastoise
	cp 172
	jr c, .pickCharizard
	ld a, VENUSAUR
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, RAZOR_LEAF
	ld [W_MOVE1], a
	ld a, SWORDS_DANCE
	ld [W_MOVE2], a
	ld a, SLEEP_POWDER
	ld [W_MOVE3], a
	ld a, BODY_SLAM
	ld [W_MOVE4], a
	call AddPartyMon
	ret
.pickBlastoise
	ld a, BLASTOISE
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, HYDRO_PUMP
	ld [W_MOVE1], a
	ld a, BLIZZARD
	ld [W_MOVE2], a
	ld a, DARK_PULSE
	ld [W_MOVE3], a
	ld a, EARTHQUAKE
	ld [W_MOVE4], a
	call AddPartyMon
	ret
.pickCharizard
	ld a, CHARIZARD
	ld [$CF91], a
	ld a, 1
	ld [$CC49],a ; $1 for enemy party
	ld a, FIRE_BLAST
	ld [W_MOVE1], a
	ld a, SWORDS_DANCE
	ld [W_MOVE2], a
	ld a, EARTHQUAKE
	ld [W_MOVE3], a
	ld a, OMINOUS_WIND
	ld [W_MOVE4], a
	call AddPartyMon
	ret

MonClassPointers:
	dw MonClass1
	dw MonClass2
	dw MonClass3
	dw MonClass4
	dw MonClass5
	dw MonClass6
	dw MonClass7
	dw MonClass8
	dw MonClass9

MonClass1:
	db 32 ; num mons in this list
	db CATERPIE, TACKLE, STRING_SHOT, 0, 0
	db WEEDLE, POISON_STING, STRING_SHOT, 0, 0
	db MAGIKARP, TACKLE, 0, 0, 0
	db ZUBAT, WING_ATTACK, CONFUSE_RAY, BITE, LEECH_LIFE
	db PIDGEY, WING_ATTACK, QUICK_ATTACK, MIRROR_MOVE, SAND_ATTACK
	db RATTATA, SUPER_FANG, QUICK_ATTACK, TAIL_WHIP, 0
	db DIGLETT, SCRATCH, SAND_ATTACK, GROWL, 0
	db DRILBUR, SCRATCH, FURY_SWIPES, 0, 0
	db SPEAROW, PECK, MIRROR_MOVE, GROWL, LEER
	db NIDORAN_M, DOUBLE_KICK, HORN_DRILL, POISON_STING, LEER
	db EKANS, ACID, BITE, SCREECH, WRAP
	db NIDORAN_F, DOUBLE_KICK, POISON_STING, TAIL_WHIP, FURY_SWIPES
	db PARAS, SCRATCH, LEECH_LIFE, SPORE, GROWTH
	db DITTO, TRANSFORM, 0, 0, 0
	db CHARMANDER, SCRATCH, SMOKESCREEN, EMBER, LEER
	db VULPIX, FIRE_SPIN, CONFUSE_RAY, QUICK_ATTACK, TAIL_WHIP
	db SQUIRTLE, WATER_GUN, BITE, WITHDRAW, TAIL_WHIP
	db VENONAT, SLEEP_POWDER, POISONPOWDER, LEECH_LIFE, SUPERSONIC
	db MEOWTH, BITE, PAY_DAY, SCREECH, GROWL
	db PURRLOIN, SLASH, SCRATCH, SAND_ATTACK, GROWL 
	db DRATINI, SLAM, THUNDER_WAVE, LEER, WRAP
	db DEINO, TACKLE, ROAR, BITE, SLAM
	db BULBASAUR, RAZOR_LEAF, LEECH_SEED, GROWTH, POISONPOWDER
	db ODDISH, ABSORB, ACID, POISONPOWDER, SLEEP_POWDER
	db HAPPINY, MEGA_KICK, POUND, METRONOME, THUNDERBOLT
	db IGGLYBUFF, POUND, SING, DEFENSE_CURL, BODY_SLAM
	db PICHU, THUNDERSHOCK, THUNDER_WAVE, FLY, GROWL
	db CLEFFA, METRONOME, SING, POUND, MEGA_PUNCH
	db SWINUB, ICE_SHARD, TACKLE, ANCIENTPOWER, MIST
	db JOLTIK, THUNDER_WAVE, SLASH, LEECH_LIFE, STRING_SHOT
	db SHROOMISH, STUN_SPORE, HEADBUTT, LEECH_SEED, ABSORB
	db FLABEBE, SWIFT, TACKLE, RAZOR_LEAF, MIMIC

MonClass2:
	db 55 ; num mons in this list
	db RATTATA, SUPER_FANG, HYPER_FANG, QUICK_ATTACK, TAIL_WHIP
	db DIGLETT, SLASH, DIG, SAND_ATTACK, GROWL
	db VULPIX, FLAMETHROWER, CONFUSE_RAY, QUICK_ATTACK, TAIL_WHIP
	db MANKEY, KARATE_CHOP, SEISMIC_TOSS, LEER, LOW_KICK
	db PANCHAM, KARATE_CHOP, TACKLE, LEER, COMET_PUNCH
	db POLIWAG, WATER_GUN, BODY_SLAM, AMNESIA, HYPNOSIS
	db MACHOP, KARATE_CHOP, SEISMIC_TOSS, LEER, LOW_KICK
	db BELLSPROUT, SLAM, RAZOR_LEAF, ACID, WRAP
	db BELLSPROUT, RAZOR_LEAF, STUN_SPORE, SLEEP_POWDER, POISONPOWDER
	db GEODUDE, ROCK_THROW, EARTHQUAKE, HARDEN, SELFDESTRUCT
	db ROGGENROLA, STONE_EDGE, HARDEN, SAND_ATTACK, 
	db MAGNEMITE, THUNDERSHOCK, SWIFT, SUPERSONIC, SCREECH
	db CUBONE, BONE_CLUB, HEADBUTT, LEER, ICE_BEAM
	db HORSEA, WATER_GUN, SWIFT, SMOKESCREEN, LEER
	db SLOWPOKE, WATER_GUN, HEADBUTT, AMNESIA, DISABLE
	db DODUO, DRILL_PECK, FURY_ATTACK, GROWL, DOUBLE_TEAM
	db GRIMER, SLUDGE, POUND, POISON_GAS, DISABLE
	db GASTLY, HYPNOSIS, NIGHT_SHADE, CONFUSE_RAY, LICK
	db VOLTORB, SWIFT, SELFDESTRUCT, LIGHT_SCREEN, SCREECH
	db SANDSHREW, SLASH, POISON_STING, SAND_ATTACK, FURY_SWIPES
	db GROWLITHE, FLAMETHROWER, BITE, LEER, AGILITY
	db SEEL, AURORA_BEAM, HEADBUTT, REST, GROWL
	db SHELLDER, CLAMP, AURORA_BEAM, SUPERSONIC, WITHDRAW
	db EXEGGCUTE, SLEEP_POWDER, LEECH_SEED, BARRAGE, POISONPOWDER
	db EXEGGCUTE, SLEEP_POWDER, POISONPOWDER, LEECH_SEED, SOLARBEAM
	db EEVEE, BITE, QUICK_ATTACK, TAIL_WHIP, SAND_ATTACK
	db TENTACOOL, WATER_GUN, ACID, SUPERSONIC, SCREECH
	db DROWZEE, CONFUSION, HEADBUTT, DISABLE, HYPNOSIS
	db GOLDEEN, WATERFALL, HORN_DRILL, SUPERSONIC, TAIL_WHIP
	db STARYU, WATER_GUN, SWIFT, HARDEN, MINIMIZE
	db FARFETCH_D, SLASH, PECK, SWORDS_DANCE, LEER
	db KOFFING, SLUDGE, SMOKESCREEN, SELFDESTRUCT, TACKLE
	db KRABBY, STOMP, GUILLOTINE, BUBBLE, HARDEN
	db MUNCHLAX, BODY_SLAM, CRUNCH, LICK, METRONOME
	db MIME_JR, MEGA_PUNCH, CONFUSION, DAZZLINGLEAM, REFLECT
	db ELEKID, THUNDERPUNCH, QUICK_ATTACK, LOW_KICK, THUNDER_WAVE
	db MAGBY, FIRE_PUNCH, SMOG, SMOKESCREEN, CONFUSE_RAY
	db SMOOCHUM, ICE_PUNCH, LOVELY_KISS, LICK, POUND
	db SHUPPET, CONFUSE_RAY, SUCKER_PUNCH, DAZZLINGLEAM, SCREECH
	db GOLETT, SHADOW_PUNCH, MEGA_PUNCH, DEFENSE_CURL, POUND
	db INKAY, SLASH, PSYBEAM, REFLECT, HYPNOSIS
	db MIENFOO, DOUBLESLAP, MEDITATE, SWIFT, JUMP_KICK
	db DRILBUR, DIG, FURY_SWIPES, SCRATCH, SEISMIC_TOSS
	db NUMEL, ROCK_SLIDE, EMBER, GROWL, TAKE_DOWN
	db WAILMER, SURF, BODY_SLAM, SPLASH, GROWL
	db SKORUPI, LEER, PIN_MISSILE, NIGHT_SLASH, POISON_STING
	db CROAGUNK, SLUDGE_WAVE, TOXIC, COUNTER, MIMIC
	db PHANPY, BODY_SLAM, ROCK_SLIDE, TACKLE, GROWL
	db FLABEBE, SWIFT, DAZZLINGLEAM, DOUBLE_TEAM, REFLECT
	db KLINK, THUNDERBOLT, GEAR_GRIND, SCREECH, METAL_SOUND
	db LITWICK, WILL_O_WISP, NIGHT_SHADE, OMINOUS_WIND, PSYCHIC
	db SWINUB, ICE_SHARD, TACKLE, ANCIENTPOWER, EARTHQUAKE
	db JOLTIK, THUNDER_WAVE, SLASH, LEECH_LIFE, STRING_SHOT
	db SNOVER, RAZOR_LEAF, ICE_SHARD, LEER, TOXIC
	db SHELLOS, SURF, RECOVER, HARDEN, REST

MonClass3:
	db 56
	db JIGGLYPUFF, BODY_SLAM, SING, DISABLE, DEFENSE_CURL
	db FLABEBE, SWIFT, DAZZLINGLEAM, DOUBLE_TEAM, REFLECT
	db SPEAROW, DRILL_PECK, MIRROR_MOVE, GROWL, LEER
	db CHARMANDER, FLAMETHROWER, SLASH, GROWL, LEER
	db SQUIRTLE, SURF, BITE, WITHDRAW, TAIL_WHIP
	db BULBASAUR, RAZOR_LEAF, GIGA_DRAIN, SLEEP_POWDER, POISONPOWDER
	db CLEFAIRY, METRONOME, BODY_SLAM, SING, MINIMIZE
	db PIKACHU, THUNDERBOLT, SLAM, THUNDER_WAVE, TAIL_WHIP
	db DIGLETT, SLASH, DIG, SAND_ATTACK, DOUBLE_TEAM
	db MAGNEMITE, THUNDERBOLT, SWIFT, SUPERSONIC, LIGHT_SCREEN
	db KLINK, THUNDERBOLT, GEAR_GRIND, SCREECH, METAL_SOUND
	db KRABBY, CRABHAMMER, GUILLOTINE, BUBBLEBEAM, HARDEN
	db KOFFING, SLUDGE, SMOKESCREEN, SELFDESTRUCT, TACKLE
	db OMANYTE, SPIKE_CANNON, BUBBLEBEAM, HORN_ATTACK, LEER
	db KABUTO, SLASH, BUBBLEBEAM, ABSORB, LEER
	db TYRUNT, ROCK_SLIDE, CRUNCH, TACKLE, TAIL_WHIP
	db AMAURA, THUNDER_WAVE, AURORA_BEAM, MIST, ANCIENTPOWER
	db BUTTERFREE, CONFUSION, SLEEP_POWDER, POISONPOWDER, GUST
	db BEEDRILL, TWINEEDLE, SWIFT, TOXIC, OMINOUS_WIND
	db NIDORINA, POISON_STING, BITE, DOUBLE_KICK, TAIL_WHIP
	db NIDORINO, POISON_STING, HORN_ATTACK, DOUBLE_KICK, PECK
	db LICKITUNG, SLAM, STOMP, SCREECH, DISABLE
	db PORYGON, RECOVER, PSYBEAM, REFLECT, MIMIC
	db RHYHORN, HORN_DRILL, HORN_ATTACK, STOMP, LEER
	db GROWLITHE, FLAMETHROWER, TAKE_DOWN, DOUBLE_TEAM, LEER
	db GASTLY, HYPNOSIS, NIGHT_SHADE, CONFUSE_RAY, LICK
	db LITWICK, WILL_O_WISP, NIGHT_SHADE, OMINOUS_WIND, PSYCHIC
	db MAREEP, THUNDER_WAVE, THUNDERBOLT, LIGHT_SCREEN, TACKLE
	db KOFFING, SLUDGE, SMOKESCREEN, SELFDESTRUCT, TOXIC
	db STARYU, BUBBLEBEAM, SWIFT, RECOVER, MINIMIZE
	db SLOWPOKE, CONFUSION, HEADBUTT, AMNESIA, WATER_GUN
	db DODUO, DRILL_PECK, FURY_ATTACK, GROWL, DOUBLE_TEAM
	db FARFETCH_D, SLASH, PECK, SWORDS_DANCE, LEER
	db MACHOP, KARATE_CHOP, SUBMISSION, LEER, DOUBLE_TEAM
	db EEVEE, BODY_SLAM, SWIFT, TAIL_WHIP, SAND_ATTACK
	db EXEGGCUTE, SLEEP_POWDER, POISONPOWDER, LEECH_SEED, SOLARBEAM
	db TRAPINCH, CRUNCH, DIG, SAND_ATTACK, RAZOR_WIND
	db CACNEA, PIN_MISSILE, SAND_ATTACK, GIGA_DRAIN, POISON_STING
	db MIME_JR, MEGA_PUNCH, CONFUSION, DAZZLINGLEAM, REFLECT
	db ELEKID, THUNDERPUNCH, QUICK_ATTACK, LOW_KICK, THUNDER_WAVE
	db MAGBY, FIRE_PUNCH, SMOG, SMOKESCREEN, CONFUSE_RAY
	db SMOOCHUM, ICE_PUNCH, LOVELY_KISS, LICK, POUND
	db SHUPPET, CONFUSE_RAY, SUCKER_PUNCH, DAZZLINGLEAM, SCREECH
	db GOLETT, SHADOW_PUNCH, MEGA_PUNCH, DEFENSE_CURL, POUND
	db INKAY, SLASH, PSYBEAM, REFLECT, HYPNOSIS
	db MIENFOO, DOUBLESLAP, MEDITATE, SWIFT, JUMP_KICK
	db DRILBUR, DIG, FURY_SWIPES, SCRATCH, SEISMIC_TOSS
	db NUMEL, ROCK_SLIDE, EMBER, GROWL, TAKE_DOWN
	db WAILMER, SURF, BODY_SLAM, SPLASH, GROWL
	db SKORUPI, LEER, PIN_MISSILE, NIGHT_SLASH, POISON_STING
	db CROAGUNK, SLUDGE_WAVE, TOXIC, COUNTER, MIMIC
	db PHANPY, BODY_SLAM, ROCK_SLIDE, TACKLE, GROWL
	db MUNCHLAX, BODY_SLAM, CRUNCH, LICK, METRONOME
	db SNOVER, RAZOR_LEAF, ICE_SHARD, LEER, TOXIC
	db SHELLOS, SURF, RECOVER, HARDEN, REST
	db HORSEA, DRAGON_PULSE, WATER_GUN, AGILITY, DOUBLE_TEAM

MonClass4:
	db 43
	db BUTTERFREE, PSYBEAM, SLEEP_POWDER, POISONPOWDER, GUST
	db BEEDRILL, X_SCISSOR, AGILITY, STRING_SHOT, FURY_ATTACK
	db LICKITUNG, BODY_SLAM, TAKE_DOWN, STOMP, DISABLE
	db PORYGON, RECOVER, PSYBEAM, TRI_ATTACK, MIMIC
	db SLOWPOKE, CONFUSION, HEADBUTT, AMNESIA, WATER_GUN
	db RHYHORN, HORN_DRILL, HORN_ATTACK, STOMP, LEER
	db GLOOM, PETAL_DANCE, ACID, SLEEP_POWDER, POISONPOWDER
	db IVYSAUR, RAZOR_LEAF, SLEEP_POWDER, GROWTH, LEECH_SEED
	db CHARMELEON, FLAMETHROWER, SLASH, LEER, DOUBLE_TEAM
	db WARTORTLE, SURF, BODY_SLAM, WITHDRAW, SKULL_BASH
	db KADABRA, PSYBEAM, RECOVER, DISABLE, CONFUSION
	db POLIWHIRL, SURF, MEGA_PUNCH, AMNESIA, HYPNOSIS
	db ONIX, SLAM, ROCK_SLIDE, HARDEN, SCREECH
	db MR_MIME, CONFUSION, LIGHT_SCREEN, BARRIER, SUBSTITUTE
	db JYNX, ICE_PUNCH, LICK, LOVELY_KISS, DOUBLE_TEAM
	db RATICATE, HYPER_FANG, QUICK_ATTACK, TAIL_WHIP, SUPER_FANG
	db PARASECT, SLASH, SPORE, LEECH_LIFE, STUN_SPORE
	db MACHOKE, KARATE_CHOP, SUBMISSION, LEER, DOUBLE_TEAM
	db WEEPINBELL, SLAM, RAZOR_LEAF, ACID, WRAP
	db WEEPINBELL, RAZOR_LEAF, STUN_SPORE, SLEEP_POWDER, POISONPOWDER
	db GRAVELER, ROCK_THROW, EARTHQUAKE, HARDEN, SELFDESTRUCT
	db PONYTA, TAKE_DOWN, EMBER, STOMP, DOUBLE_TEAM
	db MAROWAK, BONEMERANG, HEADBUTT, LEER, COUNTER
	db HITMONLEE, DOUBLE_KICK, JUMP_KICK, TAKE_DOWN, MEDITATE
	db HITMONCHAN, COMET_PUNCH, MEGA_PUNCH, DOUBLE_TEAM, COUNTER
	db HITMONCHAN, THUNDERPUNCH, FIRE_PUNCH, ICE_PUNCH, COMET_PUNCH
	db HITMONTOP, DIG, QUICK_ATTACK, COUNTER, MEGA_KICK
	db WIGGLYTUFF, BODY_SLAM, SING, DISABLE, MIMIC
	db OMANYTE, SPIKE_CANNON, BUBBLEBEAM, HORN_ATTACK, LEER
	db KABUTO, SLASH, BUBBLEBEAM, ABSORB, LEER
	db TYRUNT, ROCK_SLIDE, CRUNCH, TACKLE, TAIL_WHIP
	db AMAURA, THUNDER_WAVE, AURORA_BEAM, MIST, ANCIENTPOWER
	db PIDGEOTTO, WING_ATTACK, FLY, QUICK_ATTACK, SAND_ATTACK
	db PIDGEOTTO, WING_ATTACK, FLY, QUICK_ATTACK, DOUBLE_TEAM
	db DODUO, DRILL_PECK, TRI_ATTACK, DOUBLE_TEAM, FLY
	db GASTLY, HYPNOSIS, NIGHT_SHADE, CONFUSE_RAY, DREAM_EATER
	db LITWICK, WILL_O_WISP, NIGHT_SHADE, OMINOUS_WIND, PSYCHIC
	db GRIMER, SLUDGE, ACID_ARMOR, TOXIC, BODY_SLAM	
	db GRIMER, SLUDGE, ACID_ARMOR, TOXIC, EXPLOSION
	db KRABBY, SURF, CRABHAMMER, STOMP, GUILLOTINE
	db FLAAFFY, THUNDERBOLT, CONFUSE_RAY, GROWL, LIGHT_SCREEN
	db VIBRAVA, BUG_BUZZ, SCREECH, SUPERSONIC, CRUNCH
	db FLOETTE, SWIFT, DAZZLINGLEAM, REFLECT, MIMIC

MonClass5:
	db 43
	db POLIWHIRL, SURF, MEGA_PUNCH, AMNESIA, HYPNOSIS
	db JYNX, ICE_PUNCH, LICK, LOVELY_KISS, THRASH
	db IVYSAUR, RAZOR_LEAF, SLEEP_POWDER, GROWTH, GIGA_DRAIN
	db CHARMELEON, FLAMETHROWER, SLASH, LEER, DOUBLE_TEAM
	db WARTORTLE, SURF, BODY_SLAM, WITHDRAW, SKULL_BASH
	db RATICATE, HYPER_FANG, QUICK_ATTACK, TAIL_WHIP, SUPER_FANG
	db PARASECT, SLASH, SPORE, LEECH_LIFE, STUN_SPORE
	db BRELOOM, DRAIN_PUNCH, GIGA_DRAIN, TAKE_DOWN, LEECH_SEED
	db MACHOKE, KARATE_CHOP, SUBMISSION, LEER, DOUBLE_TEAM
	db WEEPINBELL, SLAM, RAZOR_LEAF, ACID, WRAP
	db WEEPINBELL, RAZOR_LEAF, STUN_SPORE, SLEEP_POWDER, POISONPOWDER
	db GRAVELER, ROCK_THROW, EARTHQUAKE, HARDEN, SELFDESTRUCT
	db BOLDORE, ROCK_THROW, EARTHQUAKE, SAND_ATTACK, HEADBUTT
	db PONYTA, TAKE_DOWN, EMBER, STOMP, DOUBLE_TEAM
	db MAROWAK, BONEMERANG, HEADBUTT, LEER, COUNTER
	db HITMONLEE, DOUBLE_KICK, JUMP_KICK, TAKE_DOWN, MEDITATE
	db HITMONCHAN, COMET_PUNCH, MEGA_PUNCH, DOUBLE_TEAM, COUNTER
	db HITMONCHAN, THUNDERPUNCH, FIRE_PUNCH, ICE_PUNCH, COMET_PUNCH
	db HITMONTOP, DIG, QUICK_ATTACK, COUNTER, MEGA_KICK
	db WIGGLYTUFF, BODY_SLAM, SING, DISABLE, MIMIC
	db HAUNTER, HYPNOSIS, CONFUSE_RAY, NIGHT_SHADE, DREAM_EATER
	db HAUNTER, TOXIC, GIGA_DRAIN, HYPNOSIS, NIGHT_SHADE
	db LAMPENT, WILL_O_WISP, PSYCHIC, NIGHT_SHADE, TOXIC
	db DRAGONAIR, DRAGON_RAGE, SLAM, THUNDER_WAVE, TAKE_DOWN
	db ZWEILOUS, DRAGON_RAGE, BITE, DRAGON_RUSH, MIMIC
	db DUGTRIO, EARTHQUAKE, SLASH, SAND_ATTACK, DOUBLE_TEAM
	db DUGTRIO, DIG, SLASH, SAND_ATTACK, DOUBLE_TEAM
	db ARBOK, ACID, GLARE, TAKE_DOWN, SCREECH
	db VENOMOTH, PSYWAVE, POISONPOWDER, LEECH_LIFE, SLEEP_POWDER
	db VENOMOTH, TOXIC, CONFUSION, LEECH_LIFE, SUPERSONIC
	db PERSIAN, SLASH, SCREECH, SWIFT, DOUBLE_TEAM
	db LIEPARD, FURY_SWIPES, PLAY_ROUGH, PAY_DAY, DOUBLE_TEAM
	db FEAROW, DRILL_PECK, FLY, MIRROR_MOVE, DOUBLE_TEAM
	db CLEFABLE, METRONOME, MOONBLAST, SUBSTITUTE, SING 
	db PRIMEAPE, THRASH, SEISMIC_TOSS, SCREECH, COUNTER
	db SEAKING, WATERFALL, HORN_DRILL, SUPERSONIC, FURY_ATTACK
	db GOLBAT, WING_ATTACK, CONFUSE_RAY, TOXIC, BITE
	db VILEPLUME, PETAL_DANCE, POISONPOWDER, GIGA_DRAIN, ACID
	db BELLOSSOM, ACID, STUN_SPORE, LEAF_BLADE, DRAIN_PUNCH
	db PANGORO, CRUNCH, LEER, CUT, COMET_PUNCH
	db FLAAFFY, THUNDERBOLT, CONFUSE_RAY, GROWL, LIGHT_SCREEN
	db VIBRAVA, BUG_BUZZ, SCREECH, SUPERSONIC, CRUNCH
	db FLOETTE, SWIFT, DAZZLINGLEAM, REFLECT, MIMIC


MonClass6:
	db 55
	db SLOWBRO, BUBBLEBEAM, HEADBUTT, AMNESIA, DISABLE
	db SLOWKING, CONFUSION, HEADBUTT, AMNESIA, DISABLE
	db RAICHU, THUNDERBOLT, SWIFT, DOUBLE_TEAM, FLASH
	db MAGNETON, THUNDERBOLT, THUNDER_WAVE, SUPERSONIC, SCREECH
	db KLANG, SHIFT_GEAR, METAL_SOUND, THUNDERBOLT, VICEGRIP
	db TANGELA, GIGA_DRAIN, SLEEP_POWDER, SLAM, GROWTH
	db TANGELA, GIGA_DRAIN, POISONPOWDER, SLAM, GROWTH
	db TANGELA, GIGA_DRAIN, STUN_SPORE, SLAM, GROWTH
	db SEADRA, SURF, SWIFT, DOUBLE_TEAM, SMOKESCREEN
	db ELECTABUZZ, THUNDERPUNCH, MEGA_PUNCH, LIGHT_SCREEN, SCREECH
	db MAGMAR, FLAMETHROWER, SMOG, SMOKESCREEN, CONFUSE_RAY
	db PIDGEOT, WING_ATTACK, QUICK_ATTACK, DOUBLE_TEAM, SAND_ATTACK
	db PIDGEOT, FLY, QUICK_ATTACK, MIRROR_MOVE, SAND_ATTACK
	db DODRIO, DRILL_PECK, TRI_ATTACK, DOUBLE_TEAM, GROWL
	db MUK, SLUDGE, TOXIC, ACID_ARMOR, MINIMIZE
	db MUK, BODY_SLAM, TOXIC, ACID_ARMOR, MINIMIZE
	db ELECTRODE, THUNDERBOLT, SWIFT, LIGHT_SCREEN, EXPLOSION
	db ELECTRODE, SWIFT, THUNDER_WAVE, LIGHT_SCREEN, EXPLOSION
	db SANDSLASH, SLASH, ROCK_SLIDE, POISON_STING, SAND_ATTACK
	db SANDSLASH, DIG, ROCK_SLIDE, POISON_STING, SAND_ATTACK
	db GOLDUCK, SURF, CONFUSION, DISABLE, SWIFT
	db ALAKAZAM, PSYBEAM, RECOVER, REFLECT, DISABLE
	db DEWGONG, AURORA_BEAM, TAKE_DOWN, REST, GROWL
	db NIDOQUEEN, BODY_SLAM, DOUBLE_KICK, POISON_STING, GROWL
	db NIDOKING, THRASH, DOUBLE_KICK, POISON_STING, TOXIC
	db VENOMOTH, PSYWAVE, POISONPOWDER, BUG_BUZZ, SLEEP_POWDER
	db VENOMOTH, TOXIC, PSYWAVE, BUG_BUZZ, SUPERSONIC
	db PERSIAN, SLASH, SCREECH, SWIFT, DOUBLE_TEAM
	db FEAROW, DRILL_PECK, DRILL_RUN, MIRROR_MOVE, DOUBLE_TEAM
	db CLEFABLE, METRONOME, DAZZLINGLEAM, SUBSTITUTE, SING 
	db PRIMEAPE, THRASH, CROSS_CHOP, SCREECH, COUNTER
	db SEAKING, WATERFALL, MEGAHORN, SUPERSONIC, FURY_ATTACK
	db GOLBAT, WING_ATTACK, CONFUSE_RAY, TOXIC, BITE
	db VILEPLUME, PETAL_DANCE, POISONPOWDER, GIGA_DRAIN, ACID
	db BELLOSSOM, ACID, STUN_SPORE, LEAF_BLADE, DRAIN_PUNCH
	db DUGTRIO, EARTHQUAKE, SLASH, SAND_ATTACK, DOUBLE_TEAM
	db DUGTRIO, DIG, SLASH, SAND_ATTACK, DOUBLE_TEAM
	db PANGORO, CRUNCH, KARATE_CHOP, LEER, SUBSTITUTE
	db GALVANTULA, THUNDER, SLASH, DOUBLE_TEAM, LEECH_LIFE
	db LIEPARD, THUNDER_WAVE, SUCKER_PUNCH, SWIFT, TOXIC
	db PILOSWINE, EARTHQUAKE, ANCIENTPOWER, TAKE_DOWN, ICE_SHARD
	db WAILORD, SURF, BODY_SLAM, SUBSTITUTE, TOXIC
	db CAMERUPT, ROCK_SLIDE, EMBER, TAKE_DOWN, BODY_SLAM
	db ABOMASNOW, GIGA_DRAIN, COUNTER, BODY_SLAM, MIST
	db ABOMASNOW, ICE_PUNCH, COUNTER, BODY_SLAM, MIST
	db GOLURK, SHADOW_PUNCH, DOUBLE_TEAM, ICE_BEAM, MEGA_PUNCH
	db BANETTE, WILL_O_WISP, OMINOUS_WIND, DOUBLE_TEAM, TOXIC
	db CACTURNE, REFLECT, LEECH_SEED, PIN_MISSILE, GIGA_DRAIN
	db SIGILYPH, OMINOUS_WIND, AIR_SLASH, PSYBEAM, MIMIC
	db SPIRITOMB, AMNESIA, DARK_PULSE, PSYCHIC, OMINOUS_WIND
	db BRELOOM, DRAIN_PUNCH, GIGA_DRAIN, TAKE_DOWN, LEECH_SEED
	db MALAMAR, SLASH, NIGHT_SLASH, REFLECT, LIGHT_SCREEN
	db TROPIUS, RAZOR_LEAF, OMINOUS_WIND, STOMP, GUST
	db DRUDDIGON, DRAGON_RAGE, SLASH, CRUNCH, SCRATCH
	db GASTRODON, EARTHQUAKE, REST, ICE_BEAM, WATER_GUN

MonClass7:
	db 81
	db RAICHU, THUNDERBOLT, SURF, DOUBLE_TEAM, REFLECT
	db POLIWRATH, HYDRO_PUMP, POISON_JAB, HYPNOSIS, SUBMISSION
	db POLITOED, HYDRO_PUMP, BLIZZARD, PSYCHIC, HYPNOSIS
	db HYPNO, PSYCHIC_M, AMNESIA, DAZZLINGLEAM, THUNDER_WAVE
	db KANGASKHAN, DOUBLE_EDGE, DRAIN_PUNCH, LEER, EARTHQUAKE
	db KANGASKHAN, BODY_SLAM, EARTHQUAKE, DRAIN_PUNCH, BLIZZARD
	db CHANSEY, THUNDERBOLT, ICE_BEAM, SOFTBOILED, REFLECT
	db CHANSEY, SEISMIC_TOSS, THUNDER_WAVE, SOFTBOILED, BLIZZARD
	db MACHAMP, CROSS_CHOP, KARATE_CHOP, EARTHQUAKE, ROCK_SLIDE
	db VICTREEBEL, SWORDS_DANCE, LEAF_BLADE, HYPER_BEAM, SLEEP_POWDER
	db VICTREEBEL, HYPER_BEAM, LEAF_BLADE, WRAP, TOXIC
	db GOLEM, EARTHQUAKE, STONE_EDGE, EXPLOSION, BODY_SLAM
	db GIGALITH, STONE_EDGE, EARTHQUAKE, BODY_SLAM, HYPER_BEAM
	db RAPIDASH, FIRE_BLAST, MEGAHORN, POISON_JAB, FIRE_SPIN
	db WEEZING, SLUDGE_WAVE, FIRE_BLAST, THUNDERBOLT, EXPLOSION
	db TOXICROAK, DRAIN_PUNCH, SLUDGE_WAVE, AMNESIA, SUCKER_PUNCH
	db DRAPION, SWORDS_DANCE, POISON_JAB, X_SCISSOR, SUBMISSION 
	db SCYTHER, X_SCISSOR, NIGHT_SLASH, AIR_SLASH, SLASH
	db NINETALES, FIRE_BLAST, AMNESIA, DARK_PULSE, CONFUSE_RAY
	db VENUSAUR, TOXIC, LEECH_SEED, SLEEP_POWDER, RAZOR_LEAF
	db VENUSAUR, RAZOR_LEAF, SLEEP_POWDER, BODY_SLAM, SWORDS_DANCE
	db CHARIZARD, FIRE_BLAST, SWORDS_DANCE, EARTHQUAKE, OMINOUS_WIND
	db CHARIZARD, SWORDS_DANCE, AIR_SLASH, EARTHQUAKE, STEEL_WING
	db BLASTOISE, HYDRO_PUMP, EARTHQUAKE, BLIZZARD, FLASH_CANNON
	db BLASTOISE, BLIZZARD, HYDRO_PUMP, MIMIC, TOXIC
	db GENGAR, HYPNOSIS, DREAM_EATER, THUNDERBOLT, GIGA_DRAIN
	db GENGAR, EXPLOSION, THUNDERBOLT, SHADOW_PUNCH, GIGA_DRAIN
	db KINGLER, CRABHAMMER, SWORDS_DANCE, MUD_SHOT, X_SCISSOR
	db KABUTOPS, NIGHT_SLASH, SLASH, HYDRO_PUMP, ANCIENTPOWER
	db OMASTAR, HYDRO_PUMP, ICE_BEAM, BITE, ANCIENTPOWER
	db TYRANTRUM, CRUNCH, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM
	db AURORUS, THUNDER_WAVE, ANCIENTPOWER, THUNDERBOLT, BLIZZARD
	db PINSIR, SLASH, SWORDS_DANCE, SEISMIC_TOSS, HARDEN
	db MAGMAR, FLAMETHROWER, PSYCHIC, FIRE_SPIN, SUBMISSION
	db ELECTABUZZ, THUNDERBOLT, PSYCHIC, LOW_KICK, THUNDER_WAVE
	db JYNX, LOVELY_KISS, PSYCHIC, BLIZZARD, DRAININGKISS
	db PIDGEOT, HURRICANE, HEAT_WAVE, DOUBLE_EDGE, OMINOUS_WIND
	db PIDGEOT, HURRICANE, HYPER_BEAM, MIRROR_MOVE, HEAT_WAVE
	db DODRIO, DRILL_PECK, BODY_SLAM, STEEL_WING, HYPER_BEAM
	db SKARMORY, SWORDS_DANCE, STEEL_WING, AIR_SLASH, OMINOUS_WIND
	db MUK, FIRE_BLAST, SLUDGE_WAVE, THUNDERBOLT, DARK_PULSE
	db ELECTRODE, THUNDERBOLT, SWIFT, LIGHT_SCREEN, EXPLOSION
	db PERSIAN, BUBBLEBEAM, SLASH, PLAY_ROUGH, AMNESIA
	db PERSIAN, SLASH, NIGHT_SLASH, DOUBLE_EDGE, BUBBLEBEAM
	db SANDSLASH, SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM
	db GOLDUCK, HYDRO_PUMP, PSYCHIC, AMNESIA, BLIZZARD
	db ALAKAZAM, PSYCHIC, RECOVER, REFLECT, DAZZLINGLEAM
	db DEWGONG, ICE_BEAM, BLIZZARD, AQUA_JET, BODY_SLAM
	db NIDOQUEEN, EARTHQUAKE, BLIZZARD, SUPERPOWER, POISON_JAB
	db NIDOQUEEN, FIRE_BLAST, BLIZZARD, EARTHQUAKE, POISON_JAB
	db NIDOKING, BLIZZARD, POISON_JAB, MEGAHORN, EARTHQUAKE
	db NIDOKING, EARTHQUAKE, THUNDERBOLT, BLIZZARD, POISON_JAB
	db EXCADRILL, DRILL_RUN, SLASH, ROCK_SLIDE, X_SCISSOR
	db EXCADRILL, SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, X_SCISSOR
	db DUGTRIO, NIGHT_SLASH, SLASH, EARTHQUAKE, ROCK_SLIDE
	db DUGTRIO, SAND_TOMB, SLASH, NIGHT_SLASH, ROCK_SLIDE
	db FLORGES, MOONBLAST, GIGA_DRAIN, PSYCHIC, REFLECT
	db PINSIR, SLASH, SWORDS_DANCE, X_SCISSOR, SUPERPOWER
	db CLEFABLE, COSMIC_POWER, MOONBLAST, BLIZZARD, FIRE_BLAST
	db MAGNEZONE, THUNDERBOLT, FLASH_CANNON, THUNDER_WAVE, METAL_SOUND
	db KLINKLANG, THUNDERBOLT, THUNDER_WAVE, SHIFT_GEAR, GEAR_GRIND
	db SIGILYPH, ICE_BEAM, COSMIC_POWER, PSYCHIC, DARK_PULSE
	db SIGILYPH, THUNDER_WAVE, AIR_SLASH, PSYCHIC, DARK_PULSE
	db WAILORD, AMNESIA, SURF, BLIZZARD, EARTHQUAKE
	db CAMERUPT, AMNESIA, EARTHQUAKE, FIRE_BLAST, ROCK_SLIDE
	db HITMONLEE, MEDITATE, HI_JUMP_KICK, POISON_JAB, BODY_SLAM
	db DRUDDIGON, SLASH, NIGHT_SLASH, SUPERPOWER, EARTHQUAKE
	db TANGROWTH, SWORDS_DANCE, POISON_JAB, POWER_WHIP, EARTHQUAKE
	db STEELIX, EARTHQUAKE, STONE_EDGE, ROCK_POLISH, BODY_SLAM
	db CROBAT, X_SCISSOR, AIR_SLASH, HEAT_WAVE, GIGA_DRAIN
	db GALVANTULA, THUNDERBOLT, BUG_BUZZ, GIGA_DRAIN, THUNDER_WAVE
	db LIEPARD, AMNESIA, DARK_PULSE, PLAY_ROUGH, THUNDER_WAVE
	db ABOMASNOW, BLIZZARD, WOOD_HAMMER, EARTHQUAKE, SWORDS_DANCE
	db GOLURK, SHADOW_PUNCH, EARTHQUAKE, ICE_BEAM, ROCK_SLIDE
	db BANETTE, WILL_O_WISP, OMINOUS_WIND, THUNDERBOLT, SUCKER_PUNCH
	db CACTURNE, SUCKER_PUNCH, SWORDS_DANCE, POISON_JAB, GIGA_DRAIN
	db SPIRITOMB, AMNESIA, DARK_PULSE, PSYCHIC, OMINOUS_WIND
	db PORYGON2, ZAP_CANNON, RECOVER, BLIZZARD, TRI_ATTACK
	db TROPIUS, LEAF_BLADE, SWORDS_DANCE, EARTHQUAKE, AIR_SLASH
	db MALAMAR, SLASH, NIGHT_SLASH, PSYCHO_CUT, LIGHT_SCREEN
	db SKARMORY, SWORDS_DANCE, STEEL_WING, AIR_SLASH, OMINOUS_WIND

MonClass8:
	db 70
	db RAICHU, THUNDERBOLT, SURF, DOUBLE_TEAM, REFLECT
	db VAPOREON, SURF, BLIZZARD, ACID_ARMOR, REST
	db JOLTEON, THUNDERBOLT, PIN_MISSILE, DOUBLE_KICK, DOUBLE_TEAM
	db FLAREON, FIRE_BLAST, DOUBLE_EDGE, DOUBLE_TEAM, BODY_SLAM
	db ESPEON, PSYCHIC, REFLECT, RECOVER, DAZZLINGLEAM
	db UMBREON, TOXIC, DOUBLE_TEAM, MOONLIGHT, DARK_PULSE
	db UMBREON, BODY_SLAM, DOUBLE_TEAM, CONFUSE_RAY, DARK_PULSE
	db LEAFEON, X_SCISSOR, BODY_SLAM, LEAF_BLADE, SYNTHESIS
	db GLACEON, BITE, ICE_SHARD, BLIZZARD, BUBBLEBEAM
	db SYLVEON, MOONBLAST, PSYCHIC, REFLECT, BITE
	db KABUTOPS, NIGHT_SLASH, SLASH, HYDRO_PUMP, ANCIENTPOWER
	db OMASTAR, HYDRO_PUMP, ICE_BEAM, BITE, ANCIENTPOWER
	db TYRANTRUM, CRUNCH, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM
	db AURORUS, THUNDER_WAVE, ANCIENTPOWER, THUNDERBOLT, BLIZZARD
	db SNORLAX, REST, BLIZZARD, AMNESIA, DOUBLE_EDGE
	db TENTACRUEL, HYDRO_PUMP, DAZZLINGLEAM, SWORDS_DANCE, POISON_JAB
	db STARMIE, SURF, ICE_BEAM, RECOVER, REFLECT
	db STARMIE, THUNDER_WAVE, PSYCHIC_M, THUNDERBOLT, RECOVER
	db RHYDON, DRILL_RUN, ROCK_SLIDE, POISON_JAB, FIRE_BLAST
	db RHYDON, MEGAHORN, ROCK_SLIDE, EARTHQUAKE, SWORDS_DANCE
	db AERODACTYL, WING_ATTACK, ANCIENTPOWER, OMINOUS_WIND, FIRE_BLAST
	db TAUROS, BODY_SLAM, HYPER_BEAM, EARTHQUAKE, BLIZZARD
	db LAPRAS, SURF, ICE_BEAM, CONFUSE_RAY, BODY_SLAM
	db ARCANINE, TAKE_DOWN, FIRE_BLAST, SWIFT, LEER
	db NINETALES, FIRE_BLAST, AMNESIA, DARK_PULSE, CONFUSE_RAY
	db SANDSLASH, SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM
	db POLIWRATH, HYDRO_PUMP, POISON_JAB, HYPNOSIS, SUBMISSION
	db POLITOED, HYDRO_PUMP, BLIZZARD, PSYCHIC, HYPNOSIS
	db EXEGGUTOR, GIGA_DRAIN, HYPNOSIS, PSYCHIC, REFLECT
	db CLOYSTER, BLIZZARD, SURF, MIMIC, POISON_JAB
	db GYARADOS, HYDRO_PUMP, THUNDERBOLT, BODY_SLAM, FIRE_BLAST
	db WEEZING, SLUDGE_WAVE, THUNDERBOLT, FIRE_BLAST, EXPLOSION
	db SCYTHER, OMINOUS_WIND, SWORDS_DANCE, AIR_SLASH, X_SCISSOR
	db VENUSAUR, TOXIC, LEECH_SEED, SLEEP_POWDER, RAZOR_LEAF
	db VENUSAUR, RAZOR_LEAF, SLEEP_POWDER, BODY_SLAM, SWORDS_DANCE
	db CHARIZARD, FIRE_BLAST, SWORDS_DANCE, EARTHQUAKE, OMINOUS_WIND
	db CHARIZARD, SWORDS_DANCE, AIR_SLASH, EARTHQUAKE, STEEL_WING
	db BLASTOISE, HYDRO_PUMP, EARTHQUAKE, BLIZZARD, FLASH_CANNON
	db BLASTOISE, BLIZZARD, HYDRO_PUMP, MIMIC, TOXIC
	db GENGAR, HYPNOSIS, DREAM_EATER, THUNDERBOLT, GIGA_DRAIN
	db GENGAR, EXPLOSION, THUNDERBOLT, SHADOW_PUNCH, GIGA_DRAIN
	db KINGLER, CRABHAMMER, SWORDS_DANCE, MUD_SHOT, X_SCISSOR
	db PINSIR, SLASH, SWORDS_DANCE, X_SCISSOR, SUPERPOWER
	db CHANSEY, THUNDERBOLT, ICE_BEAM, SOFTBOILED, REFLECT
	db CHANSEY, SEISMIC_TOSS, THUNDER_WAVE, SOFTBOILED, BLIZZARD
	db DEWGONG, BLIZZARD, SURF, ICE_SHARD, TOXIC
	db FLORGES, MOONBLAST, GIGA_DRAIN, PSYCHIC, REFLECT
	db MIENSHAO, SWORDS_DANCE, POISON_JAB, ROCK_SLIDE, HI_JUMP_KICK
	db EXCADRILL, DRILL_RUN, SLASH, ROCK_SLIDE, X_SCISSOR
	db EXCADRILL, SWORDS_DANCE, EARTHQUAKE, ROCK_SLIDE, X_SCISSOR
	db FLYGON, EARTHQUAKE, BUG_BUZZ, BOOMBURST, DRAGON_RUSH
	db FLYGON, FIRE_BLAST, SAND_TOMB, DRAGON_RUSH, BUG_BUZZ
	db MAGMORTAR, THUNDERBOLT, FIRE_BLAST, PSYCHIC, EARTHQUAKE
	db ELECTIVIRE, EARTHQUAKE, THUNDERBOLT, FIRE_PUNCH, ROCK_SLIDE
	db CHANDELURE, FIRE_BLAST, WILL_O_WISP, PSYCHIC, OMINOUS_WIND
	db MILTANK, RECOVER, BODY_SLAM, BLIZZARD, EARTHQUAKE
	db DONPHAN, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM, POISON_JAB
	db SKARMORY, SWORDS_DANCE, STEEL_WING, AIR_SLASH, OMINOUS_WIND
	db AMPHAROS, THUNDERBOLT, FIRE_PUNCH, DRAGON_PULSE, THUNDER_WAVE
	db KINGDRA, HYDRO_PUMP, ICE_BEAM, DRAGON_PULSE, HYPER_BEAM
	db LICKILICKY, SWORDS_DANCE, EARTHQUAKE, POWER_WHIP, BODY_SLAM
	db CROBAT, X_SCISSOR, AIR_SLASH, HEAT_WAVE, GIGA_DRAIN
	db ABOMASNOW, BLIZZARD, WOOD_HAMMER, EARTHQUAKE, SWORDS_DANCE
	db MAGNEZONE, THUNDERBOLT, FLASH_CANNON, THUNDER_WAVE, METAL_SOUND
	db KLINKLANG, THUNDERBOLT, THUNDER_WAVE, SHIFT_GEAR, GEAR_GRIND
	db TOXICROAK, DRAIN_PUNCH, SLUDGE_WAVE, AMNESIA, SUCKER_PUNCH
	db DRAPION, SWORDS_DANCE, POISON_JAB, X_SCISSOR, SUBMISSION
	db CLEFABLE, COSMIC_POWER, MOONBLAST, BLIZZARD, FIRE_BLAST
	db PORYGON2, ZAP_CANNON, RECOVER, BLIZZARD, TRI_ATTACK
	db CRYOGONAL, BLIZZARD, NIGHT_SLASH, REFLECT, ACID_ARMOR
	
MonClass9:
	db 99
	db RAICHU, VOLT_TACKLE, SURF, DOUBLE_TEAM, REFLECT
	db DRAGONITE, HYPER_BEAM, DRAGON_RUSH, THUNDER_WAVE, BODY_SLAM
	db DRAGONITE, HURRICANE, HYPER_BEAM, WRAP, AGILITY
	db DRAGONITE, THUNDERBOLT, FIRE_BLAST, ICE_BEAM, DRAGON_RUSH
	db GYARADOS, HYPER_BEAM, HYDRO_PUMP, CRUNCH, DARK_PULSE
	db GYARADOS, HYPER_BEAM, HYDRO_PUMP, THUNDERBOLT, FIRE_BLAST
	db EXEGGUTOR, PSYCHIC_M, GIGA_DRAIN, REFLECT, LEECH_SEED
	db EXEGGUTOR, PSYCHIC_M, GIGA_DRAIN, LEECH_SEED, EXPLOSION
	db ARCANINE, CRUNCH, FIRE_BLAST, EXTREMESPEED, BODY_SLAM
	db NINETALES, AMNESIA, FIRE_BLAST, DARK_PULSE, WILL_O_WISP
	db SLOWBRO, AMNESIA, THUNDER_WAVE, SURF, PSYCHIC
	db SLOWKING, AMNESIA, THUNDER_WAVE, SURF, PSYCHIC
	db LAPRAS, HYDRO_PUMP, BLIZZARD, CONFUSE_RAY, BODY_SLAM
	db LAPRAS, THUNDERBOLT, BLIZZARD, THUNDER_WAVE, REST
	db TAUROS, BODY_SLAM, EARTHQUAKE, BLIZZARD, HYPER_BEAM
	db AERODACTYL, WING_ATTACK, ANCIENTPOWER, OMINOUS_WIND, IRON_HEAD
	db AERODACTYL, HYPER_BEAM, ANCIENTPOWER, FIRE_BLAST, WING_ATTACK
	db RHYPERIOR, DRILL_RUN, ROCK_WRECKER, MEGAHORN, POISON_JAB
	db RHYPERIOR, SWORDS_DANCE, ROCK_WRECKER, MEGAHORN, EARTHQUAKE
	db STARMIE, PSYCHIC, BLIZZARD, RECOVER, COSMIC_POWER
	db STARMIE, THUNDER_WAVE, CONFUSE_RAY, PSYCHIC, SURF
	db STARMIE, PSYCHIC_M, THUNDERBOLT, BLIZZARD, RECOVER
	db TENTACRUEL, SWORDS_DANCE, HYDRO_PUMP, POISON_JAB, DAZZLINGLEAM
	db TENTACRUEL, HYDRO_PUMP, WRAP, SWORDS_DANCE, BLIZZARD
	db SNORLAX, REST, EARTHQUAKE, BODY_SLAM, HYPER_BEAM
	db SNORLAX, BODY_SLAM, BLIZZARD, AMNESIA, REST
	db SNORLAX, DOUBLE_EDGE, EARTHQUAKE, REFLECT, REST
	db KABUTOPS, SWORDS_DANCE, ANCIENTPOWER, HYPER_BEAM, HYDRO_PUMP
	db KABUTOPS, SLASH, NIGHT_SLASH, ANCIENTPOWER, HYDRO_PUMP
	db OMASTAR, HYDRO_PUMP, ICE_BEAM, BITE, ANCIENTPOWER
	db TYRANTRUM, CRUNCH, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM
	db AURORUS, THUNDER_WAVE, ANCIENTPOWER, THUNDERBOLT, BLIZZARD
	db VAPOREON, HYDRO_PUMP, BLIZZARD, ACID_ARMOR, REST
	db JOLTEON, THUNDERBOLT, PIN_MISSILE, DOUBLE_KICK, DOUBLE_TEAM
	db FLAREON, FIRE_BLAST, DOUBLE_EDGE, DOUBLE_TEAM, BODY_SLAM
	db VENUSAUR, TOXIC, LEECH_SEED, SLEEP_POWDER, RAZOR_LEAF
	db VENUSAUR, RAZOR_LEAF, SLEEP_POWDER, BODY_SLAM, SWORDS_DANCE
	db CHARIZARD, FIRE_BLAST, SWORDS_DANCE, EARTHQUAKE, OMINOUS_WIND
	db CHARIZARD, SWORDS_DANCE, AIR_SLASH, EARTHQUAKE, STEEL_WING
	db BLASTOISE, HYDRO_PUMP, EARTHQUAKE, BLIZZARD, FLASH_CANNON
	db BLASTOISE, BLIZZARD, HYDRO_PUMP, MIMIC, TOXIC
	db GENGAR, HYPNOSIS, DREAM_EATER, THUNDERBOLT, GIGA_DRAIN
	db GENGAR, EXPLOSION, THUNDERBOLT, SHADOW_PUNCH, GIGA_DRAIN
	db BLISSEY, BLIZZARD, REFLECT, SOFTBOILED, SEISMIC_TOSS
	db BLISSEY, BLIZZARD, THUNDERBOLT, SOFTBOILED, FIRE_BLAST
	db MACHAMP, CROSS_CHOP, KARATE_CHOP, EARTHQUAKE, ROCK_SLIDE
	db MACHAMP, ROCK_SLIDE, CROSS_CHOP, EARTHQUAKE, BODY_SLAM
	db SCIZOR, SLASH, NIGHT_SLASH, X_SCISSOR, BULLET_PUNCH
	db SCIZOR, SWORDS_DANCE, X_SCISSOR, BULLET_PUNCH, OMINOUS_WIND
	db KANGASKHAN, DOUBLE_EDGE, DRAIN_PUNCH, LEER, EARTHQUAKE
	db KANGASKHAN, BODY_SLAM, EARTHQUAKE, DRAIN_PUNCH, BLIZZARD
	db POLIWRATH, HYDRO_PUMP, POISON_JAB, HYPNOSIS, SUBMISSION
	db POLITOED, HYDRO_PUMP, BLIZZARD, PSYCHIC, HYPNOSIS
	db ALAKAZAM, PSYCHO_CUT, RECOVER, REFLECT, DAZZLINGLEAM
	db ALAKAZAM, PSYCHO_CUT, RECOVER, THUNDER_WAVE, SEISMIC_TOSS
	db NIDOQUEEN, EARTHQUAKE, BLIZZARD, SUPERPOWER, POISON_JAB
	db NIDOQUEEN, FIRE_BLAST, BLIZZARD, EARTHQUAKE, POISON_JAB
	db NIDOKING, BLIZZARD, POISON_JAB, MEGAHORN, EARTHQUAKE
	db NIDOKING, EARTHQUAKE, THUNDERBOLT, BLIZZARD, POISON_JAB
	db AMPHAROS, THUNDERBOLT, FIRE_PUNCH, DRAGON_PULSE, THUNDER_WAVE
	db HYDREIGON, FIRE_BLAST, DRAGON_PULSE, SURF, CRUNCH
	db HYDREIGON, STEEL_WING, OMINOUS_WIND, DRAGON_PULSE, CRUNCH
	db ESPEON, PSYCHIC, REFLECT, RECOVER, DAZZLINGLEAM
	db UMBREON, TOXIC, DOUBLE_TEAM, MOONLIGHT, DARK_PULSE
	db UMBREON, BODY_SLAM, DOUBLE_TEAM, CONFUSE_RAY, DARK_PULSE
	db LEAFEON, X_SCISSOR, BODY_SLAM, LEAF_BLADE, SYNTHESIS
	db GLACEON, BITE, ICE_SHARD, BLIZZARD, BUBBLEBEAM
	db SYLVEON, MOONBLAST, PSYCHIC, REFLECT, BITE
	db PORYGONZ, AMNESIA, RECOVER, THUNDERBOLT, BLIZZARD
	db HERACROSS, MEGAHORN, EARTHQUAKE, SWORDS_DANCE, SUBMISSION
	db CHANDELURE, FIRE_BLAST, WILL_O_WISP, PSYCHIC, OMINOUS_WIND
	db FLYGON, EARTHQUAKE, BUG_BUZZ, BOOMBURST, DRAGON_RUSH
	db FLYGON, FIRE_BLAST, SAND_TOMB, DRAGON_RUSH, BUG_BUZZ
	db GIGALITH, STONE_EDGE, EARTHQUAKE, BODY_SLAM, HYPER_BEAM
	db MAMOSWINE, AMNESIA, BLIZZARD, EARTHQUAKE, ROCK_SLIDE
	db MAMOSWINE, AMNESIA, ICE_SHARD, EARTHQUAKE, ROCK_SLIDE
	db MILTANK, RECOVER, BODY_SLAM, BLIZZARD, EARTHQUAKE
	db DONPHAN, EARTHQUAKE, ROCK_SLIDE, BODY_SLAM, POISON_JAB
	db CRYOGONAL, BLIZZARD, NIGHT_SLASH, REFLECT, ACID_ARMOR
	db MAGMORTAR, THUNDERBOLT, FIRE_BLAST, PSYCHIC, EARTHQUAKE
	db ELECTIVIRE, EARTHQUAKE, THUNDERBOLT, FIRE_PUNCH, ROCK_SLIDE
	db KINGDRA, HYDRO_PUMP, ICE_BEAM, DRAGON_PULSE, HYPER_BEAM
	db LICKILICKY, SWORDS_DANCE, EARTHQUAKE, POWER_WHIP, BODY_SLAM
	db TANGROWTH, SWORDS_DANCE, POISON_JAB, POWER_WHIP, EARTHQUAKE
	db STEELIX, EARTHQUAKE, STONE_EDGE, ROCK_POLISH, BODY_SLAM
	db KINGDRA, HYDRO_PUMP, ICE_BEAM, DRAGON_PULSE, HYPER_BEAM
	db LICKILICKY, SWORDS_DANCE, EARTHQUAKE, POWER_WHIP, BODY_SLAM
	db CROBAT, X_SCISSOR, AIR_SLASH, HEAT_WAVE, GIGA_DRAIN
	db ABOMASNOW, BLIZZARD, WOOD_HAMMER, EARTHQUAKE, SWORDS_DANCE
	db MAGNEZONE, THUNDERBOLT, FLASH_CANNON, THUNDER_WAVE, METAL_SOUND
	db KLINKLANG, THUNDERBOLT, THUNDER_WAVE, SHIFT_GEAR, GEAR_GRIND
	db FLORGES, MOONBLAST, GIGA_DRAIN, PSYCHIC, REFLECT
	db CLEFABLE, COSMIC_POWER, MOONBLAST, BLIZZARD, FIRE_BLAST
	db MIENSHAO, SWORDS_DANCE, POISON_JAB, ROCK_SLIDE, HI_JUMP_KICK
	db PINSIR, SLASH, SWORDS_DANCE, X_SCISSOR, SUPERPOWER
	db SKARMORY, SWORDS_DANCE, STEEL_WING, AIR_SLASH, OMINOUS_WIND
	db ARTICUNO, BLIZZARD, REFLECT, HURRICANE, ROOST
	db ZAPDOS, THUNDERBOLT, DRILL_PECK, HEAT_WAVE, ROOST
	db MOLTRES, FIRE_BLAST, HURRICANE, ROOST, ANCIENTPOWER


FillMonData:
	push bc
	call EnableAutoTextBoxDrawing
	xor a
	ld [$ccd3], a
	xor a
	ld [W_ENEMYBATTSTATUS3], a ; $d069
	ld a, [$cf91]
	ld [wEnemyMonSpecies2], a
	ld hl, LoadEnemyMonData
	ld b, BANK(LoadEnemyMonData)
	call Bankswitch ; indirect jump to Func_3eb01 (3eb01 (f:6b01))
	ld hl, Func_e7a4
	ld b, BANK(Func_e7a4)
	call Bankswitch ; indirect jump to Func_e7a4 (e7a4 (3:67a4))
	pop bc
	ret

RestoreMonIDBefore:
	; restore the first actual mon in box... there is no hope for someone else understanding this code
	ld hl, W_NUMINBOX + 1
	ld a, [W_NUM_RENTED_MONS]
	ld b, a
	sub b
	sub b
	add 6 ; a contains num mons available to rent
	ld c, a
	ld b, 0
	add hl, bc ; hl points to first actual mon in box
	pop bc
	ld a, b
	ld [hl], a ; mon id restored

ShowFactoryMon:
	xor a
	ld [wListMenuID], a
	ld [H_AUTOBGTRANSFERENABLED],a ; disable auto-transfer
	ld a,1
	ld [$ffb7],a ; joypad state update flag
	ld hl,$d730
	set 6,[hl] ; turn off letter printing delay
	xor a
	ld [$cc35],a ; 0 means no item is currently being swapped
	ld [$d12a],a
	ld a,$0d ; list menu text box ID		
	ld [$d125],a

	; super hack ftw
	; overwrite the first actual mon in box with sentinel so DisplayList works, but restore it afterwards
	ld hl, W_NUMINBOX + 1
	ld a, [W_NUM_RENTED_MONS]
	ld b, a
	sub b
	sub b
	add 6 ; a contains num mons available to rent
	ld [$d12a],a ; [$d12a] = number of list entries
	ld c, a
	ld b, 0
	add hl, bc ; hl points to first actual mon in box
	; save the mon id for later
	ld a, [hl]
	ld b, a
	push bc
	ld a, $ff
	ld [hl], a

	call DisplayTextBoxID ; draw the menu text box
	call UpdateSprites ; move sprites
	hlCoord 4,2 ; coordinates of upper left corner of menu text box
	ld de,$090e ; height and width of menu text box
	call UpdateSprites ; move sprites; possibly delete this line
	ld a,1 ; max menu item ID is 1 if the list has less than 2 entries
	ld [$cc37],a
	ld a,[$d12a]
	cp a,2 ; does the list have less than 2 entries?
	jr c,.setMenuVariables
	ld a,2 ; max menu item ID is 2 if the list has at least 2 entries
.setMenuVariables
	ld [wMaxMenuItem],a
	ld a,4
	ld [wTopMenuItemY],a
	ld a,5
	ld [wTopMenuItemX],a
	ld a,%00000011 ; A button, B button, Select button
	ld [wMenuWatchedKeys],a
	ld c,10
	call DelayFrames
.pickMon
	ld hl, W_NUMINBOX
	ld a, l
	ld [$cf8b], a
	ld a, h
	ld [$cf8c], a
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld a, Bank(ShowFactoryMon)
	ld [$cf08], a ; save current bank
	call DisplayListMenuIDLoop
	jp c, RestoreMonIDBefore ; player tried to close menu
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wListScrollOffset]
	add b ; a = menuitem (0-based indexing)
	ld [wWhichPokemon], a
	call SaveScreenTilesToBuffer1
	call FactoryMonSubMenu
	push af
	call LoadScreenTilesFromBuffer1
	pop af
	and a
	jr z, .rentMon
	jp RestoreMonIDBefore
.rentMon
	; restore the first actual mon in box... there is no hope for someone else understanding this code
	ld hl, W_NUMINBOX + 1
	ld a, [W_NUM_RENTED_MONS]
	ld b, a
	sub b
	sub b
	add 6 ; a contains num mons available to rent
	ld c, a
	ld b, 0
	add hl, bc ; hl points to first actual mon in box
	pop bc
	ld a, b
	ld [hl], a ; mon id restored
	call TakeFromFactory
	ld hl, W_NUM_RENTED_MONS
	inc [hl]
	ld a, [wPartyCount]
	cp $3 ; num allowed for factory
	jp nz, ShowFactoryMon
	ret

FactoryMonSubMenu:
	hlCoord 10, 10 ; $c471
	ld b, $6
	ld c, $8
	call TextBoxBorder
	hlCoord 12, 12 ; $c49b
	ld de, ChooseMonText
	call PlaceString
	hlCoord 12, 14 ; $c4c3
	ld de, ShowStatsText ; $57dc
	call PlaceString
	hlCoord 12, 16
	ld de, CancelText
	call PlaceString
	ld hl, wTopMenuItemY ; $cc24
	ld a, 12
	ld [hli], a
	ld a, 11
	ld [hli], a
	xor a
	ld [hli], a
	inc hl
	ld a, $2
	ld [hli], a
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	ld hl, wListScrollOffset ; $cc36
	ld [hli], a
	ld [hl], a
	call HandleMenuInput
	bit 1, a ; B was pressed
	jr z, .notBPressed
	ld a, 2 ; cancel
	ret
.notBPressed
	ld a, [wCurrentMenuItem]
	cp 1
	jr z, .showStatsScreen
	cp 0 ; rent?
	jr nz, .cancelPressed
	xor a
	ret
.cancelPressed
	ld a, 2
	ret
.showStatsScreen
	ld a, $2
.asm_217b0
	ld [$cc49], a
	call ClearSprites
	ld a, $36
	call Predef ; indirect jump to StatusScreen (12953 (4:6953))
	ld a, $37
	call Predef ; indirect jump to StatusScreen2 (12b57 (4:6b57))
	call LoadScreenTilesFromBuffer1
	call ReloadTilesetTilePatterns
	call GoPAL_SET_CF1C
	call LoadGBPal
	jp FactoryMonSubMenu

ChooseMonText:
	db "RENT@"

ShowStatsText:
	db "STATS@"

CancelText:
	db "CANCEL@"

TakeFromFactory: ; 21618 (8:5618)
	ld a, [wWhichPokemon] ; $cf92
	ld hl, wBoxMonNicks
	call GetPartyMonName
	ld a, [$cf91]
	xor a
	ld [$cf95], a
	call Func_3a68
	ld a, $1
	ld [$cf95], a
	call RemovePokemon
	ret

SwapPokemonEnemy:
	xor a
	ld [H_AUTOBGTRANSFERENABLED],a ; disable auto-transfer
	ld a,1
	ld [$ffb7],a ; joypad state update flag
	ld hl,$d730
	set 6,[hl] ; turn off letter printing delay
	xor a
	ld [$cc35],a ; 0 means no item is currently being swapped
	ld [$d12a],a
	ld hl, wEnemyPartyCount
	ld a,[hl]
	ld [$d12a],a ; [$d12a] = number of list entries
	ld a,$0d ; list menu text box ID
	ld [$d125],a
	call DisplayTextBoxID ; draw the menu text box
	call UpdateSprites ; move sprites
	hlCoord 4,2 ; coordinates of upper left corner of menu text box
	ld de,$090e ; height and width of menu text box
	call UpdateSprites ; move sprites; possibly delete this line
	ld a,1 ; max menu item ID is 1 if the list has less than 2 entries
	ld [$cc37],a
	ld a,[$d12a]
	cp a,2 ; does the list have less than 2 entries?
	jr c,.setMenuVariables
	ld a,2 ; max menu item ID is 2 if the list has at least 2 entries
.setMenuVariables
	ld [wMaxMenuItem],a
	ld a,4
	ld [wTopMenuItemY],a
	ld a,5
	ld [wTopMenuItemX],a
	ld a,%00000011 ; A button, B button
	ld [wMenuWatchedKeys],a
	ld c,10
	call DelayFrames
.pickMon
	ld hl, wPartyCount
	ld a, l
	ld [$cf8b], a
	ld a, h
	ld [$cf8c], a
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld a, BATTLEFACTORYSWAPMENU
	ld [wListMenuID], a
	ld a, Bank(SwapPokemonEnemy)
	ld [$cf08], a ; save current bank
	call DisplayListMenuIDLoop
	ret c ; player tried to close menu
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wListScrollOffset]
	add b ; a = menuitem (0-based indexing)
	ld [W_SWAPMONENEMYINDEX], a
	call SaveScreenTilesToBuffer1
	ld hl, SwapMonSubMenu
	ld b, BANK(SwapMonSubMenu)
	call Bankswitch
	push af
	call LoadScreenTilesFromBuffer1
	pop af
	jp nc, SwapPokemonEnemy
	ccf
	ret

SwapPokemonPlayer:
	xor a
	ld [H_AUTOBGTRANSFERENABLED],a ; disable auto-transfer
	ld a,1
	ld [$ffb7],a ; joypad state update flag
	ld hl,$d730
	set 6,[hl] ; turn off letter printing delay
	xor a
	ld [$cc35],a ; 0 means no item is currently being swapped
	ld [$d12a],a
	ld hl, wPartyCount
	ld a,[hl]
	ld [$d12a],a ; [$d12a] = number of list entries
	ld a,$0d ; list menu text box ID
	ld [$d125],a
	call DisplayTextBoxID ; draw the menu text box
	call UpdateSprites ; move sprites
	hlCoord 4,2 ; coordinates of upper left corner of menu text box
	ld de,$090e ; height and width of menu text box
	call UpdateSprites ; move sprites; possibly delete this line
	ld a,1 ; max menu item ID is 1 if the list has less than 2 entries
	ld [$cc37],a
	ld a,[$d12a]
	cp a,2 ; does the list have less than 2 entries?
	jr c,.setMenuVariables
	ld a,2 ; max menu item ID is 2 if the list has at least 2 entries
.setMenuVariables
	ld [wMaxMenuItem],a
	ld a,4
	ld [wTopMenuItemY],a
	ld a,5
	ld [wTopMenuItemX],a
	ld a,%00000011 ; A button, B button, Select button
	ld [wMenuWatchedKeys],a
	ld c,10
	call DelayFrames
.pickMon
	ld hl, wPartyCount
	ld a, l
	ld [$cf8b], a
	ld a, h
	ld [$cf8c], a
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	xor a
	ld [wListMenuID], a
	ld a, Bank(SwapPokemonPlayer)
	ld [$cf08], a ; save current bank
	call DisplayListMenuIDLoop
	ret c ; player tried to close menu
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wListScrollOffset]
	add b ; a = menuitem (0-based indexing)
	ld b, a ; b = menuitem
	push bc
	call SaveScreenTilesToBuffer1
	ld hl, SwapMonSubMenuPlayer
	ld b, BANK(SwapMonSubMenuPlayer)
	call Bankswitch
	push af
	call LoadScreenTilesFromBuffer1
	pop af
	pop bc
	jp nc, SwapPokemonPlayer
	; swap mon data
	ld a, b ; menuitem
	ld [wCurrentMenuItem], a
	ld hl, wPartyMon1
	ld bc, $002c
	call AddNTimes
	ld d, h
	ld e, l ; de contains pointer to party mon data which will be overwritten
	ld hl, wEnemyMon1
	ld a, [W_SWAPMONENEMYINDEX]
	call AddNTimes
	ld a, [hl] ; save enemy mon id for later
	push af
	call CopyData ; swap mon data
	; swap mon id
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	pop af
	ld [hl], a
	; now place mon name
	ld [$d11e], a ; used for GetMonName
	ld hl, wPartyMonNicks
	ld a, [wCurrentMenuItem]
	ld bc, $000b
	call AddNTimes ; hl contains pointer to mon name which is 0xb bytes
	ld d, h
	ld e, l
	push de
	call GetMonName
	pop de
	ld hl, $cd6d
	ld bc, $000b
	call CopyData
	ret

SpecialTrainerDefeatMessage:
; make special trainer say their message
	ld a, [W_CUROPPONENT]
	ld d, a
	ld c, 6
	ld b, 0
	ld hl, SpecialDefeatMessagesTable
.searchingLoop
	ld a, [hl]
	cp d
	jr z, .foundIt
	add hl, bc
	jr .searchingLoop
.foundIt
	inc hl
	call PrintText

	; determine if there should be a reward
	ld a, [W_CURSTREAK]
	cp 64
	ret nc
	ld a, 1
	ld [W_FACTORY_REWARD], a
	ret

SpecialDefeatMessagesTable:
BrockDefText:
	db BROCK + $C8
	TX_FAR _BrockDefText
	db "@"
KogaDefText:
	db KOGA + $C8
	TX_FAR _KogaDefText
	db "@"
BlaineDefText:
	db BLAINE + $C8
	TX_FAR _BlaineDefText
	db "@"
GioDefText:
	db GIOVANNI + $C8
	TX_FAR _GioDefText
	db "@"
LoreleiDefText:
	db LORELEI + $C8
	TX_FAR _LoreleiDefText
	db "@"
LanceDefText:
	db LANCE + $C8
	TX_FAR _LanceDefText
	db "@"
OakDefText:
	db PROF_OAK + $C8
	TX_FAR _OakDefText
	db "@"

RandomDefeatMessage:
; make trainer say something after defeat
	call Random
	cp 60 ; number of messages in table
	jp nc, RandomDefeatMessage
	ld c, 5
	ld b, 0
	ld hl, DefeatMessagesTable
	call AddNTimes
	call PrintText
	ret

DefeatMessagesTable:
DefText1:
	TX_FAR _DefText1
	db "@"
DefText2:
	TX_FAR _DefText2
	db "@"
DefText3:
	TX_FAR _DefText3
	db "@"
DefText4:
	TX_FAR _DefText4
	db "@"
DefText5:
	TX_FAR _DefText5
	db "@"
DefText6:
	TX_FAR _DefText6
	db "@"
DefText7:
	TX_FAR _DefText7
	db "@"
DefText8:
	TX_FAR _DefText8
	db "@"
DefText9:
	TX_FAR _DefText9
	db "@"
DefText10:
	TX_FAR _DefText10
	db "@"
DefText11:
	TX_FAR _DefText11
	db "@"
DefText12:
	TX_FAR _DefText12
	db "@"
DefText13:
	TX_FAR _DefText13
	db "@"
DefText14:
	TX_FAR _DefText14
	db "@"
DefText15:
	TX_FAR _DefText15
	db "@"
DefText16:
	TX_FAR _DefText16
	db "@"
DefText17:
	TX_FAR _DefText17
	db "@"
DefText18:
	TX_FAR _DefText18
	db "@"
DefText19:
	TX_FAR _DefText19
	db "@"
DefText20:
	TX_FAR _DefText20
	db "@"
DefText21:
	TX_FAR _DefText21
	db "@"
DefText22:
	TX_FAR _DefText22
	db "@"
DefText23:
	TX_FAR _DefText23
	db "@"
DefText24:
	TX_FAR _DefText24
	db "@"
DefText25:
	TX_FAR _DefText25
	db "@"
DefText26:
	TX_FAR _DefText26
	db "@"
DefText27:
	TX_FAR _DefText27
	db "@"
DefText28:
	TX_FAR _DefText28
	db "@"
DefText29:
	TX_FAR _DefText29
	db "@"
DefText30:
	TX_FAR _DefText30
	db "@"
DefText31:
	TX_FAR _DefText31
	db "@"
DefText32:
	TX_FAR _DefText32
	db "@"
DefText33:
	TX_FAR _DefText33
	db "@"
DefText34:
	TX_FAR _DefText34
	db "@"
DefText35:
	TX_FAR _DefText35
	db "@"
DefText36:
	TX_FAR _DefText36
	db "@"
DefText37:
	TX_FAR _DefText37
	db "@"
DefText38:
	TX_FAR _DefText38
	db "@"
DefText39:
	TX_FAR _DefText39
	db "@"
DefText40:
	TX_FAR _DefText40
	db "@"
DefText41:
	TX_FAR _DefText41
	db "@"
DefText42:
	TX_FAR _DefText42
	db "@"
DefText43:
	TX_FAR _DefText43
	db "@"
DefText44:
	TX_FAR _DefText44
	db "@"
DefText45:
	TX_FAR _DefText45
	db "@"
DefText46:
	TX_FAR _DefText46
	db "@"
DefText47:
	TX_FAR _DefText47
	db "@"
DefText48:
	TX_FAR _DefText48
	db "@"
DefText49:
	TX_FAR _DefText49
	db "@"
DefText50:
	TX_FAR _DefText50
	db "@"
DefText51:
	TX_FAR _DefText51
	db "@"
DefText52:
	TX_FAR _DefText52
	db "@"
DefText53:
	TX_FAR _DefText53
	db "@"
DefText54:
	TX_FAR _DefText54
	db "@"
DefText55:
	TX_FAR _DefText55
	db "@"
DefText56:
	TX_FAR _DefText56
	db "@"
DefText57:
	TX_FAR _DefText57
	db "@"
DefText58:
	TX_FAR _DefText58
	db "@"
DefText59:
	TX_FAR _DefText59
	db "@"
DefText60:
	TX_FAR _DefText60
	db "@"

TrainerMonMenu:
	push bc
	ld a,[wWhichPokemon]
	ld b,a
	ld a,4
	sub b
	ld b,a
	ld a,[wListScrollOffset]
	add b ; a contains mon index?
	ld c, a
	ld b, $0
	push hl
	ld hl, wEnemyPartyMons
	add hl, bc ; hl contains address of enemy mon id
	ld a, [hl]
	ld [$d11e], a
	call GetMonName
	pop hl
	pop bc
	ld de,$cd6d
	ret


GetHeadID:
	; d = trainer id
	ld a, [W_INCHALLENGE]
	cp $1
	ret nz

	ld a, d
	cp BROCK
	jr nz, .koga
	ld d, HEAD_BROCK
	ret
.koga
	cp KOGA
	jr nz, .blaine
	ld d, HEAD_KOGA
	ret
.blaine
	cp BLAINE
	jr nz, .rocket
	ld d, HEAD_BLAINE
	ret
.rocket
	cp GIOVANNI
	jr nz, .lorelei
	ld d, HEAD_ROCKET
	ret
.lorelei
	cp LORELEI
	jr nz, .lance
	ld d, HEAD_LORELEI
	ret
.lance
	cp LANCE
	jr nz, .oak
	ld d, HEAD_LANCE
	ret
.oak
	ld d, HEAD_OAK
	ret

INCLUDE "data/martInventories/fossils.asm"

BattleFactoryTextE:
	ld hl, wRoamingFlag
	set 3, [hl]
	ld a, [wRoamingFlag]
	bit 5, a
	jr nz, .InverseModeOff ; switches Inverse off if it's already set
	ld hl, BattleFactoryTextInverseOn
	call PrintText
	ld hl, wRoamingFlag
	set 5, [hl] ; Switches inverse on (temporarily, as we're in the Battle Factory)
	jp TextScriptEnd
.InverseModeOff
	ld hl, BattleFactoryTextInverseOff
	call PrintText
	ld hl, wRoamingFlag
	res 5, [hl] ; Switches Inverse off (temporarily)
	jp TextScriptEnd

BattleFactoryTextInverse:
	TX_FAR _BattleFactoryTextInverse
	db "@"

BattleFactoryTextInverseOn:
	TX_FAR _BattleFactoryTextInverseOn
	db "@"

BattleFactoryTextInverseOff:
	TX_FAR _BattleFactoryTextInverseOff
	db "@"