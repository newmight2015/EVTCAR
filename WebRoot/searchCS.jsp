<%@ page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit">
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
<script type="text/javascript">
  var dddd = [
               {
                   "CSID": "1000001", 
                   "CPID": "1", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.5"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "2", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 1, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.3"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "3", 
                   "CPType": 1,			//0为快充，1为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.8"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 1, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 1, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 1, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 1, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 0, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
               {
                   "CSID": "1000001", 
                   "CPID": "4", 
                   "CPType": 1,			//1为快充，2为慢充 
                   "CPState": 1, 
                   "CPChargeStartTime": "2015-12-11 11:00:01", 
                   "CPChargeEndTime": "2015-12-11 11:00:01", 
                   "CPChargeValue": "0.4"
               },
           ]
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
<%
 if ((String)request.getAttribute("message")=="true") {
 %>
 <script>
 alert("操作成功");
 </script>
 <%
 }
 %>

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
        				<div class="c-total"></div>
        				<div class="star-rating"></div>        				
        				<div class="c-num"></div>
        			</div>
        			<div class="item fig-show">
        				<p class="list">
        					<span>5分</span>
        					<span class="o-bg">
	        					<span class="n-bg" id="p5-bg" style="width: 57px;">
	        						<span class="p-num" id="p5"></span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>4分</span>
        					<span class="o-bg">
	        					<span class="n-bg" id="p4-bg" style="width: 57px;">
	        						<span class="p-num" id="p4"></span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>3分</span>
        					<span class="o-bg">
	        					<span class="n-bg" id="p3-bg" style="width: 57px;">
	        						<span class="p-num" id="p3"></span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>2分</span>
        					<span class="o-bg">
	        					<span class="n-bg" id="p2-bg" style="width: 57px;">
	        						<span class="p-num" id="p2"></span>
	        					</span>
        					</span>
        				</p>
        				<p class="list">
        					<span>1分</span>
        					<span class="o-bg">
	        					<span class="n-bg" id="p1-bg" style="width: 57px;">
	        						<span class="p-num" id="p1"></span>
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
	            <form  method="post" action="dealMessage">
	                <input name="act" id="act" value="comment" style="display: none;">
	                <input name="csid"  id="csidv"  value="" style="display: none;">
	        		<textarea rows="3" cols="20" maxlength="100" class="comment" id="comment" name="comment" placeholder="在此输入您的简短评论，不得超过100字"></textarea>
	        		<br><span>服务、基础设施评星 :</span><div><div id="starcomment"></div><input type="text"  id="starsum" name="starsum" style="display: none;" value="5" /></div>
	        		<div class="r">
	        		<% if(usInf!=null){ %>
	        		<!-- <span >点评完毕?<input type="submit" class='btn btn-success btn-sm' value="提交"></input>  -->
	        		<span>点评完毕? <a id="makeComment" class='btn btn-success btn-sm'>提交</a>
	        		<%}else{ %>
	        		<span >登录后可点评。<a href="login.jsp" >点此登录</a>
	        		<%} %>
	        		</span></div>
	            </form>
	        </div>
	        
	       <div class="commentinfo" >
	       		<ul class="cminfo"></ul>
	       </div>
        	
        	<ul class="pagination r pagination-sm">
			  <li><a href="#">&laquo;</a></li>
			  <li><a href="#">1</a></li>
			  <li><a href="#">2</a></li>
			  <li><a href="#">3</a></li>
			  <li><a href="#">4</a></li>
			  <li><a href="#">5</a></li>
			  <li><a href="#">&raquo;</a></li>
			</ul>
			<br>
			<br>
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
      <!-- 充电站基本信息 -->
      	 <div  class="info"></div>
      <!-- 充电桩基本信息 -->
      	 <div class=" iconarea">
      	 		<div class="unuse"></div>
      	 		<div class="use"></div>		
      	 </div>

        <div class="appoint">
        	<div class="errormsg"></div>
        	<div class="box">
        		<div class="text">充电桩类型</div>
        		<div class="cptype clearfix">
        			<input type="checkbox" name="cp" value="1" /><span>快充</span>
	        		<input type="checkbox" name="cp" value="2" /><span>慢充</span>
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
<%@include file="head.jsp" %>
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn "><a href="index.jsp">首页</a></div>
		<div class="nav-btn active"><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn "><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="aboutUs.jsp">关于我们</a></div>
	</div>
</div>
</header>
<!--顶部导航栏结束 -->
<div class="map-container">
<div class="map" id="r-map" style="min-width:1024px;height:600px;">
</div>
<div class="tishi"><img alt="图标说明" src="pic/tishi.png"></div>
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
				<dd class="select-all selected" data-value="none"><a href="#">全部</a></dd>
				<dd data-value="001"><a href="#">国家电网</a></dd>
				<dd data-value="002"><a href="#">普天</a></dd>
				<dd data-value="003"><a href="#">特锐德</a></dd>
				<dd data-value="004"><a href="#">富电科技</a></dd>
				<dd data-value="005"><a href="#">特斯拉</a></dd>
				<dd data-value="006"><a href="#">比亚迪</a></dd>
				<dd data-value="007"><a href="#">埃士</a></dd>
				<dd data-value="008"><a href="#">腾势</a></dd>
				<dd data-value="009"><a href="#">宝马</a></dd>
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
				<dd class="select-all selected" data-value="none"><a href="#">全部</a></dd>
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
				<dd><input type="text" placeholder="请输入您的位置" id="suggestId"><input id="cityname" type="text" style="display:none;" ></dd>
				<div class="search btn btn-default" id="search"><a href="#">查询</a></div>
			</dl>
		</li>
		<div class="search-toggle"><a href="#">收起</a></div>
	</ul>
</div>

<!-- Generated markup by the plugin -->
<div class="tooltip top" role="tooltip" id="tooltip">
  <div class="tooltip-arrow"></div>
  <div class="tooltip-inner">
    Some tooltip text!
  </div>
</div>

<div id="searchResultPanel">
	<div class="search-box">
		<div style="display: inline-block;position: absolute;top: 15px;left: 20px;">您的位置：</div>
		<div class="search-head"><span style="display: inline-block;margin-left: 70px;">北京交通大学</span></br>
			<div class="search-tip">我们为您推荐的充电站:</div>
		</div>
		<!--以下显示推荐充电桩-->
			<div class="resultAll">
			</div>
			
		</div>
	</div>
</div>


<%@include file="footer.jsp" %>

<!--下面是左侧导航栏的代码-->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="js/mapcontrol.js" type="text/javascript"></script>
<script src="js/search.js"></script> 
<script src="js/showInf.js" type="text/javascript"></script>
<script src="js/jquery.raty.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
	
	function myFun(result){
	    var cityName = result.name;
	    //alert(""+cityName);
	    $("#cityname").val(cityName);
	    map.setCenter(cityName);   			
	    map.setCurrentCity(cityName);          // 设置地图显示的城市 此项是必须设置的
	    //alert(cityName);
	    //change_city_val(cityName);
	}
	var myCity = new BMap.LocalCity();
	myCity.get(myFun);  
	productNum=0;
	VehData = {};
	tempPt=[];
	$(".orderUnuse").bind("click",function(){alert("此功能正在开发中，敬请期待！")})
	$("#clearOverlays").bind("click",function(){map.clearOverlays;})
	$(".iconarea .mesh span").bind("mouseover",function(){
		$(this).tooltip('show')
	});
	
})

$(function(){
	
	 $('[data-toggle="tooltip"]').tooltip()
	$("[name='start-date']").val(CurentDateTime(0));
	$("[name='start-time']").val(CurentTime());
	$("[name='stop-date']").val(CurentDateTime(1));
	$("[name='stop-time']").val(CurentTime());
	//$("#csid").val(CsAllData[i].CSId);
	$("#starcomment").raty({
		  score: function() {
			    return 5;//使显示的评星默认为5星；
			  }
			});
	$(".commentbtn a").click(function(){ 
		$(".commentcontent").show();
	});
	$("#starcomment").click(function(){
		//confirm("评价");
		var starsum=$('#starcomment').raty('getScore');
		$("#starsum").val(starsum);
		//alert(CsAllData[i].CSId);
	});
})
function CurentDateTime(i)
{ 
    var now = new Date();
    var year = now.getFullYear();    //年
    var month = now.getMonth()+1;     //月
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
