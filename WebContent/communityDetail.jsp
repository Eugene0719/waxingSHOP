<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="community.CommunityDTO" %>
<%@ include file ="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>다뽑아벌SHOP</title>
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
		String id = request.getParameter("id");
		CommunityDAO dao = CommunityDAO.getInstance();
		CommunityDTO travel = dao.getCommunityById(id);
	%>
	
	<div class="container"><br>
		<div class="row">
		<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "SELECT * FROM community WHERE c_id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()){
		%>
			<div class="col-md-5">
				<img src="upload/<%=rs.getString("c_fileName") %>" style="max-width: 100%; height: auto;">
			</div>

			<div class="col-md-6" style="margin-top:30px;">
				<h4><b><%=rs.getString("c_name") %></b></h4>
				<h3><%=rs.getString("c_date") %></h3>
				<p><%=rs.getString("c_title") %>
				<p><%=rs.getString("c_content") %>
			</div>
		
		</div>
		<br>
		<button type="button" class="btn btn-primary" onclick="button()">목록</button>
		<button type="button" class="btn btn-primary" onclick="location.href='communityUpdate.jsp?id=<%=rs.getString("c_id") %>'">수정</button>
		<hr>
		<%
			}
		%>
	</div>


	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
      Copyright ⓒ 2019 재래김유진. All Rights Reserved.
    </footer>

<script>
	function button(){
		location.href='community.jsp';
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