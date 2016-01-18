; part of TPP Anniversary's gym leader rematch code
_HandleRematch:
	ld a, [wd5a2]
	and a
	jr z, _HandleRematch3
	push de
	ld a, [wRemFuncArg]
	and $f
	ld c, a
	ld hl, wRematchFlag
	ld b, $2
	predef FlagActionPredef
	ld a, c
	and a
	jr nz, .popde
	ld hl, RematchPrompt
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .popde
	pop hl
	ld b, 0
	ld a, [wRemFuncArg]
	swap a
	and $f
	ld c, a
	predef FlagActionPredef
	ld hl, wRoamingFlag
	set RANOCCURED, [hl]
	ld hl, wRanFlag
	set 7, [hl]
	ret
.popde
	pop de

_HandleRematch3:
	ld hl, wRanFlag
	res 7, [hl]
	ret
	
_HandleRematchAfter:
	ld hl, wRanFlag
	bit 7, [hl]
	res 7, [hl]
	ret z
	ld h, d
	ld l, e
	ld a, [wRemFuncArg]
	swap a
	and $f
	ld c, a
	ld b, 1
	predef FlagActionPredef
	ld hl, wRematchFlag
	ld a, [wRemFuncArg]
	and $f
	ld c, a
	ld b, 1
	predef FlagActionPredef
	ld hl, wRoamingFlag
	set RANOCCURED, [hl]
	ret
	
_OverwriteRoster:
	ld hl, W_MAPSPRITEEXTRADATA - 1
	sla d
	ld b, 0
	ld c, d
	add hl, bc
	ld a, e
	ld [hl], a
	ret

LeaguePC: ; no, not that HoF PC
	ld a, [wSpriteStateData1 + 9]
	cp $4 ; check to see if player is facing up
	ret nz
	ld a, $36
	ld hl, wOverworldMap + 4 + (VIRIDIAN_GYM_WIDTH + 6) * 4
	cp [hl] ; is the pc tile present?
	ret nz
	ld a, [wd5a2]
	and a
	ret z
	ld a, [wd751]
	bit 0, a
	ret z
	ld a, 15
	ld [H_DOWNARROWBLINKCNT2], a ; $ff8c
	jp DisplayTextID

RematchMusicList:
	db LORELEI + $c8, BRUNO + $c8, AGATHA + $c8, LANCE + $c8, $ff
	
FinalMusicList:
	db SONY3 + $c8, PROF_OAK + $c8, $ff