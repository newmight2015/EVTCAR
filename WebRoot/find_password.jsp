<%@ page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<title>注册</title>
<link href="css/register.css" rel="stylesheet" type="text/css" />
<link href="css/evtcar.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="css/find_pwd.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/find_pwd.js"></script>
<script type="text/javascript" src="js/UserCheck.js"></script>
<script src="js/staticinfo.js" type="text/javascript"></script>
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
	.head span{
		display:inline-block;
		float:right;
		color:gray;
	}
	  
</style>
</head>

<body>
<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn"><a href="index.jsp">首页</a></div>
		<div class="nav-btn"><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="aboutUs.jsp">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->

<div id="bd">

<div class="register_box">
	<div class="head">
		<h3>找回密码</h3>
	</div>
	<div class="body">
		<div class="content">
			<!--table1开始-->
			<div id="table1">
				<div class="progress p_1"></div>
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
		            <tbody>
            				<tr>
                                <td class="t">
                                    <span class="important">*</span>用户名：
                                </td>
                                <td class="z_index2">
                                    <input type="text"  name="username" class="text" autocomplete="off" maxlength="12" tabindex="1" onblur="checkname();" onchange="checkname();">
                                    <span style="display:none" class="warn">请输入您在登录时使用的用户名</span>
                                    <span id="div1" style="display: none;" class="cue"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="t">
                                    <span class="important">*</span>手机：
                                </td>
                                <td class="z_index2">
                                    <input type="text" name="tel" class="text" autocomplete="off" maxlength="11" tabindex="1" disabled="true" style="border-color: rgb(127, 157, 185);" onblur="checkPhoneNum();">
                                    <span  style="display:none" class="warn">请输入注册时使用的手机号</span>
                                    <span id="div3" style="display: none;" class="cue"></span>
                                </td>
                            </tr>
                            
                            <tr id="imgCodeArea" style="display:none;">
                                <td class="t">
                                    <span class="important">*</span>图形验证码：
                                </td>
                                <td>
                                    <input type="text" name="txt_vcode" class="text" autocomplete="off" maxlength="4" tabindex="4" onblur="checkcode();" onChange="checkcode();">
                                    <span id="spn_vcode_ok" class="warn" style="display: none;">请输入下图中的验证码</span>
                                    <span id="spn_vcode_wrong" class="cue" style="display: none;"></span>
                                    <div class="v_box">
                                        <a href="javascript:show_vcode('imgVcode')" name="change_code_img" tabindex="5">
                                            <img alt="code..." name="randImage" id="randImage" src="image.jsp" onclick="reload()"></a>看不清?<a href="javascript:reload()" class="changepic" tabindex="6">换张图</a>
                                    </div>
                                </td>
                            </tr>
                            <!--ko if:type()=='phone'-->
							<tr id="vcodeArea" style="display:none;">
                                <td class="t">
                                    	验证码：
                                </td>
                                <td class="z_index2">
                                    <input id="sms_vcode" type="text" name="vcode" class="half-text" maxlength="10" style="width:80px;margin-right:25px;"  onBlur="checkVcode();">
                                	<a id="sendSMS" class="btn btn-default btn-md half-text" onClick="sendVcode();">获取验证码</a>
                                	<span  style="display:none" class="warn">请输入手机接收到的验证码</span>
                                    <span id="div7" style="display: none;" class="cue"></span>
                                </td>
                                
                            </tr>
							<!--/ko-->
                            
                            
                            
                            <tr>
                                <td class="t">
                                    &nbsp;
                                </td>
                                <td>
                                	
                                    <a id="nextBtn" class="btn btn-success btn-lg l"  tabindex="7" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;下一步&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                    <span id="spn_agreement_wrong" class="cue" style="display:none;margin-left:2px"></span>
                                </td>
                            </tr>
                        </tbody>
		           </table>
				</div>
				<!--table1结束-->
				<!--table2-->
				<div id="table2" style="display:none;">
				<div class="progress p_2"></div>
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
		            <tbody>
            				 <tr>
                                <td class="t">
                                    <span class="important">*</span>登录密码：
                                </td>
                                <td id="in_password">
                                    <input type="password" id="txt_password" name="password" class="text" onfocus="check_password_focus()" onkeyup="txtPassword_strong_check()" onblur="password_check()" onpaste="return false;" style="display:'';" tabindex="2">
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
                                </td>
                            </tr>
                            <tr>
                                <td class="t">
                                    <span class="important">*</span>确认密码：
                                </td>
                                <td id="in_repassword">
                                    <input type="password" id="txt_repassword" name="checkpassword" class="text" onfocus="check_repassword_focus()" onblur="repassword_check()" onkeyup="repassword_session_check()" onkeydown="CheckdoSubmit(event)" onpaste="return false" style="display:'';" tabindex="3">
                                    
                                    <input type="text" id="hid_txt_repassword" name="hid_txt_repassword" class="text" onfocus="check_repassword_focus()" onblur="repassword_check()" onkeyup="repassword_session_check()" onkeydown="CheckdoSubmit(event)" onpaste="return false" style="display:none" tabindex="3">
                                    
                                    <span id="spn_repassword_ok" class="warn" style="display: none;"></i></span>
                                    <span id="spn_repassword_wrong" style="display: none;" class="cue"></span>
                                    <span style="display: none;" class="warn"></span>
                                    <span id="div5" style="display: none;" class="cue"></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <td class="t">
                                    <span class="important">*</span>图形验证码：
                                </td>
                                <td>
                                    <input type="text" name="txt_vcode" class="text" autocomplete="off" maxlength="4" tabindex="4" onblur="checkcode()">
                                    <span  class="warn" style="display: none;">请输入下图中的验证码</span>
                                    <span  class="cue" style="display: none;"></span>
                                    <div class="v_box">
                                        <a href="javascript:show_vcode('imgVcode')" name="change_code_img" tabindex="5">
                                            <img alt="code..." name="randImage" id="randImage2" src="image.jsp" onclick="reload()"></a>看不清?<a href="javascript:reload()" class="changepic" tabindex="6">换张图</a>
                                    </div>
                                </td>
                            </tr>
							<script>
							          	$("#randImage").click(function(){
						        			$(this).attr("src","image.jsp");
						        		})
						          		$(".changepic").click(function(){
						          			$("#randImage").attr("src","image.jsp");
						          		})	
						          		
	                             		$(":input[type='text']").focus(function(){ 
	                             			$(this).siblings(".cue").hide();
	                             			if($(this).siblings().hasClass("checkimg")==false){
	                             			$(this).siblings(".warn").show();
	                             			}else $(this).siblings(".warn").hide();
	                             		})
	                             		$(":input[type='text']").blur(function(){ 
	                             			$(this).siblings(".warn").hide();
	                             			if($(this).siblings().hasClass("checkimg")==false){
	                                 			$(this).siblings(".cue").show();
	                                 		}else $(this).siblings(".cue").hide();
	                             		})
						     </script>
                            <tr>
                                <td class="t">
                                    &nbsp;
                                </td>
                                <td>
                                    <a id="savePsw" class="btn btn-success btn-lg l"  tabindex="7" onclick="check();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;保存密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                    <span id="spn_agreement_wrong" class="cue" style="display:none;margin-left:2px"></span>
                                </td>
                            </tr>
                        </tbody>
		           </table>
				</div>
				<!--table2结束-->
				<!--table3-->
				<div id="table3" style="display:none;">
				<div class="progress p_3"></div>
					<div class="success">
                		<i class="fa fa-check-circle fa-5x maingreen"></i>您的新密码已设置成功！
                	</div>
                	
                	<div class="todo">
                		您可以<a href="login.jsp" class="btn btn_success">立即登录</a>或者去<a href="index.jsp">首页逛逛&nbsp;&gt;&gt;</a>
                	</div>
				</div>
				<!-- table3结束 -->
			</div>
			</div>
		</div>
	</div>
</div>

  <%@include file="footer.jsp" %>
</body>

<script type="text/javascript">
	
	$("#nextBtn").click(function(){
		if (checkname() && checkVcode() && checkcode()) {
			$("#table1").remove();
			$("#table2").show();
		}else {
            $("#spn_agreement_wrong").html("请按照提示输入信息").show();
            return false;
        }
	})
	
	$("#savePsw").click(function(){
		if (password_check() && repassword_check() && checkcode()) {
				//uspassword1,uspassword2
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
		                        	$("#table2").remove();
		                			$("#table3").show();
		                        },
		                        error: function(data) {
		                        	$("#spn_agreement_wrong").html("服务器无法响应，请稍后再试!").show();
		                         }
		                    });
	            }
				}
		}else {
            $("#spn_agreement_wrong").html("请按照提示输入信息").show();
            return false;
        }
	})
	
</script>

</html>


