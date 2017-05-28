import sys
tex = file('fmcmain.tex','r')
prev = ''
for (i,line) in enumerate(tex):
    if (prev.strip() != "") and (line.startswith('\\hin') or line.startswith('\\sol')):
        print "\hint or \solution without ending paragraph.  Line:", i
        sys.exit(1)
    prev = line
