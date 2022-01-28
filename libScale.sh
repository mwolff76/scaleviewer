#!/bin/bash

notes="C C# D D# E F F# G G# A Bb B"

declare -A interval
interval=([1]=0 [b2]=1 [2]=2 [b3]=3 [3]=4 [4]=5 [#4]=6 [b5]=6 [5]=7 [b6]=8 [6]=9 [b7]=10 [7]=11)

declare -A getN
getN=([E]=A [F]=B [F#]=C [G]=D [G#]=E [A]=F [Bb]=G [B]=H [C]=I [C#]=J [D]=K [D#]=L)

declare -A scale 
scale[Ionian]="1 2 3 4 5 6 7" # C-Ionian = C D E F G A H
scale[Dorian]="1 2 b3 4 5 6 b7" # D-Dorian = D E F G A H C
scale[Phrygian]="1 b2 b3 4 5 b6 b7" # E-Phrygian = E F G A H C D
scale[Lydian]="1 2 3 #4 5 6 7" # F-Lydian = F G A H C D E
scale[Mixolydian]="1 2 3 4 5 6 b7" # G-Mixolydian = G A H C D E F
scale[Aeolian]="1 2 b3 4 5 b6 b7" # A-Aeolian = A H C D E F G
scale[Moll-Penta]="1 b3 4 5 b7" # A Moll-Pentatonic = A C D E G

function get_pos(){
    local narr=($notes) # string in array umwandeln
    local pos=0
    for val in "${narr[@]}" # "jede Note in der Schleife in val kopieren"
    do
       if [ $val == "$1" ] # "Note = Startwert?" 
       then
           break # "beenden wenn Note gefunden"
       fi
       ((pos++)) # "Position hochzählen"
    done
    echo $pos  # Position der Note ausgeben
}

function get_played_notes(){
    declare -a playedNotes
    local narr=($notes)
    local marr=(${scale[$2]}) # String scale-interval in array umwandeln
    for val in ${marr[@]}     # und einzeln nach val kopieren in der Schleife
    do
        posm=$(($1+${interval[$val]})) # Position Startwert + interval
        if [ $posm -gt 11 ] # wenn größer 11  
        then
            let posm-=12    # dann abziehen
        fi
        playedNotes+=(${narr[$posm]}) # Note speichern 
    done
    echo ${playedNotes[@]} # Noten ausgeben
}
