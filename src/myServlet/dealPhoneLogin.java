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

		String username=request.getParameter("username").trim();
		String password=request.getParameter("password").trim();
		
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
			System.out.println("这是要用到的sql………………："+sql);
			System.out.println("@@@@@@@@要查询的用户名："+username);
			rs = pstm.executeQuery();
			JSONArray ja = new JSONArray();
			if (rs.next()) {
		    		Map<String, String> map1 = new HashMap<String, String>();
					map1.put("USid", rs.getString(1));
					map1.put("USPassWd",rs.getString(2));
					map1.put("USMail", rs.getString(3));
					map1.put("USPhoneNum",rs.getString(4));
					map1.put("USCity", rs.getString(5));
					map1.put("USCarType", rs.getString(6));
					map1.put("USBatType", rs.getString(7));
					map1.put("USCarNum", rs.getString(8));
					ja.put(map1);
					map1.clear();
			}else {
					ja.put("你输入的用户名或密码有误！");
			}
			String buff=ja.toString();
			mc.close(rs, pstm, conn);
			try{
	           	  PrintWriter out = response.getWriter(); 
	              out.write(new String(buff));  
	              out.flush();  
	              out.close();//关闭   
	               }catch(Exception e){  
	               System.out.println(e);  
	               e.printStackTrace();  
	           }
		} catch (Exception ex) {
			ex.printStackTrace();
		} 
	}
}
