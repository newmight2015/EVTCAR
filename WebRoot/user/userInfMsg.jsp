<%@ page language="java" import="java.util.*" import="myBean.usInformation"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>消息提醒</title>
	    <!-- Bootstrap -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
	<script src="../js/staticinfo.js" type="text/javascript"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="../css/evtcar.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/userInf.css">
	<link rel="stylesheet" href="../font-awesome-4.3.0/css/font-awesome.min.css">
	 <script src="../js/jquery-2.1.3.min.js"></script>
	<script src="../js/staticinfo.js" type="text/javascript"></script>
	<script src="../js/UserCheck.js"></script> 
	<script type="text/javascript">
		<%
			HttpSession sess = request.getSession();
			usInformation usInf = (usInformation)sess.getAttribute("usInf");
		%>
		window.MAINURL = "<%=basePath%>";
		STATICINFO.USERINFO.URL = "<%=basePath%>";
		STATICINFO.USERINFO.name = "<%= usInf==null ? "" : usInf.getUsId()%>";
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
		  $("#oldmsg").click(function(){
		  	  $("#oldMsgContent").toggle();
		  });
		});
	</script>
</head>

<body>

	<div class="contain back-color">
		<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn"><a href="../index.jsp">首页</a></div>
		<div class="nav-btn"><a href="../searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="../inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn active"><a href="../userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="../aboutUs.jsp">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->
		<div class="main">
			<div class="newcontainer">
				<%@include file="menu.jsp" %>
				<div id="chargemessage">
					<div class="title">消息提醒</div>
					<div class="inf">
						<!--panel面板的标题，下同-->
						<div class="containbox">
				            <div class="panel panel-primary"> 
					            <!--panel面板的标题，下同-->
					            <div class="panel-heading" id="msg">
					              <h3 class="panel-title">最新提醒</h3>
					            </div>
					            <!--panel面板的内容，下同-->
					            <div class="panel-body" id = "msgContent">
									
					          	</div>
				          </div>
				         </div>
				         <!--panel面板的标题，下同-->
						<div class="containbox">
				            <div class="panel panel-primary"> 
					            <!--panel面板的标题，下同-->
					            <div class="panel-heading" id="oldmsg">
					              <h3 class="panel-title">历史提醒</h3>
					            </div>
					            <!--panel面板的内容，下同-->
					            <div class="panel-body" id = "oldMsgContent">
									
					          	</div>
				          </div>
				         </div>
					</div>
				</div>
				
				

		    </div>
		</div>
		<%@include file="footer.jsp" %>
		
	</div>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="../js/bootstrap.min.js"></script>

    <script type="text/javascript">
		$('#myTab a').click(function (e) {
			e.preventDefault()
			$(this).tab('show')
		})
		$(function(){
			//功能：查询最新消息提醒
			USERCheck.checkMsg(function(isok,error){ 
				if(isok){ 
					data = JSON.parse(error);
					var j=0;
					$.each(data, function(i, content){
						var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='msg"+j+"' style='display: none;' value='"+data[i].msgid+
								"'><strong>"+data[i].msgCreatTime+
				              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
				                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteMsg("+j+");' >×</span></button></div>"
				        $("#msgContent").append(msg);
				                j++;
					})
				}else{ 
					alert("false")
				}
			},window.MAINURL);
			//功能：查询历史消息提醒
			USERCheck.checkOldMsg(function(isok,error){
				if(isok){
					data = JSON.parse(error);
					var j=0;
					$.each(data, function(i, content){
						var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='oldmsg"+j+"' style='display: none;' value='"+data[i].msgid+
								"'><strong>"+data[i].msgCreatTime+
				              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
				                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteOldMsg("+j+");' >×</span></button></div>"
				        $("#oldMsgContent").append(msg);
				                j++;
					})
				}else{ 
					alert("false")
				}
			},window.MAINURL)
		});
		//点击最新消息后的“X”将此消息移至历史提醒消息，修改数据库msgState为'2'，表示历史消息
		function deleteMsg(j){
			var msg="#msg"+j;
			var msgid=$(msg).val();
			var act="deleteMsg";
			//alert(""+msgid+"");
			var AjaxURL=window.MAINURL+"dealMessage?msgid="+msgid+"&act="+act;
        	$.ajax({
                type: "POST",
                dataType: "html",
                url: AjaxURL,
                success: function (data) {
                	alert("删除消息成功！");
                	//重新执行查询最新消息---张伟
                	$("#msgContent").empty();
                	$("#oldMsgContent").empty();
                	USERCheck.checkMsg(function(isok,error){ 
        				if(isok){ 
        					data = JSON.parse(error);
        					var j=0;
        					$.each(data, function(i, content){
        						var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='msg"+j+"' style='display: none;' value='"+data[i].msgid+
        								"'><strong>"+data[i].msgCreatTime+
        				              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
        				                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteMsg("+j+");' >×</span></button></div>"
        				        $("#msgContent").append(msg);
        				                j++;
        					})
        				}else{ 
        					alert("false")
        				}
        			},window.MAINURL);
                	/* USERCheck.checkMsg(function(isok,data){ 
        				if(isok){ 
        					var j=0;
        					$.each(data, function(i, content){
        						var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='msg"+j+"' style='display: none;' value='"+data[i].msgid+
        								"'><strong>"+data[i].msgCreatTime+
        				              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
        				                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteMsg("+j+");' >×</span></button></div>"
        				        $("#msgContent").append(msg);
        				                j++;
        					})
        				}else{ 
        					alert("false")
        				}
        			},window.MAINURL); */
                	USERCheck.checkOldMsg(function(isok,error){
						if(isok){
							data = JSON.parse(error);
							var j=0;
							$.each(data, function(i, content){
								var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='oldmsg"+j+"' style='display: none;' value='"+data[i].msgid+
										"'><strong>"+data[i].msgCreatTime+
						              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
						                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteOldMsg("+j+");' >×</span></button></div>"
						        $("#oldMsgContent").append(msg);
						        j++;
							})
						}else{ 
							alert("false")
						}
						},window.MAINURL)
        			/* USERCheck.checkOldMsg(function(isok,data){
						if(isok){
							var j=0;
							$.each(data, function(i, content){
								var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='oldmsg"+j+"' style='display: none;' value='"+data[i].msgid+
										"'><strong>"+data[i].msgCreatTime+
						              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
						                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteOldMsg("+j+");' >×</span></button></div>"
						        $("#oldMsgContent").append(msg);
						                j++;
							})
						}else{ 
							alert("false")
						}
						},window.MAINURL) */
                },
                error: function(data) {
                    alert("error:");
                }
            });
		};
		//点击最新消息后的“X”将此消息从历史提醒消息中删除，修改数据库数据msgState='3'，表示删除的消息
		function deleteOldMsg(j){
			var oldmsg="#oldmsg"+j;
			var msgid=$(oldmsg).val();
			var act="deleteOldMsg";
			//alert(""+msgid+"");
			var AjaxURL=window.MAINURL+"dealMessage?msgid="+msgid+"&act="+act;
        	$.ajax({
                type: "POST",
                dataType: "html",
                url: AjaxURL,
                success: function (data) {
                	alert("删除消息成功！");
                	//重新执行查询最新消息---张伟
                	$("#oldMsgContent").empty();
                	USERCheck.checkOldMsg(function(isok,error){
						if(isok){
							data = JSON.parse(error);
							var j=0;
							$.each(data, function(i, content){
								var msg = "<div class='alert alert-success alert-dismissible' role='alert'><input id='oldmsg"+j+"' style='display: none;' value='"+data[i].msgid+
										"'><strong>"+data[i].msgCreatTime+
						              	"</strong>&nbsp;&nbsp;&nbsp;<strong>提示:</strong><span class='content'>"+data[i].msgValue+
						                "</span><button type='button' class='close' id='close' aria-label='Close'><span aria-hidden='true' onclick='deleteOldMsg("+j+");' >×</span></button></div>"
						        $("#oldMsgContent").append(msg);
						        j++;
							})
						}else{ 
							alert("false")
						}
						},window.MAINURL)
                },
                error: function(data) {
                    alert("error:");
                }
            });
		};
	</script>
</body>
</html>

