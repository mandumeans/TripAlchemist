package member.dto;

public class LandmarkList {
	private int landmarkNum;
	private String name;
	private String address;
	private float lat;
	private float lng;
	private int likes;
	private String createby;
	public int getLandmarkNum() {
		return landmarkNum;
	}
	public void setLandmarkNum(int landmarkNum) {
		this.landmarkNum = landmarkNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public float getLat() {
		return lat;
	}
	public void setLat(float lat) {
		this.lat = lat;
	}
	public float getLng() {
		return lng;
	}
	public void setLng(float lng) {
		this.lng = lng;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getCreateby() {
		return createby;
	}
	public void setCreateby(String createby) {
		this.createby = createby;
	}
}
