<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="javax.mail.Transport"%>
<%@ page import ="javax.mail.Message"%>
<%@ page import ="javax.mail.Address"%>
<%@ page import ="javax.mail.internet.InternetAddress"%>
<%@ page import ="javax.mail.internet.MimeMessage"%>
<%@ page import ="javax.mail.Session"%>
<%@ page import ="javax.mail.Authenticator"%>
<%@ page import ="java.util.Properties"%>
<%@ page import ="user.UserDAO"%>
<%@ page import ="util.SHA256"%>
<%@ page import ="util.Gmail"%>
<%@ page import ="java.io.PrintWriter"%>	<!-- 특정한 스크립트 구문을 출력하고자 할때-->

<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	
	if(session.getAttribute("userID") != null){	//로긴 된상태면 세션값을 주고
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){	//안됐으면 로긴페이지로 가세요
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
	}

	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true ){
		PrintWriter script =response.getWriter(); 
		script.println("<script>");
		script.println("alert('이미 인증된 회원 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
	}
	
	//사용자에게 보낼 메세지 기입
	String host = "http://localhost:8080/";
	String from = "ugee719@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "다뽑아벌여SHOP 회원가입 인증을 위한 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요."+

		"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";

		
		//smtp에 접속하기 위한 정보
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.gmail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.ssl.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.soketFactory.port", "465");
	p.put("mail.smtp.soketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.soketFactory.fallback", "false");
	
	//이메일을 전송하는 부분 (사용자가 관리자한테 이메일 보낼수 있게)
	try{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);	//메일에 제목을넣고
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);	//받는사람 주소
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);
		
	}catch(Exception e){
		e.printStackTrace();
		PrintWriter script =response.getWriter(); 
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.')");
		script.println("history.back()'");
		script.println("</script>");
		script.close();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>다뽑아벌여SHOP</title>
	<!-- 부트스트랩 css 추가 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css 추가 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>

<!-- 내비게이션 시작 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index.jsp">다뽑아벌여SHOP</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!-- 토글러를 눌렀을때 이부분이 눌러졌다가 안눌러졌다가 -->
      <div id="navbar" class="collapse navbar-collapse">
      	<ul class="navbar-nav mr-auto">
      		<li class="nav-item">
      			<a class="nav-link" href="index.jsp">메인</a>
      		</li>
      		<li class="nav-item active">
      			<a class="nav-link" href="community.jsp">이벤트</a>
      		</li>
      		<li class="nav-item">
      			<a class="nav-link" href="contact.jsp">문의</a>
      		</li>
      		<!-- 눌렀을때 나오는  -->
      		<li class="nav-item dropdown">
      			<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
      				회원 관리
      			</a>
      			<div class="dropdown-menu" aria-labelledby="dropdown">
      			
      			<%
      				if(userID == null){
      			%>
      			
      				<a class="dropdown-item" href="userLogin.jsp">로그인</a>
      				<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
      			<%
      				} else {
      			%>
      				<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
      			<%
      				}
      			%>
      			</div>
      		</li>
      	</ul>
      	<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
          <input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
      </div>
	</nav>
<!-- 내비게이션 끝 -->

	<section class="container mt-3" style="max-width: 560px;">
		<div class="alert alert-success mt-4" role="alert">
			이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가셔서 인증해주세요.
		</div>
	
	</section>
	
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
      Copyright ⓒ 2019 재래김유진. All Rights Reserved.
    </footer>

	
	<!-- 제이쿼리 자바스크립트 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가 -->
	<script src="./js/popper.js"></script> 
	<!-- 부트스트랩 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>
