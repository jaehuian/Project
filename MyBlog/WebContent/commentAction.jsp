<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page"/>
<jsp:setProperty name="comment" property="bbsID"/>
<jsp:setProperty name="comment" property="bbsComment"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">

<%-- 부트스트랩 연결 --%>
<link rel="stylesheet" href="css/bootstrap.css">
<title>웹프로그래밍 연습</title>
</head>

<body>
<%
	String userID = null;
	
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		if(comment.getBbsComment()==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		else{
			CommentDAO commentDAO=new CommentDAO();
			int result=commentDAO.write(comment.getBbsID(),userID,comment.getBbsComment());
		
			if(result==-1){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
	}
	
	System.out.println(comment.getBbsID());
	System.out.println(comment.getBbsComment());
%>
</body>
</html>