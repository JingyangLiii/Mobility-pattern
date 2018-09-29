import java.io.IOException;
import java.io.RandomAccessFile;

public class combine { 
	  public static void main(String[] args) { 
		  String readFile, writeFile,temp,last=" ";
		  String[] content;

			try{
				readFile="../Sample data/locationTrace.txt";
				RandomAccessFile rf= new RandomAccessFile(readFile,"rw");
				writeFile="../Sample data/combineLocationTrace.txt";
				RandomAccessFile wf= new RandomAccessFile(writeFile,"rw");
				while((temp=rf.readLine())!=null){
					temp=new String(temp.getBytes("8859_1"), "gbk");
					content=temp.split(",");
					if (!content[0].equals(last)){
					wf.write(temp.getBytes());
					wf.write("\r\n".getBytes());}
					last=content[0];
				}	
				rf.close();
				wf.close();

			}	  
			catch(IOException e){
				System.out.println("Some thing wrong with reading the file");}
	  }
}