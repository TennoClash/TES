<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="/TES/plugin/script/jasny-bootstrap.min.js"></script>
<script src="/TES/plugin/script/jquery.funnyText.min.js"></script>
<script src="/TES/plugin/script/echarts.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/jquery.funnyText.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/jasny-bootstrap.min.css">
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

.row-fluid {
	position: relative;
}

#roleul li {
	margin-bottom: 5px;
	text-align: center;
	cursor: pointer;
	border: 1px solid #ffcccc;
	border-radius: 1em;
}

#perul li {
	margin-bottom: 5px;
	text-align: center;
	cursor: pointer;
	border: 1px solid #ffcccc;
	border-radius: 1em;
}
</style>

<script>
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
		/************************************************************************************/
		var myChart = echarts.init(document.getElementById('main'));

		// 指定图表的配置项和数据
		var dataAxis = [];
		//dataAxis.push("测试一");
		var data=[];  
		var data22; 
		$.ajax({
			type : "POST",
			url : "/TES/get_Lead_Check",
			dataType : "json",
			data : {
			},
			success : function(data2) {
				data22 = data2;
				console.log(data2);
				var sx = 1;
				$("#hidden1").val(bmp(data2))
				$.each(data2, function(i, v) {

					var os = data2[i].user_name;
					os = JSON.stringify(os);
					os = os.replace('"', "")
					os = os.replace('"', "")

					dataAxis.push(os);

					data.push(parseFloat(parseFloat(data2[i].avg).toFixed(2)))
					$("#td1").text(data2[1].scount)
					$("#td2").text(data2[1].evacount)
					$("#td3").text((data2[1].evacount / data2[1].scount).toFixed(2) * 100 + "%")
					$("#ttd").append("<tr><td>" + sx + "</td><td>" + data2[i].user_name + "</td><td>" + parseFloat(parseFloat(data2[i].avg).toFixed(2)) + "</td></tr>")
					sx++;
				})

			}
		})
 
		var yMax = 10;
		var dataShadow = [];


		option = {
			title : {
				text : '按班级统计',
			},
			xAxis : {
				data : dataAxis,
				axisLabel : {
					inside : true,
					textStyle : {
						color : '#fff'
					}
				},
				axisTick : {
					show : false
				},
				axisLine : {
					show : false
				},
				z : 10
			},
			yAxis : {
				axisLine : {
					show : false
				},
				axisTick : {
					show : false
				},
				axisLabel : {
					textStyle : {
						color : '#999'
					}
				}
			},
			dataZoom : [
				{
					type : 'inside'
				}
			],
			series : [
				{ // For shadow
					type : 'bar',
					itemStyle : {
						normal : {
							color : 'rgba(0,0,0,0.05)'
						}
					},
					barGap : '-100%',
					barCategoryGap : '40%',
					data : dataShadow,
					animation : false
				},
				{
					type : 'bar',
					itemStyle : {
						normal : {
							color : new echarts.graphic.LinearGradient(
								0, 0, 0, 1,
								[
									{
										offset : 0,
										color : '#83bff6'
									},
									{
										offset : 0.5,
										color : '#188df0'
									},
									{
										offset : 1,
										color : '#188df0'
									}
								]
							)
						},
						emphasis : {
							color : new echarts.graphic.LinearGradient(
								0, 0, 0, 1,
								[
									{
										offset : 0,
										color : '#2378f7'
									},
									{
										offset : 0.7,
										color : '#2378f7'
									},
									{
										offset : 1,
										color : '#83bff6'
									}
								]
							)
						}
					},
					data : data
				}
			]
		};



		// 使用刚指定的配置项和数据显示图表。
		setTimeout(function() {
			myChart.setOption(option);
		}, 1000); 
		



	})
	function bmp(json) {
		var hmp;
		$.each(json, function(i, v) {
			if (i == json.length - 1) {
				hmp = hmp + json[i].user_name;
			} else {
				hmp = hmp + json[i].user_name + ",";
			}

		})
		return hmp;
	}
</script>

</head>
<body>
	<div class="container-fluid"
		style="background-color: #333;height:100%;">
		<div id="particles-js"
			style="width: 100%; height: 100%;position: absolute;"></div>
		<div class="row-fluid column">
			<div class="span12">
				<h1 id="ver" style="display:inline-block">教师评价系统 &nbsp;</h1>
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
						查看学生评教&nbsp;&nbsp;<i class="fa fa-folder-open"></i>
					</legend>
				</fieldset>


				<table class="table">
					<thead>
						<tr>

							<th>学生总数</th>
							<th>参评人数</th>
							<th>参评率</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="td1">120</td>
							<td id="td2">130</td>
							<td id="td3">参评人数</td>
						</tr>
					</tbody>
				</table>
				<div id="main" style="width: 40%;height: 600px;display:inline-block"></div>

				<table class="table"
					style="float: right;width: 40%;height:50%;overflow: scroll;">
					<thead>
						<tr>

							<th>排名</th>
							<th>教师姓名</th>
							<th>分数</th>
						</tr>
					</thead>
					<tbody id="ttd">

					</tbody>
				</table>
				<input type="hidden" id="hidden1" />





			</div>
		</div>
	</div>
	<script src="/TES/plugin/script/particles.min.js"></script>
	<script src="/TES/plugin/script/app.js"></script>


</body>
</html>