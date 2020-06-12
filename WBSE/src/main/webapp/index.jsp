<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js">
</script>
<title>首頁</title>
</head>
<body>

今天日期為:<p id="date"></p>
	<div style="display: flex;">
    <!-- Sidebar -->
    <aside id="adise" style="width: 20%;">
    <table>
	<tbody id="welcome">
	
    </tbody>
    
    
</table> 
    	<input type="button" id="loginbutton" value="登入" onclick="showlogin()" style="display:block;" />
        <input type="button" id="showinfolistbutton"value="填寫表單" onclick="showinfoList()"  style="display:none;"/>
        <input type="button" id="history"value="查看歷史紀錄" onclick="showhistory()"  style="display:none;"/>
    </aside>

    <!-- Main -->
    <main style="
        /* Take the remaining width */
        flex: 1;

        /* Make it scrollable */
        overflow: auto;
    " id="main">
   
      
     請先登入
   
    
 
    
    </main>
</div>
</body>


<script>


$(function() {
	  test();
	var  n =  new Date();
	 var y = n.getFullYear();
	 var m = n.getMonth() + 1;
	 var d = n.getDate();
	  document.getElementById("date").innerHTML = y + "/" + m + "/" + d;
	  
	});




function test() {
	 
	   let jsonUrl = "/thermometer/test";
	   $.get(jsonUrl, function(data) {
		  
		   		if(data!=""){	
					$("#main").empty()
		        	$("#welcome").prepend("<input type='button' value='登出' onclick='logout()' />")
		        	$("#welcome").prepend("<h5 >歡迎"+"</h5>"+"<h5 id='numbertmp'>"+data+"</h5>")
		        	do_change()
					}
				  
		
			  });

	   }
function showlogin() {		  
	$("#main").empty()
		var content =
			  "<form action='#'>"
			  +"<p>請輸入帳號密碼</p><p>account: <input type='text' id='account' name='account' value=''/></p>"
			  +"<p>password: <input type='text' id='password' name='password' value=''/></p>"
			  +"<input type='button' value='Submit' onclick='login()' />"
			  +"</form>";
						 
			  $("#main").append(content); 

}

function logout() {
	   
	   let jsonUrl = "/thermometer/logout";
	    $.ajax({
	        url:jsonUrl,
	        type: "GET",
	        success: function(data){
	        	$("#main").empty()
	        	$("#welcome").empty()
	           $("#main").append("<p>登出成功</p>")
	           
	           do_changeforlogout()
	        },
	        error: function(data){
	        	$("#main").empty()
	           $("#main").append("<p>登出失敗</p>")
	        }     
	 }); 

	  
	   
	   }
	 
function login() {
	   var account1 = document.getElementById("account").value;
	   var password1 = document.getElementById("password").value;
	   var obj = { account: account1, password: password1};
	   var myJSON = JSON.stringify(obj);
	   console.log(myJSON);
	   
	   let jsonUrl = "/thermometer/login";
	    $.ajax({
	        url:jsonUrl,
	        type: "POST",
	        contentType: "application/json",	        
	        data: myJSON,
	        success: function(data){
	        	$("#main").empty()
	        	$("#welcome").prepend("<input type='button' value='登出' onclick='logout()' />")
	        	$("#welcome").prepend("<h5 >歡迎"+"</h5>"+"<h5 id='numbertmp'>"+data.number+"</h5>")
	        	$("#main").append("<p>登入成功</p>")
	        	do_change()
	        	
	        },
	        error: function(data){
	        	$("#main").empty()
	           $("#main").append("<p>登入失敗，帳號或密碼錯誤</p>")
	        }     
	 }); 

	  
	   
	   }
	   
function do_change(){
	document.getElementById("loginbutton").style.display = "none";
	document.getElementById("showinfolistbutton").style.display = "block";
	document.getElementById("history").style.display = "block";
	}

function do_changeforlogout(){
	document.getElementById("loginbutton").style.display = "block";
	document.getElementById("showinfolistbutton").style.display = "none";
	document.getElementById("history").style.display = "none";
	}
	
 function showinfoList() {
	 var number = document.getElementById("numbertmp").textContent;
		var date = document.getElementById("date").textContent;
	 let Url = "/thermometer/checktodayinfo?date="+date+"&number="+number;
	   makeAjaxCall(Url,"GET").then(function (data){
				console.log(data)

				if(data=="今日已填寫表單"){
					$("#main").empty()
		        	$("#main").append("<p>今日已填寫表單</p>")
					}
				else if(data=="今日尚未填寫"){
				$("#main").empty();
				var number = document.getElementById("numbertmp").textContent;
				var today = document.getElementById("date").textContent;
				var content =
		  "<form action='#'>"
		  +"填寫表單<p>日期: <input type='text' id='date' name='date' readonly='readonly' value='"+today+"'/></p>"
		  +"<p>學號: <input type='text' id='number' name='number' readonly='readonly' value='"+number+"'/></p>"
		  +"年級: <select name='grade'> <option value='1'>1</option> <option value='2'>2</option> <option value='3'>3</option></select>"
		  +"班級: <select name='classX'> <option value='甲'>甲</option> <option value='乙'>乙</option> <option value='丙'>丙</option><option value='丁'>丁</option></select>"
		  +"姓名: <input type='text' id='name' name='name' value=''/>"
		  +"<p>測量的額溫:<input type='text' id='temperature' name='temperature' value=''/>"
		  +"</br>"
		  +"備註:<textarea name='note' rows='4' cols='50'></textarea>"
		  +"</br>"
		  +"<input type='button' value='提交' onclick='createinfo()' />"
		  +"</form>";
					 
		  $("#main").append(content); 
				}
		}, function(xhr, ajaxOptions, thrownError){
		            console.log(xhr.status);
		            console.log(thrownError);
		        });
} 

 function createinfo() {			 
					 var mydata = $('form').serialize();
					 
					   let jsonUrl = "/thermometer/student";
					    $.ajax({
					        url:jsonUrl,
					        type: "POST",	        
					        data: mydata,
					        success: function(data){
					        	
					        	$("#main").empty()
					        	$("#main").append("<p>已傳送表單</p>")
					        },
					        error: function(xhr, ajaxOptions, thrownError){
					            console.log(xhr.status);
					            console.log(thrownError);
					        }     
					 }); 

	   
	   }
 function showhistory() {
	 var number = document.getElementById("numbertmp").textContent;
	 var today = document.getElementById("date").textContent;
	   let jsonUrl = "/thermometer/student/"+number;
	   $.get(jsonUrl, function(data) {
		  
		   		if(data==null){	
					$("#main").empty()
		        	$("#welcome").prepend("<p>尚未填寫表單</p>")
					}else{
						$("#main").empty()
			        	$("#main").append("<table><tbody id='myhistory'><tr> <th>姓名</th><th>學號</th><th>年級</th><th>班級</th><th>額溫</th><th>備註</th><th>填寫日期</th><th>狀態</th></tr></tbody></table> ")
			        	for (let item in data) { 
			        		console.log(data[item].grade)
			        		console.log(data[item].classX)
			        	
					    	
			        	var tmp =
			        		"<tr>" +"<td>" + data[item].name + "</td>" + "<td>" + data[item].number + "</td>" + "<td>" + data[item].grade+ "</td>" + "<td>" + data[item].classX + "</td>" + "<td>" + data[item].temperature + "</td>" + "<td>" + data[item].note + "</td>" + "<td>" + data[item].date + "</td>" + "<td>" + data[item].status + "</td>" ;
			       		if(data[item].date==today)
				       		tmp = tmp + "<td>" + "<input type='button' value='修改' onclick='updateinfoList()' />" + "</td>"+ "</tr>";
				       		else{
							tmp =tmp+ "</tr>";

					       		}
			        	$("#myhistory").append(tmp)

						}
	 				  }
		
			  });

	   }

 function updateinfoList() {
		$("#main").empty();
		var number = document.getElementById("numbertmp").textContent;
		var today = document.getElementById("date").textContent;
		 let jsonUrl = "/thermometer/student/"+number+"/date?date="+today;
		 $.get(jsonUrl, function(data) {
			 console.log(data.grade)
     		console.log(data.classX)
			 var content =
				  "<form action='#'>"
				  +"填寫表單<p>日期: <input type='text' id='date' name='date' readonly='readonly' value='"+data.date+"'/></p>"
				  +"<p>學號: <input type='text' id='number' name='number' readonly='readonly' value='"+data.number+"'/></p>"
				  +"年級: <select name='grade'><option selected='selected'>"+data.grade+"</option> <option value='1'>1</option> <option value='2'>2</option> <option value='3'>3</option></select>"
				  +"班級: <select name='classX'><option selected='selected'>"+data.classX+"</option> <option value='甲'>甲</option> <option value='乙'>乙</option> <option value='丙'>丙</option><option value='丁'>丁</option></select>"
				  +"姓名: <input type='text' id='name' name='name' value='"+data.name+"'/>"
				  +"<p>測量的額溫:<input type='text' id='temperature' name='temperature' value='"+data.temperature+"'/>"
				  +"</br>"
				  +"備註:<textarea name='note' rows='4' cols='50'>"+data.note+"</textarea>"
				  +"</br>"
				  +"<input type='button' value='提交' onclick='updateinfo()' />"
				  +"</form>";
							 
				  $("#main").append(content); 

			 });



		
		
			
	}  
 function updateinfo() {

	 var mydata = $('form').serialize();
	 
	   let jsonUrl = "/thermometer/student";
	    $.ajax({
	        url:jsonUrl,
	        type: "PUT",	        
	        data: mydata,
	        success: function(data){
	        	
	        	$("#main").empty()
	        	$("#main").append("<p>表單已經修改</p>")
	        },
	        error: function(xhr, ajaxOptions, thrownError){
	        	$("#main").empty()
	        	$("#main").append("<p>表單修改失敗</p>")
	        }     
	 }); 



	 
	 }
function makeAjaxCall(url, methodType){
	 console.log("makeAjaxCall");
	 return new Promise((resolve, reject)=>{
		 console.log("inPromise");
			   $.ajax({
			        url:url,
			        type: "get",	        
			    	datatype:"text",
			        success: function(data){
			        	
			        	resolve(data)
			        },
			        error: function(repoList){
			        	reject(repoList)
			        }     
			 }); 
		 });
		
		}


</script>
</html>
