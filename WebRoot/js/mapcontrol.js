//targetJson 目标JSON，packJson 被组装JSON

function addGroupJson(targetJson, packJson){

    if(targetJson && packJson){

       for(var p in packJson){

           targetJson[p] = packJson[p];

       }

    }

}
/** 
* json对象转字符串形式 
*/ 
function json2str(o) { 
	var arr = []; 
	var fmt = function(s) { 
	if (typeof s == 'object' && s != null) return json2str(s); 
	return /^(string|number)$/.test(typeof s) ? "'" + s + "'" : s; 
	} 
	for (var i in o) arr.push("'" + i + "':" + fmt(o[i])); 
	return '{' + arr.join(',') + '}'; 
} 

function createJson(prop, val) {
    // 如果 val 被忽略
    if(typeof val === "undefined") {
        // 删除属性
        delete str1[prop];
    }
    else {
        // 添加 或 修改
        str1[prop] = val;
    }
}
function createRandomInf(){ //自动生成soc以及目的地
	var soc=$(".vehicle-inf").children("input.soc");
    var destination=$(".vehicle-inf").children(".destination");
	var pt = null;
	var f=$("#saveInf").data("Number");
	
	for(var i;i<tempPt.length;i++){//清空tempPt数组
		tempPt[i]=null;
	}
	for(var i=0;i<soc.length;i++){
			var d=Math.random()*360;
			pt = new BMap.Point(VehData[f].lng+Math.sin(d)*0.05,VehData[f].lat+Math.cos(d)*0.04);//以初始起点为中心，5公里为半径，生成D端
			tempPt[i]=pt;  //将目标地点存放在tempPt中
			
			destination.eq(i).val(tempPt[i].lng+","+tempPt[i].lat);
			soc.eq(i).val(Math.round(50-Math.random()*40));
			
		}
}
function creatClusterer(e,f){//创建聚合点
	var MAX = e;
	var markers = [];
	var pt = null;
	var i = 0;
	for (; i < MAX; i++) {
	   var d=Math.random()*360;
	   pt = new BMap.Point(VehData[f].lng+Math.sin(d)*Math.random()*0.02,VehData[f].lat+Math.cos(d)*Math.random()*0.02);
	   markers.push(new BMap.Marker(pt));
	}
	//最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
	var markerClusterer = new BMapLib.MarkerClusterer(map, {markers:markers});
	return markers;
}
function saveInf(){ //保存车辆信息
		var addres=[];
		var soc=$(".vehicle-inf").children("input.soc");
		var destination=$(".vehicle-inf").children(".destination");
		var a=$("#saveInf").data("Number");
		var b=VehData[a];
		var markers=creatClusterer(soc.length,a);//创建聚合点
		console.log(markers)
		for(var i=0;i<soc.length;i++){
			var tempArr = destination.eq(i).val().split(",");
			var temp={"olng":markers[i].point.lng,"olat":markers[i].point.lat,"soc":soc.eq(i).val(),"dlng":tempArr[0],"dlat":tempArr[1]};
			addres.push(temp);
		}
		
		b.address=addres;
		
		hiddenInf();//隐藏面板
		
}

function submitinf(e){//点击设置，显示车辆设置面板
		var hh=$(".inf input").eq(e-1);
		var a=hh.val();
		$("#saveInf").data("Number",e);
		showInf(a,e);//(输入的车辆数，第几区域)
}
function hiddenInf(){//隐藏面板
		$(".manual-data").hide();
}

function showInf(e,f){//显示车辆设置面板
	$(".manual-data .vehicle-setting .vehicle-inf").remove();
	if(VehData[f].address == null){
		for(var i=1;i<=e;i++){
		$(".manual-data .vehicle-setting").append("<div class='vehicle-inf'>第<span>"+i+"</span>辆车：<span>SOC:</span><input type='text' class='input-small soc'/><span>目的地:</span><input type='text' class='destination'></div>");
		}
	}else{
		for(var i=1;i<=e;i++){
		$(".manual-data .vehicle-setting").append("<div class='vehicle-inf'>第<span>"+i+"</span>辆车：<span>SOC:</span><input type='text' class='input-small soc' value='"+VehData[f].address[i-1].soc+"'/><span>目的地:</span><input type='text' class='destination' value='"+VehData[f].address[i-1].dlng+","+VehData[f].address[i-1].dlat+"'></div>");
	   }
	}
	
	$(".manual-data").show();
}
function addMarker(e){
	  var point = new BMap.Point(e.point.lng, e.point.lat);
	  var marker = new BMap.Marker(point);
	  map.addOverlay(marker);
	  productNum++;
	  var label = new BMap.Label(productNum,{offset:new BMap.Size(20,-10)});
	  marker.setLabel(label);
	  $(".position-setting .pick-content").append("<div class='inf'><i class='icon-plus '></i>新增地址"+productNum+":请输入车辆请求数：<input type='text' class='input-small'/><a class='btn btn-small btn-success' href='#' onclick='submitinf("+productNum+");'><i class='icon-cog'></i>设置</a></div>");
	  var temp={"lng":e.point.lng,"lat":e.point.lat,"address":null};
	  VehData[productNum]=temp;
}
$(document).ready(function(){
    map = new BMap.Map("r-map");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	
	
	productNum=0;
	VehData = {};
	tempPt=[];
	
})



/**
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
		//绘制地图
		
	
	sendPos=new Object();
    sendPos.lng="";
    sendPos.lat="";
	
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
		//G("searchResultPanel").innerHTML = str;
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
		var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		//G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		G("suggestId").value=myValue;
		//setCookie('posBuff',myValue,1);
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
			var myIcon = new BMap.Icon("pic/icon_car.png", new BMap.Size(30, 44), {//是引用图标的名字以及大小，注意大小要一样
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

$( "#toUser" ).autocomplete({
source: function( request, response ) {
var userId = $("#toUser").val();
$.ajax({
type: "POST",
url: "MailAction?method=findUser&userIdorNum=" + encodeURI(encodeURI(userId)),
dataType: "json",
data: {
maxRows: 12
},
success: function( data ) {
if(data.length > 0){
response( $.map( data, function( item ) {
return {
userNum:item.usernum,
userName:item.username,
value: item.username + "(" + item.usernum +")"
}
}));
}
}
});
},
minLength: 1,
select: function( event, ui ) {
$("#userNum").val(ui.item.userNum);
},
open: function() {
$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
},
close: function() {
$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
}
});

/////
$('#autocompleteInput').autocomplete({
        source:function(query,process){
            var matchCount = this.options.items;//返回结果集最大数量
            $.post("/bootstrap/region",{"matchInfo":query,"matchCount":matchCount},function(respData){
                return process(respData);
            });
        },
        formatItem:function(item){
            return item["regionName"]+"("+item["regionNameEn"]+"，"+item["regionShortnameEn"]+") - "+item["regionCode"];
        },
        setValue:function(item){
            return {'data-value':item["regionName"],'real-value':item["regionCode"]};
        }
    });
 
$("#goBtn").click(function(){ //获取文本框的实际值
        var regionCode = $("#autocompleteInput").attr("real-value") || "";
        alert(regionCode);
    });
	**/
