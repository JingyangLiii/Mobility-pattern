import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.ArrayList;  

public class NameToSymble { 
  public static void main(String[] args) { 
  	String readFile, writeFile,listFile;
	String temp;
	String add;
	String zeroFill;
	int length=0;
	String[] content;
	ArrayList<String> data = new ArrayList<String>();
	try{
		readFile="../Sample data/combineLocationTrace.txt";
		RandomAccessFile rf= new RandomAccessFile(readFile,"rw");
		writeFile="../Sample data/symbolDataRaw.txt";
		RandomAccessFile wf= new RandomAccessFile(writeFile,"rw");
		listFile="../Sample data/MapList.txt";
		RandomAccessFile lf= new RandomAccessFile(listFile,"rw");
		int i=0;
		while((temp=rf.readLine())!=null){
			String[] part=temp.split(",");
			temp=new String(part[0].getBytes("8859_1"), "gbk");				
			if(!temp.equals("一天结束")){
				if (!(data.contains(temp))){
					data.add(temp);
					add=temp+","+part[1]+","+(data.lastIndexOf(temp)+1)+"\r\n";
					lf.write(add.getBytes()); //生成位置名称和symbol对应的map
				}
				add=data.lastIndexOf(temp)+1 + " ";
				wf.write(add.getBytes());
				i++;
			}
			else{
				if (length<i){
					length=i;
				}
				i=0;
				add="\r\n";
				wf.write(add.getBytes());
			}	
		}			
		rf.close();
		wf.close();		
		lf.close();
		}
	catch(IOException e){
		System.out.println("Some thing wrong with reading the file");}	
	
 	try{
		readFile="../Sample data/symbolDataRaw.txt";
		RandomAccessFile rf= new RandomAccessFile(readFile,"rw");
		writeFile="../Sample data/symbolData.txt";
		RandomAccessFile wf= new RandomAccessFile(writeFile,"rw");
		while((temp=rf.readLine())!=null){
			content=temp.split(" ");
			zeroFill="0 ";
			for(int j=0;j<(length-content.length);j++){
				zeroFill=zeroFill+"0 ";
				}
			add=temp+zeroFill+"\r\n";
			wf.write(add.getBytes());
			}
		rf.close();
		wf.close();	
		}
 	catch(IOException e){
		System.out.println("Some thing wrong with reading the file");}	
  }  
}