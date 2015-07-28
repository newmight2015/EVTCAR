<%@  page language="java" import="java.util.*" import="myBean.usInformation" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<title>查询充电站信息</title>


<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=r6bfCVxPZTpoKGGNthyuupYh"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script src="js/jquery-2.1.3.min.js"></script>
<link href="css/evtcar.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="styles/nyroModal.css" rel="stylesheet" type="text/css" />
<link href="css/inq-sta.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
<link href="static/style/release/other13.css" rel="stylesheet" type="text/css" />
<script src="static/js/release/cities08.js"  type="text/javascript"></script>
<script src="static/js/release/autocomplete.js" type="text/javascript"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
<script src="js/bootstrap.min.js"></script>

<script src="js/mapcontrol.js" type="text/javascript"></script>
	<script src="js/staticinfo.js" type="text/javascript"></script>
<script type="text/javascript">
	<%
		HttpSession sess = request.getSession();
		usInformation usInf = (usInformation)sess.getAttribute("usInf");
	%>
	window.MAINURL = "<%=basePath%>";
	STATICINFO.USERINFO.name = "<%= usInf==null ? "" : usInf.getUsId()%>";
	</script>
<style>
body{
	font: 14px/1.6 "Helvetica Neue",Arial,"Microsoft Yahei",sans-serif;
}
</style>
</head>

<body>

<!--顶部导航栏开始 -->
<%@include file="head.jsp" %>
<!--下面是中部导航栏的代码-->
<div class="nav-green nav-head" id="J_m_nav">
	<div class="nav-content">
		<div class="nav-btn "><a href="index.jsp">首页</a></div>
		<div class="nav-btn "><a href="searchCS.jsp">我要充电</a></div>
		<div class="nav-btn active"><a href="inq_sta.jsp">充电站分布</a></div>
		<div class="nav-btn"><a href="userInf.jsp">用户管理</a></div>
		<div class="nav-btn"><a href="aboutUs.jsp">关于我们</a></div>
	</div>
</div>
</header>
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
        </div>
     </div>
      
    </div>
  </div>
</div>
<!--顶部导航栏结束 -->
<div id="content">

<div class="order-main">
	<div class="hot-cities">
	<div class="search-citys">
				<span>当前城市：</span>
				<!--热门城市下拉
				<input class="text ac_input" id="city_name" type="text" placeholder="请输入城市中文或拼音" value="请输入城市中文或拼音" onKeyUp="input_keyup();" onClick="append_city();" onBlur="input_blur()" onFocus="if(value=='请输入城市中文或拼音'){value='';style.color='red';}" />	
				<input class="text" id="hid_city_name" name="index_city" style="display:none">
				<input class="text" id="hid_real_city_name" name="real_index_city" style="display:none">
				
				<div class="pop search-citys-pop click" style="display:none;z-index:9999" id="cityarea">
					<a href="javascript:void(0)" id="pop-close" class="pop-close" ></a>
					<div class="search-citys-tit click">热门城市(可直接输入中文名/拼音/三字码)</div>
					<div class="search-citys-tt click">
						<a class="current click" onClick="tabCutover(this,'s-citys1')" href="javascript:void(0)">热门<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys2')" href="javascript:void(0)">ABCDEFG<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys3')" href="javascript:void(0)">HIJKL<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys4')" href="javascript:void(0)">MNOPQRST<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys5')" href="javascript:void(0)">UVWXYZ<span></span></a>
					</div>
					<div class="search-citys-list click" id="citylist"></div>
				</div>
				
				<input type="text" id="city" autocomplete="off" value="上海" name="s_cities" onclick="this.value='';GetCityList(this);" onkeyup="selCity(event)" class="inputbox text ac_input" />
				-->
			
				<input type="text" class="text ac_input"  value="" size="15"  id="homecity_name" name="homecity_name" mod="address|notice" mod_address_source="hotel" mod_address_suggest="@Beijing|北京|53@Shanghai|上海|321@Shenzhen|深圳|91@Guangzhou|广州|80@Qingdao|青岛|292@Chengdu|成都|324@Hangzhou|杭州|383@Wuhan|武汉|192@Tianjin|天津|343@Dalian|大连|248@Xiamen|厦门|61@Chongqing|重庆|394@" mod_address_reference="cityid" mod_notice_tip="中文/拼音" />
				<input id="cityid" name="cityid" type="hidden" value="{$cityid}" />	
				<a class="btn btn-xs btn-default" id="city_search">查询</a>
		</div>
	</div>
<!--城市选择下拉 -->
	<div id="jsContainer" class="jsContainer" style="height:0">
					    <div id="tuna_alert" style="display:none;position:absolute;z-index:999;overflow:hidden;"></div>
					    <div id="tuna_jmpinfo" style="visibility:hidden;position:absolute;z-index:120;"></div>
	</div>
<!--城市选择下拉结束-->
	<div class="map" id="r-map"></div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>

					<script type="text/javascript" src="js/fixdiv.js"></script>
					<script type="text/javascript" src="js/address.js"></script>
<script type="text/javascript">
				initalMap();
				function myFun(result){
				    var cityName = result.name;
				    map.setCenter(cityName);   //关于setCenter()可参考API文档---”传送门“
				    //alert(cityName);
				    change_city_val(cityName);
				}
				var myCity = new BMap.LocalCity();
				myCity.get(myFun);
				//创建一个LocalCity对象myCity，然后调用其get()方法，就得到了用户IP对应的城市。该城市结果会以参数形式传递给回调函数myFun。接下来就是myFun(结果城市result)来执行了----即上文红色代码。

				/**
				 * 用户点击城市后，城市名填入input框
				 *
				 */
				function change_city_val(city)
				{
					$('#homecity_name').css({ color: "#606060"});
					$('#homecity_name').val(city);
					//$('#hid_city_name').val(pinyin_city);
					//$("#hid_real_city_name").val(city);
					//$('#cityarea').hide();
					 map.centerAndZoom(city,11);
					 map.clearOverlays();
				     $.ajax({
				                        type: "POST",
				                        dataType: "html",
				                        crossDomain: true, 
				                        url: "dealMessage",
				                        data: {cityname:city,act:"searchCityCS"},
				                        success: function (data) {
				                                CsAllData = JSON.parse(data);
				                                var point = new Array(); //存放标注点经纬信息的数组
				                                marker = new Array(); //存放标注点对象的数组
				                                var info = new Array(); //存放提示信息窗口对象的数组
				                                searchInfoWindow =new Array();//存放检索信息窗口对象的数组
				                                var srcpic = "pic/icon_charger.png";
				                                eachAllCs(srcpic,point,marker,info,searchInfoWindow,false);
				                        },
				                        error: function(data) {
				                            alert("error:"+data.responseText);
				                         }
				                    }); 
				}
					$("#city_search").click(function(){
						var cityname =  $("#homecity_name").val();
						change_city_val(cityname);
					})
					$("#homecity_name").change(function(){
						var cityname =  $("#homecity_name").val();
						change_city_val(cityname);
					})
</script>




