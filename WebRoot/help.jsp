<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>帮助中心</title>
<link href="css/copyright.css" rel="stylesheet" type="text/css" />
<link href="css/help.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="page" class="page">
<%@include file="head.jsp" %>
  <div id="content" class="content">
  <div class="select-box"><a href="sub-html/zclc.html" target="frame" class="a">注册流程</a><a href="sub-html/nav-proc.html" target="frame" class="a">充电导航流程</a><a href="sub-html/app-proc.html" target="frame" class="a">充电预约流程</a></div>
  <iframe name="frame" scrolling="yes" class="frame"></iframe>
  
 <%@include file="bottom.jsp" %>
</div>
</body>
</html>
