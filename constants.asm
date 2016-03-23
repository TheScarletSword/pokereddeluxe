CHALLENGE_MODE EQU 0
CHALLENGE_MODE_PLUS EQU 0
GEN_2_SPRITES EQU 1

INCLUDE "macros.asm"

INCLUDE "hram.asm"
INCLUDE "vram.asm"

INCLUDE "constants/hardware_constants.asm"
INCLUDE "constants/oam_constants.asm"
INCLUDE "constants/misc_constants.asm"

INCLUDE "constants/wram_constants.asm"

INCLUDE "constants/pokemon_constants.asm"
INCLUDE "constants/pokedex_constants.asm"
INCLUDE "constants/trainer_constants.asm"
INCLUDE "constants/item_constants.asm"
INCLUDE "constants/type_constants.asm"
INCLUDE "constants/move_constants.asm"
INCLUDE "constants/move_animation_constants.asm"
INCLUDE "constants/move_effect_constants.asm"
INCLUDE "constants/status_constants.asm"
INCLUDE "constants/sprite_constants.asm"
INCLUDE "constants/palette_constants.asm"
INCLUDE "constants/evolution_constants.asm"
INCLUDE "constants/list_constants.asm"
INCLUDE "constants/map_constants.asm"
INCLUDE "constants/map_dimensions.asm"
INCLUDE "constants/connection_constants.asm"
INCLUDE "constants/hide_show_constants.asm"
INCLUDE "constants/credits_constants.asm"
INCLUDE "constants/music_constants.asm"
INCLUDE "constants/tilesets.asm"
INCLUDE "constants/starter_mons.asm"
INCLUDE "color/wram.asm"

RANOCCURED     EQU 0
OAKBATTLE      EQU 1
DIPLOMASEEN    EQU 2

OAKABLE EQU (1 << DIPLOMASEEN)