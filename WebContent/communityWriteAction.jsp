<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="community.CommunityDAO"%>
<%@ page import="community.CommunityDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {	//로그인을 해야 글 등록이 가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
	}
	
	/* String str = "";
	String[] array = str.split(".");
		for(int i=0; i<array.length; i++){
			out.println(array[i]);
		} */
		
	String filename = "";
	String realFolder = "/Users/ugee/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/LectureEvaluation/upload";
	/* "C:\\eclipse_ee\\eclipse-workspace\\aboutme\\WebContent\\upload" */
	int maxSize = 5 * 1024 * 1024;
	String encType = "UTF-8";
	
	CommunityDAO dao = CommunityDAO.getInstance();
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String c_id = multi.getParameter("c_id");
	String c_name = multi.getParameter("c_name");
	String c_title = multi.getParameter("c_title");
	String c_date = multi.getParameter("c_date");
	String c_content = multi.getParameter("c_content");

	
	Enumeration files = multi.getFileNames();
	String fname =(String) files.nextElement();
	String c_fileName = multi.getFilesystemName(fname);
	
	PreparedStatement pstmt = null;
	
	String sql = "INSERT INTO community VALUES(?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, c_id);
	pstmt.setString(2, c_name);
	pstmt.setString(3, c_title);
	pstmt.setString(4, c_date);
	pstmt.setString(5, c_content);
	pstmt.setString(6, c_fileName);
	pstmt.executeUpdate();
	
	if(pstmt !=null)
		pstmt.close();
	if(conn !=null)
		conn.close();
	
	//새로운 기록 추가
	CommunityDTO newCommunityDTO = new CommunityDTO();
	newCommunityDTO.setC_id(c_id);
	newCommunityDTO.setC_name(c_name);
	newCommunityDTO.setC_title(c_title);
	newCommunityDTO.setC_date(c_date);
	newCommunityDTO.setC_content(c_content);
	newCommunityDTO.setFileName(filename);
	
	dao.addCommunityDTO(newCommunityDTO);
	
	response.sendRedirect("community.jsp");
			
%>