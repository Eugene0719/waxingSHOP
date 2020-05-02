package likey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class LikeyDAO {

	private Connection conn;
	
	public LikeyDAO() {

		try {
			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation?&useSSL=false";
			String dbID = "root";
			String dbPassword = "1111";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
}
	
	public int like(String userID, String evaluationID, String userIP) {
		String SQL = "INSERT INTO likey VALUES(?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, evaluationID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//추천 중복 오류
	}
	
}
