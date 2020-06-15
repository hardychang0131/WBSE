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
        
        <input type="button" id="tcheckinfostatus"value="審查表單" onclick="showsetinfo()"  style="display:none;"/>
        <input type="button" id="tshowinfo"value="查看表單" onclick="showallinfo()"  style="display:none;"/>
        
        
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
    
    <aside id="right" style="width: 20%;">
    
    </aside>
</div>
</body>


<script>


$(function() {
	  test2();
	var  n =  new Date();
	 var y = n.getFullYear();
	 var m = n.getMonth() + 1;
	 var d = n.getDate();
	  document.getElementById("date").innerHTML = y + "/" + m + "/" + d;
	  
	});

function test2(){

	let Url="/thermometer/checkrole";
	let jsonUrl = "/thermometer/test";
$.get(jsonUrl, function(data1) {
	console.log(data1)
	if(data1!=""){
	   makeAjaxCall(Url,"GET").then(function (data){
				console.log(data)

				if(data=="teacher"){
									
									$("#main").empty()
						        	$("#welcome").prepend("<input type='button' value='登出' onclick='logout()' />")
						        	$("#welcome").prepend("<h5 >歡迎"+"</h5>"+"<h5 id='numbertmp'>"+data1+"</h5>")
						        	do_changeforteacher()
									
								  
						
							  
				}else if(data=="student"){
											   			
									$("#main").empty()
						        	$("#welcome").prepend("<input type='button' value='登出' onclick='logout()' />")
						        	$("#welcome").prepend("<h5 >歡迎"+"</h5>"+"<h5 id='numbertmp'>"+data1+"</h5>")
						        	do_change()
									
								  
						
							
				
				}
		}, function(xhr, ajaxOptions, thrownError){
		            console.log(xhr.status);
		            console.log(thrownError);
		        });

	}

});
}



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
			  +"<p>請輸入帳號密碼</p><p>帳號: <input type='text' id='account' name='account' value=''/></p>"
			  +"<p>密碼: <input type='text' id='password' name='password' value=''/></p>"
			  +"<input type='button' value='登入' onclick='login()' />"
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
	        	$("#right").empty()
	           $("#main").append("<p>登出成功</p>")
	           
	           do_changeforlogout()
	        },
	        error: function(data){
	        	$("#right").empty()
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
	        	let Url = "/thermometer/checkrole";
		  			makeAjaxCall(Url,"GET").then(function (data){
		        	console.log(data);
		        	if(data=="teacher"){
		        		do_changeforteacher()
			        	}
		        	else if(data=="student"){
		        		do_change()
			        	}
		        	
		  			},function(xhr, ajaxOptions, thrownError){
			            console.log(xhr.status);
			            console.log(thrownError);
			        }) 
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
	document.getElementById("tcheckinfostatus").style.display = "none";
	document.getElementById("tshowinfo").style.display = "none";
	}
function do_changeforteacher(){
	document.getElementById("loginbutton").style.display = "none";
	document.getElementById("tcheckinfostatus").style.display = "block";
	document.getElementById("tshowinfo").style.display = "block";
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
		        	$("#main").prepend("<p>尚未填寫表單</p>")
					}else{
						$("#main").empty()
			        	$("#main").append("<table><tbody id='myhistory'><tr> <th>姓名</th><th>學號</th><th>年級</th><th>班級</th><th>額溫</th><th>備註</th><th>填寫日期</th><th>狀態</th></tr></tbody></table> ")
			        	for (let item in data) { 
			        		console.log(data[item].grade)
			        		console.log(data[item].classX)
			        	
					    	
			        	var tmp =
			        		"<tr>" +"<td>" + data[item].name + "</td>" + "<td>" + data[item].number + "</td>" + "<td>" + data[item].grade+ "</td>" + "<td>" + data[item].classX + "</td>" + "<td>" + data[item].temperature + "</td>" + "<td>" + data[item].note + "</td>" + "<td>" + data[item].date + "</td>" + "<td>" + data[item].status + "</td>" ;
			       		if(data[item].date==today){
				       		if(data[item].status=="尚未審核")
				       			tmp = tmp + "<td>" + "<input type='button' value='修改' onclick='updateinfoList()' />" + "</td>"+ "</tr>";
			       		}else{
							tmp =tmp+ "</tr>";

					       		}
			        	$("#myhistory").append(tmp)

						}
	 				  }
		
			  });

	   }



 function showsetinfo() {
	 var today = document.getElementById("date").textContent;
	   let jsonUrl = "/thermometer/teacher/findbytoday?date="+today;
	   $.get(jsonUrl, function(data) {	  
		   		if(data==null){	
					$("#main").empty()
		        	$("#main").prepend("<p>尚未有人填寫表單</p>")
					}else{
						 console.log("not null")
						$("#main").empty()
						$("#right").empty()
			        	$("#main").append("<table><tbody id='myhistory'><tr> <th>姓名</th><th>學號</th><th>年級</th><th>班級</th><th>額溫</th><th>備註</th><th>填寫日期</th><th>狀態</th></tr></tbody></table> ")
			        	
			        	for (let item in data) { 
			        		console.log(data[item].grade)
			        		console.log(data[item].classX)
				    	console.log(item)
			        	var tmp =
			        		"<tr>"+"<td>" + data[item].name + "</td>" + "<td id='numbertag"+item+"'>" + data[item].number + "</td>" + "<td>" + data[item].grade+ "</td>" + "<td>" + data[item].classX + "</td>" + "<td>" + data[item].temperature + "</td>" + "<td>" + data[item].note + "</td>" + "<td>" + data[item].date + "</td>" + "<td>" + data[item].status + "</td>"  + "<td>" + "<input type='button' value='審查' onclick='showupdateinfoList("+item+")' />" + "</td>"+ "</tr>";
			        	$("#myhistory").append(tmp)
						}
	 				  }		
			  });
	   }






 
 function updateinfoList() {
		$("#main").empty();
		var number = document.getElementById("numbertmp").textContent;
		var today = document.getElementById("date").textContent;
		 let jsonUrl = "/thermometer/student/"+data+"/date?date="+today;
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

function showallinfo() {
	var number = document.getElementById("numbertmp").value;
	   let jsonUrl = "/thermometer/teacher";
	   $.get(jsonUrl, function(data) {	  
		   		if(data==null){	
					$("#main").empty()
		        	$("#main").prepend("<p>尚未有人填寫表單</p>")
					}else{
						 console.log("not null")
						$("#main").empty()
			        	$("#main").append("<table><tbody id='myhistory'><tr> <th>姓名</th><th>學號</th><th>年級</th><th>班級</th><th>額溫</th><th>備註</th><th>填寫日期</th><th>狀態</th></tr></tbody></table> ")
			        	
			        	for (let item in data) { 
			        		console.log(data[item].grade)
			        		console.log(data[item].classX)
				    	
			        	var tmp =
			        		"<tr>" +"<td>" + data[item].name + "</td>" + "<td>" + data[item].number + "</td>" + "<td>" + data[item].grade+ "</td>" + "<td>" + data[item].classX + "</td>" + "<td>" + data[item].temperature + "</td>" + "<td>" + data[item].note + "</td>" + "<td>" + data[item].date + "</td>" + "<td>" + data[item].status + "</td>"  +  "</tr>";
			        	$("#myhistory").append(tmp)
						}
						 $("#right").empty()
						var tmp=
							"<p>輸入要查詢的學號: <input type='text' id='number' name='number' value=''/></p>"
							+"<input type='button' value='搜尋' onclick='serachbynumber()' />"
							+"<p>輸入要查詢的日期: <input type='text' id='date1' name='date1' value=''/></p>"
							+"<input type='button' value='搜尋' onclick='serachbydate()' />"
							+"</br>"
							+"<input type='button' value='查看尚未填寫者' onclick='whonowrite()' />";
							$("#right").append(tmp)
	 				  }		
			  });
	   }


function serachbydate(){


	var date1 = document.getElementById("date1").value;
	console.log(date1) 
	date1.replace(/\//g, "%2F");
	console.log("new:"+date1) 
	/* var date = "2020%2F6%2F12" */
	   let jsonUrl = "/thermometer/teacher/findbydate?date="+date1;


	   
	   $.get(jsonUrl, function(data) {	  
		   console.log(data)
		   		if(data==null){	
					$("#main").empty()
		        	$("#main").prepend("<p>尚未填寫表單</p>")
					}else{
						 console.log("not null")
						$("#main").empty()
			        	$("#main").append("<table><tbody id='myhistory'><tr> <th>姓名</th><th>學號</th><th>年級</th><th>班級</th><th>額溫</th><th>備註</th><th>填寫日期</th><th>狀態</th></tr></tbody></table> ")
			        	
			        	for (let item in data) { 
			        		console.log(data[item].grade)
			        		console.log(data[item].classX)
				    	
			        	var tmp =
			        		"<tr>" +"<td>" + data[item].name + "</td>" + "<td>" + data[item].number + "</td>" + "<td>" + data[item].grade+ "</td>" + "<td>" + data[item].classX + "</td>" + "<td>" + data[item].temperature + "</td>" + "<td>" + data[item].note + "</td>" + "<td>" + data[item].date + "</td>" + "<td>" + data[item].status + "</td>"  +  "</tr>";
			        	$("#myhistory").append(tmp)
						}
						
	 				  }		
			  });







	
}

function serachbynumber() {
	var number = document.getElementById("number").value;
	   let jsonUrl = "/thermometer/teacher/"+number;
	   
	   $.get(jsonUrl, function(data) {	  
		   		if(data==null){	
					$("#main").empty()
		        	$("#main").prepend("<p>尚未填寫表單</p>")
					}else{
						 console.log("not null")
						$("#main").empty()
			        	$("#main").append("<table><tbody id='myhistory'><tr> <th>姓名</th><th>學號</th><th>年級</th><th>班級</th><th>額溫</th><th>備註</th><th>填寫日期</th><th>狀態</th></tr></tbody></table> ")
			        	
			        	for (let item in data) { 
			        		console.log(data[item].grade)
			        		console.log(data[item].classX)
				    	
			        	var tmp =
			        		"<tr>" +"<td>" + data[item].name + "</td>" + "<td>" + data[item].number + "</td>" + "<td>" + data[item].grade+ "</td>" + "<td>" + data[item].classX + "</td>" + "<td>" + data[item].temperature + "</td>" + "<td>" + data[item].note + "</td>" + "<td>" + data[item].date + "</td>" + "<td>" + data[item].status + "</td>"  +  "</tr>";
			        	$("#myhistory").append(tmp)
						}
						
	 				  }		
			  });
	   }
function tupdateinfo() {

	 var mydata = $('form').serialize();
	 
	   let jsonUrl = "/thermometer/teacher";
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


function showupdateinfoList(item) {
	var tmp = "numbertag"+item
	console.log("tmp:"+tmp)
	
	var number = document.getElementById(tmp).textContent;
	console.log("n:"+number)
	var today = document.getElementById("date").textContent;
	console.log("t"+today)
	$("#main").empty();
	console.log("ininininininininininininini")
	 let jsonUrl = "/thermometer/teacher/"+number+"/date?date="+today;
	 $.get(jsonUrl, function(data) {
		 console.log(data.grade)
 		console.log(data.classX)
		 var content =
			  "<form action='#'>"
			  +"填寫表單<p>日期: <input type='text' id='date' name='date' readonly='readonly' value='"+data.date+"'/></p>"
			  +"<p>學號: <input type='text' id='number' name='number' readonly='readonly' value='"+data.number+"'/></p>"
			  +"年級: <select name='grade'><option selected='selected' readonly='readonly'>"+data.grade+"</select>"
			  +"班級: <select name='classX'><option selected='selected' readonly='readonly'>"+data.classX+"</select>"
			  +"姓名: <input type='text' id='name' name='name' readonly='readonly' value='"+data.name+"'/>"
			  +"<p>測量的額溫:<input type='text' id='temperature' name='temperature' readonly='readonly' value='"+data.temperature+"'/>"
			  +"</br>"
			  +"備註:<textarea name='note' rows='4' cols='50' readonly='readonly'>"+data.note+"</textarea>"
			  +"</br>"
			  +"<input type='button' value='審核完畢' onclick='tupdateinfo()' />"
			  +"</form>";
						 
			  $("#main").append(content); 

		 });



	
	
		
}
</script>
</html>
