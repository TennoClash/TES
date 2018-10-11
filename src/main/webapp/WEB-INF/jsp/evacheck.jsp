<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>教室评价系统</title>
<script src="/TES/plugin/script/jquery-1.11.3.min.js"></script>
<script src="/TES/plugin/script/imissyou.js"></script>
<script src="/TES/plugin/script/clicktext.js"></script>
<script src="/TES/plugin/script/bootstrap.min.js"></script>
<script src="/TES/plugin/script/bootstrap-slider.min.js"></script>
<script src="/TES/plugin/script/jquery.cookie.js"></script> 
<script src="/TES/plugin/script/calendar5.js"></script> 

<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/jquery.funnyText.css">

<style>
html, body {
	height: 100%;
	width: 100%;
	overflow: hidden;
	margin: 0;
	padding: 0;
}

.column {
	background-color: #FFFFFF;
	border: 1px solid #DDDDDD;
	border-radius: 8px 8px 8px 8px;
	padding: 10px 19px 24px;
}
.row-fluid{
position: relative; 
} 
</style>

<script>
var c = new Calendar("c");                     
    document.write(c);
	$(document).ready(function() {
		var menu_json;
		/*---------------JSP Init----------------*/
		var user_type = '<%=session.getAttribute("user_type")%>';
		var role_id = '<%=session.getAttribute("role_id")%>';
		$.ajax({
			type : "POST",
			url : "/TES/welcomeinit",
			dataType : "json",
			data : {
				r : role_id
			},
			success : function(data) {
				console.log(data);
				menu_json = data;
				var x = 1;
				var n_id = 0;
				$li_e = $("<li></li>");
				var $li = [];
				var nav_id = [];
				var parent_id = [];
				for (var k = 0; k < data.length; k++) {
					//eval("var $li" + x + "=" + $li_e);
					$li[x] = $("<li></li>");

					if (data[k].nav_id != "" && data[k].nav_id != null) {
						n_id++;
						nav_id[n_id] = data[k].nav_id;

						if (data[k].context == "首页") {
							$li[x] = $(" <li class='active'><a href='" + data[k].a_context + "'>首页</a></li>");
							$("#l_nav").append($li[x]);
						} else {
							$li[x] = $(" <li class='" + data[k].css_class + "'>" + data[k].context + "</li>");
							$("#l_nav").append($li[x]);
						}
					}
					if (data[k].parent_id == nav_id[n_id]) {
						if (data[k].css_class == "divider") {
							$li[x] = $(" <li class=" + data[k].css_class + ">" + data[k].context + "</li>")
							$($li[x - 1]).after($li[x]);
						} else if (data[k].context == "学生信息导入") {
							$li[x] = $(" <li><a id='s_click' href='" + data[k].a_context + "'>" + data[k].context + "</a></li>")
							$($li[x - 1]).after($li[x]);

						} else if (data[k].context == "教师信息导入") {
							$li[x] = $(" <li><a id='t_click' href='" + data[k].a_context + "'>" + data[k].context + "</a></li>")
							$($li[x - 1]).after($li[x]);
						} else {
							$li[x] = $(" <li><a href='" + data[k].a_context + "'>" + data[k].context + "</a></li>")
							$($li[x - 1]).after($li[x]);
						}
					}
					x++;
				}
			},
			error : function() {
				alert("登录信息过期，请重新登录！");
				location.href = "/TES/login"
			}
		});
		/*---------------jsp-version----------------*/
		$ver1 = $("<small>学生版</small>");
		$ver2 = $("<small>教师版</small>");
		$ver3 = $("<small>院系领导版</small>");
		$ver4 = $("<small>管理员版</small>");
		switch (role_id) {
		case "1":
			$("#ver").append($ver1);
			break;
		case "2":
			$("#ver").append($ver2);
			break;
		case "3":
			$("#ver").append($ver3);
			break;
		case "4":
			$("#ver").append($ver4);
			break;
		default:
			break;
		}
		$('#ver').funnyText();
		/*--------------iMissYou----------------*/
		$.iMissYou({
			title : "诶你怎么跑了( ꒪Д꒪)ノ",
			favicon : {
				enabled : false,
				src : 'iMissYouFavicon.ico'
			}
		});

		$("#l_nav").on("click", "#s_click", function() {
			$.cookie('insert_type', 's'); 
		}) 
 
		$("#l_nav").on("click", "#t_click", function() {	
		$.cookie('insert_type', 't');
		})
		
		$("#sub").on("click",function(){
		var sem=$("#semester").val();
		var in_type= $("input[name='m_type']:checked").val();
		var start=$("#statr_time").val();
		var end=$("#end_time").val();
		$.ajax({
			type : "POST",
			url : "/TES/add_task",
			data : {
				sem:sem,
				in_type:in_type,
				start:start,
				end:end
			},
			success : function(data) {
			window.location.href="/TES/jump/jumpevama"
			
			}
		})
		
		})
	})
</script>

</head>
<body>

	<div class="container-fluid" 
		style="background-color: #333;height:100%;">
		<div id="particles-js"  style="width: 100%; height: 100%;position: absolute;">	</div>
		<div class="row-fluid column" >
			<div class="span12">
			
				<h1 id="ver" style="display:inline-block">
					教师评价系统 &nbsp;
				</h1>
				<i class="fa fa-sign-out"
						style="font-size:80px;display:inline-block; float:right"></i>

			</div>
		</div>

		<div class="row-fluid" style="height:100%;">
			<div class="span2 column" style="height:100%;">
				<ul class="nav nav-list" id="l_nav">

				</ul>

			</div>

			<div class="span10 column">
			<fieldset>
					<legend>
						查看评教&nbsp;&nbsp;<i class="fa fa-folder-open"></i>
					</legend>
				</fieldset>
				<div>
					<table class="table">
						<thead>
							<tr>
								<th>课程名</th>
								<th>教师名</th>
								<th>状态</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${evaChecks}" var="ec">
								<tr>
									<td>${ec.course_name}</td>
									<td>${ec.user_name}</td>
										<c:if test="${ec.eva_state == 0 }">
											<td>已评</td>
										</c:if>
										<c:if test="${ec.eva_state == 1 }">
											<td><a href="eva_check.do?teacher_id=${ec.teacher_id}&semester=${ec.semester}&course_id=${ec.course_num}&eva_type=${role_id}&eva_user=${user_number}&id=${ec.id}">未评</a></td>
										</c:if> 
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
			</div>
			


		</div>
	</div>

<script src="/TES/plugin/script/particles.min.js"></script>
<script src="/TES/plugin/script/app.js"></script> 
<script src="/TES/plugin/script/jquery.funnyText.min.js"></script> 


</body>
</html>