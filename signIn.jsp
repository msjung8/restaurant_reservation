<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>회원가입 사이트</title>
		<script>
			function home(){
				window.open("prototype.jsp", "_self");
			}
		</script>
		<style>
			header {
                text-align : center;
                font-size : 40px;
                text-shadow: 3px 3px skyblue;
            }
            header::first-letter {
                color : #FA8072;
            }
        	body {
                background-color : #F9F3E9;
                width : 300px;
                margin-left : auto;
                margin-right : auto;
            }
            hr {
                border : 1px solid #FA8072;
            }
			button, input {
				width : 300px;
				height : 50px;
				margin-top : 30px;
				margin-bottom : 30px;
				font-size : 17px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
			}
		</style>
	</head>
	<body>
		<header>
			<h2>회원가입 사이트</h2>
		</header>
        <form method="get" action="signInUser.html">
            <input type="submit" value="일반유저 회원가입">
		</form>
		<form method="get" action="signInRest.html">
            <input type="submit" value="레스토랑 회원가입">
		</form>
		<button type="button" onclick="home()">홈으로</button>
	</body>
</html>