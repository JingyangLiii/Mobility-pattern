import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.ArrayList;
import org.apache.poi.hssf.usermodel.*;

public class Frepattern_prefix { 
	  public static void main(String[] args) { 
		  String readFile,MapList,temp,trace,add;
		  String[] content,coordinate;
		  ArrayList<String> LocationData = new ArrayList<String>();
		  ArrayList<String> coordinateData = new ArrayList<String>();
		  int r=0,c=0,k=0,id=1,num=2;
		  HSSFRow row;
		  HSSFCell cell;
		  //创建HSSFWorkbook对象(excel的文档对象)  
	      HSSFWorkbook wb = new HSSFWorkbook();  
	      //建立新的sheet对象（excel的表单）  
	      HSSFSheet sheet=wb.createSheet("Frepattern_prefix"); 
			try{
				readFile="../Sample data/Frepattern_prefix.txt";
				RandomAccessFile rf= new RandomAccessFile(readFile,"rw");
				MapList="../Sample data/MapList.txt";
				RandomAccessFile Mf= new RandomAccessFile(MapList,"rw");
				trace="../Sample data/MapInformationPrefix.txt";
				RandomAccessFile tf= new RandomAccessFile(trace,"rw");
				while((temp=Mf.readLine())!=null){
					temp=new String(temp.getBytes("8859_1"), "gbk");
					content=temp.split(",");
					LocationData.add(content[0]);
					coordinateData.add(content[1]);
				}
				
				while((temp=rf.readLine())!=null){
					String[] place=temp.split("	");
					row=sheet.createRow(r);
					for(int j=0;j<place.length;j++){
						if(Integer.parseInt(place[j])<0){
							cell=row.createCell(c);
							cell.setCellValue(-Integer.parseInt(place[j]));
							k=1;
							c=0;
							r++;
							add="\r\n";
							tf.write(add.getBytes());
							add=""+num;
							tf.write(add.getBytes());
							num++;
							id=1;
						}
						else if(Integer.parseInt(place[j])>0){
							if (k==1){
								row=sheet.createRow(r);
								k=0;}
							cell=row.createCell(c);
							cell.setCellValue(LocationData.get(Integer.parseInt(place[j])-1));
							c++;
							coordinate=coordinateData.get(Integer.parseInt(place[j])-1).split(" ");
							add="{"+"\"lng\""+":" +coordinate[1]+ ","+"\"lat\""+":" +coordinate[0]+ ","+"\"name\""+":"+"\""+LocationData.get(Integer.parseInt(place[j])-1)+"\""+","+"\"id\""+":"+id+"}"+",";
							tf.write(add.getBytes());
							id++;
						}
						else{
							break;}
					}
				}
				rf.close();
				Mf.close();
				tf.close();
			}	  
			catch(IOException e){
				System.out.println("Some thing wrong with reading the file");}
			//输出Excel文件  
			try{
			FileOutputStream output=new FileOutputStream("../Sample data/Frepattern_prefix.xls");  
			wb.write(output);  
			output.flush();
			wb.close();}	  
			catch(IOException e){
				System.out.println("Some thing wrong.");
	  		}
	}
}	  