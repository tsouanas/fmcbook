#!/bin/sh

# first compile
xetex fmc
if [ $? -ne 0 ]; then
    echo "Error during first compilation."
    exit 1
fi

# get lang and date
FMCLANG=`cat fmc.lang`
FMCLAST=`date +"%Y-%m-%d, %H:%M %Z"`

# finalize compilation
bibtex fmc \
  && xetex fmc \
  && makeindex -o fmc.ind fmc.idx \
  && makeindex -o fmc.nnd fmc.ndx \
  && xetex fmc \
  && cp fmc.pdf fmc-${FMCLANG}.pdf
if [ $? -ne 0 ]; then
    echo "Error during full compilation."
    exit 1
fi

# find pagecount
grep 'Output written on fmc.pdf' fmc.log | egrep -o '[0-9]+' > fmc-${FMCLANG}.pages

# create .last and .lasttag
echo -n $FMCLAST > fmc-${FMCLANG}.last
echo -n $FMCLAST | sed 's/[^0-9]//g' > fmc-${FMCLANG}.lasttag

# create .webtoc
grep '\\tocchapterentry\ ' fmc.toc | sed 's/^.tocchapterentry {/<li>/' | sed 's/}{[0-9]*}{[0-9]*}$//' > fmc-${FMCLANG}.webtoc

