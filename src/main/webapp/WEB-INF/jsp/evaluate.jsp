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
<script src="/TES/plugin/script/bootstrap-treeview.min2.js"></script>
<script src="/TES/plugin/script/jquery.cookie.js"></script>


<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap-treeview.min.css">
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

li {
	list-style-type: none;
}

.row-fluid {
	position: relative;
}

.radiocss {
	margin-bottom: 100px;
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

						} else if (data[k].context == "参与评价") {
							$li[x] = $(" <li><a href='" + data[k].a_context + '<%=session.getAttribute("d_type")%>' + "&eva_user=" + '<%=session.getAttribute("user_number")%>' + "'>" + data[k].context + "</a></li>")
							$($li[x - 1]).after($li[x]);
						} else if (data[k].context == "同行评价") {
							$li[x] = $(" <li><a href='" + data[k].a_context + '<%=session.getAttribute("d_type")%>' + "'>" + data[k].context + "</a></li>")
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

		var expanded_json;
		var exjson;
		var iix;
		if (role_id == 1) {
			iix = 1;
		}
		if (role_id == 2) {
			iix = 4;
		}
		if (role_id == 3) {
			iix = 2;
		}
		$.ajax({
			type : "POST",
			url : "/TES/evaluatex",
			data : {
				i : iix
			},
			success : function(data) {
				function getTree() {
					return data;
				}
				$('#tree').treeview({
					data : getTree(),
					levels : 10,
					backColor : '#daeaff',
					collapseIcon : "fa fa-institution",
					selectable : false,
					highlightSelected : false,
				});
				console.log($.parseJSON(data))
				var tree = $('#tree');
				var node = tree.treeview('getExpanded', 1);
				exjson = [];

				expanded_json = node;

				for (var i = 0; i < expanded_json.length; i++) {
					var arr2 = {
						pid : expanded_json[i].pid,
						id : expanded_json[i].id,
						text : expanded_json[i].text
					}
					exjson.push(arr2);
				}
				console.log(exjson);

				$.each($("#tree .list-group li"), function(i, v) {

					for (var i = 0; i < node.length; i++) {
						if ($(this).text() == node[i].text) {
							$(this).css("font-size", "20px");
							$(this).css("font-weight", "bold");
						}
					}
				})
				json($.parseJSON(data))
				/*$(".list-group-item").attr('class', "tree22")
				$(".list-group").attr('class', "tree222")
				$("#tree").attr('id', "tree222")
				$(".treeview").attr('class', "tree222")
				$(".tree22").removeAttr('data-nodeid')*/
				var newtree = $("#tree").clone();
				$("#tree").remove();
				$("#iooi").before(newtree);
			}
		})
		/*****************************************************/

		var json_origin;

		$.ajax({
			type : "POST",
			url : "/TES/evaluateOrigin",
			data : {
				i : iix
			},
			success : function(data) {
				json_origin = data;
				console.log(data);
			}
		})

		$("#iooi").on("click", function() {
			var total = 0;
			$("input[type=radio]").each(function() {
				if (this.checked) {
					var namecc = $(this).attr("name").split("e");
					var conut = $(this).val();
					$.each(json_origin, function(i, v) {
						if (namecc[1] == v.id) {
							total = total + v.weight * conut;
							$.each(exjson, function(ii, vv) {
								if (v.pid == vv.id) {
									console.log(v.pid + "!!!" + vv.id)
								}
							})
						}
					})
				}
			});
			console.log(total);

			var teacher_id = $("#teacher_id").val();
			var semester = $("#semester").val();
			var course_id = $("#course_id").val();
			var eva_type = $("#eva_type").val();
			var eva_user = $("#eva_user").val();
			var eid = $("#eid").val();

			if (eva_type == 1) {

				$.ajax({
					type : "POST",
					url : "/TES/eva_sub",
					data : {
						teacher_id : teacher_id,
						semester : semester,
						course_id : course_id,
						eva_type : eva_type,
						eva_user : eva_user,
						score : total * 10,
						eid : eid
					},
					success : function(data) {
					       window.location.href=document.referrer;
					}
				})
			}
			if (eva_type == 2) {
				$.ajax({
					type : "POST",
					url : "/TES/eva_sub_t",
					data : {
						teacher_id : teacher_id,
						semester : semester,
						eva_type : eva_type,
						eva_user : eva_user,
						score : total * 10,
					},
					success : function(data) {}
				})

			}




		})


	})



	function json(jsontree) {
		if ((typeof jsontree == 'object') && (jsontree.constructor == Object.prototype.constructor)) {
			var arrey = [];
			arrey.push(jsontree);

		} else
			arrey = jsontree;
		var iii = 0;
		for (var i = 0; i < arrey.length; i++) {

			var jn = arrey[i];
			if (jn.nodes && jn.nodes.length > 0) {
				json(jn.nodes);
			} else {
				$.each($("#tree .list-group li"), function(i, v) {
					if (jn.text == $(this).text()) {
						//$(this).after("<br><input type='radio' value='8' name='count'>非常满意(8分)<input type='radio'  value='6' name='count'>满意(6分)<input type='radio' value='4' name='count'>不满意(4分) <input type='radio' value='2' name='count'>极不满意(2分)")

						var cid = $(this).attr("data-nodeid");
						var ccid = "'name'+" + jn.pid + "";
						var cname = eval(ccid);

						var htmlstr = $(this).html();
						var htmlstrleft = htmlstr.substring(htmlstr.lastIndexOf(">") + 1, htmlstr.length);
						var htmlstrright = htmlstr.substring(0, htmlstr.lastIndexOf(">") + 1);
						$(this).html("");
						var con = [ 1, 0.85, 0.65, 0.45 ];
						$(this).html(htmlstrright + "<input type='radio' value=" + con[iii] + " name=" + cname + ">" + htmlstrleft);
						$(this).css("display", "inline-block");
						$(this).css("background-color", "#fff")
						iii++
					//$(this).html($(this).html() + "<br><input type='radio' value='8' name=" + cname + ">非常满意(8分)<input type='radio' style='margin-left:20px;' value='6' name=" + cname + ">满意(6分)<input type='radio' style='margin-left:20px;' value='4' name=" + cname + ">不满意(4分) <input type='radio' style='margin-left:20px;' value='2' name=" + cname + ">极不满意(2分)")
					}
				})
			}
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
			<input type="hidden" id="teacher_id" value="${teacher_id}"> <input
				type="hidden" id="semester" value="${semester}"> <input
				type="hidden" id="eva_user" value="${eva_user}"> <input
				type="hidden" id="eva_type" value="${eva_type}">
			<c:if test="${eva_type == 1 }">
			<input type="hidden" id="course_id" value="${course_id}">
			<input type="hidden" id="eid" value="${eid}">
			</c:if>
			<c:if test="${eva_type == 1 }">
			
			</c:if>

			<div class="span10 column"
				style="max-height:600px;overflow:scroll;overflow-x: hidden;overflow-y:auto;"
				id="box2">
				<div id="box1"
					style="max-width:600px;list-style-type:none;width:70%;margin-left:auto;margin-right:auto;">
					<div id="tree"
						style="max-width:600px;list-style-type:none;margin-left:auto;margin-right:auto;"></div>
					<button id="iooi" style="width:50px;margin-left:220px">提交</button>

				</div>



			</div>



		</div>
	</div>

	<script src="/TES/plugin/script/particles.min.js"></script>
	<script src="/TES/plugin/script/app.js"></script>
	<script src="/TES/plugin/script/jquery.funnyText.min.js"></script>


</body>
</html>