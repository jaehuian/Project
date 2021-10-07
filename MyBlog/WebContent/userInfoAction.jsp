<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   

<%-- 유저 클래스 포함 --%>
<%@ page import="user.UserDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>웹프로그래밍 연습</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	
	//유저 정보에 공란이 있을 경우
	if((user.getUserPassword()==null && !userID.contains("@gmail.com")) || 
			user.getUserName() == null || user.getUserGender()==null || user.getUserEmail() == null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else{
		UserDAO userDAO=new UserDAO();
		user.setUserID(userID);
		int result=userDAO.updateUserInfo(user);
	
		if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('수정 실패')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('수정 성공')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	}
%>
</body>
</html>