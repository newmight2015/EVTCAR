package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import myTools.dataBase;
import myBean.usInformation;

public class dealRegister extends HttpServlet {

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

		String usId=request.getParameter("username").trim();
		String usMail=request.getParameter("email").trim();
		String usPhoneNum=request.getParameter("tel").trim(); 
		String usPassWd=request.getParameter("password").trim();
		String checkCondition = "Select USid from UserPerInf where USid = '"+ usId +"'"; 	     
        String insertCondition ="INSERT UserPerInf(USid,USPassWd,USMail,USPhoneNum) VALUES(?,?,?,?)";             

        try {
     	   dataBase  db= new dataBase();
           Connection con =db.getConnection(); 
           
           PreparedStatement sql = con.prepareStatement(checkCondition);
           ResultSet rs = sql.executeQuery();

	       JSONObject jo = new JSONObject();
           if(!rs.next()){
        	   sql = con.prepareStatement(insertCondition);
        	   sql.setString(1, usId);
    	       sql.setString(2, usPassWd);
    	       sql.setString(3, usMail);
    	       sql.setString(4, usPhoneNum);
    	       int m= sql.executeUpdate();
    	       if(m!=0)  
    	       {	
    	    	   HttpSession sess = request.getSession();
    	    	   usInformation usinf = new usInformation();
    	    	   usinf.setUsId(usId);
    	    	   usinf.setUsMail(usMail);
    	    	   usinf.setUsPhoneNum(usPhoneNum);
    	    	   usinf.setUsPassWd(usPassWd);
    	    	   sess.setAttribute("usInf", usinf);//注册成功后将用户信息放入session中。
    	       }      
           } 
           db.close(rs, sql, con);
        }catch (SQLException e) {
			e.printStackTrace();
		}
	    RequestDispatcher dispathcer =request.getRequestDispatcher("searchCS.jsp");
		dispathcer.forward(request,response);	
		
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
