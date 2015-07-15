package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.JSONArray;
import org.json.JSONObject;

import myBean.usInformation;
import myBean.wrongMessage;
import myTools.dataBase;

public class dealPhoneLogin extends HttpServlet {

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
	private static  final transient Logger log = Logger.getLogger(dealLogin.class);
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
		
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
		String username=request.getParameter("username").trim();
		String password=request.getParameter("password").trim();
		System.out.println("____phonelogin:"+username);
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = null;
		dataBase mc = new dataBase();
	    sql = "select * from UserPerInf  where USid=? and USPassWd=?";
		try {
			Connection conn=mc.getConnection();
			pstm=conn.prepareStatement(sql);
			pstm.setString(1, username);
			pstm.setString(2, password);
			rs = pstm.executeQuery();
			JSONObject jo = new JSONObject();
			if (rs.next()){
					String usid = rs.getString("USid");
					String usphone = rs.getString("USPhoneNum");
					String usmail = rs.getString("USMail");
					String coin = rs.getString("USCoin");
					JSONObject usinf = new JSONObject();//存放用户信息
					usinf.put("USid", usid);
					usinf.put("USPhone", usphone);
					usinf.put("USMail", usmail);
					usinf.put("USCoin", coin);
					
					HttpSession ss = request.getSession();
					usInformation usInf = new usInformation();
					usInf.setUsId(usid);
					usInf.setUsPhoneNum(usphone);
					usInf.setUsMail(usmail);
					ss.setAttribute("usInf", usInf);
					
					ss.setAttribute("usSessId", ss.getId());
					
					log.info("____phoneloginsession:"+ss.getId());
					jo.put("isSuccess",true);//登录成功标志
					jo.put("message",usinf);
			}else {
					jo.put("isSuccess",false);//登录失败
					jo.put("message","登录失败");
			}
			mc.close(rs, pstm, conn);
			try{
	           	  PrintWriter out = response.getWriter(); 
	              out.println(jo.toString());  
	              out.flush();  
	              out.close();
	        }catch(Exception e){  
	               System.out.println(e);  
	               e.printStackTrace();  
	           }
		} catch (Exception ex) {
			ex.printStackTrace();
		} 
	}
}
