default: build

screenconf:
	echo "% fmc.conf created by Makefile" > fmcconf.tex
	echo "\\printfalse" >> fmcconf.tex

printconf:
	echo "% fmc.conf created by Makefile" > fmcconf.tex
	echo "\\printtrue"  >> fmcconf.tex

build: clean
	sh mkbuild.sh

upload:
	sh mkupload.sh

clean:
	rm -f fmc.aux
	rm -f fmc.log
	rm -f fmc.{bbl,blg}
	rm -f fmc.{idx,ilg,ind,ndx,nnd}
	rm -f fmc.pgf
	rm -f fmc.toc
	rm -f fmc.hints
	rm -f fmc.solutions
	rm -f fmc.proofs
	rm -f fmc.symbols
	rm -f fmc.report

cleanall: clean
	rm -f fmc.lang
	rm -f fmc*.pdf
	rm -f fmc*.{last,lasttag,pages,webtoc}
	cp fmcconf.tex.default fmcconf.tex

