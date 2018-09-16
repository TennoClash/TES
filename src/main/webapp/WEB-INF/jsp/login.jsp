<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="/TES/plugin/script/jquery-1.11.3.min.js"></script>
<script src="/TES/plugin/script/imissyou.js"></script>
<script src="/TES/plugin/script/md5.js"></script>
<script src="/TES/plugin/script/clicktext.js"></script>
<script src="/TES/plugin/script/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap-2.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="/TES/plugin/css/util.css">
<link rel="stylesheet" type="text/css" href="/TES/plugin/css/main.css">

<script>
	$(document).ready(function() {
		$.iMissYou({
			title : "诶你怎么跑了( ꒪Д꒪)ノ",
			favicon : {
				enabled : false,
				src : 'iMissYouFavicon.ico'
			}
		});

		var input = $('.validate-input .input100');
		$("button").on("click", function() {

			var name = $("input[name='username']").val();
			var pass = $("input[name='pass']").val();
			pass = md5(pass);
			var check = true;
			if (pass != null && name != "" && pass != null && name != "") {
						var url = "/TES/ajax_login";
						var param = {
							name : name,
							pass : pass
						};
						$.post(url, param, function(data) {
							alert(data);
							if (data != "用户名或密码错误") {
								location.href = "/TES/welcome"
							}
						});
					}
			for (var i = 0; i < input.length; i++) {
				if (validate(input[i]) == false) {
					showValidate(input[i]);
					check = false;
				} else {
					console.log(name + "++" + pass);
					
				}
			}
		})


		$('.input100').each(function() {
			$(this).on('blur', function() {
				if ($(this).val().trim() != "") {
					$(this).addClass('has-val');
				} else {
					$(this).removeClass('has-val');
				}
			})
		});
		$('.validate-form .input100').each(function() {
			$(this).focus(function() {
				hideValidate(this);
			});
		});

		function validate(input) {
			if ($(input).val().trim() == '') {
				return false;
			}
		}

		function showValidate(input) {
			var thisAlert = $(input).parent();
			$(thisAlert).addClass('alert-validate');
		}

		function hideValidate(input) {
			var thisAlert = $(input).parent();
			$(thisAlert).removeClass('alert-validate');
		}


	});
</script>
<title>教师评价系统</title>
</head>
<body>
	<div class="limiter">
		<div class="container-login100"
			style="background-image: url('/TEva/img/bg-02.jpg');">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54"
				style="display:block;">
				<form class="login100-form validate-form">
					<span class="login100-form-title p-b-49">登录教师评价系统</span>

					<div class="wrap-input100 validate-input m-b-23"
						data-validate="请输入用户名">
						<span class="label-input100">用户名</span> <input class="input100"
							type="text" name="username" placeholder="请输入用户名"
							autocomplete="off"> <span class="focus-input100"
							data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="请输入密码">
						<span class="label-input100">密码</span> <input class="input100"
							type="password" name="pass" placeholder="请输入密码"> <span
							class="focus-input100" data-symbol="&#xf190;"></span>
					</div>

					<div class="text-right p-t-8 p-b-31">
						<a href="javascript:">忘记密码？</a>
					</div>

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button type="button" class="login100-form-btn">登 录</button>
						</div>
					</div>

					<div class="flex-col-c p-t-25">
						<a href="javascript:" class="txt2">立即注册</a>
					</div>
				</form>
			</div>




		</div>

	</div>

</body>
</html>