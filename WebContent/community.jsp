<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ include file ="dbconn.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="community.CommunityDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewpoint" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>다뽑아벌여SHOP</title>
	<!-- 부트스트랩 css 추가 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css 추가 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>

<body>
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			System.out.println("검색 페이지 오류!");
		}
		
	}
	


	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
%>

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

		<%
			CommunityDAO dao = CommunityDAO.getInstance();
			ArrayList<CommunityDTO> listOfCommunitys = dao.getAllCommunitys();
		%>
	
	<div class = "container">
	<br><br>
            <h1>이벤트 게시판</h1><br>
		<div class = "row" align="center" style="padding:30px">
		

		<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "SELECT * FROM community ORDER BY c_id DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
		%>
		
		<div class = "col-md-4"> 
		<img src="upload/<%=rs.getString("c_fileName") %>" style="max-width: 100%; height: auto;"/>
		<br>
		<br>
			<h4><a href="./communityDetail.jsp?id=<%=rs.getString("c_id") %>" ><%=rs.getString("c_name") %></a></h4>
			<p><%=rs.getString("c_date") %>
		</div>
		
		<%
			}
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		%>
		
		</div>

			<%
			if(session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			%>
			<button type="button" class="btn btn-primary pull-right" onclick="button()">글쓰기</button>
			<%
			}
			%>
	</div>
	<hr>


	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
      Copyright ⓒ 2019 재래김유진. All Rights Reserved.
    </footer>

<script>
function button() {
	
	var id = "admin";
	var pw = "1";

	var user_id = prompt("아이디는 ?", "");
	var user_pw = prompt("비밀번호는 ?", "");
	
	if(user_id==id){
		if(user_pw==pw){
			alert("맞았어요 ");
			location.href='communityWrite.jsp';
		}else{
			alert("비밀번호가 일치하지 않습니다.");
			location.reload();
		}
	}else{
		alert("아이디가 일치하지 않습니다.");
		location.reload();
	}
}
</script>
	
	<!-- 제이쿼리 자바스크립트 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가 -->
	<script src="./js/popper.js"></script> 
	<!-- 부트스트랩 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>


</body>
</html>