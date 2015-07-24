package myBean;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class messageAlert {
	
	private int id;
	private String msgType;
	private String msgValue;
	private String msgCreatTime;
	private String USid;
	
	
	public messageAlert(String msgType, String msgValue,String msgCreatTime,String uSid) {
		super();
		this.msgType = msgType;
		this.msgValue = msgValue;
		this.msgCreatTime = msgCreatTime;
		USid = uSid;
	}
	
	public messageAlert(String msgType, String msgValue,String uSid) {
		super();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//�������ڸ�ʽ
		this.msgCreatTime = df.format(new Date());// new Date()
		this.msgType = msgType;
		this.msgValue = msgValue;
		this.USid = uSid;
	}
	
	public messageAlert() {
		// TODO Auto-generated constructor stub
	}
	public String getUSid() {
		return USid;
	}
	public void setUSid(String uSid) {
		USid = uSid;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getMsgValue() {
		return msgValue;
	}
	public void setMsgValue(String msgValue) {
		this.msgValue = msgValue;
	}
	public String getMsgCreatTime() {
		return msgCreatTime;
	}
	public void setMsgCreatTime(String msgCreatTime) {
		this.msgCreatTime = msgCreatTime;
		
	}
	/**
	 * 保存订单信息
	 * @return
	 */
	public boolean SaveMsg(){
		dbEntity db = new dbEntity();
		return db.saveMsg(msgType,msgValue,msgCreatTime,USid);
	}
	/**
	 * 根据msgType查询提示信息
	 * @param msgType creatord:订单；createcom：评论；coreatcor:纠错；createsha: 分享；
	 * @param USid
	 * @return
	 */
	public static List<messageAlert> checkMsg(String msgType,String USid){
		dbEntity db = new dbEntity();
		String[] condition = new String[]{msgType,USid};
		return db.checkMsg(condition);
	}
	
	
	
}
