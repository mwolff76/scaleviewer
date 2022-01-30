#!/bin/bash

. "./libScale.sh"

muster="$2" # Bsp.: Aeolian

start="$1" # Bsp.: A

buende="024-023-022-021-020-019-018-017-016-015-014-013-012-011-010-009-008-007-006-005-004-003-002-001-000"
strich="---------------------------------------------------------------------------------------------------"
e_saite="-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-"
a_saite="-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-"
d_saite="-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-"
g_saite="-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-"
h_saite="-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-"

pos=$(get_pos $start)

playedNotes=$(get_played_notes $pos $muster)

echo "Noten : "$playedNotes
echo

for val in ${playedNotes[@]}
do
    e_saite=${e_saite//${getN[$val]}/O}
    a_saite=${a_saite//${getN[$val]}/O}
    d_saite=${d_saite//${getN[$val]}/O}
    g_saite=${g_saite//${getN[$val]}/O}
    h_saite=${h_saite//${getN[$val]}/O}
done

for val in ${notes[@]}
do
    e_saite=${e_saite//${getN[$val]}/-}
    a_saite=${a_saite//${getN[$val]}/-}
    d_saite=${d_saite//${getN[$val]}/-}
    g_saite=${g_saite//${getN[$val]}/-}
    h_saite=${h_saite//${getN[$val]}/-}
done
 
echo "    "$buende
echo "    "$strich
echo
echo "e: |"${e_saite}
echo "h: |"${h_saite}
echo "g: |"${g_saite}
echo "d: |"${d_saite}
echo "a: |"${a_saite}
echo "e: |"${e_saite}
