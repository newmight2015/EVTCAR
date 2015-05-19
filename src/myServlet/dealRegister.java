package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	    	   usInformation usInf=new usInformation(usId,  usPassWd,  usMail,usPhoneNum, "",  "",  "","");
	    	   HttpSession session = request.getSession(true);
	    	   session.setAttribute("usInf",usInf); 
	       }    		  
           con.close();      
		} catch (SQLException e) {
			e.printStackTrace();
		}
	    RequestDispatcher dispathcer =request.getRequestDispatcher("index.jsp");
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
