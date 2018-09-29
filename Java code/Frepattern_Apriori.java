import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.ArrayList;
import org.apache.poi.hssf.usermodel.*;

public class Frepattern_Apriori { 
	  public static void main(String[] args) { 
		  String readFile,MapList,temp,trace,add;
		  String[] content,coordinate,term1,term2;
		  ArrayList<String> LocationData = new ArrayList<String>();
		  ArrayList<String> coordinateData = new ArrayList<String>();
		  int r=0,id=1,num=2,L=0,c=0;
		  HSSFRow row;
		  HSSFCell cell;
		  //创建HSSFWorkbook对象(excel的文档对象)  
	      HSSFWorkbook wb = new HSSFWorkbook();  
	      //建立新的sheet对象（excel的表单）  
	      HSSFSheet sheet=wb.createSheet("Frepattern_AP"); 
			try{
				readFile="../Sample data/Frepattern_Apriori.txt";
				RandomAccessFile rf= new RandomAccessFile(readFile,"rw");
				MapList="../Sample data/MapList.txt";
				RandomAccessFile Mf= new RandomAccessFile(MapList,"rw");
				trace="../Sample data/MapInformationApriori.txt";
				RandomAccessFile tf= new RandomAccessFile(trace,"rw");
				while((temp=Mf.readLine())!=null){
					temp=new String(temp.getBytes("8859_1"), "gbk");
					content=temp.split(",");
					LocationData.add(content[0]);
					coordinateData.add(content[1]);
				}
				temp=rf.readLine();
				while((temp=rf.readLine())!=null){
					String[] place=temp.split(" ");
					row=sheet.createRow(r);
					term1=place[0].split(",");
					term2=place[1].split(",");
					for(int j=0;j<place.length;j++){
						if(j==0){
							for(L=0;L<term1.length;L++){
								cell=row.createCell(c);
								cell.setCellValue(LocationData.get(Integer.parseInt(term1[L])-1));
								c++;
								coordinate=coordinateData.get(Integer.parseInt(term1[L])-1).split(" ");
								add="{"+"\"lng\""+":" +coordinate[1]+ ","+"\"lat\""+":" +coordinate[0]+ ","+"\"name\""+":"+"\""+LocationData.get(Integer.parseInt(term1[L])-1)+"\""+","+"\"id\""+":"+id+"}"+",";
								tf.write(add.getBytes());
								id++;}}
						else if(j==1){
							cell=row.createCell(c);
							cell.setCellValue("to");
							c++;
							for(L=0;L<term2.length;L++){
								cell=row.createCell(c);
								cell.setCellValue(LocationData.get(Integer.parseInt(term2[L])-1));
								c++;
								coordinate=coordinateData.get(Integer.parseInt(term2[L])-1).split(" ");
								add="{"+"\"lng\""+":" +coordinate[1]+ ","+"\"lat\""+":" +coordinate[0]+ ","+"\"name\""+":"+"\""+LocationData.get(Integer.parseInt(term2[L])-1)+"\""+","+"\"id\""+":"+id+"}"+",";
								tf.write(add.getBytes());
								}}
						else{
							cell=row.createCell(c);
							cell.setCellValue(place[2]+"(Support Rate)");
							c++;
							cell=row.createCell(c);
							cell.setCellValue(place[3]+"(Support Degree)");
							c++;
							cell=row.createCell(c);
							cell.setCellValue(place[4]+"(Confidence Rate)");
							c++;
							cell=row.createCell(c);
							cell.setCellValue(place[5]+"(Confidence Degree)");
							c=0;
							r++;
							add="\r\n";
							tf.write(add.getBytes());
							add=""+num;//写完一列换行
							tf.write(add.getBytes());
							num++;//序号加一
							id=1;
							break;
						}
						}
				
					}
				rf.close();
				Mf.close();
				tf.close();}
				
				  
			catch(IOException e){
				System.out.println("Some thing wrong with reading the file");}
			//输出Excel文件  
			try{
			FileOutputStream output=new FileOutputStream("../Sample data/.xls");  
			wb.write(output);  
			output.flush();
			wb.close();}	  
			catch(IOException e){
				System.out.println("Some thing wrong.");
	  		}
	}
}
