BattleFactory_h:
	db $13 ; tileset
	db BATTLE_FACTORY_HEIGHT, BATTLE_FACTORY_WIDTH ; dimensions (y, x)
	dw BattleFactoryBlocks, BattleFactoryTextPointers, BattleFactoryScript ; blocks, texts, scripts
	db $00 ; connections
	dw BattleFactoryObject ; objects
