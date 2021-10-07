<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>

<%-- 게시글 클래스 포함 --%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">

<%-- 디자인(부트스트랩, 글꼴) 연결 --%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>웹프로그래밍 연습</title>

<%-- 글 링크 글자색 지정 --%>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber")!=null){
		pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
 <nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed"
    data-toggle="collapse" data-target="#navbar-collapse-1"
    aria-expanded="false">
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>
  </button>  
  <a class="navbar-brand" href="main.jsp">MyBlog</a>
 </div>
 <div class="collapse navbar-collapse" id="navbar-collapse-1">
  <ul class="nav navbar-nav">
   <li><a href="main.jsp">메인</a>
   <li class="active"><a href="bbs.jsp">게시판</a>
  </ul>
  <%
  	if(userID==null) {
  %>
   <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropddown-toggle"
    data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">접속하기<span class="caret"></span></a>
   <ul class="dropdown-menu">
    <li ><a href="login.jsp">로그인</a></li>
    <li ><a href="join.jsp">회원가입</a></li>
   </ul>
   </li>
  </ul> 
  <%
  		}else{
  %>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropddown-toggle"
    data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">회원관리<span class="caret"></span></a>
   <ul class="dropdown-menu">
   	<li ><a href="userInfo.jsp">회원정보 수정</a></li>
    <li ><a href="logoutAction.jsp">로그아웃</a></li>
   </ul>
   </li>
  </ul> 
  <%
  		}
  %>
 </div>
 </nav>
 
  <%-- 게시판 목록 --%>
 <div class="container">
 <div class="row">
 	<table class="table table-striped" style="text-align:center;">
 		<thead>
 			<tr>
 			<th style="border-right: 1px solid white;">번호</th>
 			<th style="border-right: 1px solid white;">제목</th>
 			<th style="border-right: 1px solid white;">작성자</th>
 			<th>작성일</th>
 			</tr>
 		</thead>
 		
 		<%-- 데이터 베이스에서 글 불러오기 --%>
 		<tbody>
 		<%
 			BbsDAO bbsDAO = new BbsDAO();
 			ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
 			for(int i=0;i<list.size();i++){
 		%>
 			<tr>
 			<td><%= list.get(i).getBbsID() %></td>
 			<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %></a></td>
 			<td><%= list.get(i).getUserID() %></td>
 			<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시 "+ list.get(i).getBbsDate().substring(14,16) + "분 " %></td>
 			</tr>
 		<%
 			}
 		%>
 		</tbody>
 	</table>
 	
 	<%-- 다음페이지 또는 이전페이지가 존재할 시  버튼 생성 --%>
 	<%
 		if(pageNumber != 1){
 	%>
 	<a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
 	<%
 		} if(bbsDAO.nextPage(pageNumber+1)){
 	%>
 	<a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
 	<%
 		}
 	%>
 	
 	<%-- 로그인하지 않을 경우 글쓰기 버튼 숨김 --%>
 	<% if(userID!=null){
 	%>
 		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
 	<%
 		}
 	%>
 </div>
 </div>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>