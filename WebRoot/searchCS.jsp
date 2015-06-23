<%@ page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>充电导航</title>

<link href="css/evtcar.css" rel="stylesheet">
<link href="css/search.css" rel="stylesheet">
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/evtcar.css" rel="stylesheet">
<link rel="stylesheet" href="lib/jquery.raty.css">
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=r6bfCVxPZTpoKGGNthyuupYh"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>

<script src="js/WdatePicker.js" type="text/javascript"></script>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.min.js"></script> 
<script src="js/staticinfo.js" type="text/javascript"></script>
<link rel="stylesheet" href="lib/jquery.raty.js">
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

<script src="js/UserCheck.js"></script> 
<script >
	<%
		HttpSession sess = request.getSession();
		usInformation usInf = (usInformation)sess.getAttribute("usInf");
	%>
	window.MAINURL = "<%=basePath%>";
	STATICINFO.USERINFO.URL = "<%=basePath%>";
	STATICINFO.USERINFO.name = "<%= usInf==null ? "" : usInf.getUsId()%>";
	
</script>

<style>
body {
	font-size: 14px;
	line-height: 1.428571429;
	color: #333333;
}
.map{

	width:100%;
	height:500px;
}
</style>

</head>

<body>
<!-- Modal -->
<div class="modal fade" id="csintro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title text"><strong>充电站详细信息</strong></h4>
      </div>
      <div class="modal-body">
        <div class="info"></div>
         <div class="content">
        	<hr>
        	<div class="op-bar">
        		<div class="op-total">*评价是用户对本充电站的服务及设施点评</div>
        		<div class="op-statis">
        			<div class="item font-show">
        				<p class="c-total">5.0</p>
        				<p><span class="star-rating">
        					<span class="yellowstar50 star-icon"></span>
        					</span>
        				</p>
        				<p class="c-num">共有<b>100</b>人评价</p>
        			</div>
        			<div class="item fig-show">
        				<p class="list">
        					<span>5分</span>
        					<span class="o-bg">
	        					<span class="n-bg" style="width: 57px;">
	        						<span class="p-num">0人</span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>4分</span>
        					<span class="o-bg">
	        					<span class="n-bg" style="width: 57px;">
	        						<span class="p-num">0人</span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>3分</span>
        					<span class="o-bg">
	        					<span class="n-bg" style="width: 57px;">
	        						<span class="p-num">0人</span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>2分</span>
        					<span class="o-bg">
	        					<span class="n-bg" style="width: 57px;">
	        						<span class="p-num">0人</span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>1分</span>
        					<span class="o-bg">
	        					<span class="n-bg" style="width: 57px;">
	        						<span class="p-num">0人</span>
	        					</span>
        					</span>
        				</p>
        			</div>
        		</div>
        		
        	</div>
        	<div class="commentbtn">
        			<span class="r ">想说点什么？</span>
	        </div>
	        <div class="clearfix commentcontent">
	        		<textarea rows="3" cols="20" maxlength="100" class="comment" placeholder="在此输入您的简短评论，不得超过100字"></textarea>
	        		<br><span>服务、基础设施评星 :</span><div id="starcomment"></div>
	        		<div class="r"><span >点评完毕?<a class='btn btn-success btn-sm'>提交</a></span></div>
	        </div>
        	<ul>
        		
        		<li>
        			<div class="comment-body">
        			<span class="star-rating">
        				<span class="syellowstar50 star-icon"></span>
        			</span>
        			<span class="name">ssk***2</span>
        			<span class="date">2015-06-22</span>
        			<div class="commentdetail">设备完好，下次再来</div>
        			</div>
        		</li>
        		
        		<li>
        			<div class="comment-body">
        			<span class="star-rating">
        				<span class="syellowstar50 star-icon"></span>
        			</span>
        			<span class="name">速度***是 </span>
        			<span class="date">2015-06-22</span>
        			<div class="commentdetail">快充数量有点少，平时可能排队</div>
        			</div>
        		</li>
        	</ul>
        	<ul class="pagination r pagination-sm">
			  <li><a href="#">&laquo;</a></li>
			  <li><a href="#">1</a></li>
			  <li><a href="#">2</a></li>
			  <li><a href="#">3</a></li>
			  <li><a href="#">4</a></li>
			  <li><a href="#">5</a></li>
			  <li><a href="#">&raquo;</a></li>
			</ul>
        </div>
     </div>
      
    </div>
  </div>
</div>

<!-- Modal2  预约信息显示-->
<div class="modal fade" id="csorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title text"><strong>用户充电预约</strong></h4>
      </div>
      <div class="modal-body">
      	 <div  class="info">
      	 	
      	 </div>
        <div class="appoint">
        	<div class="errormsg"></div>
        	<div class="box">
        		<div class="text">充电桩类型</div>
        		<div class="cptype clearfix">
        			<input type="checkbox" name="cp" value="快充" /><span>快充</span>
	        		<input type="checkbox" name="cp" value="慢充" /><span>慢充</span>
	        		<input type="checkbox" name="cp" value="快慢充" /><span>快慢充</span>
        		</div>
        		
        	</div>

            <div class="box">
              <div class="text">开始时间</div>
              <div class="time clearfix">
              <input name="start-date" type="text" class="cal" onfocus="WdatePicker()" >
              <input name="start-time" type="text" class="time" onfocus="WdatePicker({dateFmt:'HH:mm:ss'})"/>
              </div>
            </div>
            <div class="box">
              <div class="text">结束时间</div>
              <div class="time clearfix">
              <input name="stop-date" type="text" class="cal" onfocus="WdatePicker()">
              <input name="stop-time" type="text" class="time" onfocus="WdatePicker({dateFmt:'HH:mm:ss'})"/>
              </div>
            </div>
            <div class="orderbutton">
                <a class="btn btn-success btn-lg"  id = "makeOrder">提交预约</a>
            </div>
        </div>
     </div>
      
    </div>
  </div>
</div>
<!--<div></div> -->

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
			<script>
				if(STATICINFO.USERINFO.name!=""){
					$(".loader").html("<span style='color:white'>Hi,"+
							STATICINFO.USERINFO.name+"欢迎回到车快充!  </span><a href='logout.jsp' style='color:white'>退出登录</a>&nbsp;&nbsp;<a href='register.html'>免费注册</a>")
				}
			</script>
		
		</div>
	</div>
</div>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn"><a href="index.html">首页</a></div>
		<div class="nav-btn active"><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="#">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->
<div class="map-container">
<div class="map" id="r-map" style="min-width:1024px;height:600px;">
</div>
<div class="map-messagebox" style="display:none">
	<div class="message">
		请输入您的详细位置
	</div>
</div>
<div class="map-search">
	<ul class="select">
		<div class="select-section">
		<li class="select-list">
			<dl id="select1" data-csOperator="none">
				<dt>服务商：</dt>
				<dd class="select-all selected" data-value="all"><a href="#">全部</a></dd>
				<dd data-value="001"><a href="#">国家电网</a></dd>
				<dd data-value="002"><a href="#">普天</a></dd>
				<dd data-value="003"><a href="#">特锐德</a></dd>
				<dd data-value="004"><a href="#">富电科技</a></dd>
				<dd data-value="005"><a href="#">特斯拉</a></dd>
			</dl>
		</li>
		<li class="select-list">
			<dl id="select2" data-csRange="none">
				<dt>范围：</dt>
				<dd class="select-all selected"  data-value="5"><a href="#">0~5公里</a></dd>
				<dd data-value="10"><a href="#">0~10公里</a></dd>
				<dd data-value="20"><a href="#">0~20公里</a></dd>
				<dd data-value="30"><a href="#">0~30公里</a></dd>
				<dd data-value="40"><a href="#">0~40公里</a></dd>
			</dl>
		</li>
		<li class="select-list">
			<dl id="select3" data-csParkFee="none">
				<dt>停车费：</dt>
				<dd class="select-all selected" data-value="all"><a href="#">全部</a></dd>
				<dd data-value="0"><a href="#">免费</a></dd>
				<dd data-value="5"><a href="#">0~5元/h</a></dd>
				<dd data-value="10"><a href="#">0~10元/h</a></dd>
				<dd data-value="100"><a href="#">>10元/h</a></dd>
			</dl>
		</li>
		
		</div>
		<li class="select-result">
			<dl>
				<dt>已选条件：</dt>
				<dd class="select-no">暂时没有选择过滤条件</dd>
				
			</dl>
			
		</li>
		<li class="search-input clearfix">
			<dl>
				<dt>您的位置：</dt>
				<dd><input type="text" placeholder="请输入您的位置" id="suggestId"></dd>
				<div class="search btn btn-default" id="search"><a href="#">查询</a></div>
			</dl>
		</li>
		<div class="search-toggle"><a href="#">收起</a></div>
	</ul>
</div>


<div id="searchResultPanel">
	<div class="search-box">
		<div class="search-head">您的位置：<span>北京交通大学</span></br>
			<div class="search-tip">我们为您推荐的充电站:</div>
		</div>
		<!--以下显示推荐充电桩-->
			<div class="resultAll">
			</div>
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

<!--下面是左侧导航栏的代码-->
<script src="js/bootstrap.min.js"></script>
<script src="js/mapcontrol.js" type="text/javascript"></script>
<script src="js/search.js"></script> 
<script src="js/showInf.js" type="text/javascript"></script>
<script src="js/jquery.raty.js" type="text/javascript"></script>
<script>
$(function(){
	$("[name='start-date']").val(CurentDateTime(0)+"         今天");
	$("[name='start-time']").val(CurentTime());
	$("[name='stop-date']").val(CurentDateTime(1)+"         明天");
	$("[name='stop-time']").val(CurentTime());
	$("#starcomment").raty();
	$(".commentbtn a").click(function(){ 
		$(".commentcontent").show();
	})
})

function CurentDateTime(i)
{ 
    var now = new Date();
    var year = now.getFullYear();    //年
    var month = now.getMonth();     //月
    var day = now.getDate()+i;        //日
    var clock = year + "-";
    if(month < 10)
        clock += "0";
    clock += month + "-";
    if(day < 10)
        clock += "0";
    clock += day;
    return(clock); 
}
function CurentTime()
{ 
    var now = new Date();
    var hh = now.getHours();            //时
    var mm = now.getMinutes();          //分
    var ss = now.getSeconds();           //秒
    var clock = hh + ":";
    if (mm < 10) clock += '0'; 
    clock += mm + ":"; 
    if (ss < 10) clock += '0'; 
    clock += ss; 
    return(clock); 
}
</script>
</body>
</html>
