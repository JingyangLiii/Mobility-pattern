import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

public class GetData
{
	public String data;
	public String readFile, writeFile;
	public String[] content;
	public String contents;
    public void getData(String path){
        File file=new File(path);
		String text[];
		text=file.list();//find all file name in this path
		try{
			writeFile="../Sample data/Data.txt";
			RandomAccessFile wf= new RandomAccessFile(writeFile,"rw");
			for(int i=0;i<text.length;i++){ 
				readFile=path+"/"+text[i];
				RandomAccessFile rf= new RandomAccessFile(readFile,"r");	
				for(int j=0;j<6;j++){   //move to line 7
					data = rf.readLine();
				}
				while(true){  //read line
					data = rf.readLine();
					if (data==null){
						break;}
					content= data.split(",");
					contents=content[0]+" "+content[1]+" "+content[3]+" "+content[4]+" "+content[5]+" "+content[6]+"\r\n";
					wf.write(contents.getBytes());
				}
				rf.close();}
			wf.close();}
		catch(IOException e){
			System.out.println("some thing wrong with reading the file");}
		
    }
	
	public void getLocationData(String path){
		try{
			writeFile="../Sample data/coordinateData.txt";
			RandomAccessFile wf= new RandomAccessFile(writeFile,"rw");
			readFile="../Sample data/Data.txt";
			RandomAccessFile rf= new RandomAccessFile(readFile,"r");	
			while(true){  //read line
				data = rf.readLine();
				if (data==null){
					break;}
				content= data.split(" ");
				contents=content[0]+" "+content[1]+" "+content[2]+" "+content[3]+"\r\n";
				wf.write(contents.getBytes());
			}
			rf.close();
			wf.close();}
		catch(IOException e){
			System.out.println("some thing wrong with reading the file");}
		
    }
	
    public static void main(String[] args){
		GetData a = new GetData();
		switch (args[0]){
			case "0": a.getData("../Sample data/Trajectory");
			break;
			case "1": a.getLocationData("../Sample data/Trajectory");
			break;
		}
    }
}