<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>
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
	//evaluationID는 자동증가, userID는 위에서, likecount는 자동으로 0값
	request.setCharacterEncoding("UTF-8");
	String lectureName = null;
	String professorName = null;
	int lectureYear = 0;
	//String semesterDivide = null;
	String lectureDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	/* String totalScore = null;
	String creditScore = null;
	String comfortableScore = null;
	String lectureScore = null; */
	
	//사용자로부터 입력받게
	if(request.getParameter("lectureName") != null) {
		lectureName = (String) request.getParameter("lectureName");
	}
	if(request.getParameter("professorName") != null) {
		professorName = (String) request.getParameter("professorName");
	}
	if(request.getParameter("lectureYear") != null) {	
		try {						//lectureYear는 인트형이니까 ParseInt정수형으로 바꾸기
			lectureYear = Integer.parseInt(request.getParameter("lectureYear"));	
		} catch (Exception e) {
			System.out.println("강의 연도 데이터 오류");
		}
	}
	/* if(request.getParameter("semesterDivide") != null) {
		semesterDivide = (String) request.getParameter("semesterDivide");
	} */
	if(request.getParameter("lectureDivide") != null) {
		lectureDivide = (String) request.getParameter("lectureDivide");
	}
	if(request.getParameter("evaluationTitle") != null) {
		evaluationTitle = (String) request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != null) {
		evaluationContent = (String) request.getParameter("evaluationContent");
	}
	/* if(request.getParameter("totalScore") != null) {
		totalScore = (String) request.getParameter("totalScore");
	}
	if(request.getParameter("creditScore") != null) {
		creditScore = (String) request.getParameter("creditScore");
	}
	if(request.getParameter("comfortableScore") != null) {
		comfortableScore = (String) request.getParameter("comfortableScore");
	}
	if(request.getParameter("lectureScore") != null) {
		lectureScore = (String) request.getParameter("lectureScore");
	} */
	
	//<select>숫자 선택하는건 required로 못함
	if (lectureName == null || professorName == null || lectureYear == 0 || 
			lectureDivide == null || evaluationTitle == null || evaluationContent == null ||
			evaluationTitle.equals("") || evaluationContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else {
		//사용자가 등록한 글 내용 (등록할거)
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear, lectureDivide, evaluationTitle, evaluationContent, 0));
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = './index.jsp';");
			script.println("</script>");
			script.close();
		}
	}
%>