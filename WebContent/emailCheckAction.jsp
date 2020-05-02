<%@page import="java.io.PrintWriter"%>
<%@page import="util.SHA256"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("code");
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");	//object객체를 반환하기때문에 (String)으로
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();

	}
	String userEmail = userDAO.getUserEmail(userID);
	boolean rightCode = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false; //해시값과 사용자가 보낸코드값과 일치하는지
	if(rightCode == true) {
		userDAO.setUserEmailChecked(userID);	//해당사용자의 이메일 인증을 처리해주게
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		

	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		

	}
%>
