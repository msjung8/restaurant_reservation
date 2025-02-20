<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<% Date d1 = new Date(); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>
            prototype
        </title>
        <style>
            header {
                text-align : center;
                font-size : 30px;
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
            section.second button {
                margin-top : 20px;
            }
            button, input.button{
				width : 100px;
				height : 25px;
				font-size : 13px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
                margin-right : 10px;
			}
            section.first label, section.second label{
                font-size : 17px;
                font-weight : bold;
            }
            p.review{
                background-color : lightgray;
            }
        </style>
        <script>
            window.onload = start;
            var isLogIn = "true";
            ////onload시에 session값에 id가 들어가있는지 판별(로그인 상태인지 구분하는 것)
            function start(){
                var sessionID = "<%=session.getAttribute("UID")%>";
                if(sessionID != "null"){
                    var value = localStorage.getItem("isLogIn");
                    if(value.length!=0){
                        var storedStorage = JSON.parse(value);
                        var temp1 = storedStorage.indexOf("&");
                        var rName = storedStorage.substring(0, temp1);
                        var isLogIn = storedStorage.substring(temp1+1);
                        if(isLogIn=="true"){
                            var name = document.getElementById("name");

                            var idlabel = document.getElementById("idLabel");
                            var passlabel = document.getElementById("passLabel");
                            var id = document.getElementById("id");
                            var pass = document.getElementById("pass");
                            var button = document.getElementById("logInButton");
                            var button2 = document.getElementById("signIn");

                            var par = idlabel.parentElement;
                            var par2 = document.getElementById("secondPar");
                            par.removeChild(idlabel);
                            par.removeChild(passlabel);
                            par.removeChild(id);
                            par.removeChild(pass);
                            par.removeChild(button);
                            par.removeChild(button2);

                            name.innerHTML= rName+"님 환영합니다.";

                            var newButton = document.createElement("button");
                            newButton.innerHTML="로그아웃";
                            newButton.setAttribute("type", "button");
                            newButton.setAttribute("onclick", "logOut(this)");

                            var newButton2 = document.createElement("button");
                            newButton2.innerHTML="개인정보수정";
                            newButton2.setAttribute("type", "button");
                            newButton2.setAttribute("onclick", "revise_id_DB()");
                            newButton2.setAttribute("id", "revise");
                        
                            par2.appendChild(newButton2);
                            par2.appendChild(newButton);

                        }
                        var value2 = localStorage.getItem("isUser");
                        if(value2.length != 0){
                            var storedStorage = JSON.parse(value2);
                            var isUser = storedStorage;
                            if(isUser=="false"){
                                var btn1 = document.getElementById("btnFavor");
                                var parBtn = btn1.parentElement;

                                parBtn.removeChild(btn1);
                            }
                        }
                    }
                }
                else if(sessionID == "null"){
                    localStorage.setItem("isLogIn", "");
                }
            }
            ////로그인 부분---------------------------------------------------------------------------------------------
            function logIn(){
                //로그인 함수
                id = document.getElementById("id");
                pass = document.getElementById("pass");
                var xmlhttp = false;
                xmlhttp = new XMLHttpRequest();
                if((id != "") & (pass != "")){
                    var url = 'logIn.jsp?id=' + id.value + '&pass=' + pass.value;
                    xmlhttp.onreadystatechange = function(){
                        //로그인 관련 함수 : 로그인 처리를 AJAX로 하는 함수
                        if(xmlhttp.readyState == 4 & xmlhttp.status == 200){
                            var tempIndex1 = xmlhttp.responseText.indexOf("name=");
                            var tempIndex2 = xmlhttp.responseText.indexOf("flag=");
                            var tempIndex3 = xmlhttp.responseText.indexOf("isUser=");
                            var tempIndex4 = xmlhttp.responseText.indexOf("EOP");

                            var rName = xmlhttp.responseText.substring(tempIndex1+5, tempIndex2);
                            var flag = xmlhttp.responseText.substring(tempIndex2+5, tempIndex3);
                            var isUser = xmlhttp.responseText.substring(tempIndex3+7, tempIndex4);
                            
                            if(flag=="true"){
                                var name = document.getElementById("name");

                                var idlabel = document.getElementById("idLabel");
                                var passlabel = document.getElementById("passLabel");
                                var id = document.getElementById("id");
                                var pass = document.getElementById("pass");
                                var button = document.getElementById("logInButton");
                                var button2 = document.getElementById("signIn");

                                var par = idlabel.parentElement;
                                var par2 = document.getElementById("secondPar");
                                par.removeChild(idlabel);
                                par.removeChild(passlabel);
                                par.removeChild(id);
                                par.removeChild(pass);
                                par.removeChild(button);
                                par.removeChild(button2);

                                name.innerHTML= rName+"님 환영합니다.";

                                var newButton = document.createElement("button");
                                newButton.innerHTML="로그아웃";
                                newButton.setAttribute("type", "button");
                                newButton.setAttribute("onclick", "logOut(this)");

                                var newButton2 = document.createElement("button");
                                newButton2.innerHTML="개인정보수정";
                                newButton2.setAttribute("type", "button");
                                newButton2.setAttribute("onclick", "revise_id_DB()");
                                newButton2.setAttribute("id", "revise");
                                
                                par2.appendChild(newButton2);
                                par2.appendChild(newButton);
                                var temp = rName+"&"+"true";
                                localStorage.setItem("isLogIn", JSON.stringify(temp));
                                localStorage.setItem("isUser", JSON.stringify(isUser));
                                if(isUser=="false"){
                                    var btn1 = document.getElementById("btnFavor");
                                    var parBtn = btn1.parentElement;
                                    parBtn.removeChild(btn1);
                                }
                            }
                            else {
                                alert("아이디와 비밀번호를 확인해주세요");
                            }
                        }
                    }
                    xmlhttp.open("GET", url, true);
                    xmlhttp.send(null);
                }
            }

            ////로그아웃 부분-----------------------------------------------------------------------------------------
            function logOut(e){
                //로그아웃 함수
                alert("로그아웃 합니다.");
                localStorage.setItem("isLogIn", "");
                window.open("prototype.jsp", "_self");
            }

            ////회원가입 부분----------------------------------------------------------------------------------------------
            function sign_In(){
                //회원가입 함수
                window.open("signIn.jsp", "_self");
            }

            ////메인메뉴(레스토랑 목록 띄우기) 부분---------------------------------------------------------------------------
            function search_resList() {
                //메인메뉴 관련 함수 : 레스토랑 검색 결과를 AJAX로 가져오는 함수
                //list_restaurant_DB.jsp에 연결해서 검색어를 보냄 - 해당 음식점 목록 가져옴
                var xmlhttp = false;
                xmlhttp = new XMLHttpRequest();
            	var menu = document.getElementById("menu");
                var search_tag = document.getElementById("search_tag");
                var value = localStorage.getItem("isLogIn");
                var value2 = localStorage.getItem("isUser");
                var isUser;
                if(value2.length!=0){
                    var storedStorage = JSON.parse(value2);
                    isUser = storedStorage;
                }
                if(value.length!=0){
                    var storedStorage = JSON.parse(value);
                    var temp1 = storedStorage.indexOf("&");
                    var rName = storedStorage.substring(0, temp1);
                    var isLogIn = storedStorage.substring(temp1+1);

                    if(isLogIn=="false"){
                        alert("로그인 이후에 이용해주세요");
                        return false;
                    }
                }
                else{
                    alert("로그인 이후에 이용해주세요");
                    return false;
                }
                if((search_tag.value != "") & (search_tag.value != " ")){
                    var url = 'list_restaurant_DB.jsp?tag=' + search_tag.value;
                    xmlhttp.onreadystatechange = function(){
                        //메인메뉴 관련 함수 : 메인화면을 비우고 검색 결과를 표시하는 함수
                        // 레스토랑 리스트 가져와서 third 섹션 내에 출력함
                        let arr = new Array();
                        var sec = document.getElementById("thirdSection"); //레스토랑 정보 넣을 섹션
                        while (sec.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
                                sec.removeChild(sec.firstChild);
                            }
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                            var start = xmlhttp.responseText.indexOf("^"); //시작구분자
                            var end = xmlhttp.responseText.indexOf("@"); //끝 구분자
                            var tempStr = xmlhttp.responseText.substring(start+1, end);
                            
                            arr = tempStr.split("\n");
                            for(var i=0; i<arr.length-1;i++){
                                var temp1 = arr[i].indexOf("res_name"); //문자별 구분자
                                var temp2 = arr[i].indexOf("res_phone"); //문자별 구분자
                                var temp3 = arr[i].indexOf("address"); //문자별 구분자
                                var temp4 = arr[i].indexOf("menu");
                                
                                var res_name = arr[i].substring(temp1+9,temp2); //레스토랑 이름
                                var res_number = arr[i].substring(temp2+10,temp3); // 레스토랑 전화번호
                                var address= arr[i].substring(temp3+8,temp4);
                                var menu = arr[i].substring(temp4+5);
                                var p = document.createElement("p"); // p태그 만들어서 
                                p.innerHTML ="레스토랑 이름: " + res_name + "<br>" + 
                                            "전화번호: " + res_number + "<br>" + 
                                            "주소: " + address + "<br>"+
                                            "메뉴: " + menu + "<hr>";
                                if(isUser=="true"){
                                    p.setAttribute("onclick","get_reserveList(this)");
                                }
                                sec.appendChild(p); //p태그를 section (class이름 third)에 추가하기
                            }
                        } else {
                            var p = document.createElement("p");
                            p.innerHTML = "서버 오류로 불러올수 없습니다.";
                            sec.appendChild(p);
                        }
                    }
                    xmlhttp.open("GET", url, true);
                    xmlhttp.send(null);
                    menu.innerHTML = "레스토랑 검색 결과 / " + search_tag.value;
                }
                else{
                    alert("검색어를 제대로 입력해주세요");
                    search_tag.focus();
                    return false;
                }
                search_tag.value="";
                return false;
            }
            function get_reserveList(e) {
            	 //메인메뉴 관련 함수 : 레스토랑 정보 다음 페이지로 넘겨주기 위한 함수
            	 var tempIndex1 = e.innerHTML.indexOf("레스토랑 이름:");
                 var tempIndex2 = e.innerHTML.indexOf("전화번호:");
                 var tempIndex3 = e.innerHTML.indexOf("주소:");
                 var tempIndex4 = e.innerHTML.indexOf("메뉴:");
				 var tempIndexHR = e.innerHTML.indexOf("<hr>");
				 
                 var tempString1 = e.innerHTML.substring(tempIndex1+7, tempIndex2-4);
                 var tempString2 = e.innerHTML.substring(tempIndex2+4, tempIndex3-4);
                 var tempString3 = e.innerHTML.substring(tempIndex3+2, tempIndex4-4);

                 var tempString1 = tempString1.split(": ");
                 var tempString2 = tempString2.split(": ");
				 var tempString3 = tempString3.split(": ");
                 
                 sessionStorage.setItem("ResName",tempString1[1]);
                 sessionStorage.setItem("ResPhone",tempString2[1]);
                 sessionStorage.setItem("ResAddress",tempString3[1]);
                 
                 window.open("resCheck.jsp","_self");
            }

            ////즐겨찾기 부분-----------------------------------------------------------------------------------------------
            function favorite(){
                //즐겨찾기 메뉴(ajax로 구현)
                var xmlhttp = false;
                xmlhttp = new XMLHttpRequest();
                var value = localStorage.getItem("isLogIn");
                if(value.length!=0){
                    var storedStorage = JSON.parse(value);
                    var temp1 = storedStorage.indexOf("&");
                    var rName = storedStorage.substring(0, temp1);
                    var isLogIn = storedStorage.substring(temp1+1);
                    if(isLogIn=="false"){
                        alert("로그인 이후에 이용해주세요");
                        return false;
                    }
                }
                else{
                    alert("로그인 이후에 이용해주세요");
                    return false;
                }
                var url = 'favor_DB_list.jsp?';
                xmlhttp.onreadystatechange = function(){
                    let arr = new Array();
                    var sec = document.getElementById("thirdSection"); //레스토랑 정보 넣을 섹션
                    while (sec.hasChildNodes()){	// 부모노드가 자식이 있는지 여부를 알아낸다
                        sec.removeChild(sec.firstChild);
                    }
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var start = xmlhttp.responseText.indexOf("^"); //시작구분자
                        var end = xmlhttp.responseText.indexOf("@"); //끝 구분자
                        var tempStr = xmlhttp.responseText.substring(start+1, end);
                        arr = tempStr.split("\n");
                        for(var i=0; i<arr.length-1;i++){
                            var temp1 = arr[i].indexOf("res_name"); //문자별 구분자
                            var temp2 = arr[i].indexOf("res_phone");
                            var temp3 = arr[i].indexOf("starpoint");
                            var temp4 = arr[i].indexOf("address");
                            var temp5 = arr[i].indexOf("menu");
                            var res_name = arr[i].substring(temp1+9,temp2); //레스토랑 이름
                            var res_phone = arr[i].substring(temp2+10,temp3); // 레스토랑 전화번호
                            var starpoint = arr[i].substring(temp3+10,temp4);
                            var address = arr[i].substring(temp4+8,temp5);
                            var menu = arr[i].substring(temp5+5);
                            var p = document.createElement("p"); // p태그 만들어서 
                            p.innerHTML ="별점: " + starpoint +"<br>"+
                                "레스토랑 이름: " + res_name + "<br>" + 
                                "전화번호: " + res_phone + "<br>" +
                                "주소: " + address +"<br>" + 
                                "메뉴: " + menu + "<hr>";
                            p.setAttribute("onclick","get_reserveList(this)");
                            sec.appendChild(p); //p태그를 section (class이름 third)에 추가하기
                        }
                        if(arr.length == 1){
                            var p = document.createElement("p");
                            p.innerHTML = "현재 등록된 즐겨찾기가 없습니다.";
                            sec.appendChild(p);
                        }
                        xmlhttp.abort();
                    }
                    else {
                    	var p = document.createElement("p");
                        p.innerHTML = "서버 오류로 불러올수 없습니다.";
                        sec.appendChild(p);
                    }
                }
                xmlhttp.open("GET", url, true);
                xmlhttp.send(null);
                var menuText = document.getElementById("menu");
                menuText.innerHTML = "즐겨찾기";
            }
            	   
            ////예약 리스트 부분--------------------------------------------------------------------------------------------
            function reserve_list(){
                var xmlhttp = false;
                xmlhttp = new XMLHttpRequest();
                var value2 = localStorage.getItem("isUser");
                var isUser;
                if(value2.length!=0){
                    var storedStorage = JSON.parse(value2);
                    isUser = storedStorage;
                }
                var value = localStorage.getItem("isLogIn");
                if(value.length!=0){
                    var storedStorage = JSON.parse(value);
                    var temp1 = storedStorage.indexOf("&");
                    var rName = storedStorage.substring(0, temp1);
                    var isLogIn = storedStorage.substring(temp1+1);
                    if(isLogIn=="false"){
                        alert("로그인 이후에 이용해주세요");
                        return false;
                    }
                }
                else{
                    alert("로그인 이후에 이용해주세요");
                    return false;
                }
                //ajax 시 작
                var url;
                if(isUser=="true"){
                    //유저 아이디로 로그인하면 줄 url
                    url = "reserved_DB_list.jsp?";
                }
                else if(isUser=="false"){
                    //레스토랑 아이디로 로그인하면 줄 url
                    url = "res_reserve_DB_list.jsp?";
                }
                xmlhttp.onreadystatechange = function(){
                    let arr = new Array();
                    var sec = document.getElementById("thirdSection"); //레스토랑 정보 넣을 섹션
                    while (sec.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
                            sec.removeChild(sec.firstChild);
                    }
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var start = xmlhttp.responseText.indexOf("^"); //시작구분자
                        var end = xmlhttp.responseText.indexOf("@"); //끝 구분자
                        
                        var tempStr = xmlhttp.responseText.substring(start+1, end);
                        arr = tempStr.split("\n");
                        for(var i=0; i<arr.length-1;i++){
                            var temp1 = arr[i].indexOf("res_name"); //문자별 구분자
                            var temp2 = arr[i].indexOf("user_id");
                            var temp3 = arr[i].indexOf("res_phone");
                            var temp4 = arr[i].indexOf("date");
                            var temp5 = arr[i].indexOf("time");
                            var temp6 = arr[i].indexOf("popul");
                            var temp7;
                            if(isUser=="true"){
                                temp7 = arr[i].indexOf("address");
                            }
                            
                            var res_name = arr[i].substring(temp1+9,temp2); //레스토랑 이름
                            var user_id = arr[i].substring(temp2+8,temp3); // 레스토랑 전화번호
                            var res_phone = arr[i].substring(temp3+10,temp4);
                            var res_date =arr[i].substring(temp4+5,temp5);
                            var res_time =arr[i].substring(temp5+5,temp6);
                            var population =arr[i].substring(temp6+6);
                            var address;
                            if(isUser=="true"){
                                population =arr[i].substring(temp6+6,temp7);
                                address = arr[i].substring(temp7+8);
                            }
                            
                            var p = document.createElement("p"); // p태그 만들어서
                            if(isUser=="true"){
                                p.innerHTML ="레스토랑 이름 : " + res_name + "<br>" + 
                                "유저: " + user_id + "<br>" +
                                "레스토랑 전화번호: " + res_phone + "<br>" +
                                "날짜: " + res_date + "<br>" +
                                "시간: " + res_time + "<br>" + 
                                "인원: " + population + "<br>" +
                                "주소: " + address + "<hr>";
                            }
                            else if(isUser=="false"){
                                p.innerHTML ="레스토랑 이름 : " + res_name + "<br>" + 
                                "유저: " + user_id + "<br>" +
                                "레스토랑 전화번호: " + res_phone + "<br>" +
                                "날짜: " + res_date + "<br>" +
                                "시간: " + res_time + "<br>" + 
                                "인원: " + population + "<hr>";
                            }

                            p.setAttribute("onclick", "del(this)");

                            if(!dateCheck(res_date)){
                                //true이면 아직 지나지 않은 예약날자 | false이면 이미 지난 예약 날짜, 갔던 안갔던 	 쓸 수 있음
                                p.setAttribute("class", "review");
                                if(isUser=="true"){
                                    //유저 아이디로 로그인했을때 줄 함수
                                    p.setAttribute("onclick", "reviewClick(this)");
                                }
                            }
                            sec.appendChild(p); //p태그를 section (class이름 third)에 추가하기
                        }
                        if(arr.length == 1){
                            var p = document.createElement("p");
                            p.innerHTML = "현재 등록된 예약이 없습니다.";
                            sec.appendChild(p);
                        }
                        xmlhttp.abort();
                    }
                    else {
                        var p = document.createElement("p");
                        p.innerHTML = "서버 오류로 불러올수 없습니다.";
                        sec.appendChild(p);
                    }
                }
                xmlhttp.open("GET", url, true);
                xmlhttp.send(null);
                var menu = document.getElementById("menu");
                menu.innerHTML = "예약 리스트<br>>삭제하고 싶은 예약리스트를 클릭하세요<br>>회색 예약리스트는 리뷰를 작성할수 있습니다.";
            }
            function del(e){
                var tempIndex1 = e.innerHTML.indexOf("레스토랑 이름:");
                var tempIndex2 = e.innerHTML.indexOf("유저:");
                var tempIndex3 = e.innerHTML.indexOf("레스토랑 전화번호:");
                var tempIndex4 = e.innerHTML.indexOf("날짜:");
                var tempIndex5 = e.innerHTML.indexOf("시간:");
                var tempIndex6 = e.innerHTML.indexOf("인원");
				 
                var tempString1 = e.innerHTML.substring(tempIndex1+7, tempIndex2-4);
                var tempString2 = e.innerHTML.substring(tempIndex2+2, tempIndex3-4);
                var tempString3 = e.innerHTML.substring(tempIndex3+9, tempIndex4-4);
                var tempString4 = e.innerHTML.substring(tempIndex4+2, tempIndex5-4);
                var tempString5 = e.innerHTML.substring(tempIndex5+2, tempIndex6-4);

                var tempString1 = tempString1.split(": ");
                var tempString2 = tempString2.split(": ");
                var tempString3 = tempString3.split(": ");
                var tempString4 = tempString4.split(": ");
                var tempString5 = tempString5.split(": ");      

                sessionStorage.setItem("ResName",tempString1[1]);
                sessionStorage.setItem("UserID",tempString2[1]);
                sessionStorage.setItem("ResPhone",tempString3[1]);
                sessionStorage.setItem("Date",tempString4[1]);
                sessionStorage.setItem("time",tempString5[1]);

                window.open("delCheck.jsp","_self");
            }

            ////리뷰 부분--------------------------------------------------------------------------------------------------
            function dateCheck(date){
                var temp = date.split("-");

                var thisYear = temp[0];
                var thisMonth = temp[1];
                var thisDay = temp[2];

                var nowYear = <%=d1.getYear()-100%>;
                var nowMonth = <%=d1.getMonth()+1%>;
                var nowDay = <%=d1.getDate()%>;

                if(thisYear < nowYear){
                    //최소한 이번년도보다 이전이다, 이미 기한이 지남
                    return false;
                }
                else if(thisYear > nowYear){
                    //최소한 이번년도보다 미래이다. 기한이 지나지 않음
                    return true;
                }
                else if(thisYear == nowYear){
                    if(thisMonth < nowMonth){
                        //이번년도인데 이미 지나간 달임
                        return false;
                    }
                    else if(thisMonth > nowMonth){
                        //이번년도인데 아직 지나가지 않은 달
                        return true;
                    }
                    else if(thisMonth == nowMonth){
                        //이번년도, 이번달
                        if(thisDay < nowDay){
                            //이번년도, 이번달, 이미 지나간 날 
                            return false;
                        }
                        else if(thisDay > nowDay){
                            //아직 지나가지 않은 날
                            return true;
                        }
                        else if(thisDay == nowDay){
                            //오늘, 바로 오늘
                            return true;
                        }
                    }
                }
            }
            function reviewClick(e){
                var tempIndex1 = e.innerHTML.indexOf("레스토랑 이름:");
                var tempIndex2 = e.innerHTML.indexOf("유저:");
                var tempIndex3 = e.innerHTML.indexOf("레스토랑 전화번호:");
                var tempIndex4 = e.innerHTML.indexOf("날짜:");
                var tempIndex5 = e.innerHTML.indexOf("시간:");
                var tempIndex6 = e.innerHTML.indexOf("인원");
				 
                var tempString1 = e.innerHTML.substring(tempIndex1+7, tempIndex2-4);
                var tempString2 = e.innerHTML.substring(tempIndex2+2, tempIndex3-4);
                var tempString3 = e.innerHTML.substring(tempIndex3+9, tempIndex4-4);
                var tempString4 = e.innerHTML.substring(tempIndex4+2, tempIndex5-4);
                var tempString5 = e.innerHTML.substring(tempIndex5+2, tempIndex6-4);

                var tempString1 = tempString1.split(": ");
                var tempString2 = tempString2.split(": ");
                var tempString3 = tempString3.split(": ");
                var tempString4 = tempString4.split(": ");
                var tempString5 = tempString5.split(": ");      

                sessionStorage.setItem("ResName",tempString1[1]);
                sessionStorage.setItem("UserID",tempString2[1]);
                sessionStorage.setItem("ResPhone",tempString3[1]);
                sessionStorage.setItem("Date",tempString4[1]);
                sessionStorage.setItem("time",tempString5[1]);

                window.open("reviewCheck.jsp","_self");
            }

            ////개인정보 수정 부분------------------------------------------------------------------------------------------
            function revise_id_DB(){ // 레스토랑, 유저아이디 정보 바꾸기
                var xmlhttp = false;
                xmlhttp = new XMLHttpRequest();
            	var url = 'ID_Connector.jsp?';
                xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function(){
                    var sec = document.getElementById("thirdSection"); //레스토랑 정보 넣을 섹션
                    while (sec.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
                            sec.removeChild(sec.firstChild);
                    }
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var start = xmlhttp.responseText.indexOf("^"); //시작구분자
                        var end = xmlhttp.responseText.indexOf("@"); //끝 구분자
                        var tempStr = xmlhttp.responseText.substring(start+1, end);
                        if(tempStr=="user"){
                            window.open("userRevise.jsp","_self");
                        }
                        else if(tempStr=="res"){
                            window.open("resRevise.jsp","_self");
                        }
                        xmlhttp.abort();
                    }
                    else {
                        var p = document.createElement("p");
                        p.innerHTML = "서버 오류로 불러올수 없습니다.";
                        sec.appendChild(p);
                    }
                }
                xmlhttp.open("GET", url, true);
                xmlhttp.send(null);
            }
        </script>
    </head>
    <body>
        <header>
            <h1>레스토랑스</h1>
        </header>
        <h3 id="name">로그인 해주세요</h3>
        <hr>
        <section class="first" id="firstSection">
                <form id="firstPar">
                    <label id="idLabel">아이디 : </label>
                    <input type="text" id="id">
                    <label id="passLabel">패스워드 : </label>
                    <input type="password" id="pass">
                    <button type="button" onclick="logIn()" id="logInButton">로그인</button>
                    <button type="button" onclick="sign_In()" id="signIn">회원가입</button><br><br>
                    
                </form>
            <section class="second" id="secondSection">
                <form id="secondPar">
                    <label>검색어 : </label><input id="search_tag" type="text"> 
                  	<button type="submit" onclick="return search_resList()">검색</button><Br>
                    <button type="button" onclick="favorite()" id="btnFavor">즐겨찾기</button>
                    <button type="button" onclick="reserve_list()" id="btnReserve">예약리스트</button>
                </form>
            </section>
        </section>
        <hr>
        <h3 id="menu">메인화면</h3>
        <hr>
        <section class="third" id="thirdSection">
        	
        	
        </section>
    </body>
</html>