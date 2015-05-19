package myBean;

public class position {

	/**
	 * @param args
	 */
	private String lng;
	private String lat;
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
	public position(String lng, String lat) {
		super();
		this.lng = lng;
		this.lat = lat;
	}
	

}
