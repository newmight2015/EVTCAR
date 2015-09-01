<%@  page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="UTF-8" %>
<script src="js/respond.js" type="text/javascript"></script>
<header>


<div class="modal fade" id="showDownload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">APP下载</h4>
      </div>
      <div class="modal-body" style="text-align:center""> 
      		
      		<img src="pic/andriodapp.png"/>
      		<p>扫描二维码下载app</p>
      		<p>建议Android4.0以上版本</p>
      		<p><a href="http://www.ezchong.com/download/ezchong731.apk" class="btn btn-success">点此下载到电脑</a></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<div class="top">
	<div class="wp">
		<div class="logo">
			<a href="index.jsp" class="icon_img_logo"></a>
		</div>
		<div class="menu">
			<div class="xl">
				<ul>
				
					<li><a id="download">客户端下载</a></li>
					<li><a>运营商加盟</a></li>
				</ul>
			</div>
			<script>
				$("#download").click(function(){
					$("#showDownload").modal();
				});
			</script>
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


