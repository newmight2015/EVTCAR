<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>充电预约</title>
<link href="css/appoint.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
<link href="css/copyright.css" rel="stylesheet" type="text/css" />
<script src="js/WdatePicker.js" type="text/javascript"></script>
<script src="js/calendar.js" type="text/javascript"></script>
</head>

<body>
<div id="page" class="page">
   <%@include file="head.jsp" %>
  <form action="#" method="post">
    <div id="content" class="content">
      <div class="info">
        <div class="box">
          <div class="text">充电开始时间</div>
          <input name="start-date" type="text" class="cal" onfocus="WdatePicker()" >
          <input name="start-time" type="text" class="time" onfocus="WdatePicker({dateFmt:'HH:mm:ss'})"/>
        </div>
        <div class="box">
          <div class="text">充电结束时间</div>
          <input name="stop-date" type="text" class="cal" onfocus="WdatePicker()">
          <input name="stop-time" type="text" class="time" onfocus="WdatePicker({dateFmt:'HH:mm:ss'})"/>
        </div>
        <div class="box2">
          <div id="position" class="text">请输入所在位置</div>
          <input name="position" type="text" class="position"/>
          <a href="#" class="map-click" onclick="window.showModalDialog('sub-html/baidu-map1.html','','dialogWidth=697px;dialogHeight=378px;status=no;help=no;scroll=no;resiizable=no')">在地图选择</a> </div>
        <div align="center">
          <input type="submit" class="button" value="充电预约" onclick="alert('功能正在开发中')"/>
        </div>
      </div>
      <div class="proc">
        <p class="p">预约流程：</p>
        <img src="pic/process.gif" class="img"/></div>
  </form>
<%@include file="bottom.jsp" %>
</div>
</body>
</html>

