<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>教室评价系统</title>
<script src="/TES/plugin/script/jquery-1.11.3.min.js"></script>
<script src="/TES/plugin/script/imissyou.js"></script>
<script src="/TES/plugin/script/clicktext.js"></script>
<script src="/TES/plugin/script/jquery.cookie.js"></script>
<script src="/TES/plugin/script/md5.js"></script>
<script src="/TES/plugin/script/bootstrap.min.js"></script>
<script src="/TES/plugin/script/bootstrap-slider.min.js"></script>
<script src="/TES/plugin/script/xlsx.full.min.js"></script>


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
</style>

<script>
	$(document).ready(function() {
	var menu_json;
		/*---------------JSP Init----------------*/
		var user_type = '<%=session.getAttribute("user_type")%>';
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
				menu_json=data;
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
		switch (user_type) {
		case "0":
			$("#ver").append($ver1);
			break;
		case "1":
			$("#ver").append($ver2);
			break;
		case "2":
			$("#ver").append($ver3);
			break;
		case "9":
			$("#ver").append($ver4);
			break;
		default:
			break;
		}
		/*--------------iMissYou----------------*/
		$.iMissYou({
			title : "诶你怎么跑了( ꒪Д꒪)ノ",
			favicon : {
				enabled : false,
				src : 'iMissYouFavicon.ico'
			}
		});

		$("#demo").on("click", function() {
			console.log(jsonobj1);
			var jsonstr = JSON.stringify(jsonobj1);
			var u_type = $.cookie('insert_type')
			console.log(jsonstr);
			$.ajax({
				type : "POST",
				url : "/TES/studentinfo",
				data : {
					ListSrt : jsonstr,
					u_type : u_type
				},
				dataType : "json",
				success : function(data) {
						alert("成功插入"+data+"条数据");
				},
				error : function(data) {}
			});

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
		<div class="row-fluid column">
			<div class="span12">
				<h1 id="ver">教师评价系统 &nbsp;</h1>
			</div>
		</div>

		<div class="row-fluid" style="height:100%;">
			<div class="span2 column" style="height:100%;">
				<ul class="nav nav-list" id="l_nav">

				</ul>

			</div>

			<div class="span10 column">
				<input type="file" onchange="importf(this)" />
				<div id="demo"></div>
			</div>


		</div>
	</div>
	<script>
		var wb;
		var rABS = false;
		var jsonobj1;
		function importf(obj) {
			if (!obj.files) {
				return;
			}
			var f = obj.files[0];
			var reader = new FileReader();
			reader.onload = function(e) {
				var data = e.target.result;
				if (rABS) {
					wb = XLSX.read(btoa(fixdata(data)), {
						type : 'base64'
					});
				} else {
					wb = XLSX.read(data, {
						type : 'binary'
					});
				}
				document.getElementById("demo").innerHTML = JSON.stringify(XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]));
				jsonobj1 = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
				$.each(jsonobj1, function(i, val) {
					jsonobj1[i].user_type=parseInt(jsonobj1[i].user_type);
					jsonobj1[i].password=md5(jsonobj1[i].password);
				});
			};
			if (rABS) {
				reader.readAsArrayBuffer(f);
			} else {
				reader.readAsBinaryString(f);  
			}
		}
	
		function fixdata(data) {
			var o = "",
				l = 0,
				w = 10240;
			for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
			o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
			return o;
		}
	</script>
</body>
</html>