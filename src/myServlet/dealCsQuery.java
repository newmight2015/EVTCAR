package myServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import myBean.csInformation;
import myTools.dataBase;
import myTools.sort;
import myTools.utils;
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
		JSONArray dataAsec = new JSONArray();
		//String csarea=request.getParameter("csarea").trim();
		
		String csOperator=request.getParameter("csOperator").trim();
		Double csRange;
		if(request.getParameter("csRange").equals("none")) csRange =  5.0;
		else csRange = Double.parseDouble(request.getParameter("csRange"));
		String csParkFee=request.getParameter("csParkFee").trim();
		String lng=request.getParameter("lng").trim();
		String lat=request.getParameter("lat").trim();
		/*System.out.println(lng);
		System.out.println(lat);
		System.out.println(csRange);
		System.out.println(csParkFee);
		System.out.println(csOperator);*/
		
		dataBase db=new dataBase();
		Connection con =db.getConnection();
		String condition ;
		ArrayList<String> temp = new ArrayList<String>();
		StringBuffer tempCondition = new StringBuffer();
		//condition ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSPub = 1 and cs.CSState = 1 ";
		//查询所有充电站（包括公用私用运营未运营等充电站）zw
		condition ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSProvince='北京' ";
		if(!csOperator.equals("none")){
			temp.add(" cs.OperatorID= '"+csOperator+"'");
		}
		if(!csParkFee.equals("none")){
			temp.add(" cs.CSID IN (select CSID from [CS_ParkOperatorInformation] cp where cp.ParkFeeDay <="+csParkFee +")");
		}
		
		//if(temp.isEmpty()) condition ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSID = cp.CSID and cs.CSPub = 1 and cs.CSState = 1 ";
		//查询所有充电站（包括公用私用运营未运营等充电站）zw
		if(temp.isEmpty()) condition ="Select * from CS_BasicInformation cs,CS_ParkOperatorInformation cp where cs.CSID = cp.CSID and cs.CSProvince='北京'";
		else {
			Iterator i = temp.iterator();
			while(i.hasNext()){
				 tempCondition.append(" and ");
				 tempCondition.append(i.next());
				 if(!i.hasNext()) {//���һ��Ԫ��
			         tempCondition.append(" and cs.CSID = cp.CSID");
			      }
			}
			condition +=tempCondition.toString();
		}
		System.out.println(condition);
		PreparedStatement sql;
		try {
		sql = con.prepareStatement(condition);
		ResultSet rs = sql.executeQuery();
		if(!rs.next()){
				JSONObject data = new JSONObject();
				data.put("message", "无查询结果");
				csInf.put(data);
				//System.out.println("无查询结果");
		}
		int i=0;
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
			data.put("CSFeeDay", rs.getFloat(28));
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
					data.put("srcpic", "pic/s_green.png");
				}else if(csstate==2){//未运营
					data.put("srcpic", "pic/s_red.png");
				}else if(csstate==3){//未知
					data.put("srcpic", "pic/s_red.png");
				}
			}else{
				data.put("srcpic", "pic/s_red.png");
			}
			//end--ZW
			csInf.put(data);
			i++;
		}
		//System.out.println("共"+i+"条结果");
		rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 //System.out.print(csInfPos.get(0).getCsName()+","+csInfPos.get(0).getCsAddr()+"   ");
		catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			Map<String,Double> map= new TreeMap<String,Double>();
			for(int i=0;i<csInf.length();i++){
				JSONObject data = new JSONObject();
				Double dis = null;
				try {
					data = (JSONObject) csInf.get(i);
					dis = utils.Distance(Double.parseDouble(lng),Double.parseDouble(lat),(Double)data.get("CSLongValue"),(Double)data.get("CSLatiValue"));
					data.put("csDis",dis);
					if(dis>csRange*1000){
						csInf.put(i, "none");
					}else{
						
						map.put(String.valueOf(i), dis);
					}
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			//��map ��������
			sort sort = new sort();
			List<Entry<String, Double>> list = sort.mapSortAsce(map);
			
			for(Map.Entry<String,Double> mapping:list){ 
				try {
					dataAsec.put(csInf.get(Integer.parseInt(mapping.getKey()) ) );
				} catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} 
		}
		
		out.println(dataAsec);
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
