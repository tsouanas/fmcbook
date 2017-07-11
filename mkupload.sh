#!/bin/sh

FMCLANG=`cat fmc.lang`
FMCLASTTAG=`cat fmc-${FMCLANG}.lasttag`
HOSTNAME=tsouanas.org
HOSTPATH=fmcbook/

cp fmc-${FMCLANG}.pdf fmc-${FMCLANG}-${FMCLASTTAG}.pdf

scp fmc-${FMCLANG}-${FMCLASTTAG}.pdf fmc-${FMCLANG}.{last,lasttag,pages,webtoc} $HOSTNAME:$HOSTPATH

ssh $HOSTNAME "cd fmcbook && sh lastonly.sh ${FMCLANG}"

rm -f fmc-${FMCLANG}-${FMCLASTTAG}.pdf

