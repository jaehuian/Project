package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class CommentDAO {
	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String dbURL="jdbc:mysql://localhost:3306/MyBlog";
			String dbID="root";
			String dbPassword="kyj74558429@";
			Class.forName("com.mysql.jdbc.Driver");	
			conn= DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
		
	//db에서 댓글 불러오기
	public ArrayList<Comment> getComments(int bbsID){
		String SQL="SELECT * FROM COMMENT WHERE bbsID = ?";
		ArrayList<Comment> list = new ArrayList<Comment>();
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				Comment comment=new Comment();
				comment.setCommentID(rs.getInt(1));
				comment.setBbsID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setBbsComment(rs.getString(4));
				list.add(comment);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//db에 댓글 등록
		public int write(int bbsID, String userID, String bbsComment) {
			String SQL="INSERT INTO COMMENT(bbsID, userID, bbsComment) VALUES(?, ?, ?)";
			try {
				PreparedStatement pstmt=conn.prepareStatement(SQL);
				pstmt.setInt(1,bbsID);
				pstmt.setString(2,userID);
				pstmt.setString(3,bbsComment);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
}
