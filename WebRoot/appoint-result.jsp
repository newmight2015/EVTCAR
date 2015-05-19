<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>预约订单</title>
<link href="css/appoint -res.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="page" class="page">
<div id="log" class="log"><a href="login.html">登录</a><a href="register.html">注册</a></div>
<div id="nav" class="nav">
  <div id="title" class="title"><img src="pic/title.png" /></div>
  <hr class="hr"/>
  <ul class="bar">
    <li id="m1"><a href="index.html">首页</a></li>
    <li id="m2"><a href="char-nav.html">充电导航</a></li>
    <li id="m3"><a href="inq-sta.html">查询充电站信息</a></li>
    <li id="m4"><a href="appoint.html">充电预约</a></li>
    <li id="m5"><a href="user-man.html">用户管理</a></li>
    <li id="m6" class="m6"><a href="help.html">帮助中心</a></li>
  </ul>
</div>
<div id="content" class="content">
  <div class="app-info">
    <div class="caption">预约信息:</div>
    <div class="info1">
      <div style="float:left"><img src="pic/charge-stick.gif" class="img"/></div>
      <div class="information">
        <div class="text-box1">
          <div class="text">充电开始时间：</div>
          <div class="data">时间<!--这里放从result.html传过来的数据--></div>
        </div>
        <div class="text-box1">
          <div class="text">充电结束时间：</div>
          <div class="data">时间<!--这里放从result.html传过来的数据--></div>
        </div>
        <div class="text-box2">
          <div class="text">充电地点：</div>
          <div class="data">地点<!--这里放从result.html传过来的数据--></div>
        </div>
      </div>
    </div>
  </div>
  <div class="veh-info">
    <div class="caption">车辆信息:</div>
    <div class="info2">
      <div class="text-box3">
        <div class="sub-box">
          <div class="star">*</div>
          <div class="veh-text">车牌号：</div>
          <div class="data2">京A 00000<!--传入数据--></div>
        </div>
        <div class="sub-box">
        <div class="star">*</div>
          <div class="veh-text">车主姓名：</div>
          <div class="data2">张三<!--传入数据--></div></div>
      </div>
      <p class="alert">充电时请现场核对以上信息</p>
    </div>
  </div>
  <div id="copyright" class="copyright">
    <p>地址：北京市海淀区上园村3号北京交通大学交通运输学院　邮编：100044<br />
      北京交通大学交通运输学院保留网站所有权利 未经允许不得复制、镜像 </p>
  </div>
</div>
</body>
</html>