#!/bin/sh

FMCLANG=`cat fmc.lang`
FMCLASTTAG=`cat fmc-${FMCLANG}.lasttag`
HOSTNAME=tsouanas.org
HOSTPATH=fmcbook/

# tag pdf
cp fmc-${FMCLANG}.pdf fmc-${FMCLANG}-${FMCLASTTAG}.pdf

# upload .pdf, .bib, and metafiles
rsync -av fmc-${FMCLANG}-${FMCLASTTAG}.pdf fmcbook.bib fmc-${FMCLANG}.{last,lasttag,pages,webtoc} $HOSTNAME:$HOSTPATH

# execute scripts remotely to get rid of old pdf files and make the site
ssh $HOSTNAME "cd fmcbook && sh lastonly.sh ${FMCLANG} && sh mksite.sh ${FMCLANG}"

# remove tagged pdf
rm -f fmc-${FMCLANG}-${FMCLASTTAG}.pdf

