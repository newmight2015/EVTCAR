package myBean;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * �û�������Ϣ
 * @author stando
 *@param USid 用户ID
 *@param USOrdId 订单ID
 *@param USOrdDate	订单生成时间
 *@param USOrdStartTime	订单开始时间
 *@param USOrdEndTime	订单结束时间
 *@param USOrdStatue	 1 确认订单  2 订单交易完成 3订单交易失败
 *@param USOrdType	 1 快充 2 慢充 3 快慢充
 *@param CSID	充电站Id
 */
public class usOrder {

	private String USid;
	private String USOrdId;
	private String USOrdDate;
	private String USOrdStartTime;
	private String USOrdEndTime;
	private String USOrdStatue;
	private String USOrdType;
	private String USOrdCsName;
	private String USOrdCsAddr;
	private String CSID;
	
	public usOrder(){
		
	}
	
	public usOrder(String uSid, String cSID,
			String uSOrdStartTime, String uSOrdEndTime, String uSOrdStatue,String uSOrdType
			,String uSOrdCsName,String uSOrdCsAddr
			) {
		super();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//�������ڸ�ʽ
		USOrdDate = df.format(new Date());// new Date()
		USid = uSid;
		CSID = cSID;
		USOrdStartTime = uSOrdStartTime;
		USOrdEndTime = uSOrdEndTime;
		USOrdStatue = uSOrdStatue;
		USOrdType = uSOrdType;
		USOrdCsName  = uSOrdCsName;
		USOrdCsAddr = uSOrdCsAddr;
	}
	public String getUSOrdId() {
		return USOrdId;
	}
	public void setUSOrdId(String uSOrdId) {
		USOrdId = uSOrdId;
	}
	public String getUSOrdDate() {
		return USOrdDate;
	}
	public void setUSOrdDate(String uSOrdDate) {
		USOrdDate = uSOrdDate;
	}
	public String getUSOrdStartTime() {
		return USOrdStartTime;
	}
	public void setUSOrdStartTime(String uSOrdStartTime) {
		USOrdStartTime = uSOrdStartTime;
	}
	public String getUSOrdEndTime() {
		return USOrdEndTime;
	}
	public void setUSOrdEndTime(String uSOrdEndTime) {
		USOrdEndTime = uSOrdEndTime;
	}
	public String getUSOrdStatue() {
		return USOrdStatue;
	}
	public void setUSOrdStatue(String uSOrdStatue) {
		USOrdStatue = uSOrdStatue;
	}
	public String getUSOrdType() {
		return USOrdType;
	}

	public void setUSOrdType(String uSOrdType) {
		USOrdType = uSOrdType;
	}

	public String getCSID() {
		return CSID;
	}
	public void setCSID(String cSID) {
		CSID = cSID;
	}
	
	public String getUSOrdCsName() {
		return USOrdCsName;
	}

	public void setUSOrdCsName(String uSOrdCsName) {
		USOrdCsName = uSOrdCsName;
	}

	public String getUSOrdCsAddr() {
		return USOrdCsAddr;
	}

	public void setUSOrdCsAddr(String uSOrdCsAddr) {
		USOrdCsAddr = uSOrdCsAddr;
	}
	public void getOrdId(){
		dbEntity db = new dbEntity();
		int ordid = 0;
		if(db.checkOrdId(CSID,USid,USOrdDate)){
			 try {
				  ordid = db.getResultSet().getInt(1);
				  USOrdId = String.valueOf(ordid);
			 } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 }
		
	}
	
	public boolean saveOrder(){
		dbEntity db = new dbEntity();
	    return db.SaveOrder(CSID,USid,USOrdDate,USOrdStartTime,USOrdEndTime,USOrdStatue,USOrdType,USOrdCsName,USOrdCsAddr);
	}
	public boolean saveMsg(){
	//	this.getOrdId();
		StringBuffer temp = new StringBuffer();
		temp.append("您的预约订单已经生成,充电站名：");
		temp.append(USOrdCsName);
		temp.append("，起始时间：");
		temp.append(USOrdStartTime);
		temp.append("，请及时充电！");
		return new messageAlert("createOrd",temp.toString(),USOrdDate,USid).SaveMsg();
	}
	
	
	
}
