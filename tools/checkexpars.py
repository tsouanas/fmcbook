import sys

tex = file('fmcmain.tex','r')

def empty(line):
    return (line.strip() == '')


for word in ['exercise', 'problem']:
    tex.seek(0)
    EXMODE = False
    EXBODYMODE = False
    NEXTMUSTNOTBEBODY = False
    def body(line):
        line = line.strip()
        return (not empty(line)) and (not line.startswith('\end'+word)) and (not line.startswith('\\'+word))
    def endline(line):
        line = line.strip()
        return line.startswith('\end'+word) and (not line.startswith('\end'+word+'s'))
    def startline(line):
        line = line.strip()
        return line.startswith('\\'+word) and (not line.startwith('\\'+word+'s'))
    for (i,line) in enumerate(tex):
        if line.strip().startswith('\\' + word) and not line.strip().startswith('\\' + word + 's'):
            if EXMODE:
                print "Error at line", i, word, "started but already in", word, "mode."
                sys.exit(1)
            EXMODE = True
            EXBODYMODE = True

        if empty(line):
            if EXMODE:
                if EXBODYMODE:
                    EXBODYMODE = False
                    NEXTMUSTNOTBEBODY = True

        if line.strip().startswith('\end' + word) and not line.strip().startswith('\end' + word + 's'):
            if not EXMODE:
                print "Error at line", i, "word ended but was not in ", word, "mode."
                sys.exit(1)
            EXMODE = False

        if not empty(line):
            if NEXTMUSTNOTBEBODY:
                print "Error at line", i, "found a normal line but next cannot be a body"

        NEXTMUSTNOTBEBODY = False

tex.close()
