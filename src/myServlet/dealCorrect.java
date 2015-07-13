package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import myTools.dataBase;
import myBean.usInformation;
import myBean.usOrder;



public class dealCorrect extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public dealCorrect() {
		super();
	}

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
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
		
		HttpSession ss = request.getSession();
		usInformation usInf = (usInformation)ss.getAttribute("usInf");
		
		String  CSId,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes;
		System.out.println("进入dealCorrect");
		CSId=new String( request.getParameter("changedata0").getBytes("iso8859-1"), "utf-8");		
		CSName=new String( request.getParameter("changedata1").getBytes("iso8859-1"), "utf-8");
		CSAddr=new String( request.getParameter("changedata2").getBytes("iso8859-1"), "utf-8");
		CSDate=new String( request.getParameter("changedata3").getBytes("iso8859-1"), "utf-8");
		CSMode=new String( request.getParameter("changedata4").getBytes("iso8859-1"), "utf-8");
		CSFast=new String( request.getParameter("changedata5").getBytes("iso8859-1"), "utf-8");
		CSlow=new String( request.getParameter("changedata6").getBytes("iso8859-1"), "utf-8");
		Operator=new String( request.getParameter("changedata7").getBytes("iso8859-1"), "utf-8");
		ParkFee=new String( request.getParameter("changedata8").getBytes("iso8859-1"), "utf-8");
		CSPub=new String( request.getParameter("changedata9").getBytes("iso8859-1"), "utf-8");
		CSState=new String( request.getParameter("changedata10").getBytes("iso8859-1"), "utf-8");
		CSPhone=new String( request.getParameter("changedata11").getBytes("iso8859-1"), "utf-8");
		CSNotes=new String( request.getParameter("changedata12").getBytes("iso8859-1"), "utf-8");
		String usId = usInf.getUsId();
		System.out.println(CSId+CSName+CSAddr+CSDate+CSMode+CSFast+CSlow+Operator+ParkFee+CSPub+CSState+CSPhone+CSNotes);
		  
		  boolean isError = false;
		  
		String sql="insert into CS_correction(CSID,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes,USID) "
				+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		 try {
	     	   dataBase  db= new dataBase();
	           Connection con =db.getConnection(); 
	           PreparedStatement ps;
	           ps= con.prepareStatement(sql);
	               
	                ps.setString(1, CSId);
		       		ps.setString(2, CSName);
		       		ps.setString(3, CSAddr);
		       		ps.setString(4, CSDate);
		       		ps.setString(5, CSMode);
		       		ps.setString(6, CSFast);
		       		ps.setString(7, CSlow);
		       		ps.setString(8, Operator);
		       		ps.setString(9, ParkFee);
		       		ps.setString(10, CSPub);
		       		ps.setString(11, CSState);
		       		ps.setString(12, CSPhone);
		       		ps.setString(13, CSNotes);
		       		ps.setString(14, usId);
      		   
		       int m= ps.executeUpdate();
		       System.out.print(sql);
		       if(m!=0)  
		       {
		    	   System.out.println("提交信息成功");
				    ms.append("isSuccess", true);
					ms.append("message", "提交信息成功");
					isError = false;
					request.setAttribute("message", "true");
		       }else{
				    ms.append("isSuccess", false);
					ms.append("message", "提交信息失败");
					isError = true;
					request.setAttribute("message", "false");
		       }    		  
	           con.close();      
			}catch (SQLException e) {
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		 RequestDispatcher dispatcher = request.getRequestDispatcher("/searchCS.jsp");

		 dispatcher .forward(request, response);
			  
		  
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
