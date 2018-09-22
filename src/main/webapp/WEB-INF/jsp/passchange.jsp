<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>教师评价系统</title>
<script src="/TES/plugin/script/jquery-1.11.3.min.js"></script>
<script src="/TES/plugin/script/imissyou.js"></script>
<script src="/TES/plugin/script/clicktext.js"></script>
<script src="/TES/plugin/script/md5.js"></script>
<script src="/TES/plugin/script/bootstrap.min.js"></script>
<script src="/TES/plugin/script/bootstrap-slider.min.js"></script>
<script src="/TES/plugin/script/jquery.funnyText.min.js"></script> 
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/jquery.funnyText.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/iconic/css/material-design-iconic-font.min.css">

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
	$(document).ready(function() {

		/*---------------JSP Init----------------*/
		var user_type = '<%=session.getAttribute("user_type")%>';
		//var user_type=${sessionScope.user.user_type}
		var role_id='<%=session.getAttribute("role_id")%>';
		$.ajax({
			type : "POST",
			url : "/TES/welcomeinit",
			dataType : "json",
			data : {
				r : role_id
			},
			success : function(data) {
				console.log(data);
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
				alert("菜单查询失败！");
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
		/*--------------checkPassWord----------------*/
		var $checkpass = $("<i class='fa fa-check-circle' id='c_ok1' style='font-size:25px;color: #0bca00;'></i>");
		var $checkfail = $("<i class='fa fa-times-circle' id='c_fail1' style='font-size:25px;color: #ff0b0b;'></i>");
		$("#checkpass").on("keyup", function() {
			var newpass = $("#newpass").val();
			if ($(this).val().trim() != newpass) {
				$("#c_ok1").remove();
				$("#checkpass").after($checkfail);
			} else {
				$("#checkpass").after($checkpass);
				$("#c_fail1").remove();
			}
		})

		var isChangeable = false;
		$("#originalpass").on("blur", function() {
			var $checkpass2 = $("<i class='fa fa-check-circle' id='c_ok' style='font-size:25px;color: #0bca00;'></i>");
			var $checkfail2 = $("<i class='fa fa-times-circle' id='c_fail' style='font-size:25px;color: #ff0b0b;'></i>");
			var p_c = $(this).val().trim()
			p_c = md5(p_c);
			var user_number = '<%=session.getAttribute("user_number")%>';
			$.ajax({
				type : "POST",
				url : "/TES/pass_check",
				dataType : "json",
				data : {
					name : user_number,
					pass : p_c
				},
				success : function(data) {
					if (data == "1") {
						$("#c_ok").remove();
						$("#c_fail").remove();
						$("#originalpass").after($checkpass2);
						isChangeable = true;
					} else {
						$("#c_fail").remove();
						$("#c_ok").remove();
						$("#originalpass").after($checkfail2);
						isChangeable = false;
					}
				}
			})
		})

		$("#pwsubmit").on("click", function() {
			var p_c = $("#newpass").val().trim()
			p_c = md5(p_c);
			var user_number = '<%=session.getAttribute("user_number")%>';
			var $at = $("<div class='alert alert-error' id='check-err-alert' style='margin:0px 0px 0px 30px;width:25%;display:inline-block'><button type='button' class='close' data-dismiss='alert'>×</button> <h4>  密码错误! </h4> <strong>警告!</strong> 必须正确验证原密码.</div>");
			if (!isChangeable) {
				if ($("#c_fail").length > 0) {
					$("#check-err-alert").remove();
					$("#c_fail").after($at);
				} else {
					$("#check-err-alert").remove();
					$("#originalpass").after($at);
				}
			} else {
				$.ajax({
					type : "POST",
					url : "/TES/pw_update",
					dataType : "json",
					data : {
						type : role_id,
						pass : p_c,
						num : user_number
					},
					success : function(data) {
						if (data == "1") {
							var $updatesuc = $("<div class='alert alert-success' id='update-success-alert' style='margin:0px 0px 0px 30px;width:25%;display:inline-block'><button type='button' class='close' data-dismiss='alert'>×</button> <h4> 操作成功! </h4> 密码修改成功 </div>")
							$("#originalpass").val("");
							$("#newpass").val("");
							$("#checkpass").val("");
							$("#c_ok").remove();
							$("#c_ok1").remove();
							$("#check-err-alert").remove();
							$("#originalpass").after($updatesuc);
						} else {
							var $updatesuc = $("<div class='alert alert-error' id='update-error-alert' style='margin:0px 0px 0px 30px;width:25%;display:inline-block'><button type='button' class='close' data-dismiss='alert'>×</button> <h4> 操作失败! </h4> 密码修改失败 </div>")
							$("#originalpass").val("");
							$("#newpass").val("");
							$("#checkpass").val("");
							$("#c_fail1").remove();
							$("#c_fail").remove();
							$("#check-err-alert").remove();
						}
					}
				})
			}
		})
		$("#l_nav").on("click", "#s_click", function() {
			$.cookie('insert_type', 's'); 
		}) 
 
		$("#l_nav").on("click", "#t_click", function() {	
		$.cookie('insert_type', 't');
		})

	})
</script>

</head>
<body>
	<div class="container-fluid"
		style="background-color: #333;height:100%;">
		<div id="particles-js"  style="width: 100%; height: 100%;position: absolute;">	</div>
		<div class="row-fluid column">
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
						修改密码&nbsp;&nbsp;<i class="fa fa-key"></i>
					</legend>
					<label>原始密码</label> <input type="text" style="margin-right:10px"
						id="originalpass" placeholder="请输原始密码" /> <span
						class="help-block">请先输入原始密码以验证</span>
					<legend></legend>

					<label>新密码</label><input type="password" id="newpass"
						placeholder="请输入新密码" /> <label>确认密码</label><input type="password"
						id="checkpass" style="margin-right:10px" placeholder="请确认密码" /> <br>
					<button type="button" id="pwsubmit" class="btn">提交</button>
				</fieldset>
			</div>


		</div>


	</div>

<script src="/TES/plugin/script/particles.min.js"></script>
<script src="/TES/plugin/script/app.js"></script> 
</body>
</html>