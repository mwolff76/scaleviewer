class FileReader : Object{
    
    private string file;
    private Posix.FILE fp=null;
    private char[] buffer = new char[1024];
    private StringBuilder buffTxt=new StringBuilder();
    private size_t l=0;

    public FileReader(string f){
        file=f;
        fp=Posix.FILE.open(file, "r");
    }

    ~FileReader(){
        fp.close();
    }

    public bool ready(){
        return (fp!=null);
    }

    public bool readAll(){
        while (!fp.eof()){
            l = fp.read(buffer, 1, 1024);
            if (l > 0){
                buffTxt.append((string)buffer);
            }
        }
        return true;
    }

    public string text(){
        return buffTxt.str;
    }
  
}
