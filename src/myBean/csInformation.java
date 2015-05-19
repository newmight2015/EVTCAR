package myBean;

public class csInformation {

	private String lng;
	private String lat;
	
	private String csAddr;
	private String csName;
	private String csFastNum;//快充数量
	private String csSlowNum;//慢充数量
	
	
	private String csDist;//到充电站的距离
	private String csAllNum;//充电站的充电桩数
	private String csFreeNum;//空闲充电桩数
	
	private String csState;//充电桩类型
	
	
	public csInformation(){
		return;
	}

	public csInformation(String lng, String lat, String csFastNum, String csSlowNum,
			String csName,String csAddr, String csDist, String csAllNum, String csFreeNum,String csState) {
		super();
		this.lng = lng;
		this.lat = lat;
		this.csFastNum = csFastNum;
		this.csSlowNum = csSlowNum;
		this.csAddr=csAddr;
		this.csName = csName;
		this.csDist = csDist;
		this.csAllNum = csAllNum;
		this.csFreeNum = csFreeNum;
		this.csState=csState;
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

	public String getCsFastNum() {
		return csFastNum;
	}

	public void setCsFastNum(String csFastNum) {
		this.csFastNum = csFastNum;
	}

	public String getCsSlowNum() {
		return csSlowNum;
	}

	public void setCsSlowNum(String csSlowNum) {
		this.csSlowNum = csSlowNum;
	}
	public String getCsAddr() {
		return csAddr;
	}

	public void setCsAddr(String csAddr) {
		this.csAddr = csAddr;
	}
	public String getCsName() {
		return csName;
	}

	public void setCsName(String csName) {
		this.csName = csName;
	}
	public String getCsDist() {
		return csDist;
	}
	public void setCsDist(String csDist) {
		this.csDist = csDist;
	}
	public String getCsAllNum() {
		return csAllNum;
	}
	public void setCsAllNum(String csAllNum) {
		this.csAllNum = csAllNum;
	}
	public String getCsFreeNum() {
		return csFreeNum;
	}
	public void setCsFreeNum(String csFreeNum) {
		this.csFreeNum = csFreeNum;
	}
	public String getCsState() {
		return csState;
	}

	public void setCsState(String csState) {
		this.csState = csState;
	}

	
	
}
