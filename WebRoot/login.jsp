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
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<link href="css/evtcar.css" rel="stylesheet" type="text/css" />
<link href="css/login.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.3.0/css/font-awesome.min.css">

<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
</head>

<body>
		<!--顶部导航栏开始 -->
<header>
<div class="top">
	<div class="wp">
		<div class="logo">
			<a href="/" class="icon_img_logo"></a>
		</div>
		<div class="menu">
			<div class="xl">
				<ul>
					<li><a>客户端下载</a></li>
					<li><a>运营商加盟</a></li>
				</ul>
			</div>
			<div class="loader">
				<a href="register.html" class="btn btn-success btn-lg"><span>注册</span></a>
				<a href="login.jsp" class="btn btn-success btn-lg"><span>登录</span></a>
			</div>
		</div>
	</div>
</div>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn"><a href="index.html">首页</a></div>
		<div class="nav-btn"><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="#">关于我们</a></div>
	</div>
</div>
</header>

<form action="dealLogin.do" method="post" class="form" onsubmit="checklogin();return false;">
  <div id="page" class="page">
    <div class="login-content">    
      <div  class="log">
        	<div class="title">登录车快充</div>
	        <div class="input-group user">
			  <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
			  <input class="form-control" name="username" type="text" placeholder="邮箱/用户名/手机">
			</div>	
			 <p id="div1"><span>请输入邮箱地址/昵称/手机号码</span></p>
         	<div class="input-group password">
			  <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
			  <input class="form-control" type="password"  name="password" placeholder="密码">
			</div>
			<p id="div2"><span >请填入长度为6-20个字符的密码</span></p>
	        <div class="input-group check">
	          <div class="checkcode">
	          	<input class="form-control" name="checkcode" type="text" id="checkcode" placeholder="验证码"/>
	          </div>
	          <div class="checkimg"> 
	          		<a><img alt="code..." name="randImage" id="randImage" src="image.jsp"/></a>
	          </div>
	          <a class="changepic">换张图</a>
	          <script>
		          	$("#randImage").click(function(){
	        			$(this).attr("src","image.jsp");
	        		})
	          		$(".changepic").click(function(){
	          			$("#randImage").attr("src","image.jsp");
	          		})
	          </script>
	        </div>
	        <p id="div3"><span >请填入图片中的字符，不区分大小写</span></p>
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
	        <p id="div4"><a href="">忘记密码？</a></p>
	        <div class="button" id="button">
	        	<input type="submit"  value="登陆"/>
	        </div>
	       <div class="regist"> <span>还没有账号？<a href="register.html" class="btn btn-default btn-xs">点击我注册</a></span>		
	       </div>
      </div>
      <div class="ad"><img src="pic/sssd.png" /></div>
    </div>
    
  </div>
  </div>
  
  <div class="company-footer nav-green">
	<div class="footer-content">
		<div class="footer-content-text">
			<img src="pic/footer-telephone-icon.png" alt="phone">
			<p>
				
				<span class="contents">Tel:123456789123</span>
			</p>
		</div>
		<div class="footer-content-text">
			<img src="pic/footer-smartphone-icon.png" alt="smartphone">
			<p>
				
				<span class="contents">Mobile:123456789123</span>
			</p>
		</div>
		<div class="footer-content-text">
			<img src="pic/footer-mail-icon.png" alt="mail">
			<p>
				<span class="contents">Mail:bilinghc@163.com</span>
			</p>
		</div>
		<div>
		<p class="copyright"> &nbsp;&nbsp;© 2015 京ICP备15002253号
&nbsp;&nbsp;|&nbsp;&nbsp;北京交通大学交通运输学院系统工程与控制研究所&nbsp;&nbsp;|&nbsp;&nbsp;充电站数据来自政府有关部门</p>
		</div>
	</div>
</div>
</form>


</body>
<script type="text/javascript"> 
$(function(){ 
	$("[name='username']").on({
		focus:function(){
		  $("#div1").css("margin-top","-20px");
		  $("#div1").show();
		},
	    blur:function(){ 
			 $("#div1").hide();
		} 
	})

	$("[name='password']").on({
		focus:function(){
		  $("#div2").css("margin-top","-20px");
		  $("#div2").show();
		},
	    blur:function(){ 
			 $("#div2").hide();
		} 
	})

	$("[name='checkcode']").on({
		focus:function(){
		  $("#div3").css("margin-top","-20px");
		  $("#div3").show();
		},
	    blur:function(){ 
			 $("#div3").hide();
		} 
	})
}) 
</script> 


</html>
