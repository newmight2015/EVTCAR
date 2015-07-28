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
<!-- Modal test-->
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
		<div class="nav-btn"><a href="index.jsp">首页</a></div>
		<div class="nav-btn "><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn  active"><a href="aboutUs.jsp">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->
<div class="company-function">
		<div class="aboutall_bg">
			<div class="footer_bg">
				<div class="footer_aboutus_bg">
				</div>
			</div>
		</div>
		
		<div class="content function">
				<p>亲爱的用户，您好！</p>
				<p>自第一代产品“电动汽车智能充电服务平台”和“电动汽车充电无忧APP”上线8个月以来，收到了大量用户对产品的反馈意见。在此基础上，我们于2015年5月正式对第一版产品进行更新换代，于2015年7月打造出我们的第二代产品“车快充”平台和“车快充”APP。第二代产品数据更加齐全，功能更完善，更贴近用户的需求。但我们深知，好的产品离不开用户的支持和反馈，因此您在使用我们的产品中有何建议，请发送至bilinghc@163.com。我们会认真考虑您的建议，努力进一步打造出满足您要求的产品。</p>
				<h4 class="r">感谢用户您的支持和帮助！</h4>
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
