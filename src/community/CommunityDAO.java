package community;


import java.util.ArrayList;



public class CommunityDAO {
	
	private ArrayList<CommunityDTO> listOfCommunitys = new ArrayList<CommunityDTO>();
	private static CommunityDAO instance = new CommunityDAO();
	
	public static CommunityDAO getInstance() {
		return instance;
	}
	
	public ArrayList<CommunityDTO> getAllCommunitys(){
		return listOfCommunitys;
	}
	
	
	public CommunityDTO getCommunityById(String c_id) {
		CommunityDTO communityById = null;
		
		for(int i=0; i<listOfCommunitys.size(); i++) {
			CommunityDTO communityDTO = listOfCommunitys.get(i);
			if(communityDTO !=null && communityDTO.getC_id()!=null && communityDTO.getC_id().equals(c_id)) {
				communityById =communityDTO;
				break;
			}
		}
		return communityById;
	}
	
	public void addCommunityDTO(CommunityDTO communityDTO) {
		listOfCommunitys.add(communityDTO);
	}
	
}
	

	
	//DB에서 글 목록 가져오기
	//리스트에 담아 반환해주는 ArrayList<Bbs>함수 생성
//	private ArrayList<CommunityDTO> getList(int pageNumber){
//		String SQL = "SELECT * FROM community WHERE c_id < ? available = 1 ORDER BY c_id DESC LIMIT 6";
//		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext()-(pageNumber-1)*6);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				CommunityDTO community = new CommunityDTO(
//						rs.getInt(1),
//						rs.getString(2),
//						rs.getString(3),
//						rs.getInt(4),
//						rs.getString(5),
//						rs.getString(6)
//						);
//				list.add(community);
//						
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
//	
//	//글 내용 불러오는 함수
//	public CommunityDTO getCommunity(int c_id) {
//		String SQL = "SELEC * FROM community WHERE c_id=?";
//				try {
//					PreparedStatement pstmt = conn.prepareStatement(SQL);
//					pstmt.setInt(1, c_id);
//					rs=pstmt.executeQuery();
//					if(rs.next()) {
//						CommunityDTO community = new CommunityDTO();
//						community.setC_id(rs.getInt(1));
//						community.setC_userId(rs.getString(2));
//						community.setC_title(rs.getString(3));
//						community.setC_date(rs.getInt(4));
//						community.setC_content(rs.getString(5));
//						community.setC_file(rs.getString(6));
//						
//						return community;
//					}
//				}catch(Exception e) {
//					e.printStackTrace();
//				}
//				return null;
//	}
	
	
	
	
	
	
	
	
//	public int write(String c_title, String c_userId, String c_date, String c_content, String c_file) {
//		String SQL ="INSERT INTO community VALUES (NULL, ?, ?, ?, ?, ?)";
//		try {
//			
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext());
//			pstmt.setString(2, c_userId);
//			pstmt.setString(3, c_title);
//			pstmt.setString(4, c_date);
//			pstmt.setString(5, c_content);
//			return pstmt.executeUpdate();
//		}catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			try {
//				if(pstmt != null) pstmt.close();
//				if(conn != null) conn.close();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		return -1;
//	}
//	
//	//10 단위 페이징 처리를 위한 함수
//
//	public boolean nextPage (int pageNumber) {
//		String SQL = "SELECT * FROM BBS WHERE bbsID < ? bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
//		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				return true;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return false; 		
//	}
//	
//	
//	//community 게시글 번호 가져오는 함수
//	public int getNext() { 
//		String SQL = "SELECT c_id FROM community ORDER BY c_id DESC";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				return rs.getInt(1) + 1;
//			}
//			return 1;//첫 번째 게시물인 경우
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1; //데이터베이스 오류
//
//	}
//
//	
//}
