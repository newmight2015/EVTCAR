package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import myBean.usInformation;
import myTools.dataBase;

import org.json.JSONArray;
import org.json.JSONException;
//import org.json.JSONException;
import org.json.JSONObject;

public class dealPhoneRegister extends HttpServlet {

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
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
	}

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


		String usId=request.getParameter("username").trim();
		String usMail=request.getParameter("email").trim();
		String usPhoneNum=request.getParameter("tel").trim(); 
		String usPassWd=request.getParameter("password").trim();
		 	     
        String insertCondition ="INSERT UserPerInf VALUES(?,?,?,?,?,?,?,?)";             
        try {
     	   dataBase  db= new dataBase();
           Connection con =db.getConnection(); 
           PreparedStatement sql;
           sql = con.prepareStatement(insertCondition);
		
	       sql.setString(1, usId);
	       sql.setString(2, usPassWd);
	       sql.setString(3, usMail);
	       sql.setString(4, usPhoneNum);
	       sql.setString(5, "");
	       sql.setString(6, "");
	       sql.setString(7, "");
	       sql.setString(8, "");
	       		   
	       int m= sql.executeUpdate();
	       System.out.print(insertCondition);
	       if(m!=0)  
	       {
	    	   
	           JSONArray ja = new JSONArray();
	           String buff = null;
	           Map<String, String> map1 = new HashMap<String, String>();
			   map1.put("PUser", usId);
			   ja.put(map1);
			   map1.clear();
			   buff=ja.toString();
	           try{
	           	  PrintWriter out = response.getWriter(); 
	              out.write(new String(buff));  
	              out.flush();  
	              out.close();//¹Ø±Õ   
	               }catch(Exception e){  
	               System.out.println(e);  
	               e.printStackTrace();  
	           }
	       }    		  
           con.close();      
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
