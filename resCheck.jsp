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
				res_phone = sessionStorage.getItem("ResPhone");
				res_addr = sessionStorage.getItem("ResAddress");
				
				temp1 = document.getElementById("res_name");
				temp2 = document.getElementById("res_phone");
				temp3 = document.getElementById("addr");
				
				temp1.value=res_name;
				temp2.value=res_phone;
				temp3.innerHTML=res_addr;
			}
			function home(){
				window.open("prototype.jsp", "_self");
			}
		</script>
	</head>
	<body>
		<header>
			<h2>선택하신 레스토랑이 이 정보가 맞습니까?</h2>
		</header>
		<form method="GET" action="reserve_restaurant.jsp">
			레스토랑 이름 : <input type="text" id = "res_name" name="res_name" readonly class="block"> <br>
			레스토랑 전화번호 : <input type="text" id = "res_phone" name="res_phone" readonly class="block"><br>
			레스토랑 주소 : <textarea cols="40" rows="5" maxlength="200" id="addr" name="addr" readonly class="block"></textarea> <br>
			<button type="submit">네</button><button type="button" onclick="home()">아니요(홈으로)</button>
		</form>
	</body>
</html>