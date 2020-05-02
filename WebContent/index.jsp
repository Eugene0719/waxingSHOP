<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
	if(userID == null){
		PrintWriter script =response.getWriter(); 
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
	}
	
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false){
		PrintWriter script =response.getWriter(); 
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");	//이메일 인증을 받으시겠습니까?
		script.println("</script>");
		script.close();
		
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
      		<li class="nav-item active">
      			<a class="nav-link" href="index.jsp">메인</a>
      		</li>
      		<li class="nav-item ">
      			<a class="nav-link" href="community.jsp">이벤트</a>
      		</li>
      		<li class="nav-item ">
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
	
	<div class="container">
      <form method="get" action="./index.jsp" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="전체">전체</option>
          <option value="팔">팔<% if(lectureDivide.equals("팔")) out.println("✓"); %></option><!-- 사용자가 선택한게 전공이라면 -->
          <option value="다리">다리<% if(lectureDivide.equals("다리")) out.println("✓"); %></option>
          <option value="겨드랑이">겨드랑이<% if(lectureDivide.equals("겨드랑이")) out.println("✓"); %></option>
          <option value="브라질리언">비키니/브라질리언<% if(lectureDivide.equals("브라질리언")) out.println("✓"); %></option>
        </select>
        <select name="seachType" class="form-control mx-1 mt-2">
          <option value="최신순">최신순</option>
          <option value="추천순">추천순<% if(searchType.equals("추천순")) out.println("selected"); %></option><!-- 사용자가 선택한게 전공이라면 -->
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        <a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
      </form>
      
      <%
	      ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	  	  evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	  	  if(evaluationList != null)
	  	  for(int i = 0; i < evaluationList.size(); i++) {
	  		if(i == 5) break;	//6개 가지고 왔지만 5개까지 출력
	  		EvaluationDTO evaluation = evaluationList.get(i);
      %>
      
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left"><%= evaluation.getLectureName() %>&nbsp;<small><%= evaluation.getProfessorName() %></small></div>
          </div>
        </div>
        <div class="card-body">
          <h5 class="card-title">
           <%=evaluation.getEvaluationTitle()%>&nbsp;<small>(<%=evaluation.getLectureYear()%>회차)</small>
          </h5>
          <p class="card-text"><%=evaluation.getEvaluationContent()%></p>
          <div class="row">
          <div class="col-9 text-left">
              <span style="color: green;">(추천: <%=evaluation.getLikeCount()%>)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">추천</a>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">삭제</a>
            </div>
          </div>
        </div>
      </div>
      <%

		}
	
	 %>
      
    </div>
    <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
      <%
			if(pageNumber <= 0) {
		%>     
		        <a class="page-link disabled">이전</a>
		<%
			} else {
		%>
				<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>
		<%
			}
		%>
		      </li>
		      <li class="page-item">
		<%
			if(evaluationList.size() < 6) {
		%>     
		        <a class="page-link disabled">다음</a>
		<%
			} else {
		%>
				<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>
		<%
			}
		%>
      </li>
    </ul>
     <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
     <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="./evaluationRegisterAction.jsp" method="post">
              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label>왁싱받은 날짜</label>
                  <input type="text" name="lectureName" class="form-control" maxlength="20" required>
                </div>
                <div class="form-group col-sm-6">
                  <label>회원이름</label>
                  <input type="text" name="professorName" class="form-control" maxlength="20" required>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label>확싱 회차</label>
                  <select name="lectureYear" class="form-control">
                    <option value="1" selected>1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                  </select>
                </div>
                <!-- <div class="form-group col-sm-4">
                  <label>수강 학기</label>
                  <select name="semesterDivide" class="form-control">
                    <option name="1학기" selected>1학기</option>
                    <option name="여름학기">여름학기</option>
                    <option name="2학기">2학기</option>
                    <option name="겨울학기">겨울학기</option>
                  </select>
                </div> -->
                <div class="form-group col-sm-6">
                  <label>왁싱부위</label>
                  <select name="lectureDivide" class="form-control">
                    <option name="전체" selecte>전체</option>
                    <option name="팔">팔</option>
                    <option name="다리">다리</option>
                    <option name="겨드랑이">겨드랑이</option>
                    <option name="겨드랑이">비키니/브라질리언</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label>제목</label>
                <input type="text" name="evaluationTitle" class="form-control" maxlength="20" required>
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea type="text" name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;" required></textarea>
              </div>
              <!-- <div class="form-row">
                <div class="form-group col-sm-3">
                  <label>종합</label>
                  <select name="totalScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>성적</label>
                  <select name="creditScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>널널</label>
                  <select name="comfortableScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>강의</label>
                  <select name="lectureScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
              </div> -->
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary">등록하기</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">불편사항</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form method="post" action="./reportAction.jsp">
              <div class="form-group">
                <label>어떤점이 불편하셨나요?</label>
                <input type="text" name="reportTitle" class="form-control" maxlength="20">
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea type="text" name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-danger">접수하기</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
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