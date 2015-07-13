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
<meta name="keywords" content="电动汽车充电 充电导航 充电站  电动汽车服务  去哪充电  充电站分布  北京市充电站查询 充电站位置  充电站地址   北京市充电桩查询  充电桩位置  充电桩地址    ">
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
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body"> </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn active"><a href="index.jsp">首页</a></div>
		<div class="nav-btn "><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="#">关于我们</a></div>
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
							<div class="tittle">方便用户查询北京区域充电站的位置	</div>
							<div class="content">点击充电站信息查询，随时随地掌握一手北京市充电站分布信息，让你智行天下。
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="function-pic">
							<img src="pic/functionpic1.png">
						</div>
						<div class="function-content">
							<div class="tittle">为您自动推送三条最近的充电路线</div>
							<div class="content">用户也可在WEB浏览器相应网页上输入地点名称，网页也会为用户推送相对于所输地点最合适的3个可用充电站。用户可随意选择任一充电站作为目的地，平台为用户规划起点到所选充电站的最优路径。
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="function-pic">
						<img src="pic/functionpic3.png">
						</div>
						<div class="function-content">
							<div class="tittle">手机APP语音导航带您去最近充电站	</div>
							<div class="content">用户可通过手机终端发出充电请求，平台主动为用户提供在续驶里程范围内的3个满足用户需求的可用充电站，避免或者减少用户在充电站的排队。
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>
	
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
