package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import myBean.usInformation;
import myBean.wrongMessage;
import myTools.dataBase;


public class dealLogin extends HttpServlet {

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
		  Logger logger = Logger.getLogger(dealLogin.class.getName());
		   //如果指定logger名字，则是把日志，输出到pay-log 指定的日志文件中去
		 // Logger logger = Logger.getLogger("pay-log");
		  //MyLog4j.getSomething();
		  
		  
		String username=request.getParameter("username").trim();
		String password=request.getParameter("password").trim();
		String checkcode=request.getParameter("checkcode").trim();
		usInformation usInf;
		List<String> errors = new ArrayList();
		wrongMessage wm= new wrongMessage();
		HttpSession session = request.getSession();
		String rand=(String)session.getAttribute("rand");
		if(!checkcode.equals(rand)) {
			errors.add("验证码输入错误");
			wm.setErrors(errors);
			request.setAttribute("Error",wm);
			RequestDispatcher dispather=request.getRequestDispatcher("login.jsp");
			dispather.forward(request,response);
		}else{
					usInf=(usInformation)session.getAttribute("usInf");
					if(usInf!=null){
						System.out.println("login session----->"+usInf);
						System.out.println("login name1----->"+usInf.getUsId());
					}
					if(isLogin(username,password,session))
					{
								usInf=(usInformation)session.getAttribute("usInf"); 
								System.out.println("login name3----->"+usInf.getUsId());
								RequestDispatcher dispather=request.getRequestDispatcher("searchCS.jsp");
								dispather.forward(request,response);
					}else 
					{
							errors.add("输入的用户名或密码错误！");
							wm.setErrors(errors);
							request.setAttribute("Error",wm);
							request.getRequestDispatcher("login.jsp").forward(request,response);
						}
				}
		
		
			//usInformation usInf=(usInformation)session.getAttribute("usInf");
			
		
	}

/*****************确认输入的用户名和密码是否正确*****************/
public boolean isLogin(String username,String password,HttpSession session ) {
	boolean flag = false;
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
		
		if (rs.next()) {
			flag = true;
			usInformation usInf=new usInformation(rs.getString(1), rs.getString(2),  rs.getString(3),rs.getString(4), rs.getString(5),rs.getString(6),  rs.getString(7),rs.getString(8));
			
			
			session.setAttribute("usInf",usInf); 
	    	System.out.println("用户名>>>>>>>>"+usInf.getUsId()+","+usInf.getUsPassWd()+"登录");
		}
		mc.close(rs, pstm, conn);
	} catch (Exception ex) {
		ex.printStackTrace();
	} 

	return flag;
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
