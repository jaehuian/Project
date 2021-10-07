package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	//소셜 연동 로그인
	public int Login(String userID) {
		String SQL="SELECT userID FROM USER WHERE userID = ?";
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userID)) {
					return 1; //로그인 성공
				}
			}
			return -1; //아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	//일반 로그인 함수
	public int Login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM USER WHERE userID = ?";
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	//일반 가입 함수
	public int Join(User user) {
		String SQL="INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//소셜 가입 함수
	public int Join_Social(User user) {
		String SQL="INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, null);
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, null);
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//유저 정보 함수
	public User getUserInfo(String userID) {
		String SQL="SELECT userID, userPassword, userName, userGender, userEmail FROM USER WHERE userID = ?";
		User user = new User();
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				
				//유저 정보 반환
				return user;
			}
			return null; //유저 정보 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null; //데이터베이스 오류
	}
	
	//유저 정보 수정 함수
	public int updateUserInfo(User user) {
		String SQL="UPDATE USER SET userPassword = ?, userName = ?, userGender = ?, userEmail = ? WHERE userID = ?";
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserPassword());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserID());
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
