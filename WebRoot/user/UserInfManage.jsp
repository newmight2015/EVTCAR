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
	<script src="../js/register_121015.js" type="text/javascript"></script>
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
	<style>
	.important{ 
		color:red;
		margin-right:8px;
	}
	.textarea{
		border: 1px solid #7f9db9;
		float: left;
		width: 400px;
		margin-right: 10px;
		padding: 7px 10px;
		line-height: 18px;
		outline: 0 none;
	}  
	</style>
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
		<div class="nav-btn"><a href="../aboutUs.jsp">关于我们</a></div>
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
				            				<tr style="display: none;" >
				                                <td class="t" ><span class="important">*</span>昵称：</td>
				                                <td>
				                                	<input class="text" type="text" id="usname" value="" autocomplete="off">
					                                <span id="a1" style="display:none" class="warn">请填入2-10位中文或英文昵称</span>
	                                    			<span id="a2" style="display: none;" class="cue"></span>
												</td>
				                            </tr>
				                            <tr>
				                                <td class="t" ><span class="important">*</span>邮箱：</td>
				                                <td>
					                                <input class="text" type="text" id="usemail" value="" autocomplete="off">
					                                <span id="b1" style="display:none" class="warn">请输入您的邮箱，用于找回密码和接受消息</span>
	                                    			<span id="b2" style="display: none;" class="cue"></span>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="t" ><span class="important">*</span>手机：</td>
				                                <td>
					                                <input class="text" type="text" id="usphone" value="" autocomplete="off">
					                                <span id="c1" style="display:none" class="warn">用于接收信息，密码修改，获取积分奖励等服务</span>
		                                    		<span id="c2" style="display: none;" class="cue"></span>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="t" >城市：</td>
				                                <td>
				                                	<input class="text" type="text" id="uscity" value="" autocomplete="off">
				                                	<span id="d1" style="display:none" class="warn">请填入您所在城市</span>
	                                    			<span id="d2" style="display: none;" class="cue">请输入正确的城市</span>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="t" >简介：</td>
				                                <td>
				                               	 	<textarea class="textarea"  rows="3" cols="50" type="text" id="usnotes" value="" autocomplete="off"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="t">
				                                    &nbsp;
				                                </td>
				                                <td>
				                                	<input class="btn btn-primary" type="submit" id="saveusinf" style="float: left;margin-right: 10px;" value="保存信息"></input>
				                                	<span class="warn" id="SaveOkMsg" style="display: none;"> 你的资料保存成功！ </span>
				                                	<span id="s2" style="display: none;" class="cue">请正确输入以上信息</span>
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
				                                <td class="t" ><span class="important">*</span>新登录密码：</td>
				                                <!-- <td><input type="password" id="uspassword1" class="text" value="" autocomplete="off"></td> -->
				                                <td><input type="password" id="txt_password" name="password" class="text" onfocus="check_password_focus()" onkeyup="txtPassword_strong_check()" onblur="password_check()" onpaste="return false;" style="display:'';" tabindex="2">
                                    			<input type="text" id="hid_txt_password" name="hid_txt_password" class="text" onfocus="check_password_focus()" onkeyup="txtPassword_strong_check()" onblur="password_check()" onpaste="return false;" style="display:none" tabindex="2">
				                                <span id="capslock_change" class="prompt" style="display:none"><span class="icon"></span>大写键盘已打开</span>
			                                    <span id="spn_password_ok" class="warn" style="display: none;"></span>
			                                    <span id="spn_password_wrong" class="cue" style="display: none;"></span>
			                                    <span id="spnPwdStrongTips" style="display: none" class="warn warn_p">密码强度:
			                                    <span class="msg_level" id="spnPwdStrong1" style="display: none;"><span class="s1">弱</span><span>中</span><span>强</span></span>
			                                    <span id="spnPwdStrong2" class="msg_level" style="display: none;"><span class="s1">弱</span><span class="s2">中</span><span>强</span></span>
			                                    <span id="spnPwdStrong3" class="msg_level" style="display: none;">
			                                    <span class="s1">弱</span><span class="s2">中</span><span class="s3">强</span></span>
			                                    </span>
			                                    <span style="display: none;" class="warn"></span>
			                                    <span id="div4" style="display: none;" class="cue"></span>
				                                <span id="m1" style="display:none" class="warn">请输入6-20个字符，可用英文、数字及字符组成</span>
                                    			<span id="m2" style="display: none;" class="cue">请输入正确的城市</span>
                                    			</td>
				                            </tr>
				                            <tr>
				                                <td class="t" ><span class="important">*</span>重新输入新密码：</td>
				                                <!-- <td><input type="password" id="uspassword2" class="text" value="" autocomplete="off"></td><td><div id="alertinf" style="color:red;"></div></td>
				                                <span id="n1" style="display:none" class="warn"></span>
                                    			<span id="n2" style="display: none;" class="cue">请输入正确的城市</span> -->
                                    			<td><input type="password" id="txt_repassword" name="checkpassword" class="text" onfocus="check_repassword_focus()" onblur="repassword_check()" onkeyup="repassword_session_check()" onkeydown="CheckdoSubmit(event)" onpaste="return false" style="display:'';" tabindex="3">
                                    
			                                    <input type="text" id="hid_txt_repassword" name="hid_txt_repassword" class="text" onfocus="check_repassword_focus()" onblur="repassword_check()" onkeyup="repassword_session_check()" onkeydown="CheckdoSubmit(event)" onpaste="return false" style="display:none" tabindex="3">
			                                    
			                                    <span id="spn_repassword_ok" class="warn" style="display: none;"></i></span>
			                                    <span id="spn_repassword_wrong" style="display: none;" class="cue"></span>
			                                    <span style="display: none;" class="warn"></span>
			                                    <span id="div5" style="display: none;" class="cue"></span>
			                                    </td>
				                            </tr>
				                            <tr>
				                                <td class="t">
				                                    &nbsp;
				                                </td>
				                                <td>
				                                	<input type="submit" id="changepassword" class="btn btn-primary" style="float: left;margin-right: 10px;" value="修改密码"></input>
				                                	<span id="ChangeMsg" style="display: none;" class="warn" > 你的密码修改成功！ </span>
				                                	<span id="cm" style="display: none;" class="cue">请正确输入您的密码！</span>
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
			$("#s2").css("display","none");
			$("#SaveOkMsg").css("display","none");
   			if( checkusemail() && checkusphone()){ //判断信息是否输入正确
   				//var usname = $("#usname").val();
   				var usemail = $("#usemail").val();
   				var usphone = $("#usphone").val();
   				var uscity = $("#uscity").val();
   				var usnotes = $("#usnotes").val();
   				var act="saveusinf";
   	            var AjaxURL=window.MAINURL+"dealMessage?usemail="+usemail+"&usphone="+usphone
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
			}else{
				$("#s2").css("display","block");
			}
			
		});
		/* $("#uspassword2").blur(function(){
			var uspassword1 = $("#txt_password").val();
			var uspassword2 = $("#txt_repassword").val();
			if(uspassword1!=uspassword2){
			  	$("#alertinf").html("<h6>两次输入的密码不同</h6>");
			}else{
				$("#alertinf").html("");
				//$("#changepassword").attr("disabled",true);
			}
		}); */
		$("#changepassword").click(function (e) {
			//uspassword1,uspassword2
			$("#cm").css("display","none");
			$("#ChangeMsg").css("display","none");
			if(repassword_check()==true){
				var uspassword1 = $("#txt_password").val();
				var uspassword2 = $("#txt_repassword").val();
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
			}else{
				$("#cm").css("display","block");
			}
			
		});
		//修改个人信息和密码的限制
		//昵称
		$("#usname").focus(function() {
			$("#a1").css("display","block");
			$("#a2").css("display","none");
		});
		$("#usname").blur(function() {
			$("#a1").css("display","none");
			if(checkusname()==false){
				$("#a2").css("display","block");
			}
		});
		//邮箱
		$("#usemail").focus(function() {
			$("#b1").css("display","block");
			$("#b2").css("display","none");
		});
		$("#usemail").blur(function() {
			$("#b1").css("display","none");
			if(checkusemail()==false){
				$("#b2").css("display","block"); 
				
			}
		});
		//手机
		$("#usphone").focus(function() {
			$("#c1").css("display","block");
			$("#c2").css("display","none");
			
		});
		$("#usphone").blur(function() {
			$("#c1").css("display","none");
			if(checkusphone()==false){
				$("#c2").css("display","block"); 
			}
		});
		//城市(暂时不限制)
		/* $("#uscity").focus(function() {
			//alert("1");
			$("#d1").css("display","block");
			$("#d2").css("display","none");
		});
		$("#uscity").blur(function() {
			//alert("2");
			$("#d1").css("display","none");
			$("#d2").css("display","block"); 
		}); */
		
	</script>
</body>
</html>

