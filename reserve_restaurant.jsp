<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.* , java.util.Date" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
	String u_id = (String) session.getAttribute("UID");
	String u_name =(String) session.getAttribute("UName");
	String r_name =  request.getParameter("res_name");
	String r_phone = request.getParameter("res_phone");
			
	session.setAttribute("res_name",r_name);
	session.setAttribute("res_phone",r_phone);

	Date d1 = new Date();
	d1.getYear();
	d1.getMonth();
	d1.getDate();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script>
			var xmlhttp = false;
			if(window.XMLHttpRequest){
				xmlhttp = new XMLHttpRequest();
			}
			function search_reviewList() { //list_restaurant_DB.jsp에 연결해서 검색어를 보냄 - 해당 음식점 목록 가져옴
				var url = 'review_DB_list.jsp?'
						xmlhttp.open("GET", url, true);
						xmlhttp.onreadystatechange = get_reviewList;
						xmlhttp.send(null);
							
			}
			function get_reviewList() { // 레스토랑 리스트 가져와서 third 섹션 내에 출력함
				let arr = new Array();
				var temp_list = document.getElementById("temp_list"); //레스토랑 정보 넣을 섹션
				while (temp_list.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
					temp_list.removeChild(temp_list.firstChild);
				}

				if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var start = xmlhttp.responseText.indexOf("^"); //시작구분자
					var end = xmlhttp.responseText.indexOf("@"); //끝 구분자
					
					var tempStr = xmlhttp.responseText.substring(start+1, end);
					arr = tempStr.split("\n");
					for(var i=0; i<arr.length-1;i++){
						var temp1 = arr[i].indexOf("res_name"); //문자별 구분자
						var temp2 = arr[i].indexOf("user_name");
						var temp3 = arr[i].indexOf("star_point");
						var temp4 = arr[i].indexOf("res_review");
						
						var res_name = arr[i].substring(temp1+9,temp2); //레스토랑 이름
						var user_name = arr[i].substring(temp2+10,temp3); // 레스토랑 전화번호
						var star_point = arr[i].substring(temp3+11,temp4);
						var res_review =arr[i].substring(temp4+11);
						
						var p = document.createElement("p"); // p태그 만들어서 
						p.innerHTML ="레스토랑 이름 : " + res_name + "<br>" + 
						"유저: " + user_name + "<br>" +
						"별점: " + star_point + "<br>" +
						"리뷰: " + res_review + "<hr>";
						temp_list.appendChild(p); //p태그를 section (class이름 third)에 추가하기
					}

					if(arr.length == 1){
						var p = document.createElement("p");
						p.innerHTML = "현재 등록된 리뷰가 없습니다.";
						temp_list.appendChild(p);
					}
							
				} else {
					var p = document.createElement("p");
					p.innerHTML = "서버 오류로 불러올수 없습니다.";
					temp_list.appendChild(p);
				}
			}

			function reserve(){
				var temp_list = document.getElementById("temp_list");
				while (temp_list.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
					temp_list.removeChild(temp_list.firstChild);
				}
				
				var res_name = document.createElement("p");
				var res_phone = document.createElement("p");
				var user_name = document.createElement("p");
				var date = document.createElement("p");

				var newForm = document.createElement("form");
				newForm.setAttribute("method", "get");
				newForm.setAttribute("action", "go_reserve.jsp");

				var date_input = document.createElement("input");
				date_input.setAttribute("type","text");
				date_input.setAttribute("id", "date");
				date_input.setAttribute("name", "date");
				date_input.setAttribute("placeholder", "YY-MM-DD");

				var time = document.createElement("p");
				var time_input= document.createElement("input");
				time_input.setAttribute("type","text");
				time_input.setAttribute("id", "time");
				time_input.setAttribute("name", "time");
				time_input.setAttribute("placeholder", "HH-MM");

				var popul = document.createElement("p");
				var popul_input =document.createElement("input");
				popul_input.setAttribute("type","text");
				popul_input.setAttribute("id", "popul");
				popul_input.setAttribute("name", "popul");

				var tempP = document.createElement("p");
				tempP.innerHTML="<br>";

				var button1 = document.createElement("button");
				button1.setAttribute("type", "submit");
				button1.setAttribute("onclick", "return checkStep()");
				button1.innerHTML = "예약하기";
				
				res_name.innerHTML = "가게이름 : " + "<%=r_name%>";
				res_phone.innerHTML = "가게 전화번호 : " +"<%=r_phone%>";
				user_name.innerHTML = " 에약자명 : " + "<%=u_name%>";
				date.innerHTML ="날짜 : ";
				
				time.innerHTML ="시간(24시간 기준) : ";
				popul.innerHTML ="인원 : ";
				
				var temp_list = document.getElementById("temp_list");
				temp_list.appendChild(res_name);
				temp_list.appendChild(res_phone);
				temp_list.appendChild(user_name);
				temp_list.appendChild(newForm);

				newForm.appendChild(date);
				newForm.appendChild(date_input);
				newForm.appendChild(time);
				newForm.appendChild(time_input);
				newForm.appendChild(popul);
				newForm.appendChild(popul_input);
				newForm.appendChild(tempP);
				newForm.appendChild(button1);
			}

			function checkStep(){
				var date = document.getElementById("date").value;
				var time = document.getElementById("time").value;
				var popul = document.getElementById("popul").value;

				//현재 날짜 받아오기
				var year = <%=d1.getYear()-100%>
				var month = <%=d1.getMonth()+1%>
				var day = <%=d1.getDate()%>

				//입력값이 빈칸인지 확인
				if(date=="" | date==" "){
					alert("날짜를 다시 확인해주세요");
					return false;
				}
				if(time=="" | time==" "){
					alert("시간을 다시 확인해주세요");
					return false;
				}
				if(popul=="" | popul==" "){
					alert("인원을 다시 확인해주세요");
					return false;
				}

				//-가 있는지 없는지 확인
				var index1 = date.indexOf("-");
				var index2 = time.indexOf("-");
				if(index1 == -1){
					alert("날짜를 다시 확인해주세요");
					return false;
				}
				if(index2 == -1){
					alert("시간을 다시 확인해주세요");
					return false;
				}

				//날짜 확인 단계(예외처리)
				var temp1 = date.split("-");
				if(temp1[0].length != 2 | temp1[1].length != 2 | temp1[2].length != 2){
					alert("날짜를 다시 확인해주세요");
					return false;
				}
				if(temp1[0] < 0 | temp1[1] < 0 | temp1[2] < 0){
					alert("날짜를 다시 확인해주세요");
					return false;
				}
				if(temp1[1] == 1 | temp1[1] == 3 | temp1[1] == 5 | temp1[1] == 7 | temp1[1] == 8 | temp1[1] == 10 | temp1[1] == 12){
					if(temp1[2] > 31){
						alert("날짜를 다시 확인해주세요");
						return false;
					}
				}
				if(temp1[1] == 4 | temp1[1] == 6 | temp1[1] == 9 | temp1[1] == 11 ){
					if(temp1[2] > 30){
						alert("날짜를 다시 확인해주세요");
						return false;
					}
				}
				if((temp1[1] == 2) & (temp1[2] > 28)){
					alert("날짜를 다시 확인해주세요");
					return false;
				}
				if(temp1[0] < year){
					alert("날짜를 다시 확인해주세요");
					return false;
				}
				if(temp1[2] < day){
					if(temp1[1] <= month){
						alert("날짜를 다시 확인해주세요");
						return false;
					}
				}

				//시간 확인 단계(예외처리)
				var temp2 = time.split("-");
				if(temp2[0].length != 2 | temp2[1].length != 2){
					alert("시간을 다시 확인해주세요");
					return false;
				}
				if(temp2[0] > 23 | temp2[0] < 8 | temp2[1] > 59 | temp2[1] < 0){
					alert("시간을 다시 확인해주세요");
					return false;
				}
				if(isNaN(popul)==true){
					alert("인원을 다시 확인해주세요");
					return false;
				}
			}
			function add_review(){
				var temp_list = document.getElementById("temp_list");
				while (temp_list.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
					temp_list.removeChild(temp_list.firstChild);
				}
				
				var res_name = document.createElement("p");
				var res_phone = document.createElement("p");
				var user_name = document.createElement("p");
				var starpoint = document.createElement("p");
				var review = document.createElement("p");
				
				var newForm = document.createElement("form");
				newForm.setAttribute("method", "get");
				newForm.setAttribute("action", "add_reviewData.jsp");

				var starpoint_input = document.createElement("input");
				starpoint_input.setAttribute("type","text");
				starpoint_input.setAttribute("id", "starpoint");
				starpoint_input.setAttribute("name", "starpoint");
				starpoint_input.setAttribute("placeholder", "0~5의 숫자 중 하나");

				var review_input= document.createElement("input");
				review_input.setAttribute("type","text");
				review_input.setAttribute("id", "review");
				review_input.setAttribute("name", "review");
				review_input.setAttribute("placeholder", "리뷰할 내용을 입력하세요");


				var tempP = document.createElement("p");
				tempP.innerHTML="<br>";

				var button1 = document.createElement("button");
				button1.setAttribute("type", "submit");
				button1.setAttribute("onclick", "return checkStep()");
				button1.innerHTML = "리뷰 등록하기";
				
				res_name.innerHTML = "가게이름 : " + "<%=r_name%>";
				res_phone.innerHTML = "가게 전화번호 : " +"<%=r_phone%>";
				user_name.innerHTML = " 예약자명 : " + "<%=u_name%>";
				starpoint.innerHTML ="별점 : ";
				review.innerHTML ="리뷰 : ";
				
				var temp_list = document.getElementById("temp_list");
				temp_list.appendChild(res_name);
				temp_list.appendChild(res_phone);
				temp_list.appendChild(user_name);
				temp_list.appendChild(newForm);

				newForm.appendChild(starpoint);
				newForm.appendChild(starpoint_input);
				newForm.appendChild(review);
				newForm.appendChild(review_input);
				newForm.appendChild(tempP);
				newForm.appendChild(button1);
			}
			function add_favor() {
				var temp_list = document.getElementById("temp_list");
				while (temp_list.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
					temp_list.removeChild(temp_list.firstChild);
				}
				var res_name = document.createElement("p");
				var res_phone = document.createElement("p");
				var user_name = document.createElement("p");
				
				var newForm = document.createElement("form");
				newForm.setAttribute("method", "get");
				newForm.setAttribute("action", "add_favorData.jsp");

				var tempP = document.createElement("p");
				tempP.innerHTML="<br>";

				var button1 = document.createElement("button");
				button1.setAttribute("type", "submit");
				button1.setAttribute("onclick", "return checkStep()");
				button1.innerHTML = "즐겨찾기 등록";
				
				res_name.innerHTML = "가게이름 : " + "<%=r_name%>";
				res_phone.innerHTML = "가게 전화번호 : " +"<%=r_phone%>";
				
				var temp_list = document.getElementById("temp_list");
				temp_list.appendChild(res_name);
				temp_list.appendChild(res_phone);
				temp_list.appendChild(user_name);
				temp_list.appendChild(newForm);
				newForm.appendChild(tempP);
				newForm.appendChild(button1);
			}
			function home(){
				window.open("prototype.jsp", "_self");
			}
		</script>
		<style>
			header {
                text-align : center;
                font-size : 40px;
                text-shadow: 4px 4px #a0dab6;
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
				width : 100px;
				height : 30px;
				font-size : 13px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
			}
			label {
				font-size : 17px;
				font-weight : bold;
			}
		</style>
	</head>
	<body>
		<header>
			<h2>레스토랑 예약 화면입니다.</h2>
		</header>
		<hr>
		<h3><%=r_name%></h3>
		<button type="button" onclick="search_reviewList()">리뷰</button>
		<button type="button" onclick="reserve()">예약</button>
		<button type="button" onclick="add_favor()">즐겨찾기 추가</button>
		<button type="button" onclick="home()">홈으로</button>
		<hr>
		<section id="temp_list">
		
		</section>
	</body>
</html>