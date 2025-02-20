<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta charset="UTF-8">
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
			
			function del(){
				var xmlhttp = false;
				xmlhttp = new XMLHttpRequest();
				var res_name = document.getElementById("res_name");
				var user_id = document.getElementById("user_id");
				var res_phone = document.getElementById("res_phone");
				var date = document.getElementById("date");
				var time = document.getElementById("time");
				var url = "del_reserve_DB.jsp?res_name="+res_name.value+"&user_id="+user_id.value+
							"&res_phone="+res_phone.value+"&date="+date.value+"&time="+time.value;
				xmlhttp.open("GET", url, false);
				xmlhttp.send(null);
				
		
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
			<h2>리뷰를 작성하실 레스토랑 정보가 맞습니까?</h2>
		</header>
		<form method="GET" action="review_restaurant.jsp">
			레스토랑 이름 : <input type="text" id = "res_name" name="res_name" readonly class="block"> <br>
            유저 아이디 : <input type="text" id = "user_id" name="user_id" readonly class="block"> <br>
			레스토랑 전화번호 : <input type="text" id = "res_phone" name="res_phone" readonly class="block"><br>
            날짜 : <input type="text" id = "date" name="date" readonly class="block"> <br>
            시간 : <input type="text" id = "time" name="time" readonly class="block"> <br>
			<button type="submit" onclick="del()">네</button><button type="button" onclick="home()">아니요(홈으로)</button>
		</form>
	</body>
</html>