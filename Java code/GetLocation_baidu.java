import java.net.HttpURLConnection;
import java.net.URL;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;

public class GetLocation_baidu{
	public static String GetLocationMsg(double latitude,double longitude){
       String lng = ""+longitude;
       String lat = ""+latitude;
       String address = "";
       try{
           URL url = new URL("http://api.map.baidu.com/geocoder/v2/?ak=iv8RtS59gfmypSiLrWym26EmxcmQy3nf&callback=renderReverse&location="+ lat + "," + lng + "&output=json&pois=1");
           HttpURLConnection ucon = (HttpURLConnection) url.openConnection();
           ucon.connect();
           java.io.InputStream in = ucon.getInputStream();
           BufferedReader reader = new BufferedReader(new InputStreamReader(in,"UTF-8"));
           String str = reader.readLine(); 
           str = str.substring(str.indexOf("(") + 1, str.length()-1);
           JSONObject jsonObject = JSONObject.fromObject(str);
           address = jsonObject.getJSONObject("result").getString("formatted_address");
           JSONArray jsonArray = JSONArray.fromObject(jsonObject.getJSONObject("result").getString("pois"));
           address = address+(JSONObject.fromObject(jsonArray.get(0))).getString("name"); 
       }catch(Exception e){
           e.printStackTrace(); 
       }
       return address;
	}
	
public static void main(String[] args) { 
	String readFile, writeFile;
	String data;
	String[] content;
	String add;
	double time=0;
	double timeStamp;
	try{
		readFile="../Sample data/stayPointTrace.txt";
		RandomAccessFile rf= new RandomAccessFile(readFile,"rw");
		writeFile="../Sample data/locationTrace.txt";
		RandomAccessFile wf= new RandomAccessFile(writeFile,"rw");
		
		while(true){
			data = rf.readLine();
			if (data==null){
				break;}
			content=data.split("	");
			if(time==0){
				time=Double.parseDouble(content[4]);
				}
			else{
				timeStamp=Double.parseDouble(content[4])-time;
				if (timeStamp>=1){
					wf.write("Ò»Ìì½áÊø\r\n".getBytes());
					time=0;
				}
			}
			add = GetLocationMsg(Double.parseDouble(content[1]), Double.parseDouble(content[2])); 
			add = add+","+content[1]+" "+ content[2]+"\r\n";
			wf.write(add.getBytes());
		}
		rf.close();
		wf.close();		
		}
	catch(IOException e){
		System.out.println("Some thing wrong with reading the file");}	
		
	}
}