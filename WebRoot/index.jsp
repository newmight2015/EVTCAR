<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="myBean.usInformation"  import="myBean.ApplicationConstants"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta name="keywords" content="电动汽车充电 充电导航 充电站  电动汽车服务  去哪充电  充电站分布  北京市充电站查询 充电站位置  充电站地址   北京市充电桩查询  充电桩位置  充电桩地址    " />
<meta name="description" content="
为你打造最优质的电动汽车充电服务，享受绿色出行,
去哪充电？为您提供贴心的智能充电导航服务,
按区域搜索北京市充电桩布局、充电桩信息,
根据您的位置自动推送三条最近的充电路线,
手机APP主动用语音导航带您去最近充电站,
在建充电桩、可用充电桩、专用充电桩全知道"/>
<meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">
<title>电动汽车智能充电服务平台</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<link href="css/copyright.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.slideBox.css" rel="stylesheet" type="text/css" />
<link href="styles/nyroModal.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/jquery.nyroModal.custom.js"></script>
<!--[if IE 6]>
		<script type="text/javascript" src="js/jquery.nyroModal-ie6.min.js"></script>
	<![endif]-->

<script src="js/jquery.slideBox.js" type="text/javascript"></script>
<script>
$(function() {
  $('.nyroModal').nyroModal();
});
jQuery(function($){
	$('#slides').slideBox({
		direction : 'left',//left,top#方向
		duration : 0.3,//滚动持续时间，单位：秒
		easing : 'swing',//swing,linear//滚动特效
		delay : 5,//滚动延迟时间，单位：秒
		startIndex : 0//初始焦点顺序
	});	
});
</script>
</head>

<body>
<div id="page" class="page">
<div >
  <%
    usInformation usInf=(usInformation)session.getAttribute("usInf");
%>  

<%if(usInf == null){ %>
  <div id="log" class="log" align="right" ><a href="login.jsp">登录</a><a href="register.html" >注册</a></div>
<% }else{ %>
  <div id="exit"   class="welcome">
<span >欢迎回来：</span><a href ="user-man.jsp"> <%=usInf.getUsId()%></a>
  	<a href="dealExit.do" id="tuichu">退出登录</a>
  </div>
<% } %></div>
<div id="nav" class="nav">
  <div class="title" ><span class="title-text">电动汽车智能充电服务平台</span>
  <a class="nyroModal"  href="pic/andriodapp.png" style="margin-left:150px;" title="扫描二维码下载app(建议4.0以上版本)"><img src="pic/ad.png"  class="ad-pic" /></a><a onclick="alert('iOS版应用正在开发中')" href="" style="margin-left:10px;"><img class="ip-pic" src="pic/ip.png"  /></a></div>
  <hr class="hr"/>
  <ul class="bar">
    <li id="m1" class="m1"><a id="nav-text" href="index.jsp">首页</a></li>
    <li id="m2" class="m2"><a id="nav-text" href="char_nav.jsp">充电导航</a></li>
    <li id="m3" class="m3"><a id="nav-text" href="inq_sta.jsp">查询充电站信息</a></li>
    <li id="m4" class="m4"><a onclick="alert('功能正在开发中')" id="nav-text" href="appoint.jsp">充电预约</a></li>
    <li id="m5" class="m5"><a onclick="alert('功能正在开发中')" id="nav-text" href="user-man.jsp">我的账户</a></li>
    <li id="m6" class="m6"><a id="nav-text" href="help.jsp">帮助中心</a></li>
  </ul>
</div>
<div id="content" class="content">
  <div id="news" class="news">
    <p style="margin-left:20px;margin-top:10px;font:'MS Serif', 'New York', serif;font-size:24px;font-weight:bold;">功能简介:</p>
    
    <a href="" class="news-content">方便用户查询北京市区域充电站/桩分布的地址和位置</a><br />
    <a href="" class="news-content">根据用户需求，主动推送最佳的充电服务方案</a>
    <a href="" class="news-content">手机APP主动用语音导航带您去目标充电站</a><br />
    <a href="" class="news-content">提供充电预约服务，即到即充</a><br />
    <a href="" class="news-content">提供智能、快捷、可靠的电动汽车充电服务，减少充电排队等候时间，享受绿色出行</a><br />
    
    </div> 
<div id="slides" class="slideBox">
  <ul class="items">
    <li><a href="" title="只需一键快速到达充电站"><img src="pic/index-pic4.png"></a></li>
    <li><a href="" title="所有充电站信息应有尽有"><img src="pic/index-pic5.png"></a></li>
    <li><a href="" title="预约充电，不用排队等候"><img src="pic/index-pic6.png"></a></li>
  </ul>
</div>

<%@include file="bottom.jsp" %>
</div>
</body>
</html>
