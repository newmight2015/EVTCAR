<%@ page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="utf-8"%>
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
	<title>用户管理</title>
	    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="css/evtcar.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/userInf.css">
	<link rel="stylesheet" href="font-awesome-4.3.0/css/font-awesome.min.css">
	<script src="js/staticinfo.js" type="text/javascript"></script>
	<script src="js/jquery-2.1.3.min.js"></script>
	<script type="text/javascript">
	<%
		HttpSession sess = request.getSession();
		usInformation usInf = (usInformation)sess.getAttribute("usInf");
	%>
	window.MAINURL = "<%=basePath%>";
	STATICINFO.USERINFO.URL = "<%=basePath%>";
	STATICINFO.USERINFO.name = "<%= usInf==null ? "" : usInf.getUsId()%>";
	if(STATICINFO.USERINFO.name==""){
		alert("您好，请先登录！点击关闭跳转至登录界面");
		window.location ="login.jsp";
	}
	</script>
</head>

<body class="back-color">
	<div class="contain ">
<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn "><a href="index.jsp">首页</a></div>
		<div class="nav-btn "><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn active"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="#">关于我们</a></div>
	</div>
</div>
</header>

<!--顶部导航栏结束 -->
		<div class="main">
			<div class="newcontainer">
				<%@include file="menu.jsp" %>
		    </div>
		</div>
		<br><br><br><br><br><br><br><br><br>
		<%@include file="footer.jsp" %>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>

    <script type="text/javascript">
		$('#myTab a').click(function (e) {
							  e.preventDefault()
							  $(this).tab('show')
							})
	</script>
</body>
</html>

