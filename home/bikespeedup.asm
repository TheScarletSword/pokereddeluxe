; function to make bikes twice as fast as walking
; split because of space issues
BikeSpeedup:: ; 06a0 (0:06a0)
	ld a,[wNPCMovementScriptPointerTableNum]
	and a
	ret nz
	ld a,[W_CURMAP]
	cp a,ROUTE_17 ; Cycling Road
	jr nz,.goFaster
	ld a,[hJoyHeld]
	and a,D_UP | D_LEFT | D_RIGHT
	ret nz
.goFaster
	jpba AdvancePlayerSprite

DisplayChooseQuantityMenu:: ; 2d57 (0:2d57)
; text box dimensions/coordinates for just quantity
	hlCoord 15, 9
	ld b,1 ; height
	ld c,3 ; width
	ld a,[wListMenuID]
	cp a,PRICEDITEMLISTMENU
	jr nz,.drawTextBox
; text box dimensions/coordinates for quantity and price
	hlCoord 7, 9
	ld b,1  ; height
	ld c,11 ; width
.drawTextBox
	call TextBoxBorder
	hlCoord 16, 10
	ld a,[wListMenuID]
	cp a,PRICEDITEMLISTMENU
	jr nz,.printInitialQuantity
	hlCoord 8, 10
.printInitialQuantity
	ld de,InitialQuantityText
	call PlaceString
	xor a
	ld [wcf96],a ; initialize current quantity to 0
	jp .incrementQuantity
.waitForKeyPressLoop
	call JoypadLowSensitivity
	ld a,[hJoyPressed] ; newly pressed buttons
	bit 0,a ; was the A button pressed?
	jp nz,.buttonAPressed
	bit 1,a ; was the B button pressed?
	jp nz,.buttonBPressed
	bit 6,a ; was Up pressed?
	jr nz,.incrementQuantity
	bit 7,a ; was Down pressed?
	jr nz,.decrementQuantity
	jr .waitForKeyPressLoop
.incrementQuantity
	ld a,[wcf97] ; max quantity
	inc a
	ld b,a
	ld hl,wcf96 ; current quantity
	inc [hl]
	ld a,[hl]
	cp b
	jr nz,.handleNewQuantity
; wrap to 1 if the player goes above the max quantity
	ld a,1
	ld [hl],a
	jr .handleNewQuantity
.decrementQuantity
	ld hl,wcf96 ; current quantity
	dec [hl]
	jr nz,.handleNewQuantity
; wrap to the max quantity if the player goes below 1
	ld a,[wcf97] ; max quantity
	ld [hl],a
.handleNewQuantity
	hlCoord 17, 10
	ld a,[wListMenuID]
	cp a,PRICEDITEMLISTMENU
	jr nz,.printQuantity
.printPrice
	ld c,$03
	ld a,[wcf96]
	ld b,a
	ld hl,$ff9f ; total price
; initialize total price to 0
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
.addLoop ; loop to multiply the individual price by the quantity to get the total price
	ld de,$ffa1
	ld hl,$ff8d
	push bc
	predef AddBCDPredef ; add the individual price to the current sum
	pop bc
	dec b
	jr nz,.addLoop
	ld a,[$ff8e]
	and a ; should the price be halved (for selling items)?
	jr z,.skipHalvingPrice
	xor a
	ld [$ffa2],a
	ld [$ffa3],a
	ld a,$02
	ld [$ffa4],a
	predef DivideBCDPredef3 ; halves the price
; store the halved price
	ld a,[$ffa2]
	ld [$ff9f],a
	ld a,[$ffa3]
	ld [$ffa0],a
	ld a,[$ffa4]
	ld [$ffa1],a
.skipHalvingPrice
	hlCoord 12, 10
	ld de,SpacesBetweenQuantityAndPriceText
	call PlaceString
	ld de,$ff9f ; total price
	ld c,$a3
	call PrintBCDNumber
	hlCoord 9, 10
.printQuantity
	ld de,wcf96 ; current quantity
	ld bc,$8102 ; print leading zeroes, 1 byte, 2 digits
	call PrintNumber
	jp .waitForKeyPressLoop
.buttonAPressed ; the player chose to make the transaction
	xor a
	ld [wMenuItemToSwap],a ; 0 means no item is currently being swapped
	ret
.buttonBPressed ; the player chose to cancel the transaction
	xor a
	ld [wMenuItemToSwap],a ; 0 means no item is currently being swapped
	ld a,$ff
	ret

; function to determine if there will be a battle and execute it (either a trainer battle or wild battle)
; sets carry if a battle occurred and unsets carry if not
NewBattle:: ; 0683 (0:0683)
	ld a,[wd72d]
	bit 4,a
	jr nz,.noBattle
	callba IsPlayerCharacterBeingControlledByGame
	jr nz,.noBattle ; no battle if the player character is under the game's control
	ld a,[wd72e]
	bit 4,a
	jr nz,.noBattle
	ld b, BANK(InitBattle)
	ld hl, InitBattle
	jp Bankswitch
.noBattle
	and a
	ret