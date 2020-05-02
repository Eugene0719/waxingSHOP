package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
	
	public static Connection getConnection() throws ClassNotFoundException {
		
		try{
			String url = "jdbc:mysql://localhost:3306/LectureEvaluation?&useSSL=false";	//?autoReconnect=true&useSSL=false
			String user = "root";
			String password = "1111";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			return DriverManager.getConnection(url, user, password);
			
		}catch(SQLException e){
			System.out.println("데이터베이스 연결 실패");
			e.printStackTrace();
		
		return null;
	}

}
}
