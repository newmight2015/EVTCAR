<%@ page language="java" import="java.util.*,myBean.wrongMessage" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
<script type="text/javascript" src="js/login.js" charset="utf-8"></script>
<link href="css/login.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form action="dealLogin.do" method="post" class="form" onsubmit="checklogin();return false;">
  <div id="page" class="page">
    <div id="title" calss="title"> <img src="pic/title.png" /> <a href="index.jsp">返回首页</a> </div>
    <div id="cotent" class="content">    
      <div id="log" class="log">
        <p>欢迎登录</p>
        <div id="user" class="user">
          <div>用户名</div>
          <input name="username" type="text" id="username" />
          <span id="div1"></span>
        </div>
        <div id="code" class="code">
          <div>密&nbsp;&nbsp;码</div>
          <input name="password" type="password" id="password" />
          <span id="div2"></sapn>
        </div>
        <div id="yanzheng" class="yanzheng">
          <div class="yzm">验证码</div>
          <input name="checkcode" type="text" id="checkcode" />
          <div class="checkcode"> <img alt="code..." name="randImage" id="randImage" src="image.jsp" width="60" height="20" border="1" align="absmiddle" onclick="reload"/></div>
        </div>
        <div id="error" class="error">
        
        <%
		if(request.getAttribute("Error")!=null)
		{%><img src="img/close.gif"/>
		<% 	// 有错误，要进行打印输出
			wrongMessage wm = (wrongMessage)request.getAttribute("Error");
			List all=wm.getErrors();
			Iterator iter = all.iterator() ;
			while(iter.hasNext())
			{
	%>
				<%=iter.next()%>
	<%
			}
		}
	%>
        </div>
        <div class="button" id="button">
        <input type="submit"  value="登陆"/>
      </div>
      </div>
      <div id="ad" class="ad"><img src="pic/sssd.png" /></div>
    </div>
    
  </div>
  </div>
</form>
</body>
</html>
