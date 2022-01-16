package visitorBook;

public class VisitorBookDTO {

	int visitorBookID;
	String userID;
	String visitorBookTitle;
	String visitorBookContent;
	String created;
	int likeCount;
	
	public int getVisitorBookID() {
		return visitorBookID;
	}
	public void setVisitorBookID(int visitorBookID) {
		this.visitorBookID = visitorBookID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getVisitorBookTitle() {
		return visitorBookTitle;
	}
	public void setVisitorBookTitle(String visitorBookTitle) {
		this.visitorBookTitle = visitorBookTitle;
	}
	public String getVisitorBookContent() {
		return visitorBookContent;
	}
	public void setVisitorBookContent(String visitorBookContent) {
		this.visitorBookContent = visitorBookContent;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public VisitorBookDTO() {
		
	}
	
	public VisitorBookDTO(int visitorBookID, String userID, String visitorBookTitle, String visitorBookContent,
			String created, int likeCount) {
		super();
		this.visitorBookID = visitorBookID;
		this.userID = userID;
		this.visitorBookTitle = visitorBookTitle;
		this.visitorBookContent = visitorBookContent;
		this.created = created;
		this.likeCount = likeCount;
	}
	
	
}
