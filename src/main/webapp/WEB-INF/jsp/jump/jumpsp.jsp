<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="/TES/plugin/script/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/script/jumpres/assets/animate.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/script/jumpres/assets/style.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

</head>
<body>
	<div class="decal"></div>
	<div class="jumbotron">
		<div class="container">
			<h1 class="glow in tlt">操作成功!</h1>
			<p class="tlt" data-in-effect="bounceInDown">教师评价系统    跳转中</p>
			<i class="fa fa-spinner fa-pulse"  style="font-size:50px"></i>
			 
		</div>
	</div>
	<div class="decal"></div>
	<div class="container fade in"></div>
	</div>
	<script src="/TES/plugin/script/jumpres/assets/jquery.fittext.js"></script>
	<script src="/TES/plugin/script/jumpres/assets/jquery.lettering.js"></script>
	<script src="/TES/plugin/script/jumpres/assets/jquery.textillate.js"></script>
	<script>
		$(function() {
		var ref = "";
function consoleLog(){
    location.href = "/TES/init.do?currentPage=1"
}
ref = setInterval(function(){
    consoleLog();
},2000);
		
		
			var log = function(msg) {
				return function() {
					if (console) console.log(msg);
				}
			}
			$('code').each(function() {
				var $this = $(this);
				$this.text($this.html());
			})
			var animateClasses = 'flash bounce shake tada swing wobble pulse flip flipInX flipOutX flipInY flipOutY fadeIn fadeInUp fadeInDown fadeInLeft fadeInRight fadeInUpBig fadeInDownBig fadeInLeftBig fadeInRightBig fadeOut fadeOutUp fadeOutDown fadeOutLeft fadeOutRight fadeOutUpBig fadeOutDownBig fadeOutLeftBig fadeOutRightBig bounceIn bounceInDown bounceInUp bounceInLeft bounceInRight bounceOut bounceOutDown bounceOutUp bounceOutLeft bounceOutRight rotateIn rotateInDownLeft rotateInDownRight rotateInUpLeft rotateInUpRight rotateOut rotateOutDownLeft rotateOutDownRight rotateOutUpLeft rotateOutUpRight hinge rollIn rollOut';
	
			var $form = $('.playground form'),
				$viewport = $('.playground .viewport');
			var getFormData = function() {
				var data = {
					loop : true,
					in : {
						callback : log('in callback called.')
					},
					out : {
						callback : log('out callback called.')
					}
				};
	
				$form.find('[data-key="effect"]').each(function() {
					var $this = $(this),
						key = $this.data('key'),
						type = $this.data('type');
					data[type][key] = $this.val();
				});
				return data;
			};
			$.each(animateClasses.split(' '), function(i, value) {
				var type = '[data-type]',
					option = '<option value="' + value + '">' + value + '</option>';
				if (type) {
					$form.find('[data-key="effect"]' + type).append(option);
				}
			});
			$form.find('[data-key="effect"][data-type="in"]').val('fadeInLeftBig');
			$form.find('[data-key="effect"][data-type="out"]').val('hinge');
			$('.jumbotron h1')
				.fitText(0.5)
				.textillate({
					in : {
						effect : 'flipInY'
					}
				});
	
			$('.jumbotron p')
				.fitText(3.2, {
					maxFontSize : 18
				})
				.textillate({
					initialDelay : 1000,
					in : {
						delay : 3,
						shuffle : true
					}
				});
		});
	</script>
</body>
</html>