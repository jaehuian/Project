<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">

<%-- 디자인(부트스트랩, 글꼴) 연결--%>
<link rel="stylesheet" href="css/bootstrap.css">
<title>웹프로그래밍 연습</title>

  </head>
  <body>
  <%
  UserDAO userDAO=new UserDAO();
  //로그인 함수 호출
 	int result=userDAO.Login(user.getUserID());
 	
 	//로그인 성공
 	if(result==1){
 		session.setAttribute("userID", user.getUserID());
 		PrintWriter script=response.getWriter();
 		script.println("<script>");
 		script.println("location.href='main.jsp'");
 		script.println("</script>");
 	}
 	//아이디아 없을 경우
 	else if(result==-1){
 		//소셜 가입 함수 호출
 		result=userDAO.Join_Social(user);
 		//세션에 로그인 등록(로그인)
 		session.setAttribute("userID", user.getUserID());

		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
  %>
  </body>
</html>