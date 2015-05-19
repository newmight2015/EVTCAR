<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="myBean.csInformation" import="myBean.position"  import="javax.servlet.http.Cookie"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=r6bfCVxPZTpoKGGNthyuupYh"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<title>充电导航</title>
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
<link href="css/char-nav.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
<link href="css/copyright.css" rel="stylesheet" type="text/css" />
<link href="styles/nyroModal.css" rel="stylesheet" type="text/css" />
</head>

<body  onload= setTimeout("ch_url()",100)>
<div id="page" class="page">
 <%@include file="head.jsp" %>
  <div id="content" class="content">

    <div class="search">
      <div class="s-box1">
        <div class="s1">搜索周边充电站</div>
      </div>
      <div class="s-box2">
        <div id="r-result">
        <input class="input" name="position" type="text" id="suggestId" value="请输入您的位置" onfocus="this.value=''"/>
        </div>
        <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
      </div>
      <div class="s-box2">
      	<form name="nav" id="form2" method="post" action="dealQuery.do" >
      	<input type="hidden" name="lng" id="lng"/>
      	<input type="hidden" name="lat" id="lat"/>
        <input type="button" class="button" onClick="javascript:submitPos(); return false;" value="搜索"/>
        </form>
      </div>
      <div class="search-result">
        <div class="sr" id= "result" style="display:none;overflow: scroll">搜索结果
        	<div class="s2">	
        		<span>推荐地点1：</span><span style="width:100px;"></span><button type="button" id="button1"  onClick="javascript:findway(0); return false;" style="float:right" >驾车导航</button></br>
        		<span id="result1"></span>
        	</div>
        		
        	<div class="s2" >
        		<span>推荐地点2：</span><span style="width:100px;"></span><button type="button" id="button2"  onClick="javascript:findway(1); return false;"  style="float:right" >驾车导航</button></br>
        		<span id="result2"></span>
        	</div>
        	<div class="s2" >
        		<span>推荐地点3：</span><span style="width:100px;"></span><button type="button" id="button3"  onClick="javascript:findway(2); return false;" style="float:right"  >驾车导航</button></br>
        		<span id="result3"></span>
        	</div>
        	
        </div>
        <!--这里显示搜索结果-->
        
      </div>
    </div>
    <div class="map" id="r-map">
      <iframe name="map"  width="697" height="488" frameborder="0" scrolling="no" style="padding-left:1px;"></iframe>
    </div>	
    <%@include file="bottom.jsp" %>
</div>
</body>
</html>

<script type="text/javascript">
var map = new BMap.Map("r-map");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	function getCookie(c_name)
		{
		if (document.cookie.length>0)
		{ 
		c_start=document.cookie.indexOf(c_name + "=");
		if (c_start!=-1)
		{ 
			c_start=c_start + c_name.length+1 ;
			c_end=document.cookie.indexOf(";",c_start);
			if (c_end==-1) c_end=document.cookie.length;
			return unescape(document.cookie.substring(c_start,c_end));
		} 
		}
		return ""
	}
	
	function setCookie(c_name,value,expiredays)
	{
		var exdate=new Date()
		exdate.setDate(exdate.getDate()+expiredays)
		document.cookie=c_name+ "=" +escape(value)+
		((expiredays==null) ? "" : "; expires="+exdate.toGMTString())
	}
	function G(id) {
		return document.getElementById(id);
	}
    sendPos=new Object();
    sendPos.lng="";
    sendPos.lat="";
    function textmsg(){
      		var posBuffer=getCookie('posBuff');
	      		if(posBuffer!=""||posBuffer!=null){
	      			G("suggestId").value=posBuffer;
	      		}else G("suggestId").value="请输入您的位置";
      		}
    function ch_url()
	{
		 var d_url=document.location.href;
		 if(d_url.indexOf("char_nav.jsp")>0) G("suggestId").value="请输入您的位置";
		 else textmsg();
		 
	}  		
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "suggestId"
		,"location" : map
	});
	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
		var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		G("suggestId").value=myValue;
		setCookie('posBuff',myValue,1);
		setPlace();
	});
	
	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			var marker=new BMap.Marker(pp);
			map.centerAndZoom(pp, 15);
			sendPos.lng=pp.lng;
			sendPos.lat=pp.lat;
			var myIcon = new BMap.Icon("pic/icon_car.png", new BMap.Size(20, 32), {//是引用图标的名字以及大小，注意大小要一样
    									anchor: new BMap.Size(20, 32)});//这句表示图片相对于所加的点的位置;
			var marker2 = new BMap.Marker(pp,{icon:myIcon});  // 创建标注
			map.addOverlay(marker2);    //添加标注
			var label = new BMap.Label("您的位置",{offset:new BMap.Size(20,-10)});
			marker2.setLabel(label);
			marker2.enableDragging(true); //可拖拽
			marker2.addEventListener("mouseout", function(){ 
						sendPos.lng=marker2.getPosition().lng;
						sendPos.lat=marker2.getPosition().lat; //坐标
			});
			
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		local.search(myValue);
	}
	
	$(document).ready(function(){
		var sum=0;
	  $("input").keydown(function(event){ 
	    if(event.which==13){
		    var text= $(":text").val();
			// 将地址解析结果显示在地图上,并调整地图视野
			if(text!=null){
				sum++;
				//alert($(":text").val());
				map.clearOverlays();
				var myGeo = new BMap.Geocoder();
				myGeo.getPoint(text, function(pp){
					if (pp) {
						myValue=text;
						map.centerAndZoom(pp, 15);
						sendPos.lng=pp.lng;
						sendPos.lat=pp.lat;
						var myIcon = new BMap.Icon("pic/icon_car.png", new BMap.Size(20, 32), {//是引用图标的名字以及大小，注意大小要一样
			    									anchor: new BMap.Size(20, 32)});//这句表示图片相对于所加的点的位置;
						var marker2 = new BMap.Marker(pp,{icon:myIcon});  // 创建标注
						map.addOverlay(marker2);    //添加标注
						var label = new BMap.Label("您的位置",{offset:new BMap.Size(20,-10)});
						marker2.setLabel(label);
						marker2.enableDragging(true); //可拖拽
						marker2.addEventListener("mouseout", function(){ 
						sendPos.lng=marker2.getPosition().lng;
						sendPos.lat=marker2.getPosition().lat; //坐标
						});
						setCookie('posBuff',myValue,1);
						if(sum==2){
							sum=0;
							run(pp.lng,pp.lat);
						}
					}
				}, "北京市");
				
			}
			
	    };
	  });
	});
	function submitPos(){
		if(sendPos.lng!=""&&sendPos.lat!=""){
			run(sendPos.lng,sendPos.lat);
		}
	}
  function run( strLng,  strLat)  
	    {
	    if(strLng<73||strLng>136||strLat<3||strLat>54) alert("请输入详细地址！");
	    else{
		    G("lng").value=strLng;  
		    G("lat").value=strLat;
		    sendPos.lng="";
	    	sendPos.lat=""; 
		    G("form2").submit(); 
	    }
	    }  
	
/*************输出查询后的充电站位置*******************/

//注意：百度和谷歌的经纬度坐标顺序是相反的。
<%List list = (List)request.getAttribute("cslist");
  position p=(position)request.getAttribute("oPosition"); 
  String message=(String)request.getAttribute("errorMessage");
  if(message=="false")%> alert("请重新输入地址");
  <%
  if(list!=null&&p!=null&&message.equals("true")){
 %>
	var cs_info=[<% 
				for(int a=0;a<list.size();a++) {
	       			csInformation  csInf= (csInformation)list.get(a);
	       			%>
	       			[<%=csInf.getLng()%>,<%=csInf.getLat()%>,"<%=csInf.getCsDist()%>","<%=csInf.getCsAllNum()%>","<%=csInf.getCsFreeNum()%>" 
	       			,"<%=csInf.getCsName()%>","<%=csInf.getCsAddr()%>","<%=csInf.getCsFastNum()%>","<%=csInf.getCsSlowNum()%>"
	                ],
	                <%}%>
	           ];
				var pt = new BMap.Point(<%=p.getLng()%>,<%=p.getLat()%>);//创建起点位置标注
				var myIcon_car = new BMap.Icon("pic/icon_car.png", new BMap.Size(20, 32), {//是引用图标的名字以及大小，注意大小要一样
    									anchor: new BMap.Size(20, 32)});//这句表示图片相对于所加的点的位置;
				var marker2 = new BMap.Marker(pt,{icon:myIcon_car});  // 创建标注
				map.addOverlay(marker2);              // 将标注添加到地图中
				var circle = new BMap.Circle(pt,5000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.2, strokeOpacity: 0.2});//设置覆盖物的参数，中心坐标，半径，颜色
				map.addOverlay(circle);			
		
				var label = new BMap.Label("您的位置",{offset:new BMap.Size(20,-10)});
				marker2.setLabel(label);
				map.centerAndZoom(pt, 13);
				var point = new Array(); //存放标注点经纬信息的数组
                    var marker = new Array(); //存放标注点对象的数组
                    var info = new Array(); //存放提示信息窗口对象的数组
                    var searchInfoWindow =new Array();//存放检索信息窗口对象的数组
                      for (var i = 0; i < 3; i++) {
                        var j = i+1;
                        var str = "</br>充电站名："+cs_info[i][5]+"</br>到此充电站的距离："+cs_info[i][2]+"</br>空闲充电桩数:"+cs_info[i][4];  
                        G("result"+j).innerHTML=str;
                        point[i] = new window.BMap.Point(cs_info[i][0],cs_info[i][1]); 
                        var myIcon_charger = new BMap.Icon("pic/icon_charger.png", new BMap.Size(20, 32), {//是引用图标的名字以及大小，注意大小要一样
    									anchor: new BMap.Size(10, 32)});//这句表示图片相对于所加的点的位置;
			marker[i] = new BMap.Marker(point[i],{icon:myIcon_charger});  
                        map.addOverlay(marker[i]);
                        marker[i].disableMassClear();
                        var label = new BMap.Label("充电地点"+j,{offset:new BMap.Size(20,-10)});
						marker[i].setLabel(label);
                      //  marker[i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
                        // 创建信息窗口对象
                        info[i] =  '<img src="pic/charge-stick.gif" alt="" style="float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;"/>'+
                        			'地址：'+cs_info[i][6]+'</br>到此充电站的距离：'+cs_info[i][2]+'</br>充电桩总数:'+cs_info[i][3]+'</br>快充个数:'+cs_info[i][7]+'</br>慢充个数:'+cs_info[i][8]+
                        			'</br>空闲充电桩数:'+cs_info[i][4];
                        //创建百度样式检索信息窗口对象                       
                        searchInfoWindow[i] = new BMapLib.SearchInfoWindow(map, info[i], {
                                title  : cs_info[i][5],      //标题
                                width  : 290,             //宽度
                                height : 130,              //高度
                                panel  : "panel",         //检索结果面板
                                enableAutoPan : true,     //自动平移
				enableMessage : false,
                                searchTypes   :[
                                 //   BMAPLIB_TAB_SEARCH,   //周边检索
                                    BMAPLIB_TAB_TO_HERE,  //到这里去
                                    BMAPLIB_TAB_FROM_HERE //从这里出发
                                ]
                            });
                        //添加点击事件
                        marker[i].addEventListener("click", 
                            (function(k){
                                // js 闭包
                                return function(){
                                    //将被点击marker置为中心
                                    map.centerAndZoom(point[k], 15);
                                    //在marker上打开检索信息窗口
                                    searchInfoWindow[k].open(marker[k]);
                                }
                            })(i)                            
                        ); 
                }
               // map.centerAndZoom(point[0], 13);
               G("result").style.display="block";
  /************************************/
		  function DisplayAndHiddenBtn(btnId, type) {
		    var currentBtn = document.getElementById(btnId);
		    if (type == "d") {
		        currentBtn.style.display = "block"; //style中的display属性
		    }
		    else if (type == "h") {
		        currentBtn.style.display = "none";
		    }
		}
		  function findway(i){
				map.clearOverlays();
				var p2 = new BMap.Point(cs_info[i][0],cs_info[i][1]);
				var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});
				
				driving.search(pt, p2);
				
		  }
		  <%list.clear();}%>   
	
</script>
