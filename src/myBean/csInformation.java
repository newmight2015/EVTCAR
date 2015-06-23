package myBean;

public class csInformation {

	private String lng;
	private String lat;
	private String csName;
	private String csAddr;
	private float csArea;
	private String Datetime;
	private float csMode;
	private float csFast;
	private float csSlow;
	private float csSum;
	private String Operator;
	private float chargeFee;
	private float serviceFee;
	private String FeeNotes;
	private float csPub;// 对外状态（1-公用/2-公交专用/3-私用、4-其他）
	private float CSState;//运营状态（1-运营/2-未运营/3-未知）
	private String csTime;//营业时间
	private String CSPhone;
	private String csNotes;//备注
	public csInformation(String lng, String lat, String csName ,String csAddr, float csArea,
			String datetime, float csMode, float csFast, float csSlow,
			float csSum, String operator, float chargeFee, float serviceFee,
			String feeNotes, float csPub, float cSState, String csTime,
			String cSPhone, String csNotes) {
		super();
		this.lng = lng;
		this.lat = lat;
		this.csName =csName;
		this.csAddr = csAddr;
		this.csArea = csArea;
		this.Datetime = datetime;
		this.csMode = csMode;
		this.csFast = csFast;
		this.csSlow = csSlow;
		this.csSum = csSum;
		this.Operator = operator;
		this.chargeFee = chargeFee;
		this.serviceFee = serviceFee;
		this.FeeNotes = feeNotes;
		this.csPub = csPub;
		this.CSState = cSState;
		this.csTime = csTime;
		this.CSPhone = cSPhone;
		this.csNotes = csNotes;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getCsName() {
		return csName;
	}
	public void setCsName(String csName) {
		this.csName = csName;
	}
	public String getCsAddr() {
		return csAddr;
	}
	public void setCsAddr(String csAddr) {
		this.csAddr = csAddr;
	}
	public float getCsArea() {
		return csArea;
	}
	public void setCsArea(float csArea) {
		this.csArea = csArea;
	}
	public String getDatetime() {
		return Datetime;
	}
	public void setDatetime(String datetime) {
		Datetime = datetime;
	}
	public float getCsMode() {
		return csMode;
	}
	public void setCsMode(float csMode) {
		this.csMode = csMode;
	}
	public float getCsFast() {
		return csFast;
	}
	public void setCsFast(float csFast) {
		this.csFast = csFast;
	}
	public float getCsSlow() {
		return csSlow;
	}
	public void setCsSlow(float csSlow) {
		this.csSlow = csSlow;
	}
	public float getCsSum() {
		return csSum;
	}
	public void setCsSum(float csSum) {
		this.csSum = csSum;
	}
	public String getOperator() {
		return Operator;
	}
	public void setOperator(String operator) {
		Operator = operator;
	}
	public float getChargeFee() {
		return chargeFee;
	}
	public void setChargeFee(float chargeFee) {
		this.chargeFee = chargeFee;
	}
	public float getServiceFee() {
		return serviceFee;
	}
	public void setServiceFee(float serviceFee) {
		this.serviceFee = serviceFee;
	}
	public String getFeeNotes() {
		return FeeNotes;
	}
	public void setFeeNotes(String feeNotes) {
		FeeNotes = feeNotes;
	}
	public float getCsPub() {
		return csPub;
	}
	public void setCsPub(float csPub) {
		this.csPub = csPub;
	}
	public float getCSState() {
		return CSState;
	}
	public void setCSState(float cSState) {
		CSState = cSState;
	}
	public String getCsTime() {
		return csTime;
	}
	public void setCsTime(String csTime) {
		this.csTime = csTime;
	}
	public String getCSPhone() {
		return CSPhone;
	}
	public void setCSPhone(String cSPhone) {
		CSPhone = cSPhone;
	}
	public String getCsNotes() {
		return csNotes;
	}
	public void setCsNotes(String csNotes) {
		this.csNotes = csNotes;
	}
	
	
	
}
