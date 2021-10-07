<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>

<%-- 게시글 클래스 포함 --%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">

<%-- 디자인(부트스트랩, 글꼴) 연결 --%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>웹프로그래밍 연습</title>
</head>

<body>
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID")!=null){
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID==0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs=new BbsDAO().getBbs(bbsID);
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
   	<li ><a href="userInfoAction.jsp">회원정보 수정</a></li>
    <li ><a href="logoutAction.jsp">로그아웃</a></li>
   </ul>
   </li>
  </ul> 
  <%
  		}
  %>
 </div>
 </nav>
 
 <%-- 게시글  --%>
 <div class="container">
 <div class="row">
 <table class="table table-striped" style="text-align:center;">
 		<thead>
 			<tr>
 			<th colspan="3" >게시판 글 보기</th>
 			</tr>
 		</thead>
 		<tbody>
 			<tr>
 			<td style="width: 20%">글 제목</td>
 			<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %></td>
 			</tr>
 			<tr>
 			<td>작성자</td>
 			<td colspan="2"><%=bbs.getUserID() %></td>
 			</tr>
 			<tr>
 			<td>작성일자</td>
 			<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시 "+ bbs.getBbsDate().substring(14,16) + "분 " %></td>
 			</tr>
 			<tr>
 			<td>내용</td>
 			<td colspan="2" style="min-height: 200px; text-align: left"><%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>	
 			</tr>
 		</tbody>
 	</table>
 	<a href="bbs.jsp" class="btn btn-primary">목록</a>
 	
 	<%-- 유저가 글쓴이일 경우 수정, 삭제 버튼 출력 --%>
 	<%
 		if(userID != null && userID.equals(bbs.getUserID())){
 	%>
 	<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
 	<a onclick="return confirm('정말로 삭제하시겠습니까')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
 	<%
 		}
 	%>
 </div>
 </div>
 
 <div class="container">
 <div class="row">
 <form method="post" action="commentAction.jsp">
 <table class="table table-striped" border="1" style="text-align:center;">
 		<thead>
 		<%-- 로그인 되있을 경우 댓글 작성 출력 --%>
 		<tr>
 		<%
 			if(userID != null){
 		%>
 		<th colspan="4" style="border-right: 1px solid white;">
 		<div class="row">
 		<div><textarea placeholder="댓글 쓰기" name="bbsComment" rows="5" maxlength="1024" style="width:90%;color:black;"></textarea></div>
 		<input type="hidden" name="bbsID" value=<%=bbsID %>>
 		<div style="text-align:right;padding:10px 20px 10px 20px;"><input type="submit" class="btn btn-primary pull-right" value="댓글 쓰기"></div>
 		</div>
		</th>
		<%
 			}
 		%>
 		</tr>
 		</thead>
 		<%-- 데이터 베이스에서 글 불러오기 --%>
 		<tbody>
 		<%
 			CommentDAO commentDAO = new CommentDAO();
 			ArrayList<Comment> list = commentDAO.getComments(bbsID);
 			for(int i=0;i<list.size();i++){
 		%>
 			<tr>
 			<td style="width: 20%"><%= list.get(i).getUserID() %></td>
 			<td colspan="3"><a><%= list.get(i).getBbsComment().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %></a></td>
 			</tr>
 		<%
 			}
 		%>
 		</tbody>
 	</table>
 </form>
 </div>
 </div>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>