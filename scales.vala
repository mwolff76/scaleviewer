using Gee;

const string[] notes = {"C","C#","D","D#","E","F","F#","G","G#","A","Bb","B"};
const string[]  ikey = {"1","b2","2","b3","3","4","#4","b5","5","b6","6","b7","7"};
const int[]     ival = {0,1,2,3,4,5,6,6,7,8,9,10,11};
const string[] gNkey = {"E","F","F#","G","G#","A","Bb","B","C","C#","D","D#"};
const string[] gNval = {"A","B","C","D","E","F","G","H","I","J","K","L"};


HashMap<string,string> readText(string datei){
    var scale = new HashMap<string,string>();
    string[] lines=null;
    string[] splitStr=null;

    FileReader file=new FileReader(datei);

    if (file.ready()){
        if (file.readAll()){
            lines=file.text().split("\n");
            foreach(string line in lines){
                splitStr=line.split("=");
                if (splitStr.length > 1)
                    scale[splitStr[0]]=splitStr[1];
            }
        }
    }

    return scale;
}

int get_pos(string tonart){
    for(int i=0; i < notes.length; i++){
        if (notes[i] == tonart) return i;
    }
    return 0;

}

string[] get_played_notes(int startpos, string scaleMode, HashMap<string,int> interval){
    string[] playedNotes={};
    string[] marr = scaleMode.split(" ");
    int posm;
    foreach(string val in marr){
        posm=startpos + interval[val]; // # Position Startwert + interval
        if (posm > 11) posm-=12; //  # wenn größer 11 dann abziehen
        playedNotes+=notes[posm];// # Note speichern
    }
    return playedNotes;// # Noten ausgeben
}

void replaceValue(string[] saiten, string[] noten, HashMap<string,string> gN, string repVal){
    foreach(string note in noten){
        for(int i=0; i < saiten.length; i++){
            saiten[i]=saiten[i].replace(gN[note],repVal);
        }
    }
}


int main(string[] args){
    var interval = new HashMap<string,int>();
    var scale = new HashMap<string,string>();
    var getN = new HashMap<string,string>();
    int i, pos;

    string tonart="A", mode="Harmonic";

    for(i=0; i < ikey.length; i++){ interval[ikey[i]]=ival[i]; }

    scale=readText("scales.txt");

    for(i=0; i < gNkey.length; i++){ getN[gNkey[i]]=gNval[i]; }

    if (args.length > 2){
        tonart=args[1];
        mode=args[2];
    }

    string[] playedNotes;
    pos = get_pos(tonart);
    playedNotes=get_played_notes(pos, scale[mode], interval);

    stdout.printf("Notes : %s\n", string.joinv(",", playedNotes));

    string buende="|024-023-022-021-020-019-018-017-016-015-014-013-012-011-010-009-008-007-006-005-004-003-002-001-000|";
    string strich="|---------------------------------------------------------------------------------------------------|";
    string saiten[] = { "|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|", // E
                        "|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|", // H
                        "|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|", // G
                        "|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|", // D
                        "|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|" }; // A

    replaceValue(saiten, playedNotes, getN, "O");
    replaceValue(saiten, notes, getN, "-");

    stdout.printf("%s\n", buende);
    stdout.printf("%s\n", strich);

    foreach(string saite in saiten){
        stdout.printf("%s\n", saite);
    }

    stdout.printf("%s\n", saiten[0]);

    return 0;
}
