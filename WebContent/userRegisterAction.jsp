<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="user.UserDTO"%>
<%@ page import ="user.UserDAO"%>
<%@ page import ="util.SHA256"%>
<%@ page import ="java.io.PrintWriter"%>	<!-- 특정한 스크립트 구문을 출력하고자 할때-->

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	
	if(request.getParameter("userID") != null){	//사용자가 보낸 아이디값
		userID =request.getParameter("userID");	//userID에 담아줌
	}
	if(request.getParameter("userPassword") != null){
		userPassword = request.getParameter("userPassword");
	}		
	if(request.getParameter("userEmail") != null){
		userEmail = request.getParameter("userEmail");
	}
	
	if(userID == null || userPassword == null || userEmail == null){	//사용자가 제대로 값을 입력하지 않은 경우(빈값)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();	//오류가 나면 이 jsp 페이지 작동 종료

	
	}else{
	
	//그렇지 않은 경우 (성공) 데이터를 넣어줘야함
	UserDAO userDAO = new UserDAO();	//UserDAO를 객체로 생성 
	
	int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));	//한명의 정보를 담았음
	if (result == -1){	//회원가입 실패
		PrintWriter script =response.getWriter(); 
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디 입니다 .')");
		script.println("history.back()");
		script.println("</script>");
		script.close();	//오류가 나면 이 jsp 페이지 작동 종료

		
		}else{
			session.setAttribute("userID", userID);	//회원가입 성공하면 세션 넣어주고
			PrintWriter script =response.getWriter(); 
			script.println("<script>");
			script.println("location.href = 'emailSendAction.jsp'");	//마! 이메일 인증하러 가자! 
			script.println("</script>");
			script.close();	
		
	}
}
	
%>
