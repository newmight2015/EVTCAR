<%@ page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册</title>
<link href="css/register.css" rel="stylesheet" type="text/css" />
<link href="css/evtcar.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/register_121015.js"></script>
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
		<h3>注册新用户</h3>
		<span>带*号内容必填</span> 
	</div>
	<div class="body">
	
	<form  name="form1" method="post" action="dealRegister.do">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tbody>
            				<tr>
                                <td class="t">
                                    <span class="important">*</span>用户名：
                                </td>
                                <td class="z_index2">
                                    <input type="text"  name="username" class="text" autocomplete="off" maxlength="12" tabindex="1" onblur="checkname();" onchange="checkname();">
                                    <span style="display:none" class="warn">请填入您的用户名，此为登录名</span>
                                    <span id="div1" style="display: none;" class="cue"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="t">
                                  <span class="important">*</span>邮箱：
                                </td>
                                <td class="z_index2">
                                    <input type="text"  name="email" class="text" autocomplete="off" maxlength="40"  tabindex="1" value="" style="border-color: rgb(127, 157, 185);" onblur="checkemail();">
                                    <span style="display:none" class="warn">邮箱用于接收信息</span>
                                    <span id="div2" style="display: none;" class="cue"></span>
                                </td>
                            </tr>
            				<tr>
                                <td class="t">
                                    <span class="important">*</span>手机：
                                </td>
                                <td class="z_index2">
                                    <input type="text" name="tel" class="text" autocomplete="off" maxlength="11" tabindex="1" value="" style="border-color: rgb(127, 157, 185);" onblur="checkPhoneNum();">
                                    <span  style="display:none" class="warn">用于接收信息，密码修改，获取积分奖励等服务</span>
                                    <span id="div3" style="display: none;" class="cue"></span>
                                </td>
                            </tr>
                            
                            
                            <!--ko if:type()=='phone'-->
                             <tr  id="imgCodeArea" style="display:none;">
                                <td class="t">
                                    <span class="important">*</span>图形验证码：
                                </td>
                                <td>
                                    <input type="text" name="txt_vcode" class="text" autocomplete="off" maxlength="4" tabindex="4" onblur="checkcode()">
                                    <span id="spn_vcode_ok" class="warn" style="display: none;">请输入下图中的验证码</span>
                                    <span id="spn_vcode_wrong" class="cue" style="display: none;"></span>
                                    <div class="v_box">
                                        <a href="javascript:show_vcode('imgVcode')" name="change_code_img" tabindex="5">
                                            <img alt="code..." name="randImage" id="randImage" src="image.jsp" onclick="reload()"></a>看不清?<a href="javascript:reload()" class="changepic" tabindex="6">换张图</a>
                                    </div>
									
                                </td>
                            </tr>
                            
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
                                	
                                    <a id="register" name="register" class="btn_login"  tabindex="7" onclick="check();"></a>
                                    <span id="spn_agreement_wrong" class="cue" style="display:none;margin-left:2px"></span>
                                </td>
                            </tr>
                        </tbody>
           </table>
		</div>
	</form>
</div>
</div>

  <%@include file="footer.jsp" %>
</body>

<script type="text/javascript">
	
            
            var timeoutrun;
            
            $(function () {
            	$(".warn").css("line-height","30px");

                if ($('#txt_name') != '') {
                    if($('#txt_name').attr('class') != 'text wrong' && $('#div_identity_verification').css("display") == "none") {
                        $('#txt_name').focus();
                    }
                }
                //$('#txt_username').blur(checkname());
				//$('#txt_email').blur(checkEmail());
				//$('#txt_phone').blur(checkPhoneNum());
				
                $('.btn_login,.btn_enter,.register_pop .close').hover(function () {
                    $(this).addClass('hover');
                }, function () {
                    $(this).removeClass('hover');
                })
                $('input.text').focusout(function () {
                    $(this).css('border-color', '#7F9DB9');
                })
                $("#txt_username").keyup(function(e){ check_email_input(e);});
                $("#select_emaildomain").children().click(function() {
                    $("#txt_username").val($(this).attr("title"));
                    $("#select_emaildomain  ").css("display","none");
                    selectdomin = 0;
                });
                $("#txt_username").blur(function(){
                    setTimeout(username_check,200);
                })
                $("#txt_password").keypress(function(e) {
                    check_capslock_open(e);
                });
                $('.register_pop .close').click(function () {
                    // 关闭弹层时清空注册页的各个输入框和提示信息

                    // 清空登录密码框和右边的对勾提示
                    $('#txt_password').val('');
                    $('#spn_password_ok').css({'display': 'none'});

                    // 清空确认密码输入框和右边的对勾提示
                    $('#txt_repassword').val('');
                    $('#spn_repassword_ok').css({'display': 'none'});

                    // 清空图形验证码输入框和右边的提示信息
                    $('#txt_vcode').val('');
                    $('#spn_vcode_ok').attr('class','warn');
                    $('#spn_vcode_wrong').css({'display': 'none'});

                    // 隐藏弹层
                    $(this).parent().hide();
                    $('.mask').hide();

                    // 刷新注册页的图形验证码
                    show_vcode('imgVcode');
                });

                var bodyHeight = $('body').height();
                var screenHeight = window.screen.availHeight;

                if (bodyHeight >= screenHeight) {
                    $('.mask').css('height', bodyHeight);
                } else {
                    $('.mask').css('height', screenHeight);
                }
            });

            var miao=120;
            function changejishi(){
                if($('#div_identity_verification').length == 0){
                    return;
                }
                miao--;
                var fen,smiao;
                fen=parseInt(miao/60)
                smiao=miao-(fen*60);
                var fenstr='';
                if(fen>0){
                    fenstr=fen+'分';
                }
                if(miao>0){
                    $('#ajishi').hide();
                    $('#jishi').css({ 'display': '' });
                    $('#jishi').html(fenstr+smiao+'秒后重新获取');
                    clearInterval(timeoutrun);
                    timeoutrun=setTimeout(changejishi,1000);
                }else{
                    $('#jishi').hide();
                    $('#ajishi').css({ 'display': '' });
                    $('#ajishi').unbind().bind("click",function(){return RenSendSMS(5);});
                    $('#p_pop_mobliephone_ok').html('');
                }
            }

            function RenSendSMS(vcode_type){
                var username = $('#txt_username').val();
                var custid = 0;
                var mobile_phone = $.trim(username);
                var verify_type = vcode_type;
                $.ajax({
                    type: 'POST',
                    url: 'p/send_mobile_vcode.php',
                    data: 'custid=' + custid + '&mobile_phone=' + mobile_phone + '&verify_type=' + verify_type,
                    async: false,
                    success: function (flg) {
                        if(flg == "0") {
                            miao=120;
                            $('#p_pop_mobliephone_ok').html(msg[18]);
                            changejishi();
                        }else if (flg == "-2") {
                            // 当天发送短信验证码的次数超过了规定的最大次数
                            $('#p_pop_mobliephone_ok').hide();
                            $('#p_pop_mobliephone_wrong').html(msg[4]);
                            $('#p_pop_mobliephone_wrong').css({ 'display': '' });
                            $('#ajishi').hide();
                            $('#jishi').html(msg[21]);
                            $('#jishi').css({ 'display': '' });
                            return;
                        }else if(flg == "-4" || flg == "-5" || flg == "-7" || flg == "-8") {
                            $('#p_pop_mobliephone_ok').hide();
                            $('#p_pop_mobliephone_wrong').html(msg[19]);
                            $('#p_pop_mobliephone_wrong').css({ 'display': '' });
                            $('#ajishi').hide();
                            $('#jishi').html(msg[21]);
                            $('#jishi').css({ 'display': '' });
                            return;
                        }else {
                            $('#p_pop_mobliephone_ok').hide();
                            $('#p_pop_mobliephone_wrong').html(msg[17]);
                            $('#p_pop_mobliephone_wrong').css({ 'display': '' });
                            $('#ajishi').hide();
                            $('#jishi').html(msg[21]);
                            $('#jishi').css({ 'display': '' });
                            return;
                        }
                    }
                });
            }

            timeoutrun=setTimeout(changejishi,1000);

            var google_tag_params = { prodid: '', pagetype: '', pname: '', pcat: '', dangdangprice: '', marketprice: '', discountprice: '', promotionprice: '', ordervalue: '', pbrand: '', author: '', publisher: '', login: 'regpage' };
        

</script>

</html>


