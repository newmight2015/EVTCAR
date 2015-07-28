<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
<link href="css/copyright.css" rel="stylesheet" type="text/css" />
<link href="css/user-man.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
<link href="styles/nyroModal.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="page" class="page">
 <%@include file="head.jsp" %>
  <div id="content" class="content">
  <div class="select-box"><a href="sub-html/order-form.html" target="frame" class="a">订单管理</a><a href="sub-html/user-info.html" target="frame" class="a">用户信息</a><a href="sub-html/change-code.html" target="frame" class="a">密码修改</a></div>
  <iframe name="frame" scrolling="no" class="frame"></iframe>
 
</div>
<%@include file="bottom.jsp" %>
</body>
</html>
