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

		$("#upload_sub").on("click", function() {
			console.log(jsonobj1);
			var jsonstr = JSON.stringify(jsonobj1);
			console.log(jsonstr);
			$.ajax({
				type : "POST",
				url : "/TES/tcupload",
				data : {
					ListSrt : jsonstr,
				},
				dataType : "json",
				success : function(data) {
					$("#update-success-alert").remove();
					$("#update-fail-alert").remove();
					var $updatesuc = $("<div class='alert alert-success' id='update-success-alert' style='margin:0px 0px 0px 30px;width:25%;display:inline-block'><button type='button' class='close' data-dismiss='alert'>×</button> <h4> 操作成功! </h4> 成功插入" + data + "条数据" + " </div>")
					$("#box1").after($updatesuc);
				},
				error : function(data) {
					$("#update-success-alert").remove();
					$("#update-fail-alert").remove();
					var $updatefail = $("<div class='alert alert-fail' id='update-fail-alert' style='margin:0px 0px 0px 30px;width:25%;display:inline-block'><button type='button' class='close' data-dismiss='alert'>×</button> <h4> 操作失败! </h4> 插入失败</div>")
					$("#box1").after($updatefail);
				}
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
						教师课程管理&nbsp;&nbsp;<i class="fa fa-folder-open"></i>
					</legend>

				</fieldset>
				<div id="demo"></div>
				<div id="box1" style="margin-top:25px;display:inline-block">
					选择excel文件
					<div class="fileinput fileinput-new" data-provides="fileinput">
						<span class="btn btn-default btn-file"><span
							class="fileinput-new">Select file</span><span
							class="fileinput-exists">Change</span><input type="file"
							onchange="importf(this)" name="..."></span> <span
							class="fileinput-filename"></span> <a href="#"
							class="close fileinput-exists" data-dismiss="fileinput"
							style="float: none">&times;</a>
					</div>
					<button type="button" id="upload_sub" class="btn">上传</button>
				</div>


<center>
					<table border="1" style="text-align:center;">
					<strong>按教师搜索：</strong>
						<form action="ctt.do" method="get" class="form-search"> 
							<input class="input-medium search-query" name="queryCondition"
								value="${page.queryCondition}" id="condition" type="text">
							<button class="btn" type="submit">查询</button>
						</form>
					
					</table> 
 
				</center>



<div style="max-height:280px;overflow:scroll;overflow-x: hidden;overflow-y:auto;">
				<table class="table table-hover" >
					<thead>
						<tr>
							<th>课程名</th>
							<th>班级名</th>
							<th>教师</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cttTables}" var="c">
							<tr>
								<td>${c.course_name}</td>
								<td>${c.clazz_name}</td>
								<td>${c.user_name}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table> 
				</div>
				<div class="pagination pagination-centered">
					<center>  
						<label>第${page.currentPage}/${page.totalPage}页
							共${page.totalRows}条</label> <a href="ctt.do?currentPage=0">首页</a> <a
							href="ctt.do?currentPage=${page.currentPage-1}" 
							onclick="return checkFirst()">上一页</a> <a 
							href="ctt.do?currentPage=${page.currentPage+1}"
							onclick="return checkNext()">下一页</a> <a
							href="ctt.do?currentPage=${page.totalPage}">尾页</a> 跳转到: <input
							type="text" style="width:30px" id="turnPage" />页 <button
							class="btn"  onclick="startTurn()">跳转</button>
					</center>
				</div>

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
		    
    function checkFirst(){
         if(${page.currentPage>1}){
         
           return true;
         
         }
         alert("已到页首,无法加载更多");
        
       return false;
    }
    
    function checkNext(){
    
    if(${page.currentPage<page.totalPage}){
    
      return true;
    
    }
    alert("已到页尾，无法加载更多页");
    return false;
    
    }
     
    
    function startTurn(){
    
    var turnPage=document.getElementById("turnPage").value;
    
    if(turnPage>${page.totalPage}){
    
      alert("对不起已超过最大页数");
     
      return false;
    
    }
    
    var shref="init.do?currentPage="+turnPage;
    
    window.location.href=shref;
}
	</script>
	<script src="/TES/plugin/script/particles.min.js"></script>
	<script src="/TES/plugin/script/app.js"></script>
</body>
</html>