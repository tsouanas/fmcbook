tex = file('fmcmain.tex','r')
prev = ''
for (i,line) in enumerate(tex):
    if prev.strip() and (line.strip() == '\endexercise'):
        print ""
    print line,
    prev = line
