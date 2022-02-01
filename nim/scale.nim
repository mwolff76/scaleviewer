import tables, strutils

let
    notes = @["C","C#","D","D#","E","F","F#","G","G#","A","Bb","B"]
    interval = {"1": 0,"b2": 1,"2": 2,"b3": 3,"3": 4,"4": 5,"#4": 6,"b5": 6,"5": 7,"b6": 8,"6": 9,"b7": 10,"7": 11}.toTable
    getN = {"E": "A","F": "B","F#": "C","G": "D","G#": "E","A": "F","Bb": "G","B": "H","C": "I","C#": "J","D": "K","D#": "L"}.toTable
    


proc get_scales(filename : string):Table[string,string] =
    result = initTable[string,string]()
    for line in filename.lines:
        var spStr=line.split("=")
        result[spStr[0]]=spStr[1]



proc get_pos(tonart : string): int =
    for pos in 0..notes.len-1:
        if notes[pos] == tonart: 
            return pos



proc get_played_notes(startpos : int, scale : string): seq[string] =
    var marr = scale.split(" ") # String scale-interval in array umwandeln
    for val in marr:     # und einzeln nach val kopieren in der Schleife
        var posm=startpos + interval[val] # Position Startwert + interval
        if posm > 11:
            posm-=12 # wenn größer 11 dann abziehen
        result.add(notes[posm]) # Note speichern
    

proc myReplace(saiten : var seq[string], notes : seq[string], repVal : string) = 
    for i in 0..saiten.len-1:
        for n in notes:
            saiten[i]=replace(saiten[i], getN[n], repVal)
       


proc main(tonart : string, mode : string) =

    let
        scale=get_scales("scales.txt")
        p = get_pos(tonart)
        mynotes=get_played_notes(p, scale[mode])
       
        buende = "|024-023-022-021-020-019-018-017-016-015-014-013-012-011-010-009-008-007-006-005-004-003-002-001-000|"
        strich = "|---------------------------------------------------------------------------------------------------|"
        
    var
        saiten = @["|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-e",
                   "|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-h",
                   "|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-g",
                   "|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-d",
                   "|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-a"]
    
    myReplace(saiten, mynotes, "O");
    myReplace(saiten, notes, "-");

    echo "Noten : " & join(mynotes,",")

    echo buende
    echo strich

    for saite in saiten:
        echo saite
    
    echo saiten[0]


if paramCount() < 2:
    main("A", "Aeolian")
else:
    try:
        if notes.contains(paramStr(1)):
            main(paramStr(1),paramStr(2))
        else:
            echo "wrong key parameter use only -> (" & join(notes,",") & ")"
    except KeyError:
        echo "wrong scale mode!"
