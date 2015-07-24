<%@ page language="java" import="java.util.*" import="myBean.usInformation"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>个人资料</title>
	    <!-- Bootstrap -->
	<link href="../css/register.css" rel="stylesheet" type="text/css" />
	<link href="../css/evtcar.css" rel="stylesheet" type="text/css" />
    <link href="../css/bootstrap.min.css" rel="stylesheet">
	<script src="../js/staticinfo.js" type="text/javascript"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="../css/evtcar.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/userInf.css">
	<link rel="stylesheet" href="../font-awesome-4.3.0/css/font-awesome.min.css">
	 <script src="../js/jquery-2.1.3.min.js"></script>
	<script src="../js/staticinfo.js" type="text/javascript"></script>
	<script src="../js/UserCheck.js"></script> 
	<script type="text/javascript">
	<%
		HttpSession sess = request.getSession();
		usInformation usInf = (usInformation)sess.getAttribute("usInf");
	%>
	window.MAINURL = "<%=basePath%>";
	STATICINFO.USERINFO.URL = "<%=basePath%>";
	STATICINFO.USERINFO.name = "<%= usInf==null ? "" : usInf.getUsId()%>";
	</script>
</head>

<body>

	<div class="contain back-color">
<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn"><a href="../index.jsp">首页</a></div>
		<div class="nav-btn"><a href="../searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="../inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn active"><a href="../userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="#">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->
		<div class="main">
			<div class="newcontainer">
				<%@include file="menu.jsp" %>
		    </div>
		</div>
		<!-- 更新个人资料主体部分 start-->
		<div class="container" style="margin-top: 10px;margin-bottom: 20px;margin-left: auto;margin-right: auto;">
		  
			<div class="register_box head"  style="background: -webkit-linear-gradient(#fff,#f2f2f2); margin-bottom: 0px;">
					<h3 id="h" style="padding-left: 18px; margin-top: 15px;">修改信息</h3>
			</div>
			
			<div style="float:left;width:20%; background: #f7f7f7; height:500px">
				<ul >
					<li id="la" style=" background-color:#fff;height: 39px;  font-size: 20px;padding-left: 70px;"><a id="a" >基本资料</a></li>
					<li style="  border-top: solid 1px #dde3e9;"></li>
					<li id="lb" style="height: 39px;  font-size: 20px;padding-left: 70px;"><a id="b">修改密码</a></li>
					<li style="  border-top: solid 1px #dde3e9;"></li>
				</ul>
			</div>
	        <div name="fname" style="float:right;width:80%;height:500px">
			<div class="register_box" style="width:100%;height:500px;padding-left: 18px;">
				
				<div id="form1" style="margin-top: 10px;">
					<div><h3 style="padding-bottom: 11px;font-size:22px;padding-left: 18px;color: #999;border-bottom: solid 2px #f2f2f2;">基本信息</h3></div>
					
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
				            <tbody>
				            				<tr>
				                                <td class="t" ><span>*</span>昵称：</td>
				                                <td><input type="text" id="usname" value="" autocomplete="off"></td>
				                            </tr>
				                            <tr>
				                                <td class="t" ><span>*</span>邮箱：</td>
				                                <td><input type="text" id="usemail" value="" autocomplete="off"></td>
				                            </tr>
				                            <tr>
				                                <td class="t" ><span>*</span>手机：</td>
				                                <td><input type="text" id="usphone" value="" autocomplete="off"></td>
				                            </tr>
				                            <tr>
				                                <td class="t" >城市：</td>
				                                <td><input type="text" id="uscity" value="" autocomplete="off"></td>
				                            </tr>
				                            <tr>
				                                <td class="t" >简介：</td>
				                                <td><textarea rows="3" cols="50" type="text" id="usnotes" value="" autocomplete="off"></textarea></td>
				                            </tr>
				                            <tr>
				                                <td class="t">
				                                    &nbsp;
				                                </td>
				                                <td>
				                                	<input type="submit" id="saveusinf" style="background: -webkit-linear-gradient(#75abda,#6698c9);width: 68px;  height: 34px;color: #fff;" value="保存信息"></input>
				                                	<span  id="SaveOkMsg" style="display: none;"> 你的资料保存成功！ </span>
				                                </td>
				                            </tr>
				                        </tbody>
				           </table>
					
				</div>
				<div id="form2">
					<div><h3 style="padding-bottom: 11px;font-size:22px;padding-left: 18px;color: #999;border-bottom: solid 2px #f2f2f2;">修改密码</h3></div>
					
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
				            <tbody>
				            				<tr>
				                                <td class="t" >新登录密码：</td>
				                                <td><input type="password" id="uspassword1" value="" autocomplete="off"></td>
				                            </tr>
				                            <tr>
				                                <td class="t" >确认新密码：</td>
				                                <td><input type="password" id="uspassword2" value="" autocomplete="off"></td><td><div id="alertinf" style="color:red;"></div></td>
				                            </tr>
				                            <tr>
				                                <td class="t">
				                                    &nbsp;
				                                </td>
				                                <td>
				                                	<input type="submit" id="changepassword" style="background: -webkit-linear-gradient(#75abda,#6698c9);width: 68px;  height: 34px;color: #fff;" value="修改密码"></input>
				                                	<span  id="ChangeMsg" style="display: none;"> 你的密码修改成功！ </span>
				                                </td>
				                            </tr>
				            </tbody>
				        </table>
			</div>
		</div>
		</div>
	  
	</div>
	<!-- 更新个人资料主体部分 end-->
		
 	
	 	<%@include file="footer.jsp" %>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="../js/bootstrap.min.js"></script>

    <script type="text/javascript">
    $("#la").click(function (e) {
    	$("#la").css("background-color","#fff");
    	$("#lb").css("background-color","#f7f7f7");
    	$("#form2").hide();
    	$("#form1").show();
    });
    $("#lb").click(function (e) {
    	$("#lb").css("background-color","#fff");
    	$("#la").css("background-color","#f7f7f7");
    	$("#form1").hide();
    	$("#form2").show();
    });
    $(function(){
    	$("#")
    	$("#form2").hide();
    });
   		 $("#saveusinf").click(function (e) {
			//usname,usemail,usphone,uscity,usnotes
			var usname = $("#usname").val();
			var usemail = $("#usemail").val();
			var usphone = $("#usphone").val();
			var uscity = $("#uscity").val();
			var usnotes = $("#usnotes").val();
			var act="saveusinf";
            var AjaxURL=window.MAINURL+"dealMessage?usname="+usname+"&usemail="+usemail+"&usphone="+usphone
            +"&uscity="+uscity+"&usnotes="+usnotes+"&act="+act;
            //alert(AjaxURL);
            var a=confirm("确认提交修改");
            if(a==true){
	            $.ajax({
	                        type: "POST",
	                        dataType: "html",
	                        url: AjaxURL,
	                        success: function (data) {
	                        	//alert("修改信息成功！");
	                        	$("#SaveOkMsg").show();
	                        },
	                        error: function(data) {
	                            alert("error!");
	                         }
	                    }); 
            }
		});
		$("#uspassword2").blur(function(){
			var uspassword1 = $("#uspassword1").val();
			var uspassword2 = $("#uspassword2").val();
			if(uspassword1!=uspassword2){
			  	$("#alertinf").html("<h6>两次输入的密码不同</h6>");
			}else{
				$("#alertinf").html("");
				//$("#changepassword").attr("disabled",true);
			}
		});
		$("#changepassword").click(function (e) {
			//uspassword1,uspassword2
			var uspassword1 = $("#uspassword1").val();
			var uspassword2 = $("#uspassword2").val();
			var act="changepassword";
			if(uspassword1==uspassword2){
	            var AjaxURL=window.MAINURL+"dealMessage?uspassword1="+uspassword1+"&act="+act;
	            //alert(AjaxURL);
	            var a=confirm("是否确认修改密码？");
	            if(a==true){
		            $.ajax({
		                        type: "POST",
		                        dataType: "html",
		                        url: AjaxURL,
		                        success: function (data) {
		                        	//alert("修改信息成功！");
		                        	$("#ChangeMsg").show();
		                        },
		                        error: function(data) {
		                            alert("error!");
		                         }
		                    });
	            }
	            $("#alertinf").html("");
			}else{
				$("#alertinf").html("<h6>两次输入的密码不同</h6>");
			}
		});
		
	</script>
</body>
</html>

