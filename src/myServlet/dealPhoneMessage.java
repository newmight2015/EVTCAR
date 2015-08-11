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
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import myBean.messageAlert;
import myBean.usInformation;
import myBean.usOrder;
import myTools.SDKSendSMS;
import myTools.dataBase;
import myTools.dbUtil;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class dealPhoneMessage extends HttpServlet {
	private static  final transient Logger log = Logger.getLogger(dealPhoneMessage.class);
	private static String appVersion;
	/**
	 * Constructor of the object.
	 */
	public dealPhoneMessage() {
		super();
	}
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
		appVersion = getServletConfig().getInitParameter("appVersion");
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	
	private static void checkLogin(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		HttpSession ss = request.getSession();
		JSONObject ms = new JSONObject();
		
		log.info("进入登录检测");
		//log.info(ss.getId());
		boolean isLogin =  ss.getId().equals((String)ss.getAttribute("usSessId"));
		log.info("isLogin:"+isLogin);
		if(isLogin){
			try {
				ms.put("isSuccess", true);
				ms.put("message", "已经登录");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			try {
				ms.put("isSuccess", false);
				ms.put("message", "用户未登录");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		out.println(ms.toString());
		out.flush();
		out.close();
	}
	/**
	 * 手机用户退出
	 * @param request 
	 * @param response
	 * @throws IOException
	 */
	private static void userLogout(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		HttpSession ss = request.getSession();
		JSONObject ms = new JSONObject();
		//usInformation usInf = (usInformation)ss.getAttribute("usInf");
		String usSessId = (String) ss.getAttribute("usSessId");
		if(usSessId != null){
			ss.removeAttribute("usSessId");
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
				ms.put("message", "用户未登录，退出失败");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		out.println(ms.toString());
		out.flush();
		out.close();
	}
	/**
	 * 消息中心 信息查询
	 * @param request username;
	 * @param response
	 * @param MsgState 1:最新消息；2：历史消息
	 * @throws IOException
	 */
	private static void checkMsg(HttpServletRequest request, HttpServletResponse response , int MsgState)throws IOException{
		PrintWriter out = response.getWriter();
		HttpSession ss = request.getSession();
		JSONObject ms = new JSONObject();
		
		String username = request.getParameter("username");
		//usInformation usInf = (usInformation)ss.getAttribute("usInf");
		//String MsgType = (String) request.getAttribute("MsgType");
		String sql ="SELECT * from UserMessageInf where USid = ? and MsgState= ?";
		String pras[] = new String[]{username,String.valueOf(MsgState)};
		dbUtil db = new dbUtil();
		ResultSet rs = db.query(sql, pras);
		JSONArray msgInf = new JSONArray();
		try {
			while(rs.next()){
				JSONObject data = new JSONObject();
				try {
					data.put("msgid", rs.getString(1));
					data.put("msgType", rs.getString(2));
					data.put("msgCreatTime",rs.getString(4));
					data.put("msgValue", rs.getString(3));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				msgInf.put(data);
			}
			db.closeAll();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		out.println(msgInf.toString());
		out.flush();
		out.close();
	}
	/**
	 * 手机端用户对充电站纠错
	 * @param request changedata i;username
	 * @param response
	 * @throws IOException
	 */
	
	private static void csCorrect(HttpServletRequest request, HttpServletResponse response)throws IOException{
		
		response.setContentType("json");
		PrintWriter out = response.getWriter();
		HttpSession ss = request.getSession();
		JSONObject ms = new JSONObject();
		
		String username = new String(request.getParameter("username"));
		//usInformation usInf = (usInformation)ss.getAttribute("usInf");
		//String usSessId = (String) request.getAttribute("usSessId");
		log.info("用户名："+username);
		
		String  CSId,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes;
		//System.out.println("进入dealCorrect");
		
		CSId=new String( request.getParameter("CSId"));		
		CSName=new String( request.getParameter("CSName"));
		CSAddr=new String( request.getParameter("CSAddr"));
		CSDate=new String( request.getParameter("CSDate"));
		CSMode=new String( request.getParameter("CSMode"));
		CSFast=new String( request.getParameter("CSFast"));
		CSlow=new String( request.getParameter("CSlow"));
		Operator=new String( request.getParameter("Operator"));
		ParkFee=new String( request.getParameter("ParkFee"));
		CSPub=new String( request.getParameter("CSPub"));
		CSState=new String( request.getParameter("CSState"));
		CSPhone=new String( request.getParameter("CSPhone"));
		CSNotes=new String( request.getParameter("CSNotes"));
		//String usId = new String( request.getParameter("username"));
		System.out.println(CSId+CSName+CSAddr+CSDate+CSMode+CSFast+CSlow+Operator+ParkFee+CSPub+CSState+CSPhone+CSNotes);
		boolean isError = false;
		String sql="insert into CS_correction(CSID,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes,USID) "
				+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    String pras[] = new String[]{CSId,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes,username};
		 try {
	     	   dbUtil db = new dbUtil();
	     	   db.update(sql, pras);
		       //System.out.print(sql);
		       if(db.getResu()!=0)  
		       {
		    	   // System.out.println("提交信息成功");
		    	    new messageAlert("creatcor","您对"+CSName+"的纠错正在审核中，感谢您对本站的支持",username).SaveMsg();
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
		       db.closeAll();
	           //con.close();      
			}catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		out.println(ms);
		out.flush();
		out.close();
	}
	
	/**
	 * 根据充电站ID查询评价信息
	 * @param request CSId
	 * @param response
	 * @throws IOException
	 */
	private static void checkCommentinfo(HttpServletRequest request, HttpServletResponse response)throws IOException{
		
		
		PrintWriter out = response.getWriter();
		HttpSession ss = request.getSession();
		JSONObject ms = new JSONObject();
		
		String CSId=new String(request.getParameter("CSId"));
		log.info("查询评价信息的充电站: "+CSId);
		//System.out.println("查询评价信息的充电站"+CSId);
		JSONArray commentInf = new JSONArray();
		
		dbUtil db = new dbUtil();
		String sql ="Select USId,Time,Star,Content from CS_Comments  where CSID= ? ";
		String pras = CSId;
		ResultSet rs = db.query(sql, pras);
		try {
			while (rs.next()) {
				JSONObject data = new JSONObject();
				data.put("USId", rs.getString(1).trim());
				data.put("Time", rs.getString(2).trim());
				data.put("Star", rs.getString(3).trim());
				data.put("Content", rs.getString(4).trim());
				commentInf.put(data);
				//System.out.println(commentInf);
			}
		db.closeAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(commentInf);
		out.println(commentInf);
		out.flush();
		out.close();
	}
	
	/**
	 * 提交评价信息
	 * @param request starsum;comment;username;csid
	 * @param response
	 * @throws IOException
	 */
	private static void comment(HttpServletRequest request, HttpServletResponse response)throws IOException{
		
		
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
		
		
	    String Star=new String( request.getParameter("starsum"));
	    String Content=new String( request.getParameter("comment"));
	    String USId=request.getParameter("username");
	    String CSID=new String( request.getParameter("csid"));
		//System.out.println("点评"+starsum+comments);
		String sql="insert into CS_Comments(Star,Content,USId,CSID) values (?,?,?,?)";
		String pras[]=new String[]{Star,Content,USId,CSID};
		dbUtil db = new dbUtil();
		db.update(sql, pras);
		 try {
		       if(db.getResu()!=0)  
		       {
		    	   // System.out.println("提交信息成功");
		    	    new messageAlert("creatcom","您提交了一条"+Star+"星评论，评论内容为："+Content+"————感谢您对本站的支持!",USId).SaveMsg();
		    	    log.info("提交信息成功");
				    ms.put("isSuccess", true);
					ms.put("message", "提交评价信息成功");
					//request.setAttribute("message", "true");
		       }else{
					//request.setAttribute("message", "false");
		    	   // System.out.println("提交信息失败");
		    	   log.info("提交信息失败");
		    	   ms.put("isSuccess", false);
		    	   ms.put("message", "提交评价信息失败");
		       } 
		       db.closeAll();
			}catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 out.println(ms.toString());
		 out.flush();
		 out.close();

	}
	/**
	 * 查询全国充电站信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void searchCityCS(HttpServletRequest request, HttpServletResponse response)throws IOException{
		
		
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
		
		//String isphone = request.getParameter("isphone");
		String cityname = request.getParameter("cityname");
		log.info("要查询的城市名："+ cityname);
		//System.out.println(cityname);
		JSONArray csInf = new JSONArray();
		dataBase db=new dataBase();
		Connection con =db.getConnection();
		String condition ;
		if(cityname.equals("全国")){ 
			condition ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSID = cp.CSID";
		}
		else condition ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSID = cp.CSID and (cs.CSProvince LIKE '"+cityname+"%' or cs.CSCity LIKE '"+cityname+"%' )";
		log.info(condition);
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
			if(rs.getString(6)!=null) 
				 data.put("CSArea", rs.getString(6).trim());
			else data.put("CSArea","");
			data.put("Datetime",rs.getDate(7));
			data.put("CSLatiValue", rs.getFloat(8));
			data.put("CSLongValue", rs.getFloat(9));
			data.put("CSMode",rs.getFloat(10));
			if(rs.getFloat(11)<0){
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
			/*
			data.put("CSPub", rs.getFloat(20));
			data.put("CSState", rs.getFloat(21));
			*/
				data.put("CSPub", rs.getFloat(21));
				data.put("CSState", rs.getFloat(20));
			
			
			data.put("CSTime", rs.getString(22));
			if(rs.getString(23)!=null) data.put("CSPhone", rs.getString(23).trim());
			else data.put("CSPhone", "暂无信息");
			if(rs.getString(24)!=null) data.put("CSNotes", rs.getString(24).trim());
			else data.put("CSNotes", "暂无消息");
		//	data.put("CSFeeDay", rs.getFloat(24));
			if(rs.getFloat(28)!=-1) data.put("CSFeeDay", rs.getFloat(28));
			else  data.put("CSFeeDay", "暂无数据");
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
		 out.flush();
		 out.close();

	}
	/**
	 * app版本检测
	 * @param request	version
	 * @param response
	 * @throws IOException
	 */
	private static void checkAPPUpdate(HttpServletRequest request, HttpServletResponse response)throws IOException{
		
		response.setContentType("json");
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
		String appNowVision = request.getParameter("version");
		if(!appNowVision.equals(appVersion)){
			 try {
			    	    log.info("app版本不一致，需要更新。版本号："+appNowVision);
					    ms.put("isSuccess", true);
						ms.put("message", "http://www.ezchong.com/download/ezchong.apk");//APP下载地址
				}catch (JSONException e) {
					e.printStackTrace();
				}
		}else {
			try {
	    	    log.info("app版本不需要更新。版本号："+appNowVision);
			    ms.put("isSuccess", false);
				ms.put("message", "版本一致");//APP下载地址
			}catch (JSONException e) {
				e.printStackTrace();
			}
		}
		 //log.info(ms.toString());
		 out.println(ms);
		 out.flush();
		 out.close();
	}
	
	/**
	 * 彻底删除历史消息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void deleteMsg(HttpServletRequest request, HttpServletResponse response,int MsgState)throws IOException{
		
		
		PrintWriter out = response.getWriter();
		
		String UsId= request.getParameter("username");
		String msgid=new String( request.getParameter("msgid"));
		JSONArray Msg = new JSONArray();
		dataBase db=new dataBase();
		Connection con =db.getConnection();
		String sql;
		sql="update UserMessageInf set MsgState='"+MsgState+"' where USid='"+UsId+"' and id='"+msgid+"'";
		PreparedStatement ps;
		try {
			//System.out.println(sql);
			ps = con.prepareStatement(sql);
			int rs = ps.executeUpdate();
			if(rs!=0) {
				JSONObject data = new JSONObject();
				data.put("isSuccess", "true");
				data.put("message", "删除信息成功：msgid="+msgid);
				Msg.put(data);
				log.info("删除信息成功：msgid="+msgid);
			}else{ 
				JSONObject data = new JSONObject();
				data.put("isSuccess", "false");
				data.put("message", "删除信息失败");
				Msg.put(data);
				log.info("删除信息失败");
			}
			//rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(Msg);
		out.println(Msg);
		out.flush();
		out.close();
	}
	/**
	 * 统计评星信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void analysiscminfo(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		
		String CSId=new String( request.getParameter("CSId"));		
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
		out.flush();
		out.close();
	}
	
	/**
	 * 检测验证码
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void checkCode(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
		
		HttpSession sess = request.getSession();
		String code = (String)sess.getAttribute("rand");
		String ccode = (String)request.getParameter("code");
		log.info(ccode);
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
		try {
			log.info(ms.get("message"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(ms);
		out.flush();
		out.close();
	}
	/**
	 * 生产预约订单
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void produceOrder(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
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
			  String usId = request.getParameter("username");
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
					ms.put("message", "订单生成失败");
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
		  out.flush();
		  out.close();
	}
	
	/**
	 * 查询预约订单
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void checkOrder(HttpServletRequest request, HttpServletResponse response, int USOrdStatue)throws IOException{
		PrintWriter out = response.getWriter();
		JSONObject ms = new JSONObject();
		dataBase db=new dataBase();
		Connection con =db.getConnection();
		String USid=request.getParameter("username");
		String condition ;
		//condition ="SELECT * from UserOrderInf where USOrdStatue = '1' and USid = '"+usInf.getUsId()+"' ORDER BY USOrdId DESC";
		condition ="SELECT * from UserOrderInf where USOrdStatue = '"+USOrdStatue+"' and USid ='"+USid+"'and DATEDIFF(DAY,USOrdDate,GETDATE())<=7 ORDER BY USOrdId DESC";
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
		out.flush();
		out.close();
	}
	
	/**
	 * 充电站分享
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private static void userCsSubmit(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		String UsId= request.getParameter("username");
		String csname,csfast,cslow,operator,cspub,csstate,parkfee,csphone,csnotes,cslng,cslat;
		csname=new String( request.getParameter("CSAddr"));
		cslng=new String( request.getParameter("lng"));
		cslat=new String( request.getParameter("lat"));
		csfast=new String( request.getParameter("CSFast"));
		cslow=new String( request.getParameter("CSSlow"));
		operator=new String( request.getParameter("Operator"));
		cspub=new String( request.getParameter("CSPub"));
		csstate=new String( request.getParameter("CSState"));
		parkfee=new String( request.getParameter("ParkFeeDay"));
		csphone=new String( request.getParameter("CSPhone"));
		csnotes=new String( request.getParameter("CSNotes"));
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
		    	    new messageAlert("creatsha","您分享了一条位于"+csname+"的充电站，工作人员会尽快审核信息，感谢您对本站的支持",UsId).SaveMsg();
		    	    JSONObject data = new JSONObject();
					data.put("isSuccess", "true");
					data.put("message", "提交信息成功");
					Msg.put(data);
		       }else{
		    	    log.info("分享信息提交失败");
		    	   	JSONObject data = new JSONObject();
				    data.put("isSuccess", "false");
					data.put("message", "提交信息失败");
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
	/**
	 * 发送手机验证码
	 * @param request phone;
	 * @param response
	 * @throws IOException
	 */
	private void sendSMS(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		response.setContentType("json");
		
		Random rd = new Random();
        int result =rd.nextInt(899999)+100000;
        log.info("生成随机验证码："+result);
        HttpSession ss = request.getSession();
		ss.setAttribute("vcode", result);
		
		String Phone = request.getParameter("phone").trim();
		SDKSendSMS.sendSMS(Phone, String.valueOf(result),"29063");
        JSONObject data = new JSONObject();
        try {
		    	    log.info("验证码发送成功");
					data.put("isSuccess", true);
					data.put("message", result);
	           //con.close();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        out.println(data);
		out.flush();
		out.close();
	}
	
	private void checkIsReg(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		response.setContentType("json");
		
		String usId = request.getParameter("usId");
		String checkCondition = "Select USid,USPhoneNum from UserPerInf where USid = '"+ usId +"'";     
                
		JSONObject data = new JSONObject();
		dbUtil db = new dbUtil();
        try {
            db.query(checkCondition);
				if(!db.getRS().next()){
				    log.info(usId+":用户名可以使用");
					data.put("isSuccess", true);
					data.put("message", "该用户名可注册");
				}else{
					log.info(usId+":用户名不可使用");
					data.put("isSuccess", false);
					data.put("message", "该用户名已被注册");
					data.put("phoneNum", db.getRS().getString(2));
				}
			}catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				db.closeAll();
			}
        out.println(data);
		out.flush();
		out.close();
	}
	/**
	 * 用户提交建议信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private void userAdviceSub(HttpServletRequest request, HttpServletResponse response)throws IOException{
		PrintWriter out = response.getWriter();
		response.setContentType("json");
		
		String usId = request.getParameter("usId");
		String content = request.getParameter("content");
		String sql= "INSERT INTO UserAdviceInf (USAdviceContent, USid , USAdviceStatue) VALUES (?,?,?)";
		String pars[] = new String[]{content,usId,"1"};
		JSONObject data = new JSONObject();
		dbUtil db = new dbUtil();
        try {
            db.update(sql,pars);
				if(db.getResu()!=0){
				    log.info(usId+":该用户提交了一条建议信息");
					data.put("isSuccess", true);
					data.put("message", "提交建议信息成功");
				}else{
					log.info(usId+":该用户提交建议时发生了错误");
					data.put("isSuccess", false);
					data.put("message", "提交建议信息失败");
				}
			}catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				db.closeAll();
			}
        out.println(data);
		out.flush();
		out.close();
	}
	
	private static void getCityJson(HttpServletRequest request, HttpServletResponse response)throws IOException{
		
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String act = request.getParameter("act").trim();
		JSONObject ms = new JSONObject();

		HttpSession ss = request.getSession();
		usInformation usInf = (usInformation)ss.getAttribute("usInf");
		
		log.info("---------act:______"+act);
		
		switch(act){
			case "userAdviceSub": this.userAdviceSub(request, response);break;//手机用户提交建议信息
			case "sendSMS"		: this.sendSMS(request, response);break;//生成手机验证码
			case "checkIsReg"	: this.checkIsReg(request, response);break;//检验是否注册
			case "checkLogin"	: this.checkLogin(request, response);break;//检测登录
			case "userLogout"	: this.userLogout(request, response);break;//用户退出登录
			case "csCorrect" 	: this.csCorrect(request, response); break;//纠错
			case "checkMsg"	 	: this.checkMsg(request, response, 1);break;//查询最新消息
			case "checkOldMsg"	: this.checkMsg(request, response, 2);break;//查询历史消息
			case "commentinfo"	: this.checkCommentinfo(request, response);break;//查询评价信息
			case "comment"		: this.comment(request, response);break;//提交评价信息
			case "searchCityCS" : this.searchCityCS(request, response);break;// 查询全国充电站信息
			case "checkAPPUpdate":this.checkAPPUpdate(request, response);break;//app版本检测
		
			/****以下仍需修改***/
			case "deleteMsg"	: this.deleteMsg(request, response, 2);break;//删除消息提醒的最新消息，放入历史消息中
			case "deleteOldMsg"	: this.deleteMsg(request, response,3);break;//删除消息提醒的最新消息，放入历史消息中
			case "analysiscminfo":this.analysiscminfo(request, response);break;//统计评星信息
			case "checkCode"	: this.checkCode(request, response);break;//检验验证码
			case "produceOrder" : this.produceOrder(request, response);break;//生产订单信息
			case "checkNewOrder": this.checkOrder(request, response,1);break;//查询最新订单信息
			case "checkOldOrder": this.checkOrder(request, response,2);break;//查询历史订单信息
			case "userCsSubmit" : this.userCsSubmit(request, response);break;//分享充电站信息
			default :  
				log.error("暂无此功能:"+act);
				break;
		}
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

	
}
