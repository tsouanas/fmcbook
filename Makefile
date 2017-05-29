default: build

screenconf:
	echo "% fmc.conf created by Makefile" > fmcconf.tex
	echo "\\printfalse" >> fmcconf.tex

printconf:
	echo "% fmc.conf created by Makefile" > fmcconf.tex
	echo "\\printtrue"  >> fmcconf.tex

both:
	echo -n `date +"%Y-%m-%d, %H:%M %Z"` > fmc.lasttmp
	make printconf
	xetex fmc \
	  && bibtex fmc \
	  && xetex fmc \
	  && makeindex -o fmc.ind fmc.idx \
	  && makeindex -o fmc.nnd fmc.ndx \
	  && xetex fmc \
	  && cp fmc.pdf fmc-print.pdf
	make screenconf
	xetex fmc \
	  && bibtex fmc \
	  && xetex fmc \
	  && makeindex -o fmc.ind fmc.idx \
	  && makeindex -o fmc.nnd fmc.ndx \
	  && xetex fmc && mv fmc.lasttmp fmc.last \
	  && pdftk fmc.pdf dump_data |grep NumberOfPages | egrep -o '[0-9]+' > fmc.pages \
	  && echo -n `sed 's/[^0-9]//g' fmc.last` > fmc.lasttag \
	  && grep '\\chapter\ ' fmcmain.tex | sed 's/^.chapter /<li>/' | sed 's/\.$'//' > fmc.webtoc

build:
	echo -n `date +"%Y-%m-%d, %H:%M %Z"` > fmc.lasttmp
	xetex fmc \
	  && bibtex fmc \
	  && xetex fmc \
	  && makeindex -o fmc.ind fmc.idx \
	  && makeindex -o fmc.nnd fmc.ndx \
	  && xetex fmc && mv fmc.lasttmp fmc.last \
	  && pdftk fmc.pdf dump_data |grep NumberOfPages | egrep -o '[0-9]+' > fmc.pages \
	  && echo -n `sed 's/[^0-9]//g' fmc.last` > fmc.lasttag \
	  && grep '\\chapter\ ' fmcmain.tex | sed 's/^.chapter /<li>/' | sed 's/\.$'//' > fmc.webtoc

upload:
	cp fmc.pdf fmc-`cat fmc.lasttag`.pdf
	scp fmc-`cat fmc.lasttag`.pdf fmc.{lasttag,last,pages,webtoc} tsouanas.org:fmcbook/
	ssh necroulis "cd fmcbook && sh lastonly.sh"
	rm -f fmc-`cat fmc.lasttag`.pdf

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
	rm -f fmc.pdf
	rm -f fmc.{last,lasttag,pages,webtoc}
	echo "% fmc.conf reset by Makefile" > fmcconf.tex
	echo "\\printfalse" >> fmcconf.tex

