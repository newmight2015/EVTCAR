<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="myBean.usInformation" %>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/jquery.nyroModal.custom.js"></script>
<script type="text/javascript">
$(function() {
  $('.nyroModal').nyroModal();
});
</script>
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
<% } %>
    <div id="nav" class="nav">
    
    <div class="title"><span class="title-text">电动汽车智能充电服务平台</span></div>
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

