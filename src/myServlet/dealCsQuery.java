package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import myTools.dataBase;

public class dealCsQuery extends HttpServlet {

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
		JSONArray csInf = new JSONArray();
		
		//String csarea=request.getParameter("csarea").trim();
		String cstype=request.getParameter("cstype").trim();
		
		dataBase db=new dataBase();
		Connection con =db.getConnection();
		String condition = "Select * from 充电站静态数据表 where CSState="+cstype;
		PreparedStatement sql;
		
		try {
		sql = con.prepareStatement(condition);
		ResultSet rs = sql.executeQuery();
		while (rs.next()) {
			JSONObject data = new JSONObject();
			data.put("cslng", rs.getFloat(6));
			data.put("cslat", rs.getFloat(5));
			data.put("csFastNum", rs.getString(7).trim());
			data.put("csSlowNum", rs.getString(8).trim());
			data.put("csName", rs.getString(1).trim());
			data.put("csAddr", rs.getString(4).trim());
			data.put("csAreaCode",rs.getString(9).trim());
			data.put("csAllNum", rs.getString(10));
			data.put("csFreeNum","");
			data.put("csState", "");
			csInf.put(data);
		}
		rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 //System.out.print(csInfPos.get(0).getCsName()+","+csInfPos.get(0).getCsAddr()+"   ");
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(csInf);
		out.flush();
		out.close();
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
