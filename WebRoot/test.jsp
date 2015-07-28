<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
   
	<script type="text/javascript" src="js/login.js"></script>
    <script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
 	<form class="registerform" method="post" action="demo/ajax_post.php">
            <table width="100%" style="table-layout:fixed;">
                <tr>
                    <td class="need" style="width:10px;">*</td>
                    <td style="width:70px;">昵称：</td>
                    <td style="width:280px;"><input type="text" value="" name="name" class="inputxt" datatype="s6-18" nullmsg="请输入您的昵称！" errormsg="昵称至少6个字符,最多18个字符！" /></td>
                    <td>
                    	<div class="Validform_checktip"></div>
                        <div class="info">昵称至少6个字符,最多18个字符<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
                    </td>
                </tr>
                <tr>
                    <td class="need" style="width:10px;">*</td>
                    <td style="width:70px;">密码：</td>
                    <td style="width:210px;">
                        <input type="password" value="" name="password" class="inputxt" plugin="passwordStrength"  datatype="*6-18" nullmsg="请输入密码！" errormsg="密码至少6个字符,最多18个字符！" />
                    </td>
                    <td>
                        <div class="Validform_checktip"></div>
                        <div class="passwordStrength" style="display:none;"><b>密码强度：</b> <span>弱</span><span>中</span><span class="last">强</span></div>
                        <div class="info">密码至少6个字符,最多18个字符<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
                    </td>
                </tr>
                <tr>
                    <td class="need">*</td>
                    <td>确认密码：</td>
                    <td><input type="password" value="" name="repassword" class="inputxt" recheck="password"  datatype="*6-18" nullmsg="请确认密码！" errormsg="两次输入的密码不一致！" /></td>
                    <td>
                    	<div class="Validform_checktip"></div>
                    	<div class="info">请确认您的密码<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
                    </td>
                </tr>
                <tr>
                    <td class="need">*</td>
                    <td>移动电话：</td>
                    <td><input type="text" value="" name="tel" class="inputxt" datatype="m" nullmsg="请输入您的手机号码！" errormsg="请输入您的手机号码！"  /></td>
                    <td>
                    	<div class="Validform_checktip"></div>
                        <div class="info">请输入您的手机号码<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
                    </td>
                </tr>
                <tr>
                    <td class="need">*</td>
                    <td>所在城市：</td>
                    <td><select name="province" datatype="*" nullmsg="请选择所在城市！" errormsg="请选择所在城市！" style="width:266px;"><option value="">请选择城市</option><option value="1">瑞金市</option></select></td>
                    <td>
                    	<div class="Validform_checktip"></div>
                        <div class="info">请选择您所在的城市<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
                    </td>
                </tr>
                <tr>
                    <td class="need">*</td>
                    <td>性别：</td>
                    <td><input type="radio" value="1" name="gender" id="male" class="pr1" datatype="*" nullmsg="请选择性别！" errormsg="请选择性别！" /><label for="male">男</label> <input type="radio" value="2" name="gender" id="female" class="pr1" /><label for="female">女</label></td>
                    <td>
                    	<div class="Validform_checktip"></div>
                        <div class="info">请告诉我们您的性别<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div>
                    </td>
                </tr>
                
                <tr>
                    <td class="need"></td>
                    <td></td>
                    <td colspan="2" style="padding:10px 0 18px 0;">
                        <input type="submit" value="提 交" /> <input type="reset" value="重 置" />
                    </td>
                </tr>
            </table>
        </form>

  </body>
</html>

