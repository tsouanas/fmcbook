#!/bin/sh

# first compile
printf 'sections:'      ; grep -c '^\\section[ .]'      fmcmain.tex
printf 'problems:'      ; grep -c '^\\problem[ .]'      fmcmain.tex
printf 'openproblems:'  ; grep -c '^\\openproblem[ .]'  fmcmain.tex
printf 'exercises:'     ; grep -c '^\\exercise[ .]'     fmcmain.tex
printf 'hints:'         ; grep -c '^\\hintentry'        fmc.hints
printf 'solutions:'     ; grep -c '^\\solutionentry'    fmc.solutions

