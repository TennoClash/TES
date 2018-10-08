<%@ page language="java" pageEncoding="UTF-8"%>
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
<script src="/TES/plugin/script/bootstrap-treeview.min.js"></script>
<script src="/TES/plugin/script/jquery.cookie.js"></script>


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

.row-fluid {
	position: relative;
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

		
		var in_type;
		$("input[name='m_type']").on("click",function(){
		in_type= $("input[name='m_type']:checked").val();
		$.ajax({
			type : "POST",
			url : "/TES/evaluatex",
			data : {
				i : in_type
			},
			success : function(data) {
				function getTree() {
					return data;
				}
				$('#tree').treeview({
					data : getTree(),
					levels : 5,
					backColor : '#daeaff',
					selectable : false,
					highlightSelected : false,
				});
				$('#tree2').treeview({
					data : getTree(),
					levels : 5,
					backColor : '#daeaff',
					highlightSelected : true,
					selectedIcon : "fa fa-eye",
				});
			}
		})
		
		})

		$(".btn-primary").on("click", function() {
			var dname = $("#dname").val();
			var dweight = $("#dweight").val();
			var hidden_ind_id = $("#hidden_ind_id").val();
			$.ajax({
			type : "POST",
			url : "/TES/addindi",
			data : {
				pid:hidden_ind_id,
				weight:dweight,
				i_type:in_type,
				i_title:dname
			},
			success : function(data) {
			if(data=="1"){
			$.ajax({
			type : "POST",
			url : "/TES/evaluatex",
			data : {
				i : in_type
			},
			success : function(data) {
				function getTree() {
					return data;
				}
				$('#tree').treeview({
					data : getTree(),
					levels : 5,
					backColor : '#daeaff',
					selectable : false,
					highlightSelected : false,
				});
				$('#tree2').treeview({
					data : getTree(),
					levels : 5,
					backColor : '#daeaff',
					highlightSelected : true,
					selectedIcon : "fa fa-eye",
				});
			}
		})
			}
			}
		})
		})


	})
	function itemOnclick(target) {
		var nodeid = $(target).attr('data-nodeid');
		var tree = $('#tree');
		var node = tree.treeview('getNode', nodeid);
		console.log(node.text + "+" + node.id);
		$("#select_show").html("");
		var real_text = node.text.split(".");
		if(node.pid==0){
		$("#select_show").html("当前选择的上级指标是:" + "<span style='color:#ff2626'>" + node.text + "</span>");
		}else{
		$("#select_show").html("当前选择的上级指标是:" + "<span style='color:#ff2626'>" + real_text[1] + "</span>");
		}
		
		$("#hidden_ind_id").val(node.id);
		if (node.state.expanded) {

		} else {
			tree.treeview('expandNode', node.nodeId);
		}
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
				<div style="max-width:500px;list-style-type:none;margin-left:auto;margin-right:auto;">
				<strong>选择指标类型</strong><br> <br> 学生方面：<input type="radio"
					name="m_type" value="1" /> &nbsp; 系部方面：<input type="radio"
					name="m_type" value="2" />&nbsp; 教研室方面：<input type="radio"
					name="m_type" value="3" /> &nbsp; 同行方面：<input type="radio"
					name="m_type" value="4" /> &nbsp; 教师自我评价：<input type="radio"
					name="m_type" value="5" /> &nbsp;</div>
				<div id="tree"
					style="max-width:500px;list-style-type:none;margin-left:auto;margin-right:auto;"></div>


				<a id="modal-891721" href="#modal-container-891721" role="button"
					class="btn" data-toggle="modal">添加指标</a>
				<div id="modal-container-891721" class="modal hide fade"
					role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h3 id="myModalLabel">添加指标</h3>
					</div>
					<div class="modal-body">
						<h2>请选择上级指标：</h2>
						<div id="tree2"
							style="max-width:500px;list-style-type:none;margin-left:auto;margin-right:auto;"></div>
						<h4 id="select_show">当前选择的上级指标是:</h4>
						<input type="hidden" value="" id="hidden_ind_id" /> <label>请输入指标名</label>
						<input type="text" id="dname" /> <label>请输入指标权重</label> <input
							type="text" id="dweight" />

					</div>
					<div class="modal-footer">
						<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
						<button class="btn btn-primary" data-dismiss="modal"
							aria-hidden="true">确定</button>
					</div>
				</div>


			</div>



		</div>
	</div>

	<script src="/TES/plugin/script/particles.min.js"></script>
	<script src="/TES/plugin/script/app.js"></script>
	<script src="/TES/plugin/script/jquery.funnyText.min.js"></script>


</body>
</html>