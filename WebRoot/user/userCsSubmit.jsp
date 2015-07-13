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
	<title>充电站分享</title>
	    <!-- Bootstrap -->
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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=r6bfCVxPZTpoKGGNthyuupYh"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
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
	<style type="text/css">
		.submitInfo{
			border: 1px solid #7f9db9;
			padding:20px;
			margin-bottom:20px
		}
		
		.submitInfo th{ 
			font-size: 16px;
			width: 275px;
			padding-right: 10px;
			text-align: right;
			vertical-align: top;
			color: #404040;
			padding-top: 15px;
			font-family: 'Microsoft YaHei';
		}
		.submitInfo input{
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
				<a href="../register.html" class="btn btn-success btn-lg"><span>注册</span></a>
				<a href="../login.jsp" class="btn btn-success btn-lg"><span>登录</span></a>
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
		<div class="nav-btn"><a href="../index.html">首页</a></div>
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
				<div id="user-card">
					<div class="maozi"></div>
					<div class="inners clearfix without-side">
						<div class="avatar-unit">
							<div class="img"><img src="../pic/user1.jpg"><img src="../pic/load2.gif" style=";" class="load">
								<div class="change-avatar">
									<a class="btn wbtn btn12"><span class="text">更换头像</span></a>
									<div style="position: absolute; opacity: 0.01; overflow: hidden;">
										<iframe src="javascript:'<html></html>'" frameborder="no" border="0" name="IFrame_i8i1vmjl" id="IFrame_i8i1vmjl" style="display: none;">
										</iframe>
										<input type="file" name="file" size="1" style="position: absolute; top: 0px; left: 0px; border: 0px;">
									</div>
								</div>
							</div>
							<div class="counts clearfix">
								<a href="/yclovezyw/followers/" rel="nofollow" class="followers">
								<div class="num">0</div><div class="sub">粉丝</div></a>
								<a href="/yclovezyw/following/" class="follows">
								<div class="num">1</div><div class="sub">关注</div></a>
							</div>
						</div>
						<div class="user-inf">
							<div class="head-line"><div class="name">碎步行</div></div>
							<ul class="introduction">
								<li><i class="fa fa-location-arrow"></i>
								<em>来自北京</em></li>
								<li><i class="fa fa-suitcase"></i><em>电动车爱好者</em></li>
							</ul>
							<div class="about clearfix">自从用了乐充，充电从此无忧</div>
						</div>
						<script type="text/javascript">
						$(function(){ 
							 $(".user-inf .head-line .name").html(STATICINFO.USERINFO.name);
						})
						</script>
						<div class="bindings"> 
							<div class="fast-item">
									<a href="userInfMsg.jsp" class="btn">
											<div class="img"><i class="fa fa-calendar fa-3x"></i></div>消息提醒
									</a>
									<a href="userInfOrd.jsp" class="btn">
											<div class="img">	<i class="fa fa-shopping-cart fa-3x"></i></div>预约订单
									</a>
									<a href="" class="btn">
											<div class="img"><i class="fa fa-desktop fa-3x"></i></div>最新活动
									</a>
									<a href="" class="btn">
											<div class="img"><i class="fa fa-credit-card fa-3x"></i></div>我的收藏
									</a>
									
									<a href="userCsSubmit.jsp" class="btn">
											<div class="img"><i class="fa fa-comments fa-3x"></i></div>充电站分享
									</a>
									<a href="" class="btn without-side">
											<div class="img"><i class="fa fa-info-circle fa-3x"></i></div>更新个人资料
									</a>
							</div>
							<div class="message">
								<ul class="clearfix">
									<li><i class="fa fa-clock-o"></i>已预约时间：
									<span>80</span>小时
									</li>
									<li><i class="fa fa-question-circle"></i>充电地址分享：
									<span>0</span>条
									</li>
									<li><i class="fa fa-pencil"></i>金币：
									<span>80</span>枚
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="user-menu">
						
						<div class="btn-group l">
							<a href="" class="dropdown-toggle  tab" data-toggle="dropdown" aria-expanded="false">个人信息 <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
							    <li><a href="">基本信息</a></li>
							    <li><a href="">我的订单</a></li>
							    <li><a href="">账户金额</a></li>
							    <li><a href="">充值提现</a></li>
							    <li><a href="">积分</a></li>
							 </ul>
						</div>
						<div class="btn-group l">
							<a href="" class="dropdown-toggle  tab" data-toggle="dropdown" aria-expanded="false">客户服务 <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
							    <li><a href="">投诉</a></li>
							    <li><a href="">申诉</a></li>
							    <li><a href="">消息</a></li>
							    <li><a href="">评价</a></li>
							 </ul>
						</div>
						
					</div>
				</div>
				<div id="chargemessage">
					<div class="title">充电站分享</div>
					<div class="inf">
						<h3>第一步：请在地图中拾取您要分享的充电站地址</h3>
						<br>
						<div class="map-container">
							<div class="map" id="r-map" style="min-width:768px;height:500px;margin:0 auto;">
						</div>
						<h3>第二步：请填入充电站详细信息</h3>
						<div class="submitInfo">
							<table>
							<tbody><tr><th>地址：</th><td><input name="CSAddr" maxlength="50" placeholder="请填入充电站地址"></td><td><a><i class="icon-map-marker icon-small btn pickPositon" style="float:left;border:1px solid #000">重新拾取</a></td></tr>
								<tr><th>快充数量：</th><td><input  name="CSFast" maxlength="50" placeholder="请填入数字"/></td></tr>
								<tr><th>慢充数量：</th><td><input  name="CSSlow" maxlength="50" placeholder="请填入数字"/></td></tr>
								<tr><th>运营商：</th><td><select value="" name="OperatorID"><option>普天</option><option>国家电网</option><option>特斯拉</option><option>特锐德</option><option>富电科技</option><option>其他</option></select> </td></tr>
								<tr><th>对外状态：</th><td><select value="" name="CSPub"><option>公用</option><option>专用</option><option>待核实</option></select></td></tr>
								<tr><th>运营状态：</th><td><select value="" name="CSState"><option>运营中</option><option>未运营</option><option>待核实</option></select></td></tr>
								<tr><th>停车费用：</th><td><input name="ParkFeeDay" maxlength="50" placeholder="请填入数字"/></td></tr>
								<tr><th>电话:</th><td><input  name="CSPhone" maxlength="50" placeholder="请填入充电站联系电话"/></td></tr>
								<tr><th>备注:</th><td><input  name="CSNotes" maxlength="50" placeholder="请填入其他充电站相关信息"/></td></tr>
								<tr><td></td><td><a class="btn btn-success btn-sm" id="csInfSubmit" style="width:200px">提交</a></td></tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				

		    </div>
		</div>
		<footer>
			<div class="company-footer nav-green">
				<div class="footer-content">
					<div class="footer-content-text">
						<img src="../pic/footer-telephone-icon.png" alt="phone">
						<p>
							
							<span class="contents">Tel:123456789123</span>
						</p>
					</div>
					<div class="footer-content-text">
						<img src="../pic/footer-smartphone-icon.png" alt="smartphone">
						<p>
							
							<span class="contents">Mobile:123456789123</span>
						</p>
					</div>
					<div class="footer-content-text">
						<img src="../pic/footer-mail-icon.png" alt="mail">
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
		</footer>
		
	</div>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="../js/bootstrap.min.js"></script>

    <script type="text/javascript">
	    $(document).ready(function(){
	        map = new BMap.Map("r-map");    // 创建Map实例
	    	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
	    	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	    	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	    	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	    	
	    	
	    	map.addEventListener("click",addMarker);  
	    	geoc = new BMap.Geocoder();    
	    	map.addEventListener("click", function(e){        
	    		var pt = e.point;
	    		geoc.getLocation(pt, function(rs){
	    			var addComp = rs.addressComponents;
	    			$("[name='CSAddr']").val(addComp.province +  addComp.city  + addComp.district  + addComp.street + addComp.streetNumber);
	    		});        
	    	});
	    })
	    function posToAddr(point){
	    	var geoc = new BMap.Geocoder();      
	    	var pt = point;
	    	geoc.getLocation(pt, function(rs){
	    			var addComp = rs.addressComponents;
	    			$("[name='CSAddr']").val(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
	    	});   
	    } 
	    function addMarker(e){
	    	  map.clearOverlays();
			  var point = new BMap.Point(e.point.lng, e.point.lat);
			  var marker = new BMap.Marker(point);
			  map.addOverlay(marker);
			  marker.enableDragging();
			  marker.addEventListener("dragend", function(e){   
				  var pt = e.point;
		    		geoc.getLocation(pt, function(rs){
		    			var addComp = rs.addressComponents;
		    			$("[name='CSAddr']").val(addComp.province +  addComp.city  + addComp.district  + addComp.street + addComp.streetNumber);
		    		}); 
              });  	
		}
    	$("#csInfSubmit").click(function(){
			alert("信息提交成功!  非常感谢您对本站的支持，工作人员稍后会审核您提交的信息，恭喜您获得50金币！")
		})
		
		
		$(".stopPick").click(function(){
			map.removeEventListener("click",addMarker);  
		})
		
		$('#myTab a').click(function (e) {
			e.preventDefault()
			$(this).tab('show')
		})
		
	</script>
</body>
</html>

