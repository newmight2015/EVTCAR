package myBean;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class messageAlert {
	
	private int id;
	private String msgType;
	private String msgValue;
	private String msgCreatTime;
	private String USid;
	
	
	public messageAlert(String msgType, String msgValue, String msgCreatTime,String uSid) {
		super();
		this.msgType = msgType;
		this.msgValue = msgValue;
		this.msgCreatTime = msgCreatTime;
		USid = uSid;
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
	public boolean SaveMsg(){
		dbEntity db = new dbEntity();
		return db.saveMsg(msgType,msgValue,msgCreatTime,USid);
	}
	public static List<messageAlert> checkMsg(String msgType,String USid){
		dbEntity db = new dbEntity();
		String[] condition = new String[]{msgType,USid};
		return db.checkOrdMsg(condition);
	}
	
	
}
