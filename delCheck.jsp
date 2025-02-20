<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta charset="UTF-8">
        <style>
			header {
                text-align : center;
                font-size : 20px;
                text-shadow: 3px 3px skyblue;
            }
            header::first-letter {
                color : #FA8072;
            }
        	body {
                background-color : #F9F3E9;
                width : 800px;
                margin-left : auto;
                margin-right : auto;
            }
            hr {
                border : 1px solid #FA8072;
            }
			button, input.button{
				width : 120px;
				height : 30px;
				font-size : 13px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
				margin-top : 10px;
			}
			input.block, textarea.block{
				background-color : lightgray;
			}
		</style>
		<script>
			window.onload=start;
			function start() {
				res_name = sessionStorage.getItem("ResName");
                user_id = sessionStorage.getItem("UserID");
				res_phone = sessionStorage.getItem("ResPhone");
                date = sessionStorage.getItem("Date");
                time = sessionStorage.getItem("time");
				
				temp1 = document.getElementById("res_name");
				temp2 = document.getElementById("user_id");
                temp3 = document.getElementById("res_phone");
                temp4 = document.getElementById("date");
                temp5 = document.getElementById("time");
				
				temp1.value=res_name;
				temp2.value=user_id;
                temp3.value=res_phone;
                temp4.value=date;
                temp5.value=time;
			}
			function home(){
				window.open("prototype.jsp", "_self");
			}
		</script>
		<style>
			header {
                text-align : center;
                font-size : 25px;
                text-shadow: 3px 3px skyblue;
            }
            header::first-letter {
                color : #FA8072;
            }
        	body {
                background-color : #F9F3E9;
                width : 800px;
                margin-left : auto;
                margin-right : auto;
            }
            hr {
                border : 1px solid #FA8072;
            }
			span {
				color : red;
			}
			label.wrong{
				color: red;
			}
			label.right{
				color : skyblue;
			}
			button, input.button{
				width : 120px;
				height : 30px;
				font-size : 13px;
				margin-top : 10px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
			}
			label {
				font-size : 17px;
				font-weight : bold;
			}
			input.block {
				background-color : lightgray;
			}
		</style>
	</head>
	<body>
		<header>
			<h2>삭제하실 예약 정보가 맞습니까?</h2>
		</header>
		<form method="GET" action="del_reserve_DB.jsp">
			레스토랑 이름 : <input type="text" id = "res_name" name="res_name" readonly class="block"> <br>
            유저 아이디 : <input type="text" id = "user_id" name="user_id" readonly class="block"> <br>
			레스토랑 전화번호 : <input type="text" id = "res_phone" name="res_phone" readonly class="block"><br>
            날짜 : <input type="text" id = "date" name="date" readonly class="block"> <br>
            시간 : <input type="text" id = "time" name="time" readonly class="block"> <br>
			<button type="submit">네</button><button type="button" onclick="home()">아니요(홈으로)</button>
		</form>
	</body>
</html>