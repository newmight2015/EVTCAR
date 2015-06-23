package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import myBean.dbEntity;
import myBean.messageAlert;
import myBean.usInformation;
import myBean.usOrder;
import myTools.dataBase;

public class dealMessage extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public dealMessage() {
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
	@SuppressWarnings("deprecation")
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String act = request.getParameter("act");
		JSONObject ms = new JSONObject();

		HttpSession ss = request.getSession();
		usInformation usInf = (usInformation)ss.getAttribute("usInf");
		
		System.out.println("---------act:______"+act);
		/**
		 * 检测登录
		 */
		if(act.equals("checkLogin")){
			if(usInf != null){
				try {
					ms.append("isSuccess", true);
					ms.append("message", "已经登录");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else {
				try {
					ms.append("isSuccess", false);
					ms.append("message", "用户未登录");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			out.println(ms.toString());
		}
		
		
		/**
		 * 检测验证码是否正确
		 */
		if(act.equals("checkCode")){
			HttpSession sess = request.getSession();
			String code = (String)sess.getAttribute("rand");
			String ccode = (String)request.getParameter("code");
			if(code.equals(ccode)){
				try {
					ms.append("isSuccess", true);
					ms.append("message", "success");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				try {
					ms.append("isSuccess", false);
					ms.append("message", "fail");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			out.println(ms.toString());
		}
		
		/**
		 * 生成预约订单
		 */
		if(act.equals("produceOrder")){	
			
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd"); 
			//�����õ����ڸ�ʽ����'20010-03-13',�ͱ���Ҫ��ʽ��һ������  
			  String dateBegin = request.getParameter("dateBegin"); 
			  String dateStop = request.getParameter("dateStop");
			  boolean isError = false;
			  System.out.println(dateBegin+" "+dateStop);
			  
			  if(java.sql.Date.valueOf(dateBegin).after(java.sql.Date.valueOf(dateStop))){ 
			   
				  try {
					ms.append("isSuccess", false);
					ms.append("message", "充电结束时间小于预约时间 ,请重新输入");
					isError = true;
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				  
			  } 
			  StringBuffer timeBegin = new StringBuffer(); 
			  StringBuffer timeStop   = new StringBuffer(); 
			  
			  timeBegin.append(request.getParameter("timeBegin")); 
			  timeStop.append(request.getParameter("timeStop")); 
			  System.out.println(timeBegin.toString()+" "+timeStop.toString());
			  if(java.sql.Date.valueOf(dateBegin).equals(java.sql.Date.valueOf(dateStop))){  //��ʼ���ڵ��ڽ������� 
				   if(java.sql.Time.valueOf(timeBegin.toString()).equals(java.sql.Time.valueOf(timeStop.toString()))){ //����ʱ����ͬ
					   try {
						ms.append("isSuccess", false);
						ms.append("message", "两次输入时间相等，请重新输入");
						isError = true;
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				   }
				   else if(java.sql.Time.valueOf(timeBegin.toString()).after(java.sql.Time.valueOf(timeStop.toString()))){
					   try {
							ms.append("isSuccess", false);
							ms.append("message", "充电结束时间小于预约时间 ,请重新输入");
							isError = true;
							} catch (JSONException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
				   }
			  }
			  if(!isError){
				  //ʱ���ʽ��ȷ�����涩����Ϣ
				  try {	
				  /*csId csName csAddr csType*/
				  String csId = request.getParameter("csId");
				  String csName = request.getParameter("csName");
				  String csAddr = request.getParameter("csAddr");
				  String csType = request.getParameter("csType");
				  String USOrdStratTime = dateBegin+" "+timeBegin;
				  String USOrdEndTime = dateStop+" "+timeStop;
				  String usId = usInf.getUsId();
				  String orderStatue = "1";//确认订单
				  usOrder usord =  new usOrder(usId,csId,USOrdStratTime,USOrdEndTime,orderStatue,csType,csName,csAddr);
				  if(usord.saveOrder())
					  {
					  	usord.saveMsg();//保存订单信息
					    ms.append("isSuccess", true);
						ms.append("message", "订单生成成功");
						isError = false;
				  }else{
					    ms.append("isSuccess", false);
						ms.append("message", "订单生成失败");
						isError = true;
				  };
				//  dbEntity db = new dbEntity();
	     	    //  db.SaveOrder(USid,USOrdId,USOrdDate,USOrdStartTime,USOrdEndTime,USOrdStatue,csId);
				  } catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			  }
			  out.println(ms.toString());
		}
		
		
		/**
		 * 按城市搜索充电站
		 */
		if(act.equals("searchCityCS")){ 
			String cityname = request.getParameter("cityname");
			JSONArray csInf = new JSONArray();
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String condition ;
			condition ="Select * from CS_BasicInformation where CSCity LIKE '"+cityname+"%'";
			PreparedStatement sql;
			try {
			sql = con.prepareStatement(condition);
			ResultSet rs = sql.executeQuery();
			while (rs.next()) {
				JSONObject data = new JSONObject();
				data.put("CSId", rs.getString(1));
				data.put("CSName", rs.getString(2).trim());
				data.put("CSAddr", rs.getString(3).trim());
				data.put("CSProvince", rs.getString(4).trim());
				data.put("CSCity", rs.getString(5).trim());
				data.put("CSArea", rs.getString(6).trim());
				data.put("Datetime",rs.getDate(7));
				data.put("CSLatiValue", rs.getFloat(8));
				data.put("CSLongValue", rs.getFloat(9));
				data.put("CSMode",rs.getFloat(10));
				data.put("CSFast", rs.getFloat(11));
				data.put("CSSlow", rs.getFloat(12));
				data.put("CSSum", rs.getFloat(13));
				data.put("OperatorID",rs.getString(14));
				data.put("CSIsOrder",rs.getFloat(15));
				data.put("ParkID",rs.getString(16));
				data.put("ChargeFee", rs.getFloat(17));
				data.put("ServiceFee", rs.getFloat(18));
				if(rs.getString(19)!=null) data.put("Feenotes", rs.getString(19).trim());
				else data.put("Feenotes", "暂无信息");
				data.put("CSPub", rs.getFloat(20));
				data.put("CSState", rs.getFloat(21));
				data.put("CSTime", rs.getString(22));
				if(rs.getString(23)!=null) data.put("CSPhone", rs.getString(23).trim());
				else data.put("CSPhone", "暂无信息");
				if(rs.getString(24)!=null) data.put("CSNotes", rs.getString(24).trim());
				else data.put("CSNotes", "暂无消息");
			//	data.put("CSFeeDay", rs.getFloat(24));
				csInf.put(data);
			}
			db.close(rs, sql, con);
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
		}
		
		/**
		 * 查询订单生成信息
		 */
		if(act.equals("checkMsg")){
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String condition ;
			condition ="SELECT * from UserMessageInf where MsgType = 'createOrd' and USid = '"+usInf.getUsId()+"'";
			System.out.println(condition);
			PreparedStatement sql;
			JSONArray msgInf = new JSONArray();
			try {
				sql = con.prepareStatement(condition);
				ResultSet rs = sql.executeQuery();
				while(rs.next()){
					JSONObject data = new JSONObject();
					try {
						data.put("msgCreatTime",rs.getString(4));
						data.put("msgValue", rs.getString(3));
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					msgInf.put(data);
				}
				db.close(rs, sql, con);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			out.println(msgInf.toString());
			
		}
		
		/**
		 * 查询最新订单信息
		 */
		if(act.equals("checkNewOrder")){
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String condition ;
			condition ="SELECT * from UserOrderInf where USOrdStatue = '1' and USid = '"+usInf.getUsId()+"' ORDER BY USOrdId DESC";
			System.out.println(condition);
			PreparedStatement sql;
			JSONArray msgInf = new JSONArray();
			try {
				sql = con.prepareStatement(condition);
				ResultSet rs = sql.executeQuery();
				while(rs.next()){
					JSONObject data = new JSONObject();
					try {
						data.put("USOrdId",rs.getString(1));
						data.put("USOrdCsName", rs.getString(9));
						data.put("USOrdCsAddr", rs.getString(10));
						data.put("USOrdStartTime", rs.getString(5));
						data.put("USOrdEndTime", rs.getString(6));
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					msgInf.put(data);
				}
				db.close(rs, sql, con);
				
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			out.println(msgInf.toString());
			
		}
		try {
			System.out.println(ms.get("message"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			System.out.println("NO message!");
		}
		
		out.flush();
		out.close();
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
		this.doGet(request, response);
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
