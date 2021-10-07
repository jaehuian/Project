package comment;

public class Comment {
	private int commentID;
	private int bbsID;
	private String userID;
	private String bbsComment;
	
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsComment() {
		return bbsComment;
	}
	public void setBbsComment(String bbsComment) {
		this.bbsComment = bbsComment;
	}
}
