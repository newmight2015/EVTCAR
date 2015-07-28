<%@  page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta name="keywords" content="电动汽车充电 充电导航 充电站  车快充 电动汽车服务  去哪充电  充电站分布  北京市充电站查询 充电站位置  充电站地址   北京市充电桩查询  充电桩位置  充电桩地址    ">
<meta name="description" content="
为你打造最优质的电动汽车充电服务，享受绿色出行,
去哪充电？为您提供贴心的智能充电导航服务,
按区域搜索北京市充电桩布局、充电桩信息,
根据您的位置自动推送三条最近的充电路线,
手机APP主动用语音导航带您去最近充电站,
在建充电桩、可用充电桩、专用充电桩全知道">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">


<title>车快充</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/evtcar.css" rel="stylesheet">

<script src="js/jquery-2.1.3.min.js"></script>
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
<script src="js/staticinfo.js" type="text/javascript"></script>
<script type="text/javascript">
	<%
		HttpSession sess = request.getSession();
		usInformation usInf = (usInformation)sess.getAttribute("usInf");
	%>
	window.MAINURL = "<%=basePath%>";
	STATICINFO.USERINFO.URL = "<%=basePath%>";
	STATICINFO.USERINFO.name = "<%= usInf==null ? "" : usInf.getUsId()%>";
	</script>
<style>
body{
	font: 14px/1.6 "Helvetica Neue",Arial,"Microsoft Yahei",sans-serif;
	color: #333333;
}
</style>
</head>

<body>
<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn active"><a href="index.jsp">首页</a></div>
		<div class="nav-btn "><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="aboutUs.jsp">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->
<div class="company-function">
		<h1><b>我们的服务</b></h1>
		<div class="container function">
			<div class="rows">
					<div class="col-xs-4">
						<div class="function-pic">
							<img src="pic/functionpic2.png">
						</div>
						<div class="function-content">
							<div class="tittle">全国主要城市的充电站详细信息查询</div>
							<div class="content">用户能查询到充电站位置、快/慢充桩的数量、空闲充电桩数量、充电桩运营状况、运营时间、充电费用以及充电停车费用等充电服务信息。
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="function-pic">
							<img src="pic/functionpic1.png">
						</div>
						<div class="function-content">
							<div class="tittle">智能化主动式充电服务</div>
							<div class="content">平台根据用户车辆的位置、剩余电量、出行路线以及充电站的动静态数据等信息，调用充电调度模型，智能计算出最佳充电服务方案并提供充电预约的服务。
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="function-pic">
						<img src="pic/functionpic3.png">
						</div>
						<div class="function-content">
							<div class="tittle">众包式的充电站信息采集</div>
							<div class="content">激励每个用户主动提供新建充电站的位置、充电桩数量、名称、运营状况等信息，利于平台及时更新数据，实现最大化充电服务的覆盖。
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>
	<br><br><br><br><br>
<%@include file="footer.jsp" %>

<!--下面是左侧导航栏的代码-->
<script src="js/jquery.min.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script>
			var nt = !1;
			$(window).bind("scroll",
				function() {
				var st = $(document).scrollTop();//往下滚的高度
				nt = nt ? nt: $("#J_m_nav").offset().top;
				// document.title=st;
				var sel=$("#J_m_nav");
				if (nt < st) {
					sel.addClass("nav-fixed");
				} else {
					sel.removeClass("nav-fixed");
				}
			});
</script>
</body>
</html>
