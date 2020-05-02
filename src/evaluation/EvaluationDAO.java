package evaluation;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


	public class EvaluationDAO {

		private Connection conn;
		private ResultSet rs;

		public EvaluationDAO() {

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

		//모달 글쓰기 함수 
		public int write(EvaluationDTO evaluationDTO) {
			PreparedStatement pstmt = null;
			try {											//auto_increment						//좋아요 초기값은 0
				String SQL = "INSERT INTO evaluation VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, 0)";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, evaluationDTO.getUserID());
				pstmt.setString(2, evaluationDTO.getLectureName());
				pstmt.setString(3, evaluationDTO.getProfessorName());
				pstmt.setInt(4, evaluationDTO.getLectureYear());
				pstmt.setString(5, evaluationDTO.getLectureDivide());
				pstmt.setString(6, evaluationDTO.getEvaluationTitle());
				pstmt.setString(7, evaluationDTO.getEvaluationContent());
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return -1;
		}
		
		public ArrayList<EvaluationDTO> getList (String lectureDivide, String searchType, String seach, int pageNumber){
			if(lectureDivide.equals("전체")) {
				lectureDivide = "";
			}
			ArrayList<EvaluationDTO> evaluationList = null; //강의 평가글이 담김
			PreparedStatement pstmt = null;
			String SQL="";	//sql 결과값으로 나온 결과값 처리
			try {
				if(searchType.equals("최신순")) {
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
				}else if (searchType.equals("추천순")){
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

				}
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%"+ lectureDivide +"%");
				pstmt.setString(2, "%"+ seach +"%");
				rs = pstmt.executeQuery();
				evaluationList = new ArrayList<EvaluationDTO>();
				while(rs.next()) {
					EvaluationDTO evaluation = new EvaluationDTO(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getString(4),
							rs.getInt(5),
							rs.getString(6),
							rs.getString(7),
							rs.getString(8),
							rs.getInt(9)
							);
					evaluationList.add(evaluation);
				}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					try {
						if(rs != null)rs.close();
						if(pstmt != null)pstmt.close();
						if(conn != null)conn.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
			return evaluationList;
		}
		
		//특정 글에 좋아요 일증가 함수
		public int like(String evaluationID) {
			PreparedStatement pstmt = null;
			try {
				String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(evaluationID));
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return -1;
		}
		
		public int delete(String evaluationID) {
			PreparedStatement pstmt = null;
			try {
				String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(evaluationID));
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return -1;
		}
		
		public String getUserID(String evaluationID) {
			PreparedStatement pstmt = null;
			try {
				String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(evaluationID));
				rs = pstmt.executeQuery();
				while(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return null;
		}
}
	