
const notes=("C","C#","D","D#","E","F","F#","G","G#","A","Bb","B")
const interval=Dict(["1"=>0,"b2"=>1,"2"=>2,"b3"=>3,"3"=>4,"4"=>5,"#4"=>6,"b5"=>6,"5"=>7,"b6"=>8,"6"=>9,"b7"=>10,"7"=>11])
const getN=Dict(["E"=>"A","F"=>"B","F#"=>"C","G"=>"D","G#"=>"E","A"=>"F","Bb"=>"G","B"=>"H","C"=>"I","C#"=>"J","D"=>"K","D#"=>"L"])

function get_scales(file)
    scale=Dict{String,String}()
    for line in eachline(file)
        spStr=split(line,"=")
        scale[spStr[1]]=spStr[2]
    end
    return scale
end

function get_pos(tonart)
    for i in 1:length(notes)
        (notes[i] == tonart) && return i
    end
end

function get_played_notes(startpos, mode, scale)
    playedNotes=String[]
    marr = split(scale[mode]," ") # String scale-interval in array umwandeln
    for val in marr     # und einzeln nach val kopieren in der Schleife
        posm=startpos + interval[val] # Position Startwert + interval
        posm > 12 && (posm-=12)  # wenn größer 12 dann abziehen
        push!(playedNotes, notes[posm]) # Note speichern
    end
    return playedNotes # Noten ausgeben
end

function myReplace(saiten, notes, repVal)
    for i in 1:length(saiten)
        for n in notes
            saiten[i]=replace(saiten[i], getN[n]=>repVal)
        end
    end
end

function main(tonart, mode)

    buende= "   |024-023-022-021-020-019-018-017-016-015-014-013-012-011-010-009-008-007-006-005-004-003-002-001-000|"
    strich= "   |---------------------------------------------------------------------------------------------------|"
    saiten=["e: |-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|",
            "h: |-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|",
            "g: |-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|",
            "d: |-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|",
            "a: |-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|"]

 
    scale=get_scales("scales.txt")
    p = get_pos(tonart)
    mynotes=get_played_notes(p, mode, scale)
    myReplace(saiten, mynotes, "O");
    myReplace(saiten, notes, "-");

    println("Noten : " * join(mynotes,",") * "\n")

    println(buende)
    println(strich)

    for saite in saiten
        println(saite)
    end
    println(saiten[1])

end

main("A","Aeolian")
