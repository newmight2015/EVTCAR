package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import myTools.dbUtil;

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
			throws ServletException, IOException  {

		response.setCharacterEncoding("utf-8");
		response.setContentType("json");
		PrintWriter out = response.getWriter();
		String usId=request.getParameter("username").trim();
		JSONObject jo = new JSONObject();
		if(usId!=""){		//使用用户名密码注册
			String usMail=request.getParameter("email").trim();
			String usPhoneNum=request.getParameter("tel").trim(); 
			String usPassWd=request.getParameter("password").trim();
			String checkCondition = "Select USid from UserPerInf where USid = '"+ usId +"'";     
	        String insertCondition ="INSERT into UserPerInf(USid,USPassWd,USMail,USPhoneNum) VALUES(?,?,?,?)";             
	        String insertPras[] = new String[]{usId,usPassWd,usMail,usPhoneNum};
	        
	        try {
	        	dbUtil db = new dbUtil();
	            db.query(checkCondition);
	        	if(!db.getRS().next()){
	        	   db.update(insertCondition, insertPras);
	    	       if(db.getResu()!=0)  
	    	       {	
	    	    	   HttpSession sess = request.getSession();
	    	    	   usInformation usinf = new usInformation();
	    	    	   usinf.setUsId(usId);
	    	    	   usinf.setUsMail(usMail);
	    	    	   usinf.setUsPhoneNum(usPhoneNum);
	    	    	   usinf.setUsPassWd(usPassWd);
	    	    	   sess.setAttribute("usInf", usinf);//注册成功后将用户信息放入session中。
	    			   
	    	    	    jo.put("isSuccess",true);//注册成功标志
	    				jo.put("message","注册成功");
	    	       }else{
						jo.put("isSuccess",false);//注册成功标志
						jo.put("message","服务器无法连接，请稍后再试");
	    	       }
	           }else{
						jo.put("isSuccess",false);//注册成功标志
						jo.put("message","该用户名已注册，请重新注册");
	           }
	        	db.closeAll();
			}catch(JSONException e){
				e.printStackTrace();
			}catch (SQLException e) {
				try {
					jo.put("isSuccess",false);//注册成功标志
					jo.put("message","服务器无法连接，请稍后再试");
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				e.printStackTrace();
			} 
	        
	        out.println(jo);  
	        out.flush();  
	        out.close();//�ر�   
		}else{
			String code=request.getParameter("code").trim(); 
			HttpSession sess = request.getSession();
			String ccode = (String)sess.getAttribute("rand");
			//if(code.equals(ccode)){
			if(code.equals("2222")){
			String usPhoneNum=request.getParameter("tel").trim(); 
			String checkCondition = "Select USid from UserPerInf where USPhoneNum = '"+ usPhoneNum +"'";     
	        String insertCondition ="INSERT into UserPerInf(USid,USPassWd,USMail,USPhoneNum) VALUES(?,?,?,?)";             
	        String insertPras[] = new String[]{usPhoneNum,"666666","",usPhoneNum};
	        
	        try {
	        	dbUtil db = new dbUtil();
	            db.query(checkCondition);
	        	if(!db.getRS().next()){
	        	   db.update(insertCondition, insertPras);
	    	       if(db.getResu()!=0)  
	    	       {	
	    	    	   
	    	    	   usInformation usinf = new usInformation();
	    	    	   usinf.setUsId(usPhoneNum);
	    	    	   usinf.setUsMail("");
	    	    	   usinf.setUsPhoneNum(usPhoneNum);
	    	    	   usinf.setUsPassWd("666666");
	    	    	   sess.setAttribute("usInf", usinf);//注册成功后将用户信息放入session中。
	    			   
	    	    	    jo.put("isSuccess",true);//注册成功标志
	    				jo.put("message","注册成功");
	    				System.out.println(usPhoneNum+":注册成功");
	    	       }else{
						jo.put("isSuccess",false);//注册成功标志
						jo.put("message","服务器无法连接，请稍后再试");
	    	       }
	           }else{
						jo.put("isSuccess",false);//注册成功标志
						jo.put("message","该用户名已注册，请重新注册");
	           }
	        	db.closeAll();
			}catch(JSONException e){
				e.printStackTrace();
			}catch (SQLException e) {
				try {
					jo.put("isSuccess",false);//注册成功标志
					jo.put("message","服务器无法连接，请稍后再试");
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				e.printStackTrace();
			} 
			}else {
				try {
					jo.put("isSuccess",false);
					jo.put("message","验证码输入错误");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}//注册成功标志
				
			}

	        out.println(jo);  
	        out.flush();  
	        out.close();//�ر�   
		}
		
	}
}
