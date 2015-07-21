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
    <script src="../js/mapcontrol.js" type="text/javascript"></script>
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
<%@include file="head.jsp" %>
<!--下面是中部导航栏的代码-->
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
								<tbody><tr><th>地址：</th><td><input id="csname" name="CSAddr" maxlength="50" placeholder="请填入充电站地址"></td><td><a><i class="icon-map-marker icon-small btn pickPositon" style="float:left;border:1px solid #000">重新拾取</a></td></tr>
									<tr style="display: none;"><th>lng：</th><td><input id="cslng" name="CSLng" maxlength="50"  /></td></tr>
									<tr style="display: none;"><th>lat：</th><td><input id="cslat" name="CSLat" maxlength="50"  /></td></tr>
									<tr><th>快充数量：</th><td><input id="csfast" name="CSFast" maxlength="50" placeholder="请填入数字"/></td></tr>
									<tr><th>慢充数量：</th><td><input id="cslow" name="CSSlow" maxlength="50" placeholder="请填入数字"/></td></tr>
									<tr><th>运营商：</th><td><select id="operator" value="" name="OperatorID"><option>普天</option><option>国家电网</option><option>特斯拉</option><option>特锐德</option><option>富电科技</option><option>比亚迪</option><option>其他</option></select> </td></tr>
									<tr><th>对外状态：</th><td><select id="cspub" value="" name="CSPub"><option>公用</option><option>专用</option><option>待核实</option></select></td></tr>
									<tr><th>运营状态：</th><td><select id="csstate" value="" name="CSState"><option>运营中</option><option>未运营</option><option>待核实</option></select></td></tr>
									<tr><th>停车费用：</th><td><input id="parkfee" name="ParkFeeDay" maxlength="50" placeholder="请填入数字"/></td></tr>
									<tr><th>电话:</th><td><input id="csphone" name="CSPhone" maxlength="50" placeholder="请填入充电站联系电话"/></td></tr>
									<tr><th>备注:</th><td><input id="csnotes" name="CSNotes" maxlength="50" placeholder="请填入其他充电站相关信息"/></td></tr>
									<tr><td></td><td><a class="btn btn-success btn-sm" id="csInfSubmit" style="width:200px">提交</a></td></tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
		    	</div>
			</div>
	<%@include file="footer.jsp" %>
	</div>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="../js/bootstrap.min.js"></script>

    <script type="text/javascript">
	    $(document).ready(function(){
	    	initalMap();
	    	map.addEventListener("click",addMarker);  
	    	geoc = new BMap.Geocoder();    
	    	map.addEventListener("click", function(e){        
	    		var pt = e.point;
	    		geoc.getLocation(pt, function(rs){
	    			var marker = new BMap.Marker(pt);
	    			var addComp = rs.addressComponents;
	    			var lng=pt.lng;
	    			var lat=pt.lat;
	    			//alert(""+lng+lat);
	    			var addr = addComp.province +  addComp.city  + addComp.district  + addComp.street + addComp.streetNumber
	    			$("[name='CSAddr']").val(addr);
	    			$("#cslng").val(lng);
	    			$("#cslat").val(lat);
	    			var opts = {
	    					  position : pt,    // 指定文本标注所在的地理位置
	    					  offset   : new BMap.Size(-60, -50)    //设置文本偏移量
	    					}
	    			var label = new BMap.Label(addr, opts);  // 创建文本标注对象
	    			label.setStyle({
	    							 color : "red",
	    							 fontSize : "12px",
	    							 height : "20px",
	    							 width:'auto',
	    							 lineHeight : "20px",
	    							 fontFamily:"微软雅黑"
	    						 });
	    			map.addOverlay(label); 
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
	    
	    function enableDragend(marker){
	    	marker.addEventListener("dragend", function(e){   
			    map.clearOverlays();
			    var pt = e.point;
	    		geoc.getLocation(pt, function(rs){
	    			var marker = new BMap.Marker(pt);
	    			var addComp = rs.addressComponents;
	    			var addr = addComp.province +  addComp.city  + addComp.district  + addComp.street + addComp.streetNumber
	    			$("[name='CSAddr']").val(addr);
	    			var opts = {
	    					  position : pt,    // 指定文本标注所在的地理位置
	    					  offset   : new BMap.Size(-60, -50)   //设置文本偏移量
	    					}
	    			var label = new BMap.Label(addr, opts);  // 创建文本标注对象
	    			label.setStyle({
	    							 color : "red",
	    							 fontSize : "12px",
	    							 height : "20px",
	    							 width:'auto',
	    							 lineHeight : "20px",
	    							 fontFamily:"微软雅黑"
	    						 });
	    			map.addOverlay(label); 
	    			map.addOverlay(marker);
	    			enableDragend(marker); 
	    		}); 
          });  	
	    }
	    function addMarker(e){
	    	  map.clearOverlays();
			  var point = new BMap.Point(e.point.lng, e.point.lat);
			  var marker = new BMap.Marker(point);
			  map.addOverlay(marker);
			  marker.enableDragging();
			  enableDragend(marker); 	
		}
    	$("#csInfSubmit").click(function(){
			//alert("信息提交成功!  非常感谢您对本站的支持，工作人员稍后会审核您提交的信息，恭喜您获得50金币！")
			//提交分享的地址
			//csname,csfast,cslow,operator,cspub,csstate,parkfee,csphone,csnotes,act
			USERCheck.checkOldOrder(function(isok,error){ 
				if(isok){ 
					var csname=$("#csname").val();
					var cslng=$("#cslng").val();
					var cslat=$("#cslat").val();
					var csfast=$("#csfast").val();
					var cslow=$("#csfast").val();
					var operator=$("#operator").find("option:selected").text();
					var cspub=$("#cspub").find("option:selected").text();
					var csstate=$("#csstate").find("option:selected").text();
					var parkfee=$("#parkfee").val();
					var csphone=$("#parkfee").val();
					var csnotes=$("#csnotes").val();
					var act="csshare";
		            var AjaxURL=window.MAINURL+"dealMessage?csname="+csname+"&cslng="+cslng+"&cslat="+cslat+"&csfast="+csfast+"&cslow="+cslow+"&operator="+operator
		            +"&cspub="+cspub+"&csstate="+csstate+"&parkfee="+parkfee+"&csphone="+csphone+"&csnotes="+csnotes+"&act="+act;
		            //alert(AjaxURL);
		            $.ajax({
		                        type: "GET",
		                        dataType: "html",
		                        url: AjaxURL,
		                       // data: {VehData:JSON.stringify(VehData)},
		                        success: function (data) {
		                                data = JSON.parse(data);//存放推荐充电站的数组
		                                alert("分享地址成功");
		                        },
		                        error: function(data) {
		                            alert("error!");
		                         }
		                    }); 
				}else{ 
					alert("false");
				}

			},window.MAINURL);
		});
		
		
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

