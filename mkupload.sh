#!/bin/sh

FMCLANG=`cat fmc.lang`
FMCLASTTAG=`cat fmc-${FMCLANG}.lasttag`
HOSTNAME=tsouanas.org
HOSTPATH=fmcbook/

# tag pdf
cp fmc-${FMCLANG}.pdf fmc-${FMCLANG}-${FMCLASTTAG}.pdf

# upload pdf and metafiles
scp fmc-${FMCLANG}-${FMCLASTTAG}.pdf fmc-${FMCLANG}.{last,lasttag,pages,webtoc} $HOSTNAME:$HOSTPATH

# execute lastonly.sh remotely to get rid of old pdf files
ssh $HOSTNAME "cd fmcbook && sh lastonly.sh ${FMCLANG}"

# remove tagged pdf
rm -f fmc-${FMCLANG}-${FMCLASTTAG}.pdf

