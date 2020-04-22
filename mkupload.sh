#!/bin/sh

FMCLANG=`cat fmc.lang`
FMCLASTTAG=`cat fmc-${FMCLANG}.lasttag`
HOSTNAME=tsouanas.org
HOSTPATH=fmcbook/

TAGGEDPDF=fmc-${FMCLANG}-${FMCLASTTAG}.pdf

# create tagged pdf
cp -p fmc-${FMCLANG}.pdf ${TAGGEDPDF}

# upload .pdf, .bib, and metafiles
rsync -av ${TAGGEDPDF} fmcbook.bib fmc-${FMCLANG}.{last,lasttag,pages,webtoc} $HOSTNAME:$HOSTPATH

# execute scripts remotely to get rid of old pdf files and make the site
ssh $HOSTNAME "cd fmcbook && sh lastonly.sh ${FMCLANG} && sh mksite.sh ${FMCLANG}"

# move tagged pdf
mv -f ${TAGGEDPDF} pdf/

