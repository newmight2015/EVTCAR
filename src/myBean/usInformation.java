package myBean;
public class usInformation {
	private String usId;
	private String usPassWd;
	private String usMail;
	private String usPhoneNum;
	private String usCity;
	private String usCarType;
	private String usBatType;
	private String usCarNum;
	public usInformation(){
		return;
	}
	public usInformation(String usId, String usPassWd, String usMail,
			String usPhoneNum, String usCity, String usCarType,
			String usBatType, String usCarNum) {
		super();
		this.usId = usId;
		this.usPassWd = usPassWd;
		this.usMail = usMail;
		this.usPhoneNum = usPhoneNum;
		this.usCity = usCity;
		this.usCarType = usCarType;
		this.usBatType = usBatType;
		this.usCarNum = usCarNum;
	}
	public String getUsId() {
		return usId;
	}
	public void setUsId(String usId) {
		this.usId = usId;
	}
	public String getUsPassWd() {
		return usPassWd;
	}
	public void setUsPassWd(String usPassWd) {
		this.usPassWd = usPassWd;
	}
	public String getUsMail() {
		return usMail;
	}
	public void setUsMail(String usMail) {
		this.usMail = usMail;
	}
	public String getUsPhoneNum() {
		return usPhoneNum;
	}
	public void setUsPhoneNum(String usPhoneNum) {
		this.usPhoneNum = usPhoneNum;
	}
	public String getUsCity() {
		return usCity;
	}
	public void setUsCity(String usCity) {
		this.usCity = usCity;
	}
	public String getUsCarType() {
		return usCarType;
	}
	public void setUsCarType(String usCarType) {
		this.usCarType = usCarType;
	}
	public String getUsBatType() {
		return usBatType;
	}
	public void setUsBatType(String usBatType) {
		this.usBatType = usBatType;
	}
	public String getUsCarNum() {
		return usCarNum;
	}
	public void setUsCarNum(String usCarNum) {
		this.usCarNum = usCarNum;
	}


	
}
