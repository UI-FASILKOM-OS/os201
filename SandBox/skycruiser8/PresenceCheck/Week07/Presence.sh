#!/bin/bash
# Presence.sh
# ============================================================================
# Author: Rafi Muhammad Daffa (skycruiser8)
#
# INFO:
# This script uses text data from SCeLE's presence thread to get
# students who have yet to declare their presence.
#
# VERSION:
# v0 (2020-04-06 10:05 UTC+7) - Initial commit
#
# This is free software :)

OUT="YangBelum.txt"
[[ -e "$OUT" ]] && rm "$OUT"

touch "$OUT"

for II in {A,B,C}
do
echo "====KELAS $II====" >> "$OUT"
grep "BELUM" "$II.txt" | rev | cut --complement -d " " -f 1 | rev >> "$OUT"
echo "" >> "$OUT"
done