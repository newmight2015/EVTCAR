	package myServlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import myBean.csInformation;
import myBean.position;

import java.util.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.mail.iap.Response;

//import net.sf.json.JSONObject;


public class dealQuery extends HttpServlet {

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	private List<csInformation> csInf=new ArrayList<csInformation>();
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	/* public boolean sendInf(String x,String y) throws IOException{
    	//String host = "219.242.251.168";  //要连接的服务端IP地址
    	 String host="127.0.0.1";
    	// String host = "202.112.148.123";  //要连接的服务端IP地址
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
	     try{
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
	      if(sb.toString().equals("error"))
	      {
	    	  return false;
	      }else{
		    	String[] names = sb.toString().split("\\@"); 
		  		List<String> al=new ArrayList<String>();
		  		for (int i = 0; i < names.length; i++) {  
		  			al.add(names[i]);  
		  		}
		  		String[] str=new String[al.size()];
		  		try{
		  			for(int i=0;i<al.size();i++)
		  			{
		  				str[i]=al.get(i);
		  				String[] pos = str[i].split("\\/"); 
		  				//System.out.println(pos[0]+"  , "+pos[1]+"  ,  "+pos[2]);//分割出经纬度
		  				csInformation buf=new csInformation(pos[0],pos[1],pos[7],pos[8],pos[5],pos[6],pos[2],pos[3],pos[4],"");//发送的数据格式是  经度/纬度/到充电站的距离/充电站的充电桩数/空闲充电桩数/名称/地址/快充数/慢充数
		  				csInf.add(buf);
		  				
		  			}
		  			return true;
		  		}catch(Exception e){
		  			System.out.print("分割错误"+e);
		  			return false;
		  		}
	      }
	     }catch(Exception e){
	    	 System.out.println("接受字符串错误:"+e);
	    	 return false;
	     }
    }*/
    
  
    
	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*csInf.clear();
	    String x=request.getParameter("lng");
		String y=request.getParameter("lat");
		//System.out.println(x+","+y);
		if(sendInf(x,y))
			{
				position p=new position(x,y);
				request.setAttribute("oPosition", p);
				request.setAttribute("cslist", csInf);
				request.setAttribute("errorMessage", "true");
			}else{
				request.setAttribute("errorMessage", "false");
			}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/char_nav.jsp");
		requestDispatcher.forward(request, response);*/
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
