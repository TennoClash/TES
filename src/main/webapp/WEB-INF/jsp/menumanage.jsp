<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>教室评价系统</title>
<script src="/TES/plugin/script/jquery-1.11.3.min.js"></script>
<script src="/TES/plugin/script/imissyou.js"></script>
<script src="/TES/plugin/script/clicktext.js"></script>
<script src="/TES/plugin/script/bootstrap.min.js"></script>
<script src="/TES/plugin/script/bootstrap-slider.min.js">
<script src="/TES/plugin/script/jquery.cookie.js"></script>
<script src="/TES/plugin/script/bootstrap-select.js"></script>
<script src="/TES/plugin/script/bootstrap-treeview.min.js"></script>
<script src="/TES/plugin/script/jquery.funnyText.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/jquery.funnyText.css">

<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap-treeview.min.css">
<link rel="stylesheet" type="text/css"
	href="/TES/plugin/css/bootstrap-select.min.css">
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

.list-group-item {
	list-style-type: none;
	border: 1px;
	border-radius: 1em;
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

		var sub_type;
		$("input[name='select_level']").on("click", function() {
			var menu_level = $("input[name='select_level']:checked").val();
			if (menu_level == "1") {
				$("#d_lower_select").hide();
				$("#upper_select").hide();
				$("#d_upper_select").hide();
				$("#nav_info").show();
				sub_type = menu_level;
			}
			if (menu_level == "2") {
				$("#d_lower_select").hide();
				$("#nav_info").hide();
				$("#d_upper_select").hide();
				$("#upper_select").show();
				sub_type = menu_level;
			}
			if (menu_level == "3") {
				$("#d_lower_select").hide();
				$("#nav_info").hide();
				$("#upper_select").hide();
				$("#d_upper_select").show();
				sub_type = menu_level;
			}
			if (menu_level == "4") {
				$("#nav_info").hide();
				$("#upper_select").hide();
				$("#d_upper_select").hide();
				$("#d_lower_select").show();
				sub_type = menu_level;
			}
		})

		var cdata;
		var menu_role_m;
		$("input[name='m_type']").on("click", function() {
			menu_role_m = $("input[name='m_type']:checked").val();

			$.ajax({
				type : "POST",
				url : "/TES/welcomeinit",
				dataType : "json",
				data : {
					r : menu_role_m
				},
				success : function(data) {
					cdata = data;
					console.log(data)
					var str = "";
					var str2 = "";
					$.each(data, function(i, v) {
						if (data[i].nav_id != null && data[i].nav_id != "") {
							str += '<option value="' + data[i].nav_id + '">' + data[i].context + '</option>'
						}
						if (data[i].parent_id != null && data[i].parent_id != "" && data[i].css_class != "divider") {
							str2 += '<option value="' + data[i].id + '">' + data[i].context + '</option>'
						}
					})
					$("#select1").html(str);
					$('#select1').selectpicker('refresh');
					$("#select2").html(str);
					$('#select2').selectpicker('refresh');
					$("#select3").html(str);
					$('#select3').selectpicker('refresh');
					$("#select4").html(str2);
					$('#select4').selectpicker('refresh');
				}
			})
			$.ajax({
				type : "POST",
				url : "/TES/menux",
				data : {
					i : menu_role_m
				},
				success : function(data) {
					function getTree() {
						return data;
					}
					$('#tree').treeview({
						data : getTree(),
						levels : 5,
						backColor : '#daeaff'
					});
					console.log($.parseJSON(data))
				}
			})
		})

		$("#menusub").on("click", function() {
			if (sub_type == 1) {
				var nav_input = $("#nav_input").val();
				var select1 = $("#select1").val();
				var max = 0;
				var maxx = [];
				var maxnav = [];
				$.each(cdata, function(i, v) {
					if (cdata[i].nav_id == select1) {
						var nnav_id = cdata[i].nav_id;
						$.each(cdata, function(ii, vv) {

							if (cdata[ii].parent_id == nnav_id) {
								console.log("第二层")
								maxx.push(cdata[ii].menu_id);
							}
						})
					}
				})
				$.each(cdata, function(i, v) {
					if (cdata[i].nav_id != null && cdata[i].nav_id != "") {
						maxnav.push(cdata[i].nav_id);
					}
				})

				console.log(menu_role_m)
				console.log(Math.max.apply(null, maxx))
				console.log(Math.max.apply(null, maxnav))
				$.ajax({
					type : "POST",
					url : "/TES/menuaddf",
					data : {
						nav_input : nav_input,
						mposition : Math.max.apply(null, maxx),
						ctype : menu_role_m,
						navid : Math.max.apply(null, maxnav) + 1
					},
					success : function(data) {
						$.ajax({
							type : "POST",
							url : "/TES/menux",
							data : {
								i : menu_role_m
							},
							success : function(data) {
								function getTree() {
									return data;
								}
								$('#tree').treeview({
									data : getTree(),
									levels : 5,
									backColor : '#daeaff'
								});
								console.log($.parseJSON(data))
							}
						})

					}
				})
			}
			if (sub_type == "2") {
				var mmenuid = [];
				var mmposition;
				var nav_input_2 = $("#nav_input_2").val();
				var select2 = $("#select2").val();
				var pid;
				$.each(cdata, function(i, v) {
					if (cdata[i].nav_id == select2) {
						pid = cdata[i].id;
					}
					if (cdata[i].parent_id == select2) {
						mmenuid.push(cdata[i].menu_id);
					}
				})
				mmposition = Math.max.apply(null, mmenuid);
				if (mmenuid.length == 0) {
					$.each(cdata, function(i, v) {
						if (cdata[i].nav_id == select2) {
							mmposition = cdata[i].menu_id
						}

					})
				}

				console.log(mmenuid)
				console.log(Math.max.apply(null, mmenuid))

				$.ajax({
					type : "POST",
					url : "/TES/menuadds",
					data : {
						nav_input : nav_input_2,
						mposition : mmposition,
						ctype : menu_role_m,
						navid : select2,
						pid : pid
					},
					success : function(data) {
						$.ajax({
							type : "POST",
							url : "/TES/menux",
							data : {
								i : menu_role_m
							},
							success : function(data) {
								function getTree() {
									return data;
								}
								$('#tree').treeview({
									data : getTree(),
									levels : 5,
									backColor : '#daeaff'
								});
								console.log($.parseJSON(data))
							}
						})
					}
				})
			}
			if (sub_type == "3") {
				var select3 = $("#select3").val();
				var mposition;
				var k = 0;

				$.each(cdata, function(i, v) {
					if (cdata[i].nav_id == select3) {
						mposition = cdata[i].menu_id - 1;
						k++
					}
					if (cdata[i].parent_id == select3) {
						k++;
					}
				})

				$.ajax({
					type : "POST",
					url : "/TES/menudel",
					data : {
						mposition : mposition,
						count : k,
						ctype : menu_role_m,
						navid : select3
					},
					success : function(data) {
						$.ajax({
							type : "POST",
							url : "/TES/menux",
							data : {
								i : menu_role_m
							},
							success : function(data) {
								function getTree() {
									return data;
								}
								$('#tree').treeview({
									data : getTree(),
									levels : 5,
									backColor : '#daeaff'
								});
								console.log($.parseJSON(data))
							}
						})
					}
				})
			}
			if (sub_type == "4") {
				var select4 = $("#select4").val();

				$.each(cdata, function(i, v) {
					if (cdata[i].id == select4) {
						mposition = cdata[i].menu_id - 1;
					}
				})

				$.ajax({
					type : "POST",
					url : "/TES/menudel_2",
					data : {
						mposition : mposition,
						id : select4,
						ctype : menu_role_m
					},
					success : function(data) {
						$.ajax({
							type : "POST",
							url : "/TES/menux",
							data : {
								i : menu_role_m
							},
							success : function(data) {
								function getTree() {
									return data;
								}
								$('#tree').treeview({
									data : getTree(),
									levels : 5,
									backColor : '#daeaff'
								});
								console.log($.parseJSON(data))
							}
						})
					}
				})

			}


		})




		/*-------------------------------------------------------------------------------------------------*/



	})

	function itemOnclick(target) {
		var nodeid = $(target).attr('data-nodeid');
		var tree = $('#tree');
		var node = tree.treeview('getNode', nodeid);
		if (node.state.expanded) {
			tree.treeview('collapseNode', node.nodeId);
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
				<div class="span6" style="border-right:1px solid #e5e5e5">
					<fieldset>
						<legend>
							菜单管理&nbsp;&nbsp;<i class="fa fa-folder-open"></i>
						</legend>
						<strong>选择菜单角色</strong><br> <br> 管理员：<input type="radio"
							name="m_type" value="4" /> &nbsp; 学生：<input type="radio"
							name="m_type" value="1" />&nbsp; 教师：<input type="radio"
							name="m_type" value="2" /> &nbsp; 系院领导：<input type="radio"
							name="m_type" value="3" /> &nbsp;
						<legend></legend>

						<strong>菜单操作</strong><br> <br> 添加一级菜单：<input
							type="radio" name="select_level" value="1" />&nbsp; 添加下级菜单：<input
							type="radio" name="select_level" value="2" /> &nbsp; 删除一级菜单：<input
							type="radio" name="select_level" value="3" />&nbsp; 删除下级菜单：<input
							type="radio" name="select_level" value="4" /><br> <br>

						<fieldset id="nav_info" style="display:none">
							<label><strong>输入上级菜单名</strong></label><input id="nav_input"
								type="text" /> <label><strong id="xxs">选择本次添加菜单
									在哪条菜单之后</strong></label>

							<div class="col-sm-6" style="width:200px">
								<select id="select1" name="select"
									class="selectpicker show-tick form-control"
									data-live-search="true" data-actions-box="true">

								</select>
							</div>

						</fieldset>

						<fieldset id="upper_select" style="display:none">
							<strong>选择上级菜单</strong><br> <br>
							<div class="col-sm-6" style="width:200px">
								<select id="select2" name="select"
									class="selectpicker show-tick form-control"
									data-live-search="true" data-actions-box="true">
								</select>
							</div>
							<br> <label><strong>输入菜单名</strong></label><input
								id="nav_input_2" type="text" />
						</fieldset> 


						<fieldset id="d_upper_select" style="display:none">
							<strong>选择一级菜单</strong><br> <br>
							<div class="col-sm-6" style="width:200px">
								<select id="select3" name="select"
									class="selectpicker show-tick form-control"
									data-live-search="true" data-actions-box="true">
								</select>
							</div>
							<br>
						</fieldset>


						<fieldset id="d_lower_select" style="display:none">
							<strong>选择下级菜单</strong><br> <br>
							<div class="col-sm-6" style="width:200px">
								<select id="select4" name="select"
									class="selectpicker show-tick form-control"
									data-live-search="true" data-actions-box="true">
								</select>
							</div>
							<br>
						</fieldset>







						<br> <br>
						<button type="button" id="menusub" class="btn">提交</button>
				</div>


				<div class="span6">
					<legend>
						菜单预览&nbsp;&nbsp;<i class="fa fa-folder-open"></i>
					</legend>
					<div id="tree"
						style="width:50%;margin-left:auto;margin-right:auto;"></div>
				</div>


				</fieldset>
			</div>


		</div>


	</div>

	<script src="/TES/plugin/script/particles.min.js"></script>
	<script src="/TES/plugin/script/app.js"></script>
</body>
</html>