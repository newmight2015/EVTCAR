<%@  page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="UTF-8" %>
<header>
<div class="top">
	<div class="wp">
		<div class="logo">
			<a href="index.jsp" class="icon_img_logo"></a>
		</div>
		<div class="menu">
			<div class="xl">
				<ul>
					<li><a>客户端下载</a></li>
					<li><a>运营商加盟</a></li>
				</ul>
			</div>
			<div class="loader">
			<% if(usInf!=null){ %>
			  <form  name="form1" method="post" action="dealExit.do"  >
                <div class="xl" name="logininf">
                  <a>欢迎您:<%=usInf.getUsId() %></a>
                  <input class="btn btn-sm btn-default" type="submit" value="退出登陆" >
                  <a class="btn btn-sm btn-default" href="register.jsp" ><span>注册</span></a>
                </div>
              </form>
            <%}else{ %>
				<a href="register.jsp" class="btn btn-success btn-lg"><span>注册</span></a>
				<a href="login.jsp" class="btn btn-success btn-lg"><span>登录</span></a>
			<% } %>
			</div>
		</div>
	</div>
</div>


