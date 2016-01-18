from extras.pokemontools.pokemon_constants import pokemon_constants

for pokemon in pokemon_constants.values()[0:152]:
    text = ""
    f = open('data/baseStats/{}.asm'.format(pokemon.lower().replace('_', '')), 'r+w')
    for line in f.readlines():
        if line == "db 0 ; padding\n" or line.startswith("db BANK("):
            p = pokemon.capitalize()
            if p == "Nidoran_f": p = "NidoranF"
            if p == "Nidoran_m": p = "NidoranM"
            if p == "Farfetch_d": p = "Farfetchd"
            if p == "Mr__mime": p = "MrMime"
            text += "db BANK({}PicFront)\n".format(p)
        else:
            text += line
    f.seek(0)
    f.write(text)
    f.close()
