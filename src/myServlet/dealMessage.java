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
import java.util.TreeMap;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import myBean.ApplicationConstants;
import myBean.dbEntity;
import myBean.messageAlert;
import myBean.usInformation;
import myBean.usOrder;
import myTools.dataBase;
import myTools.dbUtil;
import myTools.sort;
import myTools.utils;

public class dealMessage extends HttpServlet {
	private static  final transient Logger log = Logger.getLogger(dealMessage.class);
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
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		//ServletActionContext.getResponse().setHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		String act = request.getParameter("act");
		JSONObject ms = new JSONObject();

		HttpSession ss = request.getSession();
		usInformation usInf = (usInformation)ss.getAttribute("usInf");
		//log.info(ss.getId());
		log.info("---------act:______"+act);
		/*
		 * 功能：修改密码
		 */
		if(act.equals("changepassword")){
			System.out.println("进入servlet"+act);
			String UsId=usInf.getUsId();
			String uspassword=new String( request.getParameter("uspassword1").getBytes("iso8859-1"), "utf-8");
			JSONArray Msg = new JSONArray();
			dbUtil db = new dbUtil();
			String sql="update UserPerInf set USPassWd=? where 	Usid=?";
			String pras[] = new String[]{uspassword,UsId};
			db.update(sql,pras);
			try {
			       if(db.getResu()!=0)  
			       {
			    	    log.info("修改密码成功");
			    	    JSONObject data = new JSONObject();
						data.put("isSuccess", "true");
						data.put("message", "修改密码成功");
						Msg.put(data);
			       }else{
			    	    log.info("修改密码失败");
			    	   	JSONObject data = new JSONObject();
					    data.put("isSuccess", "false");
						data.put("message", "修改密码失败");
						Msg.put(data);
			       }    		  
		           //con.close();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println(Msg);
			out.println(Msg);
			out.flush();
			out.close();
		}
		/*
		 * 功能：修改个人信息
		 */
		if(act.equals("saveusinf")){
			System.out.println("进入servlet"+act);
			String UsId=usInf.getUsId();
			String usemail,usphone,uscity,usnotes;
			//usname=new String( request.getParameter("usname").getBytes("iso8859-1"), "utf-8");
			usemail=new String( request.getParameter("usemail").getBytes("iso8859-1"), "utf-8");
			usphone=new String( request.getParameter("usphone").getBytes("iso8859-1"), "utf-8");
			uscity=new String( request.getParameter("uscity").getBytes("iso8859-1"), "utf-8");
			usnotes=new String( request.getParameter("usnotes").getBytes("iso8859-1"), "utf-8");
			JSONArray Msg = new JSONArray();
			dbUtil db = new dbUtil();
			String sql="update UserPerInf set USMail=?,USPhoneNum=?,USCity=?,USIntroduction=? where Usid=?";
			String pras[] = new String[]{usemail,usphone,uscity,usnotes,UsId};
			db.update(sql,pras);
			try {
			       if(db.getResu()!=0)
			       {
			    	    log.info("修改个人资料成功");
			    	    JSONObject data = new JSONObject();
						data.put("isSuccess", "true");
						data.put("message", "修改个人资料成功");
						Msg.put(data);
			       }else{
			    	    log.info("修改个人资料失败");
			    	   	JSONObject data = new JSONObject();
					    data.put("isSuccess", "false");
						data.put("message", "修改个人资料失败");
						Msg.put(data);
			       }    		  
		           //con.close();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println(Msg);
			out.println(Msg);
			out.flush();
			out.close();
		}
		/*
		 * 功能：分享充电站
		 */
		if(act.equals("csshare")){
			System.out.println("进入servlet："+act);
			String UsId=usInf.getUsId();
			String csname,csfast,cslow,operator,cspub,csstate,parkfee,csphone,csnotes,cslng,cslat;
			csname=new String( request.getParameter("csname").getBytes("iso8859-1"), "utf-8");
			cslng=new String( request.getParameter("cslng").getBytes("iso8859-1"), "utf-8");
			cslat=new String( request.getParameter("cslat").getBytes("iso8859-1"), "utf-8");
			csfast=new String( request.getParameter("csfast").getBytes("iso8859-1"), "utf-8");
			cslow=new String( request.getParameter("cslow").getBytes("iso8859-1"), "utf-8");
			operator=new String( request.getParameter("operator").getBytes("iso8859-1"), "utf-8");
			cspub=new String( request.getParameter("cspub").getBytes("iso8859-1"), "utf-8");
			csstate=new String( request.getParameter("csstate").getBytes("iso8859-1"), "utf-8");
			parkfee=new String( request.getParameter("parkfee").getBytes("iso8859-1"), "utf-8");
			csphone=new String( request.getParameter("csphone").getBytes("iso8859-1"), "utf-8");
			csnotes=new String( request.getParameter("csnotes").getBytes("iso8859-1"), "utf-8");
			JSONArray Msg = new JSONArray();
			dbUtil db = new dbUtil();
			String sql="insert into CS_Share(SCSName,SCSLat,SCSLng,SCSFast,SCSLow,SOperator,SCSPub,SCSState,SParkFee,SCSPhone,SCSNotes,USId) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?)";
			String pras[] = new String[]{csname,cslat,cslng,csfast,cslow,operator,cspub,csstate,parkfee,csphone,csnotes,UsId};
			db.update(sql, pras);
			try {
			       if(db.getResu()!=0)  
			       {
			    	    log.info("分享信息提交成功");
			    	    JSONObject data = new JSONObject();
						data.put("isSuccess", "true");
						data.put("message", "提交信息成功");
						Msg.put(data);
			       }else{
			    	    log.info("分享信息提交失败");
			    	   	JSONObject data = new JSONObject();
					    data.put("isSuccess", "false");
						data.put("message", "提交信息失败");
			       }    		  
		           //con.close();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println(Msg);
			out.println(Msg);
			out.flush();
			out.close();

		}
		/*
		 * 功能：删除消息提醒的最新消息，放入历史消息中
		 */
		if(act.equals("deleteOldMsg")){
			System.out.println("进入servlet："+act);
			String UsId=usInf.getUsId();
			String CSId=new String( request.getParameter("msgid").getBytes("iso8859-1"), "utf-8");
			response.setContentType("text/html");
			JSONArray Msg = new JSONArray();
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String sql;
			sql="update UserMessageInf set MsgState='3' where USid='"+UsId+"' and id='"+CSId+"'";
			PreparedStatement ps;
			try {
				System.out.println(sql);
				ps = con.prepareStatement(sql);
				int rs = ps.executeUpdate();
				if(rs!=0) {
					JSONObject data = new JSONObject();
					data.put("isSuccess", "true");
					Msg.put(data);
				}else{
					JSONObject data = new JSONObject();
					data.put("isSuccess", "false");
					Msg.put(data);
				}
				//rs.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(Msg);
			out.println(Msg);
			out.flush();
			out.close();
			
		}
		
		/*
		 * 功能：删除消息提醒的最新消息，放入历史消息中
		 */
		if(act.equals("deleteMsg")){
			System.out.println("进入servlet："+act);
			String UsId=usInf.getUsId();
			String CSId=new String( request.getParameter("msgid").getBytes("iso8859-1"), "utf-8");
			response.setContentType("text/html");
			JSONArray Msg = new JSONArray();
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String sql;
			sql="update UserMessageInf set MsgState='2' where USid='"+UsId+"' and id='"+CSId+"'";
			PreparedStatement ps;
			try {
				System.out.println(sql);
				ps = con.prepareStatement(sql);
				int rs = ps.executeUpdate();
				if(rs!=0) {
					JSONObject data = new JSONObject();
					data.put("isSuccess", "true");
					Msg.put(data);
				}else{
					JSONObject data = new JSONObject();
					data.put("isSuccess", "false");
					Msg.put(data);
				}
				//rs.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(Msg);
			out.println(Msg);
			
		}
		
		
		/*
		 * 统计评星信息
		 */
		
		
		if(act.equals("analysiscminfo")){
			System.out.println("进入servlet："+act);
			String CSId=new String( request.getParameter("CSId").getBytes("iso8859-1"), "utf-8");		
			response.setContentType("text/html");
			JSONArray analysisCmInf = new JSONArray();
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String sql;
			sql="select count(USId) as 'ussum',"+
			"isnull(CAST(AVG(cast(Star as DECIMAL(2,1))) AS DECIMAL(2,1)),0) as 'avg',"+
			"isnull(sum(case when Star in ('1') then 1 else 0 end),0) as '1star',"+
			"isnull(sum(case when Star in ('2') then 1 else 0 end),0) as '2star',"+
			"isnull(sum(case when Star in ('3') then 1 else 0 end),0) as '3star',"+
			"isnull(sum(case when Star in ('4') then 1 else 0 end),0) as '4star',"+
			"isnull(sum(case when Star in ('5') then 1 else 0 end),0) as '5star'"+
			" from CS_Comments where CSID='"+CSId+"'";
			PreparedStatement ps;
			try {
				System.out.println(sql);
				ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					JSONObject data = new JSONObject();
					data.put("ussum", rs.getString(1).trim());
					data.put("StarAvg", rs.getString(2).trim());
					data.put("Star1", rs.getString(3).trim());
					data.put("Star2", rs.getString(4).trim());
					data.put("Star3", rs.getString(5).trim());
					data.put("Star4", rs.getString(6).trim());
					data.put("Star5", rs.getString(7).trim());
					analysisCmInf.put(data);
					
				}
				rs.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(analysisCmInf);
			out.println(analysisCmInf);
		}
		
		/*
		 * 查询评价内容
		 */
		if(act.equals("commentinfo")){
			
			String CSId=new String( request.getParameter("CSId").getBytes("iso8859-1"), "utf-8");
			System.out.println("查询评价信息的充电站"+CSId);
			
			response.setContentType("text/html");
			JSONArray commentInf = new JSONArray();
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String condition ;
			condition ="Select USId,Time,Star,Content from CS_Comments  where CSID='"+CSId+"'";
			PreparedStatement sql;
			try {
			sql = con.prepareStatement(condition);
			//sql.setString(1, CSId);
			System.out.println(condition);
			ResultSet rs = sql.executeQuery();
			while (rs.next()) {
				JSONObject data = new JSONObject();
				data.put("USId", rs.getString(1).trim());
				data.put("Time", rs.getString(2).trim());
				data.put("Star", rs.getString(3).trim());
				data.put("Content", rs.getString(4).trim());
				commentInf.put(data);
				//System.out.println(commentInf);
			}
			rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{

			}
			System.out.println(commentInf);
			out.println(commentInf);
		}
		
		
		
		/*
		 * 执行点评功能
		 */
		
		if(act.equals("comment")){
			
			    String UsId=usInf.getUsId();

			    String starsum=new String( request.getParameter("starsum").getBytes("iso8859-1"), "utf-8");
			    String comments=new String( request.getParameter("comment").getBytes("iso8859-1"), "utf-8");	
			    String csid=new String( request.getParameter("csid").getBytes("iso8859-1"), "utf-8");
			    String usordid=new String( request.getParameter("usordid").getBytes("iso8859-1"), "utf-8");
				System.out.println("点评"+starsum+comments);
				String sql="insert into CS_Comments(Star,Content,USId,CSID,USOrdId) "
						+ "values (?,?,?,?,?)";
				 try {
			     	   dataBase  db= new dataBase();
			           Connection con =db.getConnection(); 
			           PreparedStatement ps;
			           ps= con.prepareStatement(sql);		               
			                ps.setString(1, starsum);
				       		ps.setString(2, comments);
				       		ps.setString(3, UsId);
				       		ps.setString(4, csid);
				       		ps.setString(5, usordid);
				       int m= ps.executeUpdate();
				       System.out.println(sql);  		  
			             
				       if(m!=0)  
				       {
				    	    System.out.println("提交信息成功");
				    	    new messageAlert("creatcom","您提交了一条"+starsum+"星评论，感谢您对本站的支持",UsId).SaveMsg();
						    ms.put("isSuccess", true);
							ms.put("message", "提交信息成功");
							request.setAttribute("message", "true");
				       }else{
							request.setAttribute("message", "false");
				    	    System.out.println("提交信息失败");
						    ms.put("isSuccess", false);
							ms.put("message", "提交信息失败");
				       } 
				       con.close();
					}catch (SQLException e) {
						e.printStackTrace();
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				 //out.println(ms.toString());
				 RequestDispatcher dispatcher = request.getRequestDispatcher("/searchCS.jsp");
				 dispatcher .forward(request, response);

			
		}
		/**
		 * 检测登录
		 */
		if(act.equals("checkLogin")){
			log.info("进入登录检测");
			
			//log.info(ss.getId());
			//boolean isLogin =  ss.getId().equals((String)ss.getAttribute("usSessId"));
			//log.info("isLogin:"+isLogin);
			if(usInf!=null){
				try {
					ms.put("isSuccess", true);
					ms.put("message", "已经登录");
					log.info("已经登录");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else {
				try {
					ms.put("isSuccess", false);
					ms.put("message", "用户未登录");
					log.info("用户未登录");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			out.println(ms.toString());
		}
		
		/**
		 * 用户退出登录
		 */
		if(act.equals("userLogout")){
			String username = (String) request.getParameter("username");
			if(usInf != null){
				ss.removeAttribute("usInf");
				try {
					ms.put("isSuccess", true);
					ms.put("message", "成功退出");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else {
				try {
					ms.put("isSuccess", false);
					ms.put("message", "退出失败");
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
					ms.put("isSuccess", true);
					ms.put("message", "success");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				try {
					ms.put("isSuccess", false);
					ms.put("message", "fail");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			out.println(ms.toString());
		}
		/*
		 * 提交充电桩纠错信息
		 */
		if(act.equals("correctCsInf")){	
              
			String  CSId,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes;
			//System.out.println("进入produceOrder");
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
//			  String dateBegin = request.getParameter("dateBegin"); 
//			  String dateStop = request.getParameter("dateStop");
			  boolean isError = false;
			  System.out.println(usId+CSId+CSName+CSAddr+CSDate+CSMode+CSFast+CSlow+Operator+ParkFee+CSPub+CSState+CSPhone+CSNotes);
			 
			  if(!isError){
//				  try {	
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
								    ms.put("isSuccess", true);
									ms.put("message", "提交信息成功");
									isError = false;
									//request.setAttribute("message", "true");
						       }else{
								    ms.put("isSuccess", false);
									ms.put("message", "提交信息失败");
									isError = true;
									//request.setAttribute("message", "false");
						       }    		  
					           con.close();      
							}catch (SQLException e) {
								e.printStackTrace();
							} catch (JSONException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} 
//				  usOrder usord =  new usOrder(usId,csId,USOrdStratTime,USOrdEndTime,orderStatue,csType,csName,csAddr);
//				  if(usord.saveOrder())
//					  {
//					  	usord.saveMsg();//保存订单信息
//					    ms.put("isSuccess", true);
//						ms.put("message", "订单生成成功");
//						isError = false;
//				  }else{
//					    ms.put("isSuccess", false);
//						ms.put("message", "订单生成失败");
//						isError = true;
//				  };
//				//  dbEntity db = new dbEntity();
//	     	    //  db.SaveOrder(USid,USOrdId,USOrdDate,USOrdStartTime,USOrdEndTime,USOrdStatue,csId);
//				  } catch (JSONException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
					}
//			  }
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
					ms.put("isSuccess", false);
					ms.put("message", "充电结束时间小于预约时间 ,请重新输入");
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
						ms.put("isSuccess", false);
						ms.put("message", "两次输入时间相等，请重新输入");
						isError = true;
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				   }
				   else if(java.sql.Time.valueOf(timeBegin.toString()).after(java.sql.Time.valueOf(timeStop.toString()))){
					   try {
							ms.put("isSuccess", false);
							ms.put("message", "充电结束时间小于预约时间 ,请重新输入");
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
					    ms.put("isSuccess", true);
						ms.put("message", "订单生成成功");
						isError = false;
				  }else{
					    ms.put("isSuccess", false);
						ms.put("message", "订单生成失败,暂无可用充电桩");
						isError = true;
				  };
				//  dbEntity db = new dbEntity();
	     	    //  db.SaveOrder(USid,USOrdId,USOrdDate,USOrdStartTime,USOrdEndTime,USOrdStatue,csId);
				  } catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			  }
			  out.println(ms.toString());
			  out.flush();
			  out.close();
		}
		
		
		/**
		 * 按城市搜索充电站
		 */
		if(act.equals("searchCityCS")){ 
			String cityname = request.getParameter("cityname").trim();
			//cityname=cityname.substring(0,2);
			JSONArray csInf = new JSONArray();
			dbUtil db =new dbUtil();
			
			String aa ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSID = cp.CSID  and  (cs.CSProvince LIKE '"+cityname+"%' or cs.CSCity LIKE '"+cityname+"%')";
			System.out.println(aa);
			db.query(aa);
			ResultSet rs =  db.getRS();
			try {
			while (rs.next()) {
				JSONObject data = new JSONObject();
				data.put("CSId", rs.getString(1));
				data.put("CSName", rs.getString(2).trim());
				data.put("CSAddr", rs.getString(3).trim());
				data.put("CSProvince", rs.getString(4).trim());
				data.put("CSCity", rs.getString(5).trim());
				if(rs.getString(6)!=null) 
					 data.put("CSArea", rs.getString(6).trim());
				else data.put("CSArea", " ");
				data.put("Datetime",rs.getDate(7));
				data.put("CSLatiValue", rs.getFloat(8));
				data.put("CSLongValue", rs.getFloat(9));
				data.put("CSMode",rs.getFloat(10));
				if(rs.getFloat(11)<0||rs.getFloat(12)<0){
					data.put("CSFast", "未知");
					data.put("CSSlow", "未知");
					data.put("CSSum", "未知");
				}else{
					data.put("CSFast", rs.getFloat(11));
					data.put("CSSlow", rs.getFloat(12));
					data.put("CSSum", rs.getFloat(13));
				}
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
				//增加每个充电站的图标信息srcpic---ZW
				int cspub=(int)(rs.getFloat(20));
				int csstate=(int)(rs.getFloat(21));
				if(cspub==1){//公用
					if(csstate==1){//运营中
						data.put("srcpic", "pic/g_green.png");
					}else if(csstate==2){//未运营
						data.put("srcpic", "pic/g_red.png");
					}else if(csstate==3){//未知
						data.put("srcpic", "pic/g_red.png");
					}
				}else if(cspub==2){//专用
					if(csstate==1){//运营中
						data.put("srcpic", "pic/z_green.png");
					}else if(csstate==2){//未运营
						data.put("srcpic", "pic/z_red.png");
					}else if(csstate==3){//未知
						data.put("srcpic", "pic/z_red.png");
					}
				}else if(cspub==3){//未知
					if(csstate==1){//运营中
						data.put("srcpic", "pic/t_green.png");
					}else if(csstate==2){//未运营
						data.put("srcpic", "pic/t_red.png");
					}else if(csstate==3){//未知
						data.put("srcpic", "pic/t_red.png");
					}
				}else{
					data.put("srcpic", "pic/s_red.png");
				}
				//end--ZW
				if(rs.getFloat(28)!=-1) data.put("CSFeeDay", rs.getFloat(28));
				else  data.put("CSFeeDay", "暂无数据");
				csInf.put(data);
			}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 //System.out.print(csInfPos.get(0).getCsName()+","+csInfPos.get(0).getCsAddr()+"   ");
			catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				db.closeAll();
			}
			out.println(csInf);
			out.flush();
			out.close();
		}
		/*
		 * 功能：查询历史消息提醒
		 */
		if(act.equals("checkOldMsg")){
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String condition ;
			condition ="SELECT * from UserMessageInf where MsgType = 'createOrd' and USid = '"+usInf.getUsId()+"' and MsgState='2'";
			System.out.println(condition);
			PreparedStatement sql;
			JSONArray msgInf = new JSONArray();
			try {
				sql = con.prepareStatement(condition);
				ResultSet rs = sql.executeQuery();
				while(rs.next()){
					JSONObject data = new JSONObject();
					try {
						data.put("msgid", rs.getString(1));
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
		 * 查询订单生成信息
		 */
		if(act.equals("checkMsg")){
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String condition ;
			condition ="SELECT * from UserMessageInf where MsgType = 'createOrd' and USid = '"+usInf.getUsId()+"' and MsgState='1'";
			System.out.println(condition);
			PreparedStatement sql;
			JSONArray msgInf = new JSONArray();
			try {
				sql = con.prepareStatement(condition);
				ResultSet rs = sql.executeQuery();
				while(rs.next()){
					JSONObject data = new JSONObject();
					try {
						data.put("msgid", rs.getString(1));
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
			String USid=usInf.getUsId();
			String condition ;
			//condition ="SELECT * from UserOrderInf where USOrdStatue = '1' and USid = '"+usInf.getUsId()+"' ORDER BY USOrdId DESC";
			condition ="SELECT * from UserOrderInf where USOrdStatue = '1' and USid ='"+USid+"'and DATEDIFF(DAY,USOrdDate,GETDATE())<=7 ORDER BY USOrdId DESC";
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
		if(act.equals("checkOldOrder")){
			//张伟，开始：修改历史订单模块
			dataBase db=new dataBase();
			Connection con =db.getConnection();
			String USid=usInf.getUsId();
			String condition ;
			//condition ="SELECT * from UserOrderInf where USOrdStatue = '1' and USid = '"+usInf.getUsId()+"' ORDER BY USOrdId DESC";
			condition ="SELECT * from UserOrderInf where USOrdStatue = '2' and USid ='"+USid+"' ORDER BY USOrdId DESC";
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
						data.put("CSID", rs.getString(2));
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
			//张伟，结束：修改历史订单模块	
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
