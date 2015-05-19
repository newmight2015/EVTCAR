<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<%@page import="myBean.csInformation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查询充电站信息</title>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=r6bfCVxPZTpoKGGNthyuupYh"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>

<link href="styles/nyroModal.css" rel="stylesheet" type="text/css" />
<link href="css/inq-sta.css" rel="stylesheet" type="text/css" />
<link href="css/nav-bar.css" rel="stylesheet" type="text/css" />
<link href="css/copyright.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
</head>

<body>
<div id="page" class="page">
  <%@include file="head.jsp" %>
<div id="content" class="content">
<div class="search">
<span class="city">当前城市是:<span name="this-city" class="this-city">北京<!--传入当前城市--></span><a href="#" style="text-decoration:none;font-size:16px;margin-left:10px;">更改城市</a></span>
<div class="text">查找充电站:</div>
<div class="input">
<select name="district" id="district" class="district" onchange="" >
  <option value="false" class="option">请选择区域</option>
  <option value="9" class="option">海淀区</option>
  <option value="1" class="option">朝阳区</option>
  <option value="15" class="option">西城区</option>
  <option value="7" class="option">东城区</option>
  <option value="2" class="option">通州区</option>
  <option value="4" class="option">昌平区</option>
   <option value="8" class="option">丰台区</option>
   <option value="14" class="option">石景山区</option>
  <option value="11" class="option">大兴区</option>
  <option value="12" class="option">门头沟</option>
  <option value="10" class="option">房山区</option>
  <option value="3" class="option">顺义区</option>
  <option value="5" class="option">怀柔区</option>
  <option value="6" class="option">平谷区</option>
  <option value="13" class="option">密云县</option>

</select>
<select name="station" id="station" class="station" >
  <option value="1" class="option">可用充电站</option>
  <option value="0" class="option">在建充电站</option>
</select>
</div>
<div class="button">
<form action="dealCsQuery.do" id="form1" method="post">
<input type="hidden" name="csarea" id="quyu"/>
<input type="hidden" name="cstype" id="c_leibie"/>
<input type="button" class="submit" onClick="javascript:submitOpt(); return false;" value="搜索"/>
</form>
</div>
</div>
<div class="map" id="r-map">
<iframe name="map" width="697" height="378" frameborder="0" scrolling="no"></iframe>
</div>

<%@include file="bottom.jsp" %>
</div>
</body>
</html>
<script type="text/javascript">
				initMap();
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
/*************输出查询后的充电站位置*******************/

//注意：百度和谷歌的经纬度坐标顺序是相反的。
				<% List list = (List)request.getAttribute("csInfPos");
				
				if(list!=null){
				%>
 				var data_info = [
 					<%
					for(int a=0;a<list.size();a++) {
       					csInformation  csInf= (csInformation)list.get(a);%>
	 					[<%=csInf.getLng()%>,<%=csInf.getLat()%>,<%=csInf.getCsFastNum()%>,<%=csInf.getCsSlowNum()%>
	 					,"<%=csInf.getCsName()%>","<%=csInf.getCsAddr()%>",<%=csInf.getCsAllNum()%>
	 					],
	 				<%}%>
				 ];
				 	<%
				 	String csarea=request.getParameter("csarea").trim();
					String cstype=request.getParameter("cstype").trim();
					%>
					G("district").value=<%=csarea%>;
					G("station").value=<%=cstype%>;
                   var point = new Array(); //存放标注点经纬信息的数组
                    var marker = new Array(); //存放标注点对象的数组
                    var info = new Array(); //存放提示信息窗口对象的数组
                    var searchInfoWindow =new Array();//存放检索信息窗口对象的数组
                    for (var i = 0; i < data_info.length; i++) {
                        
                        point[i] = new window.BMap.Point(data_info[i][0],data_info[i][1]); //循环生成新的地图点
                        //marker[i] = new window.BMap.Marker(point[i]); //按照地图点坐标生成标记
                        //marker[i].disableMassClear();
                        var myIcon_charger = new BMap.Icon("pic/icon_charger.png", new BMap.Size(20, 32), {//是引用图标的名字以及大小，注意大小要一样
    									anchor: new BMap.Size(20, 32)});//这句表示图片相对于所加的点的位置;
						marker[i] = new BMap.Marker(point[i],{icon:myIcon_charger});  // 创建标注
						//添加标注
                        map.addOverlay(marker[i]);
                        //  marker[i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
                        // 创建信息窗口对象
                        info[i] =  '<img src="pic/charge-stick.gif" alt="" style="float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;"/>'+
                        			'</br>地址：'+data_info[i][5]+'</br>充电桩总数：'+data_info[i][6]+
                        			'</br>快充个数:'+data_info[i][2]+'</br>慢充个数:'+data_info[i][3]+'</br>空闲充电桩数：0';
                       //创建百度样式检索信息窗口对象                       
                        searchInfoWindow[i] = new BMapLib.SearchInfoWindow(map, info[i], {
                                title  : data_info[i][4],      //标题
                                width  : 290,             //宽度
                                height : 130,              //高度
                                panel  : "panel",         //检索结果面板
                                enableAutoPan : true,     //自动平移
                                searchTypes   :[
                                  //  BMAPLIB_TAB_SEARCH,   //周边检索
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
  <%list.clear();}%>
</script>

