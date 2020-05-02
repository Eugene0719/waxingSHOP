package user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.DatabaseUtil;

public class UserDAO {

	
	
	
	//사용자가 로그인을 하는함수 (성공하면 1반환)
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	//sql 결과값으로 나온 결과값 처리
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	//sql 결과가 존재하는 경우에 한해서
				if(rs.getString(1).equals(userPassword)) {	//사용자가 입력한 값과 원래값이 같으면 1을 반환
					return 1;	//로그인 성공
				}else {
					return 0;	//비밀번호 틀림
				}
			}
			return -1;	//아이디 없음
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	//서버에 무리가 가지않게 쓰고난후 닫아줌
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();} 
				
			}
		return -2;	//데이터베이스 오류
	}
	
	//사용자 회원가입
	public int join(UserDTO user) {	//한개의 user라는 객체를 받아서 회원가입
		String SQL = "INSERT IGNORE INTO USER VALUES (?, ?, ?, ?, false)";
		Connection conn = null;								//이메일인증 첨엔 false
		PreparedStatement pstmt = null;
		ResultSet rs = null;	//sql 결과값으로 나온 결과값 처리
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());	//user 객체에 존재하는 거 DB에 담기
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate();
						//Data 하나가 추가됨 so, 성공적이면 1반환
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	//서버에 무리가 가지않게 쓰고난후 닫아줌
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();} 
				
			}
		return -1;	//회원가입 실패
	}
	
	
	public boolean getUserEmailChecked(String userID) {	
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		Connection conn = null;								
		PreparedStatement pstmt = null;
		ResultSet rs = null;	//sql 결과값으로 나온 결과값 처리
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);	
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1);	//이메일 인증 성공이면 true값 반환 (1)
			}
						
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();} 
				
			}
		return false;	//데이터베이스 오류	
	}
	
	//사용자로부터 아이디값을 입력 받아서 아이디값이 가지는 이메일 주소를 바로 반환할수 있도록 하는 함수
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID = ? ";
		Connection conn = null;								
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);	
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
						
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();} 
				
			}
		return null;	//데이터베이스 오류
	}
	
	//사용자가 이메일 인증을 완료 되게 하는 함수
	public boolean setUserEmailChecked(String userID) {	
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ? ";
		Connection conn = null;								
		PreparedStatement pstmt = null;
		ResultSet rs = null;	//sql 결과값으로 나온 결과값 처리
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);	
			pstmt.executeUpdate();
			return true;	//이메일 확인 링크에서 인증이 된 상태라도 인증을 시켜줘야됨
						
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			try {if(conn != null) conn.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(pstmt != null) pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			try {if(rs != null) rs.close();} catch(Exception e) {e.printStackTrace();} 
				
			}
		return false;	//데이터베이스 오류	
	}
}

/*
회원 데이터모델링

login 함수 
아이디와비밀번호를 받아서 로그인을 받아서 정수형으로 반환

join 함수 
사용자의 정보를 입력 받아서회원가입을 실행 
결과값 = 정수형으로 반환 

getUserEmail
사용자 아이디값을 받아서 사용자의 이메일 주소를 반환 
결과값 = 문자열로 반환

getUserEmailChecked
사용자가 현재 이메일인증이 되었는지 확인 
결과값 = 불린 참 혹은 거짓 

setUserEmailChecked
특정한사용자의 이메일 인증을 수행해주는 함수 
*/


