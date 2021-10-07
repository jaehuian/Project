<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">

<%-- 디자인(부트스트랩, 글꼴) 연결--%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<%-- 구글 연동 세팅 --%>
  <meta name="google-signin-scope" content="profile email">
  <meta name="google-signin-client_id" content="62529444596-b0sskkar2ccs6tsqjq4fnm3r26q67cj1.apps.googleusercontent.com"> 
  <script>
  function init() {
	  gapi.load('auth2', function() { 
          var gauth = gapi.auth2.init({
              client_id: '62529444596-b0sskkar2ccs6tsqjq4fnm3r26q67cj1.apps.googleusercontent.com'
          });
          
          gauth.then(function(){
              console.log('init success');
          }, function(){
              console.error('init fail');
          })
      });
  }
</script>
<%--구글연결, init() 함수 호출 --%>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
  
<title>웹프로그래밍 연습</title>
</head>
<body>

<%-- 네비게이션바 --%>
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
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropddown-toggle"
    data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">접속하기<span class="caret"></span></a>
   <ul class="dropdown-menu">
    <li class="active"><a href="login.jsp">로그인</a></li>
    <li ><a href="join.jsp">회원가입</a></li>
   </ul>
  </li>
  </ul> 
 </div>
 </nav>
 
 <%-- 기본 로그인 화면 --%>
 <div class="container">
  <div class="col-lg-4"></div>
  <div class="col-lg-4">
   <div class="jumbtron" style="padding: 20px;border: 2px solid gray; border-radius:6px;">
   <form method="post" action="loginAction.jsp">
    <h3 style="text-align: center;">로그인화면</h3>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">     
    </div>    
    <div class="form-group">
     <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">     
    </div>
    <input type="submit" class="btn btn-primary form-control" value="로그인">
   </form>
  </div>
 </div> 
 <div class="col-lg-4">
 
 	<%-- 구글 로그인 버튼 --%>
 	<div class="g-signin2" style="padding: 10px;" data-width="150" data-onsuccess="onSignIn" data-theme="light"></div>
 	<%-- 구글 프로필 전송 --%>
 	<form method="post" id="extraLoginForm" action="google_loginAction.jsp">
     <input type="hidden" id="userID" name="userID" value="">
     <input type="hidden" id="userName" name="userName" value="">
     <input type="hidden" id="userEmail" name="userEmail" value="">
   </form>
   
 </div>
 </div>
 
 <%-- 구글 함수 --%>
 <script>
 //구글 로그인
 	function onSignIn(googleUser) {
     // Useful data for your client-side scripts:
     var profile = googleUser.getBasicProfile();
     console.log("ID: " + profile.getId()); // Don't send this directly to your server!
     console.log('Full Name: ' + profile.getName());
     console.log('Given Name: ' + profile.getGivenName());
     console.log('Family Name: ' + profile.getFamilyName());
     console.log("Image URL: " + profile.getImageUrl());
     console.log("Email: " + profile.getEmail());
     
     // The ID token you need to pass to your backend:
     var id_token = googleUser.getAuthResponse().id_token;
     console.log("ID Token: " + id_token);
     
     //전송할 프로퍼티 값 세팅
     document.getElementById("userID").value=profile.getEmail();
     document.getElementById("userName").value=profile.getName();    
     document.getElementById("userEmail").value=profile.getEmail();
     
     //구글 폼 submit
     $('#extraLoginForm').submit();

   }
 </script>

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>