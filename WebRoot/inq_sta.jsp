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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<script src="static/js/release/jquery.autocomplete.js" type="text/javascript"></script>

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
	STATICINFO.USERINFO.URL = "<%=basePath%>";
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
		<div class="nav-btn"><a href="#">关于我们</a></div>
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
				<input class="text ac_input" id="city_name" type="text" value="请输入城市中文或拼音" onKeyUp="input_keyup();" onClick="append_city();" onBlur="input_blur()" onFocus="if(value=='请输入城市中文或拼音'){value='';style.color='#606060';}" />	
				<input class="text" id="hid_city_name" name="index_city" style="display:none">
				<input class="text" id="hid_real_city_name" name="real_index_city" style="display:none">
				<!--热门城市下拉-->
				<div class="pop search-citys-pop click" style="display:none;z-index:9999" id="cityarea">
					<a href="javascript:void(0)" class="pop-close" ></a>
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
			</div>
	</div>
</div>
<div class="map" id="r-map"></div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>
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

				function G(id) {
						return document.getElementById(id);
					}        
				
				function submitOpt()  
					    { 
					     var district=G("district");
					     var station=G("station");
					     if(district.value!="false" && station.value!=null){
						     G("quyu").value=district.value;
						     G("c_leibie").value = station.value;
						     G("form1").submit();
						    // alert(district.value+","+station.value);
					     }else{
					     	alert("请选择范围！");
					     }
				}  
</script>
<script language="javascript">

var cityChange= eval(cityChange);
$(function(){
 $('#index_province').change(function(){
    for(var i in cityChange){
        if(i==this.value){
           var index_city_obj = $('#index_city')[0];
           index_city_obj.innerHTML='';
           var obj = cityChange[i];
           for(var k in obj){
              if(obj[k].name){             
			  	index_city_obj.options[index_city_obj.options.length] = new Option( obj[k].name,obj[k].pinyin);
              }
           }
           break;
        }
    }
    
 });
 
})
$(function() {
	$('#city_name').autocomplete(cities, {
	max: 12, //列表里的条目数
	minChars: 0, //自动完成激活之前填入的最小字符
	width: 385, //提示的宽度，溢出隐藏
	scrollHeight: 300, //提示的高度，溢出显示滚动条
	matchContains: true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
	autoFill: false, //自动填充
	minChars:1,
	formatItem: function(row, i, max) {
	return row.name + '（'+row.pinyin+'）';
	},
	formatMatch: function(row, i, max) {
	return row.match;
	},
	
	formatResult: function(row) {
	return row.name;
	},resultsClass:'search-text'
	}).result(function(event, row, formatted) {
		$("#hid_city_name").val(row.pinyin);
		$("#hid_real_city_name").val(row.name);
		$('#pop_cities').hide();
		});
});


$(document).ready(function(){
		$(document).bind('click', hide_div);
    });
    
    function hide_div(e){
    	var biaoqian = "click";
    	var classname= $(e.target)[0].className;
    	if(classname.indexOf('click')>'-1' ||$(e.target)[0].id=='city_name')
    	return ;

    	if($('#city_name').val()=='')
        {
        	$('#city_name').val('请输入城市中文或拼音');
        	$('#city_name').css('color','#B7B7B7');
        }
        $("#cityarea").hide();
    } 

//直接输入地址框的onblur事件
function input_blur()
{
	var value = $('#city_name').val();
	var all_city_val = $(".ac_over").text();
	if(all_city_val && all_city_val!="")
	{
		var str = all_city_val.substr(0,(all_city_val.length-1));
		strs=str.split("（");
		$("#hid_city_name").val(strs[1]);
		$("#hid_real_city_name").val(strs[0]);
		$("#city_name").val(strs[0]);
		$(".search-text").hide();
	}else if($.trim(value)==''&& $('#cityarea').css('display')=='none')
	{
		$('#city_name').val('请输入城市中文或拼音');
		$('#city_name').css("color","#B7B7B7");
	}	
}
    
//直接输入地址框的onkeyup事件
function input_keyup()
{
	var value = $('#city_name').val();
	if($('#hid_real_city_name').val()!=value || $('#hid_real_city_name').val()=='')
	{
		$('#cityarea').hide();
		
	}else if(value==$('#hid_real_city_name').val())
	{
		$('#cityarea').hide();
		
	}
		
}

function check_input(){
	var value = $('#city_name').val();
	if(value==$('#hid_real_city_name').val() && $("#hid_city_name").val()!=""){
		return true;
	}
	return false;
}

/**
 * 字母页面内链
 *
 */
function letter_scroll(letter)
{
	 var obj = $("#c_"+letter);
	 $('html,body').animate({scrollTop: obj.offset().top}, 500);
}

/**
 * 用户点击城市后，城市名填入input框
 *
 */
function change_city_val(city, pinyin_city)
{
	$('#city_name').css({ color: "#606060"});
	$('#city_name').val(city);
	$('#hid_city_name').val(pinyin_city);
	$("#hid_real_city_name").val(city);
	$('#cityarea').hide();
	map.centerAndZoom(city,11);
	map.clearOverlays();
    $.ajax({
                        type: "POST",
                        dataType: "html",
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
                               /*  map.addEventListener('zoomend', function(){
								    var mapstatue = map.getZoom();
								    if(mapstatue <= 11 ){
								    	hidemakers(marker);
								        markerClusterer = new BMapLib.MarkerClusterer(map, {markers:marker});
								    }else {
								    	markerClusterer.clearMarkers(marker);
								    	showmarkers(marker);
								    }
								}); */
                                //创建聚合点
                                //map.centerAndZoom(opoint, 11);
                                //new showRecommend();
                        },
                        error: function(data) {
                            alert("error:"+data.responseText);
                         }
                    });  
}

function hidemakers(marker){ 
	for (var i = marker.length - 1; i >= 0; i--) {
		map.removeOverlay(marker[i]);
	};
}
function showmarkers(marker){ 
	for (var i = marker.length - 1; i >= 0; i--) {
		map.addOverlay(marker[i]);
	};
}

function tabCutover(c,d){$(c).parent().attr("class");$(c).parent().children().removeClass("current");$(c).addClass("current");$("."+d).parent().children().hide();$("."+d).show();}
</script>


