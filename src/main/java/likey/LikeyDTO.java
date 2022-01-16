package likey;

public class LikeyDTO {

	String userID;
	int visitorBookID;
	String userIP;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getVisitorBookID() {
		return visitorBookID;
	}
	public void setVisitorBookID(int visitorBookID) {
		this.visitorBookID = visitorBookID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public LikeyDTO() {
		
	}
	
	public LikeyDTO(String userID, int visitorBookID, String userIP) {
		super();
		this.userID = userID;
		this.visitorBookID = visitorBookID;
		this.userIP = userIP;
	}
}