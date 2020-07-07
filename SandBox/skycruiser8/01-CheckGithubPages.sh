#!/bin/bash
# 01-CheckGithubPages.sh
# ============================================================================
# Author: Rafi Muhammad Daffa (skycruiser8)
#
# INFO:
# This script continues on the work made by 00-CheckFolder.sh to check
# whether a Github user whose username is the name of a folder here has an
# os201 Github Pages site.
#
# VERSION:
# v2 (2020-03-30 12:21 UTC+7) - Silence curl reports & use error exit codes
# v1 (2020-03-29 12:57 UTC+7) - Change site checking to use grep
# v0 (2020-03-29 12:30 UTC+7) - Initial commit
#
# This is free software :)

CFSCRIPT="00-CheckFolder.sh"
CFOUT="sandbox-201.txt"
CGPOUT="GitHub-Pages-os201.txt"

FNOTFOUNDMSG="$CFSCRIPT is required but cannot be found"
CFERRORMSG="$CFOUT not found. Please use original $CFSCRIPT"

[[ -e $CFSCRIPT ]] || (echo $FNOTFOUNDMSG;exit 1)

bash $CFSCRIPT

[[ -e $CFOUT ]] || (echo $CFERRORMSG;exit 1)

UNAMELIST=$(cat $CFOUT)

[[ -e $CGPOUT ]] && rm -f $CGPOUT

touch $CGPOUT

for II in $UNAMELIST
do
echo "Check GitHub Pages for $II"
NOTFOUND=$(curl -s "https://$II.github.io/os201/" | grep "Site not found")
if [[ $NOTFOUND ]]
then
printf "%-25s %d\n" "$II" 0 >> $CGPOUT
else
printf "%-25s %d\n" "$II" 1 >> $CGPOUT
fi
done

# EOF

