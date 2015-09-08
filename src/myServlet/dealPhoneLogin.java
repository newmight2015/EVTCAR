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

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import myBean.usInformation;
import myBean.wrongMessage;
import myTools.dataBase;
import myTools.dbUtil;

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
		JSONObject jo = new JSONObject();
		PrintWriter out = response.getWriter(); 
		if(username!=null){
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
				
				if (rs.next()){
					String usid,usphone,usmail,coin,uscity,usname,uslevel,usphoto,usintr,uscontr;
					usid = rs.getString("USid");
					usphone = rs.getString("USPhoneNum");
					usmail = rs.getString("USMail");
					coin = rs.getString("USCoin");
					if(rs.getString("USCity")!=null){
						uscity=rs.getString("USCity");
					}else{
						uscity="0";
					}
					if(rs.getString("USName")!=null){
						usname=rs.getString("USName");
					}else{
						usname="0";
					}
					if(rs.getString("USLevel")!=null){
						uslevel=rs.getString("USLevel");
					}else{
						uslevel="0";
					}
					if(rs.getString("USPhoto")!=null){
						usphoto=rs.getString("USPhoto");
					}else{
						usphoto="0";
					}
					if(rs.getString("USIntroduction")!=null){
						usintr=rs.getString("USIntroduction");
					}else{
						usintr="0";
					}
					if(rs.getString("USContribute")!=null){
						uscontr=rs.getString("USContribute");
					}else{
						uscontr="0";
					}
					JSONObject usinf = new JSONObject();//存放用户信息
					usinf.put("USid", usid);
					usinf.put("USPhone", usphone);
					usinf.put("USMail", usmail);
					usinf.put("USCoin", coin);
					usinf.put("USCity", uscity);
					usinf.put("USName", usname);
					usinf.put("USLevel", uslevel);
					usinf.put("USPhoto", usphoto);
					usinf.put("USIntroduction", usintr);
					usinf.put("USContribute", uscontr);
					
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
				
              out.println(jo.toString());  
              out.flush();  
              out.close();
		        
			} catch (Exception ex) {
				ex.printStackTrace();
			} 
		}else{
			String code=request.getParameter("code").trim();
			HttpSession sess = request.getSession();
			String ccode = (String)sess.getAttribute("rand");
			if(code.equals("2222")){
			//if(code.equals(ccode)){
				dbUtil db = new dbUtil();
				String sql = "select * from UserPerInf  where USid='"+username+"'";
				db.query(sql);
			    ResultSet rs = db.getRS();
					try {
						if (rs.next()){
							    String usid,usphone,usmail,coin,uscity,usname,uslevel,usphoto,usintr,uscontr;
								usid = rs.getString("USid");
								usphone = rs.getString("USPhoneNum");
								usmail = rs.getString("USMail");
								coin = rs.getString("USCoin");
								if(rs.getString("USCity")!=null){
									uscity=rs.getString("USCity");
								}else{
									uscity="0";
								}
								if(rs.getString("USName")!=null){
									usname=rs.getString("USName");
								}else{
									usname="0";
								}
								if(rs.getString("USLevel")!=null){
									uslevel=rs.getString("USLevel");
								}else{
									uslevel="0";
								}
								if(rs.getString("USPhoto")!=null){
									usphoto=rs.getString("USPhoto");
								}else{
									usphoto="0";
								}
								if(rs.getString("USIntroduction")!=null){
									usintr=rs.getString("USIntroduction");
								}else{
									usintr="0";
								}
								if(rs.getString("USContribute")!=null){
									uscontr=rs.getString("USContribute");
								}else{
									uscontr="0";
								}
								JSONObject usinf = new JSONObject();//存放用户信息
								usinf.put("USid", usid);
								usinf.put("USPhone", usphone);
								usinf.put("USMail", usmail);
								usinf.put("USCoin", coin);
								usinf.put("USCity", uscity);
								usinf.put("USName", usname);
								usinf.put("USLevel", uslevel);
								usinf.put("USPhoto", usphoto);
								usinf.put("USIntroduction", usintr);
								usinf.put("USContribute", uscontr);
								
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
					} catch (SQLException | JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally{
						db.closeAll();
					}
					
				}else{
				try {
					jo.put("isSuccess",false);
					jo.put("message","验证码输入错误");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}//注册成功标志
			}
			out.println(jo.toString());  
            out.flush();  
            out.close();
		}
	}
}
