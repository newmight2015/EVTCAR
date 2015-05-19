package myServlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
//import org.json.JSONException;
import org.json.JSONObject;

//import ServerTest.Employee;
//import ServerTest.JsonHelper;

import myBean.csInformation;

public class dealPhoneQuery extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//csInf.clear();
	//	System.out.println("111");
	    double x=Double.parseDouble(request.getParameter("lng"));
		double y=Double.parseDouble(request.getParameter("lat"));
	    System.out.println(x+","+y);
	    String buff=sendInf(x,y);
	//	request.setAttribute("cslist", csInf);
	    //System.out.println(buff); 
	    response.setContentType("text/html");  
        response.setCharacterEncoding("UTF-8");  
  
       try{  
           PrintWriter out = response.getWriter(); 
           out.write(new String(buff));  
           out.flush();  
           out.close();//关闭   
            }catch(Exception e){  
            System.out.println(e);  
            e.printStackTrace();  
        }
	
	//	RequestDispatcher requestDispatcher = request.getRequestDispatcher("/char_nav.jsp");
	//	requestDispatcher.forward(request, response);
	}
    public String sendInf(double x,double y) throws IOException{
    	// String host = "219.242.251.168";  //要连接的服务端IP地址
    //	String host = "202.112.148.123";  //要连接的服务端IP地址
    	String host = "127.0.0.1";
	     int port = 10001;   //要连接的服务端对应的监听端口  
	     //与服务端建立连接  
	  //   System.out.println("等待连接");
	     Socket client = new Socket(host, port); 
	      //建立连接后就可以往服务端写数据了  
	     System.out.println("连接上服务器");
	     Writer writer = new OutputStreamWriter(client.getOutputStream());  
	    
		 writer.write(x+","+y);	  
	     writer.flush();  
	      //写完以后进行读操作  
	      	 BufferedReader br = new BufferedReader(new InputStreamReader(client.getInputStream()));  
	         StringBuilder sb = new StringBuilder();  
	         String temp;  
	         int index;  
	         while ((temp=br.readLine()) != null) {  
	             System.out.println(temp);  
	             if ((index = temp.indexOf("eof")) != -1) {//遇到eof时就结束接收  
	            	sb.append(temp.substring(0, index));  
	                break;  
	            }  
	            sb.append(temp);  
	         }  
	      System.out.println("from z: " + sb);
	      SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
	      System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
	      
	      writer.close();   
	      br.close();
	      client.close(); 
	     return getPos(sb.toString());//获得经纬度坐标
    }
    
    public String getPos(String value){
    	//String value = "116.3515142837/39.9566621706-116.362087/39.948485-116.331648/39.971901-116.320111/39.969693-116.341008/39.978887-116.347075/39.990632-116.337128/39.999783-116.344762/39.977471-116.367529/39.982601-116.373446/39.984241-116.307747/39.981019";  
    	JSONObject jo = new JSONObject();
    	JSONArray ja = new JSONArray();
    	Map<String, String> map1 = new HashMap<String, String>();
    	String[] names = value.split("\\@"); 
		List<String> al=new ArrayList<String>();
		for (int i = 0; i < names.length; i++) {  
			al.add(names[i]);  
		}
		String[] str=new String[al.size()];
		 
		for(int i=0;i<3;i++)
		{
			str[i]=al.get(i);
			String[] pos = str[i].split("\\/"); 
			map1.put("lng", pos[0]);
			map1.put("lat", pos[1]);
			map1.put("csName", pos[5]);
			map1.put("csAddr", pos[6]);
			map1.put("csAllNum", pos[3]);
			map1.put("csFreeNum", pos[4]);
			map1.put("csDistance", pos[2]);
			map1.put("csFastNum", pos[7]);
			map1.put("csSlowNum", pos[8]);
			ja.put(map1);
			map1.clear();
			//System.out.println(pos[0]+","+pos[1]);//分割出经纬度
			//csInformation buf=new csInformation(pos[0],pos[1],0,0,"");
			//csInf.add(buf);
		}
		System.out.println(ja.toString());
		/*try {
			jo.put("pos", ja);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		return ja.toString();
		
    }
    
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
