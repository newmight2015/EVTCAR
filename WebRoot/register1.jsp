<%@ page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>欢迎注册</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="dns-prefetch" href="//ued.paixie.net">
<link rel="dns-prefetch" href="//img-cdn2.paixie.net">
<meta name="apple-mobile-web-app-capable" content="yes" />
<script type="text/javascript" src="js/UserCheck.js"></script>
<script type="text/javascript">
		<%
			HttpSession sess = request.getSession();
			usInformation usInf = (usInformation)sess.getAttribute("usInf");
		%>
		window.MAINURL = "<%=basePath%>";
</script>
<script>
	var imgonload =function(){};
	var urls = window.location.href.split("#");
	try{ if(/^url:.+/.test(urls[1])){window.location.href=urls[1].slice(4);}}catch(e){}
	var _hmt = _hmt || [];
	var PX_HELP_DATA=['','jdn6595s6ild7fqrao0emdut21',['paixie','register','index2'],'2015/07/19 17:07:02',0]; 
	var DOMIN = {MAIN:"http://www.paixie.net",HELP:"http://help.paixie.net",TUAN:"http://tuan.paixie.net",WAP:"http://wap.paixie.net",UNION:"http://union.weixiaodian.com",VIPSHOP:"http://go.paixie.net"};
	var DOMINS = {"main":"http:\/\/www.paixie.net","tuan":"http:\/\/tuan.paixie.net","help":"http:\/\/help.paixie.net","union":"http:\/\/union.weixiaodian.com","wap":"http:\/\/wap.paixie.net","touch":"http:\/\/m.paixie.net","vipshop":"http:\/\/go.paixie.net","ued":"http:\/\/ued.paixie.net"};
</script>
<link href="css/register.css" rel="stylesheet" type="text/css" />
<link href="css/evtcar.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="css/zip.paixie.register.index2.v510.css" type="text/css" />

<link href="css/register.css" rel="stylesheet" type="text/css" />
<link href="css/evtcar.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script> 
<script>
	var PAGE_MODE = '';
	var LOGINCALLBACK='';
	var URL='http://www.paixie.net/';
</script>

</head>
<body>

<div class="login-header login-header-">
	<a href="index.jsp" class="logo"></a><h1 class="yh">欢迎注册</h1>
</div>

<div class="login-content yh login-content-" id="js-login-content"><div class="register-area" data-init="register">
	<div style="display:none">
		<input type="text"/>
		<input type="password"/>
	</div>
		<div class="form">
		<div>
			<label class="yh">账户名：</label><div class="base-text" data-bind="css:{'base-text-error':usernameErrorTip}">
				<span>邮箱/手机号</span>
				<input data-bind="
					value:username,
					event:{
						keypress:keypress
					},
					hasFocus:usernameFocus" type="text" class="login-text yh"/>
				<a class="base-close"></a>
			</div><span data-bind="html:usernameInfo"><div class="v-text">&nbsp;</div></span>
		</div>
		<div>
			<label class="yh">设置密码：</label><div class="base-text" data-bind="css:{'base-text-error':passwordErrorTip}">
				<span></span>
				<input type="password" data-bind="
					value:password,
					event:{
						keypress:keypress
					},
					hasFocus:passwordFocus,valueUpdate:'keyup'" class="login-text yh"/>
				<a class="base-close"></a>
			</div><span class="passwordinfo" data-bind="
				html:passwordInfo
							"><div class="v-text">&nbsp;</div></span>
			<!--ko if:password_strength()-->
			<div class="password-strength ko-loading" data-bind="css:{'ko-loading':false}">
				<span data-bind="css:{now:password_strength()>=1}">弱</span>
				<span data-bind="css:{now:password_strength()>=2}">中</span>
				<span data-bind="css:{now:password_strength()>=3}" class="last">强</span>
			</div>
			<!--/ko-->
		</div>
		<div>
			<label class="yh">确认密码：</label><div class="base-text" data-bind="css:{'base-text-error':password2ErrorTip}">
				<span></span>
				<input type="password" data-bind="
					value:password2,
					event:{
						keypress:keypress
					},
					hasFocus:password2Focus" class="login-text yh"/>
				<a class="base-close"></a>
			</div><span data-bind="html:password2Info"><div class="v-text">&nbsp;</div></span>
		</div>
		<!--ko if:type()=='email'-->
		<div class="codearea ko-loading" data-bind="css:{'ko-loading':false}">
			<label class="yh">验证码：</label><div class="base-text base-text135" data-bind="css:{'base-text-error':imgcodeErrorTip}">
				<span></span>
				<input type="text" data-bind="
					value:imgcode,
					event:{
						keypress:keypress
					}" class="login-text yh"/>
				<a class="base-close"></a>
			</div><img src="image.jsp" width="66" height="35"/><a href="#" class="base-refresh"></a><span data-bind="html:imgcodeInfo"><div class="v-text">&nbsp;</div></span>
		</div>
		<!--/ko-->
		<!--ko if:type()=='phone'-->
		<div class="codearea ko-loading" data-bind="css:{'ko-loading':false}">
			<label class="yh">验证码：</label><div class="base-text base-text135" data-bind="css:{'base-text-error':phonecodeErrorTip}">
				<span>验证码</span>
				<input type="text" data-bind="
					value:phonecode,
					event:{
						keypress:keypress
					}" class="login-text yh"/>
				<a class="base-close"></a>
			</div><a class="input-button" data-bind="
					click:send_phone_code.send,
					css:{'input-button-disable':send_phone_code.disable},
					html:(send_phone_code.disable())?(send_phone_code.sending())?'正在发送...':send_phone_code.time()+'后重新获取':'获取短信验证码'
				">获取短信验证码</a><span data-bind="html:phonecodeInfo"><div class="v-text">&nbsp;</div></span>
		</div>
		<!--/ko-->
		<div class="agreement">
			<label>
				<input data-bind="checked:agreement" type="checkbox"/>
				我已阅读并同意
			</label>
			<a href="/servicepolicy.html" target="_blank">《拍鞋服务协议》</a>
		</div>
		<a class="blue-button yh f16" data-bind="
			click:register,
			event:{keypress:keypress},
			html:(registering())?'正在注册...':'立即注册',
			css:{'blue-button-disable':registering}
		">立即注册</a>
	</div>
	<div class="side">
		我已有车快充账户<br>
		现在就 <a href="login.jsp">立即登录</a>
	</div>
</div>
</div>
<br><br><br><br><br><br>
<%@include file="footer.jsp" %>

<script>
var mainDomin = '';
</script>
<div style="display:none;">
<script type="text/javascript"> 
</script>
<!--[if IE]>
<script>function RESIZE(){var className = document.body.className;if($(window).width()>=1200){document.body.className = className.replace(/body980/g,'');;}else{document.body.className = className +' body980';}};RESIZE();$(document).ready(function(e) {$(window).resize(RESIZE);});</script>
<![endif]-->
<script type="text/javascript" src="http://ued.paixie.net/zip.paixie.register.index2.v178482028.js"></script>

<!--Darwin Track System Ver2.0 Begin-->
<script type="text/javascript">
if (/sv/.test(document.cookie+window.location)) {
      var _rsClientId="403";
      var _rsStepId=0;
      var _rsIsSVL=false;
      var _rsDWLP=location.protocol.indexOf("https")>-1?"https:":"http:";
      var _rsDWDN="//sv.dmclick.cn/";
      var _rsDWURL = _rsDWLP+_rsDWDN+"trk.js";
      document.write(unescape("%3Cscript src='" + _rsDWURL + "' type='text/javascript'%3E%3C/script%3E"));
}
</script>
<!--Darwin Track System Ver2.0 End-->  
</div>
<script type="text/tcl" id="js-px-alarmclock-template">
<div class="px-alarmclock" id="px-alarmclock">
	<style>
	.px-alarmclock,
	.px-alarmclock-ok,
	.px-alarmclock-error,
	.px-alarmclock-info strong,
	.px-alarmclock .text,
	.px-alarmclock-act a,
	.px-alarmclock .button{ background:url(http://img-cdn2.paixie.net/sign_pic/20141021/alarmclock1.jpg) -980px -980px no-repeat;}
	.px-alarmclock{font-size:14px;color:#000;width:400px; height:330px;position:absolute;z-index:2001;left:50%;margin-left:-200px; background-position:left top;line-height:32px;}
	.px-alarmclock-ok{background-position:left -660px;width:400px; height:330px;}
	.px-alarmclock-error{background-position:left -330px;width:400px; height:330px;}
	.px-alarmclock p{margin:0;padding:0; min-height:53px;_height:53px;}
	.px-alarmclock p.ndis{ display:none}
	.px-alarmclock-info strong,
	.px-alarmclock .text{line-height:28px;height:28px;border:0px solid #d0d0d0;width:142px;padding:0 5px;}
	.px-alarmclock-info strong{ background-position:-0px -1020px}
	.px-alarmclock-info .text{ background-position:-0px -991px}
	.px-alarmclock .button{cursor:pointer;display:inline-block;vertical-align:middle;+margin-top:-11px; width:100px; height:29px; line-height:29px; color:#333333; background-position:-300px -991px; text-align:center; font-size:12px;}
	.px-alarmclock .anew{background-position:-0px -991px;}
	.px-alarmclock .ranew{background-position:-100px -991px;}
	.px-alarmclock .anewing{background-position:-200px -991px;}
	.px-alarmclock-info b{font-weight:normal;}
	.px-alarmclock-info strong{display:inline-block;position:relative;vertical-align:middle;}
	.px-alarmclock-info strong i{position:absolute;top:0;right:0;width:27px;height:27px;background-position:-76px -18px;}
	.px-alarmclock-info strong select{position:absolute;margin:0;top:0;left:0;width:152px;border:0;padding:0;height:27px;filter:alpha(opacity=1);-moz-opacity:0.01;opacity: 0.01;cursor:pointer;}
	.px-alarmclock del{text-decoration:none;display:block;line-height:15px;font-size:12px;padding-left:110px;color:#737373;padding-right:15px}
	.px-alarmclock del.error{color:red;}
	.px-alarmclock-title{ display:none}
	.px-alarmclock-close{height:71px;width:71px;position:absolute;top:0;right:0;cursor:pointer; background-image:none}
	.px-alarmclock-content{margin:81px 0 0 0;position:relative; height:171px;}
	.px-alarmclock-act{ padding:0 0 0 102px;height:53px;overflow:hidden;}
	.px-alarmclock-act a{display:block;cursor:pointer;height:23px; width:99px; height:40px; background-position:-102px -252px;}
	.px-alarmclock-act span{display:inline-block;height:53px; width:199px; background:#fff; margin-left:-40px}
	.px-alarmclock-info{position:relative; height:180px;}
	.px-alarmclock-info span{width:104px;display:inline-block;vertical-align:middle;text-align:right; color:#585858; line-height:28px; font-size:12px}
	.px-alarmclock-result{text-align:center;}
	.px-alarmclock-result i{display:block;margin:auto;width:132px;height:132px;background-position:0 -76px;}
	.px-alarmclock-result i.ok{background-position:-137px -76px;}
	.px-alarmclock-result b{font-size:16px;margin:9px 0 6px 0;display:inline-block;vertical-align:middle;}
	</style>
	<div class="px-alarmclock-title"><span id="js_px-alarmclock-title"></span></div>
	<a class="px-alarmclock-close js-close" title="关闭"></a>
	<div id="js-px-alarmclock-content">
		<div class="px-alarmclock-content">
			<div class="px-alarmclock-info">
				<p>
					<span>短信提醒时间：</span>
					<strong>
						<b>11月9号</b>
						<i></i>
						<select id="js-alarmclock-type">
							<option value="1">11月9号</option>
							<option value="2">11月10号</option>
							<option value="3">11月11号</option>
						</select>
					</strong>
					<del>&nbsp;</del>
				</p>
				<p>
					<span>手机号码：</span>
					<input maxlength="11" type="text" class="text" id="js-alarmclock-phone"/>
					<del id="js-alarmclock-phone-error">&nbsp;</del>
				</p>
				<p class="ndis">
					<span>验证码：</span>
					<input maxlength="6" type="text" class="text" id="js-alarmclock-code"/>
					<a class="button">获取验证码</a>
					<del id="js-alarmclock-code-error">&nbsp;</del>
				</p>
			</div>
		</div>
		<div class="px-alarmclock-act">
			<span></span>
			<a id="js-alarmclock-submit" title="确定"></a>
		</div>
	</div>
	<div id="js-px-alarmclock-result-ok" style="display:none;"><div class="px-alarmclock-ok"></div></div>
	<div id="js-px-alarmclock-result-error" style="display:none;"><div class="px-alarmclock-error"></div></div>
</div>
</script></body>
</html>

