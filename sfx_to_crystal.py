import sys

f = open(sys.argv[1], 'r')

out = ""

tempo = None


for line in f.readlines():
    if not line.startswith('\t'):
        out += line
        continue
    
    things = line.strip().split()
    if things[0] == "volume":
        volume = int(things[1].strip(','))*16 + int(things[2])
        #if in_label == "Ch1":
        out += "\tvolume "+str(volume)+'\n'
    elif things[0] == "rest":
        out += "\tnote __, "+things[1]+'\n'
    elif things[0] == 'notetype':
        out += "\tnotetype "+things[1].strip(',')+", ("+things[2].strip(',')+"<<4) + "+things[3] + '\n'
    elif things[0] == 'vibrato':
        out += "\tvibrato "+things[1].strip(',')+", ("+things[2].strip(',')+"<<4) + "+things[3] + '\n'
    elif things[0] == "dspeed":
        out += "\tnotetype "+things[1] + '\n'
    elif things[0] == "dnote":
        out += "\tnote "+things[2].replace('snare1', 'C_')+', '+things[1].strip(',') + '\n'
    elif things[0] == "duty":
        out += "\tdutycycle "+things[1] + '\n'
    else:
        out += line

f = open(sys.argv[1], 'w')
f.write(out)
