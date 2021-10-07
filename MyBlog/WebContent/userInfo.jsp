<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>

<%-- 유저 클래스 포함 --%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>

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
	
	UserDAO userDAO = new UserDAO();
	User user = null;
	
	if(userID!=null)
	{
		user = userDAO.getUserInfo(userID);
		if(user==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	}
	else{
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
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
   <li><a href="bbs.jsp">게시판</a>
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
    <li><a href="login.jsp">로그인</a></li>
    <li><a href="join.jsp">회원가입</a></li>
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
   	<li class="active"><a href="userInfo.jsp">회원정보 수정</a></li>
    <li><a href="logoutAction.jsp">로그아웃</a></li>
   </ul>
   </li>
  </ul> 
  <%
  		}
  %>
 </div>
 </nav>
 
 <%-- 유저 정보--%>
 <div class="container">
 <div class="col-lg-4"></div>
 <div class="col-lg-4">
 <div class="jumbtron" style="padding: 20px;border: 2px solid gray; border-radius:6px;">
 <form method="post" action="userInfoAction.jsp">
 	<h3 style="text-align: center;">유저 정보</h3>
 	
 	<table class="table table-striped" style="text-align:center;">
 	<thead>
 		<tr>
 		<th style="border-right: 1px solid white;vertical-align:middle;">이름</th>
 		<td style="border-right: 1px solid white;">
 			<div class="form-group">
     		<input type="text" class="form-control" value=<%= user.getUserName()%> name="userName" maxlength="10">     
    		</div>
    	</td>
 		</tr>
 	</thead>
 	<thead>
 		<tr>
 		<th style="border-right: 1px solid white;vertical-align:middle;">ID</th>
 		<td style="border-right: 1px solid white;">
 			<div class="form-group">
     		<a><%= user.getUserID()%></a>  
    		</div>
    	</td>
 		</tr>
 	</thead>
 	<thead>
 	<%
 		if(user.getUserPassword()!=null)
    	{
    %>
 		<tr>
 		<th style="border-right: 1px solid white;vertical-align:middle;">비밀번호</th>
 		<td style="border-right: 1px solid white;">
 			<div class="form-group">
     		<input type="password" class="form-control" value=<%= user.getUserPassword()%> name="userPassword" maxlength="20">     
    		</div>
    	</td>
 		</tr>
 	<%
    	}
 	%>
 	</thead>
 	<thead>
 		<tr>
 		<td colspan="2" style="border-right: 1px solid white;vertical-align:middle;">
 			<div class="form-group" style="text-align: center;"> 
    		<div class="btn-group" data-toggle="buttons">
    		<%
    			if(user.getUserGender()==null || user.getUserGender().equals("남자"))
    			{
    		%>
    			<label class="btn btn-primary active">
    			<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
    			</label>
    			<label class="btn btn-primary">
    			<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
    			</label>
    		<%
    			}else{
    		%>
    			<label class="btn btn-primary">
    			<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
    			</label>
    			<label class="btn btn-primary active">
    			<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
    			</label>
    		<%
    			}
    		%>
    		</div>  
    		</div>
    	</td>
 		</tr>
 	</thead>
 	<thead>
 		<tr>
 		<th style="border-right: 1px solid white;vertical-align:middle;">e-mail</th>
 		<td style="border-right: 1px solid white;">
 			<div class="form-group">
     		<input type="email" class="form-control" value=<%= user.getUserEmail()%> name="userEmail" maxlength="30">     
    		</div>
    	</td>
 		</tr>
 	</thead>
 	<thead>
 	</table>
 	<input type="submit" class="btn btn-primary form-control" value="수정">
 </form>
 </div>
 </div>
 <div class="col-lg-4"></div>
 </div>
 
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>