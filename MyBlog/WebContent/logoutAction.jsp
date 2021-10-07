<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">
<%-- 부트스트랩 연결 --%>
<link rel="stylesheet" href="css/bootstrap.css">

<%-- 구글 연동 세팅 --%>
<meta name="google-signin-client_id" content="62529444596-b0sskkar2ccs6tsqjq4fnm3r26q67cj1.apps.googleusercontent.com">
<title>웹프로그래밍 연습</title>
</head>
<body>
<%
	//세션 만료
	session.invalidate();
%>
<script>
//구글 연결 시 onlad로 호출할 함수
//init() 호출후 then 을 이용해 곧바로 SignOut()을 호출한다
function onLoad() {
    gapi.load('auth2', function() {
      gapi.auth2.init().then(function () {
    	  SignOut();
      });
      console.log('init success');
    });
  }
//구글 로그아웃 함수
function SignOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
    });
    //자동 로그인 방지
    auth2.disconnect();
    
    //메인 페이지로 이동
    location.href = 'main.jsp';
  }
</script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
</body>
</html>