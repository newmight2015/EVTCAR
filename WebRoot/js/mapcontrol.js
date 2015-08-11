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

function showMessage(msg){
	$(".map-messagebox .message").html(msg);
    $(".map-messagebox").show(1000,function(){setTimeout(function(){$(".map-messagebox").hide(1000)},2000) });
}

function drive(i){
	var p2 = new window.BMap.Point(CsAllData[i].CSLongValue,CsAllData[i].CSLatiValue);
	var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});
	driving.search(opoint, p2);
}
//显示充电站详情js
function showcsintro(i){
	$('#csintro').modal();
	$("#csid").value=CsAllData[i].CSId;
     var Operator,CSPub,CSState,CSFeeDay,CSMode;
        if(CsAllData[i].OperatorID=='001') Operator="国家电网";
        else if(CsAllData[i].OperatorID=='002') Operator="普天";
        else if(CsAllData[i].OperatorID=='003') Operator="特锐德";
        else if(CsAllData[i].OperatorID=='004') Operator="富电科技";
        else if(CsAllData[i].OperatorID=='005') Operator="特斯拉";
        else Operator="未核实"
        
        if(CsAllData[i].CSPub=='1') CSPub="公用";
             else if(CsAllData[i].CSPub=='2') CSPub="专用";
             else if(CsAllData[i].CSPub=='3') CSPub="私用";
             else if(CsAllData[i].CSPub=='4') CSPub="其他";
             else CSPub="未核实";
        if(CsAllData[i].CSState=='1') CSState="运营中";
             else if(CsAllData[i].CSState=='2') CSState="未运营";
             else CSState="未核实";
        if(CsAllData[i].CSMode=='1') CSMode="快充";
        else if(CsAllData[i].CSMode=='2') CSMode="慢充";
        else CSMode="快慢充";	

       var csFee = CsAllData[i].CSFeeDay=='-1'?"未核实":CsAllData[i].CSFeeDay+'元/h'	
        
        $("#csintro .modal-body .info").html("<form id='change' name='changecsinf'  method='post' action='dealCorrect' ><table data-id='"+i+"'><tbody><tr style='display: none;'><th>ID：</th><td>"+CsAllData[i].CSId+
                	"</td></tr><tr><th>名称：</th><td>"+CsAllData[i].CSName+
        			"</td></tr><tr><th>地址：</th><td>"+CsAllData[i].CSAddr+
        			"</td></tr><tr><th>充电桩建设日期：</th><td>"+CsAllData[i].Datetime+
        			"</td></tr><tr><th>充电模式：</th><td>"+CSMode+
        			"</td></tr><tr><th>快充数量：</th><td>"+CsAllData[i].CSFast+
        			"</td></tr><tr><th>慢充数量：</th><td>"+CsAllData[i].CSSlow+
        			"</td></tr><tr><th>运营商：</th><td>"+Operator+
        			"</td></tr><tr><th>停车费用：</th><td>"+csFee +
        			"</td></tr><tr><th>对外状态：</th><td>"+CSPub+
        			"</td></tr><tr><th>运营状态：</th><td>"+CSState+
        			"</td></tr><tr><th>电话:</th><td>"+CsAllData[i].CSPhone+
        			"</td></tr><tr><th>备注:</th><td>"+CsAllData[i].CSNotes+
        			"</td></tr></tbody></table>"+
        			"<div style='float:right;font-size:14px;' id='subchange'>信息有误？<a class='btn btn-danger btn-sm' onclick='changeCsInf("+i+")'>>>>点我纠错</a><div></form></hr>");
        
            //查询充电站评价信息     
            var CSId=CsAllData[i].CSId;
            var AjaxURL="dealMessage?CSId="+CSId;
            $.ajax({
                        type: "GET",
                        dataType: "html",
                        url: AjaxURL,
                        data:{act:'commentinfo'},
                       // data: {VehData:JSON.stringify(VehData)},
                        success: function (data) {
                                  var CommentInfo = JSON.parse(data);//存放评价信息的数组
                                  coo();
                                  //将评论信息显示在面板上
                        	      function coo(){
                        	    	  $("#csintro .modal-body .commentinfo .cminfo li").remove();
	                                  for(var j=0;j<CommentInfo.length;j++){
	                              		$("#csintro .modal-body .commentinfo .cminfo").append(
	                              				"<li><div class='comment-body'><span class='star-rating1'><span class='syellowstar50 star-icon'></span></span><span class='name'>"+CommentInfo[j].USId+"</span>&nbsp;&nbsp;<div class='Star' data-starnum='"+CommentInfo[j].Star+"'></div>"+
	                                  			"<span class='date'>"+CommentInfo[j].Time+
	                                  			"</span><div class='commentdetail'>"+CommentInfo[j].Content+
	                                  			"</div></div></li>");
	                              		
	                              	   }
	                                  $("#csidv").attr("value",CSId);
	                                  $(".Star").each(function(){
	                              		var num = $(this).data("starnum");
	                              		$(this).raty({readOnly:true,score:num}); 
	                              	});
	                                  //统计评星并显示
	                                  $.ajax({
	                                      type: "GET",
	                                      dataType: "html",
	                                      url: AjaxURL,
	                                      data:{act:'analysiscminfo'},
	                                     // data: {VehData:JSON.stringify(VehData)},
	                                      success: function (data) {
	                                                var AnalysisCmInfo = JSON.parse(data);//存放评价信息的数组
	                                                
	                                                //alert(AnalysisCmInfo);
	                                                analysis();
	                                                //将评星信息显示在面板上
	                                      	      function analysis(){
	                                      	    	   $(".c-total").empty();	                                      	    	   
	                                      	    	   $(".star-rating").raty({readOnly:true,score:0});
	                                      	    	   $(".c-total").empty();
	                                      	    	   $(".c-num").empty();
	                                                    for(var j=0;j<AnalysisCmInfo.length;j++){
	                                                    	var avg = AnalysisCmInfo[j].StarAvg;
		                                                    //alert(avg);
		                                                	$(".star-rating").raty({readOnly:true,score:avg});
	                                                		$(".c-total").html("<P>"+AnalysisCmInfo[j].StarAvg+"</p>");
	                                                		$(".c-num").html("<P>共有"+AnalysisCmInfo[j].ussum+"人评价</p>");
	                                                		$("#p5").html("<p>"+AnalysisCmInfo[j].Star5+"人</p>");
	                                                		$("#p4").html("<p>"+AnalysisCmInfo[j].Star4+"人</p>");
	                                                		$("#p3").html("<p>"+AnalysisCmInfo[j].Star3+"人</p>");
	                                                		$("#p2").html("<p>"+AnalysisCmInfo[j].Star2+"人</p>");
	                                                		$("#p1").html("<p>"+AnalysisCmInfo[j].Star1+"人</p>");
	                                                		if(AnalysisCmInfo[j].ussum!=0){
		                                                		var p5=(AnalysisCmInfo[j].Star5/AnalysisCmInfo[j].ussum)*100;
		                                                		var p4=(AnalysisCmInfo[j].Star4/AnalysisCmInfo[j].ussum)*100;
		                                                		var p3=(AnalysisCmInfo[j].Star3/AnalysisCmInfo[j].ussum)*100;
		                                                		var p2=(AnalysisCmInfo[j].Star2/AnalysisCmInfo[j].ussum)*100;
		                                                		var p1=(AnalysisCmInfo[j].Star1/AnalysisCmInfo[j].ussum)*100;
	                                                		}else{
	                                                			var p5=0;
		                                                		var p4=0;
		                                                		var p3=0;
		                                                		var p2=0;
		                                                		var p1=0;
	                                                		}
	                                                		$("#p5-bg").width(""+p5+"px");
	                                                		$("#p4-bg").width(""+p4+"px");
	                                                		$("#p3-bg").width(""+p3+"px");
	                                                		$("#p2-bg").width(""+p2+"px");
	                                                		$("#p1-bg").width(""+p1+"px");
	                                                		
	                                                		
	                                                	}
//	                                                    var avg = AnalysisCmInfo[1].StarAvg;
//	                                                    alert(avg);
//	                                                	$(".star-rating").raty({readOnly:true,score:4});                         		
	                                              }
	                                                
	                                      },
	                                      error: function(data) {
	                                          alert("查询评价信息失败");
	                                      }
	                                  }); 
                        	    }
                                  
                        },
                        error: function(data) {
                            alert("查询评价信息失败");
                        }
                    }); 
            
        	
}
//点击详情界面“点我纠错”按钮的事件，把各项充电站信息变成可编辑状态。	//张伟：修改此方法
function changeCsInf(i){
  USERCheck.isLogin(function(isok,error){
	if(isok != 'false'){
		var j=0;
		$("#csintro .modal-body .info tr").children("td").each(function(){ 
			$(this).replaceWith("<input type='text' style='width:400px;'  id='changedata"+j+"' name='changedata"+j+"' value='"+$(this).html()+"'/>");
			j++;
		})
		//$("#subchange").html("确认完毕？<input type='submit' value='>>>>提交信息'  class='btn btn-success btn-sm'  ></input>")
		$("#subchange").html("确认完毕？&nbsp;&nbsp;<a id='correctCsInf' onclick='dealCorrect("+i+")' class='btn btn-success btn-sm' >>>>提交信息</a>")
	}else { 
    	alert("您好，请先登录！登录后才能提交信息");
        window.location.href = "login.jsp";
    }
  },window.MAINURL)

}

//处理纠错信息的方法
function dealCorrect(i){
	var r=confirm("是否确认提交纠错信息！");
	if(r==true){
		USERCheck.isLogin(function(isok,error){
	        if(isok != 'false'){
	        	//var id = $("#csorder table").data("id");
	        	var CSId=$("#changedata0").val();
	        	var CSName=$("#changedata1").val();
	        	var CSAddr=$("#changedata2").val();
	        	var CSDate=$("#changedata3").val();
	        	var CSMode=$("#changedata4").val();
	        	var CSFast=$("#changedata5").val();
	        	var CSlow=$("#changedata6").val();
	        	var Operator=$("#changedata7").val();
	        	var ParkFee=$("#changedata8").val();
	        	var CSPub=$("#changedata9").val();
	        	var CSState=$("#changedata10").val();
	        	var CSPhone=$("#changedata11").val();
	        	var CSNotes=$("#changedata12").val();
	        	var AjaxURL="dealCorrect?CSId="+CSId+"&CSName="+CSName+"&CSAddr="+CSAddr+"&CSDate="+CSDate+"&CSMode="+CSMode+"&CSFast="+CSFast+"&CSlow="+CSlow+"&Operator="+Operator+"&ParkFee="+ParkFee+"&CSPub="+CSPub+"&CSState="+CSState+"&CSPhone="+CSPhone+"&CSNotes="+CSNotes;
	        	//var url="localhost:8080/EVTcar2";
	        	$.ajax({
	                type: "POST",
	                dataType: "html",
	                url: AjaxURL,
	               // data: {VehData:JSON.stringify(VehData)},
	                success: function (data) {
	                	if(data.isSuccess=="false"){
		            		alert("提交信息失败，请重新提交!");
		            		//$("#csorder .errormsg").html(error);
	                	}else { 
		            		alert("提交纠错信息成功!");
		            		//$("#csorder .errormsg").html("您的预约请求已提交，请到用户管理中查看订单详情。");
		            		//window.location.href = 'userInf.html';
	                	} 
	                },
	                error: function(data) {
	                    alert("error:"+data.message);
	                 }
	            }); 
	        }else { 
	        	alert("您好，请先登录！登录后才能预约");
	            window.location.href = "login.jsp";
	        }
	    },window.MAINURL);
	}
	
	
}

function dealOrder(i){ 
	$('#csorder').modal();
	$('#csorder .appoint .errormsg').empty();
	 var Operator,CSPub,CSState;
        if(CsAllData[i].OperatorID=='001') Operator="国家电网";
        else if(CsAllData[i].OperatorID=='002') Operator="普天";
        else if(CsAllData[i].OperatorID=='003') Operator="特锐德";
        else if(CsAllData[i].OperatorID=='004') Operator="富电科技";
        else if(CsAllData[i].OperatorID=='005') Operator="特斯拉";
        else Operator="未核实"
        
        if(CsAllData[i].CSPub=='1') CSPub="公用";
             else if(CsAllData[i].CSPub=='2') CSPub="专用";
             else if(CsAllData[i].CSPub=='3') CSPub="未知";
             else CSPub="未核实";
        if(CsAllData[i].CSState=='1') CSState="运营中";
             else if(CsAllData[i].CSState=='2') CSState="未运营";
             else CSState="未核实";
        $("#csorder .modal-body .info").html("<table data-id='"+i+"'><tbody>"+
        	"<tr><th>用户名：</th><td>"+STATICINFO.USERINFO.name+
        	"<tr><th>您的位置：</th><td>"+STATICINFO.USERPOSITION.name+
        	"<tr><th>名称：</th><td>"+CsAllData[i].CSName+
			"</td></tr><tr><th>地址：</th><td>"+CsAllData[i].CSAddr+
			"</td></tr><tr><th>运营商：</th><td>"+Operator+
			"</td></tr></tbody></table></hr>");
}
function showPostition(i){ 
 		var	point = new window.BMap.Point(CsAllData[i].CSLongValue,CsAllData[i].CSLatiValue); //生成新的地图点
 		
 		var opts = {
 				  position : point,    // 指定文本标注所在的地理位置
 				  offset   : new BMap.Size(5, -10)    //设置文本偏移量
 				}
 		var label = new BMap.Label("推荐地点"+(i+1), opts);  // 创建文本标注对象
 		label.setStyle({
 						 color : "red",
 						 fontSize : "15px",
 						 fontWeight:"700",
 						 height : "20px",
 						 lineHeight : "20px",
 						 fontFamily:"微软雅黑"
 					 });
 		map.addOverlay(label);
 		map.centerAndZoom(point, 15);
        //在marker上打开检索信息窗口
        searchInfoWindow[i].open(marker[i]);
}
//显示推荐充电站
function showRecommend(){
	$("#searchResultPanel").show();
	$("#searchResultPanel .resultAll").empty();
	if(CsAllData.length==0){
		$("#searchResultPanel .resultAll").append("<img src='pic/nomessage.png' alt='暂无信息'></img>")
	}
	for(var i=0;i<3;i++){
		$("#searchResultPanel .resultAll").append(
				"<div class='search-content' onclick='showPostition("+i+")'><i class='resultpic result-pic"+(i+1)+
				"'></i><div class='result-content'><p>名称："+CsAllData[i].CSAddr+
				"</p><p>距离："+CsAllData[i].csDis+"米"+
				"</p><p>快充数："+CsAllData[i].CSFast+
				"</p><p>慢充数："+CsAllData[i].CSSlow+
				"</p></div></div>"
			)
	}

}
function enableOrderButton(){ 
	for(var i=0;i<CsAllData.length;i++){ 
		 if(CsAllData[i].CSIsOrder=='0'){ 
		 	if($('"#dealOrder'+i+'"')!=undefined){ 
	           $('"#dealOrder'+i+'"').attr("disabled", true);
	           $('"#dealOrder'+i+'"').removeClass("btn-success").addClass("btn-danger");
		 	}
          }
	}
}

function eachAllCs(srcpic,point,marker,info,searchInfoWindow,hasOpoint){//输出地图覆盖物
			var myIcon_car = new BMap.Icon("pic/icon_car.png", new BMap.Size(20, 32), {//是引用图标的名字以及大小，注意大小要一样
			        anchor: new BMap.Size(20, 32)});//这句表示图片相对于所加的点的位置;
			if(hasOpoint==true){
				var omarker = new BMap.Marker(opoint,{icon:myIcon_car});  // 创建标注
				//添加标注
				map.addOverlay(omarker);
			}
			$.each(CsAllData, function(i, content){
								if(content!="none"){
                                point[i] = new window.BMap.Point(CsAllData[i].CSLongValue,CsAllData[i].CSLatiValue); //循环生成新的地图点
                                //marker[i] = new window.BMap.Marker(point[i]); //按照地图点坐标生成标记
                                //marker[i].disableMassClear();
                                var srcpic1=CsAllData[i].srcpic;
                                var myIcon_charger = new BMap.Icon(srcpic1, new BMap.Size(35, 48), {//是引用图标的名字以及大小，注意大小要一样
                                                anchor: new BMap.Size(35, 48)});//这句表示图片相对于所加的点的位置;
                                marker[i] = new BMap.Marker(point[i],{icon:myIcon_charger});  // 创建标注
                                //添加标注
                                map.addOverlay(marker[i]);
                                //  marker[i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
                                // 创建信息窗口对象
                                var Operator,CSPub,CSState;
                                if(CsAllData[i].OperatorID=='001') Operator="国家电网";
                                else if(CsAllData[i].OperatorID=='002') Operator="普天";
                                else if(CsAllData[i].OperatorID=='003') Operator="特锐德";
                                else if(CsAllData[i].OperatorID=='004') Operator="富电科技";
                                else if(CsAllData[i].OperatorID=='005') Operator="特斯拉";
                                else Operator="未知"
                                
                                if(CsAllData[i].CSPub=='1') CSPub="公用";
                                     else if(CsAllData[i].CSPub=='2') CSPub="专用";
                                     else if(CsAllData[i].CSPub=='4') CSPub="未知";
                                     else CSPub="未知";
                                if(CsAllData[i].CSState=='1') CSState="运营中";
						             else if(CsAllData[i].CSState=='2') CSState="未运营";
						             else CSState="未核实"; 

				// if(CsAllData[i].CSFeeDay=='-1') CSFeeDay = "未核实";
				
                                var csFee = CsAllData[i].CSFeeDay=='-1'?"未核实":CsAllData[i].CSFeeDay+'元/h'		             
                                if(hasOpoint==true){
                                info[i] =  '<img src="pic/charge-stick.gif" alt="" style="float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;"/>'+
                                            '</br>地址： '+CsAllData[i].CSAddr+
                                            '</br>充电桩总数： '+CsAllData[i].CSSum+
                                            '</br>快充个数： '+CsAllData[i].CSFast+
                                            '</br>慢充个数： '+CsAllData[i].CSSlow+
                                            '</br>运营商： '+Operator+
                                            '</br>对外状态： '+CSPub+
                                            '</br>停车费用： '+csFee+
                                            '<p style="margin-top:10px"><a class="btn btn-success btn-sm" onclick="showcsintro('+i+')">详情</a>'+
                                            '<a class="btn btn-success btn-sm" onclick="javascript:drive('+i+')">导航</a><a class="btn btn-default btn-sm orderUnuse" disabled="ture"  alt="此功能正在开发中，敬请期待！">预约</a></p>';
                                           // '<a class="btn btn-success btn-sm" onclick="javascript:drive('+i+')">导航</a><a class="btn btn-success btn-sm" onclick="dealOrder('+i+')">预约</a></p>';
                               }else{ 
                               info[i] =  '<img src="pic/charge-stick.gif" alt="" style="float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;"/>'+
                                            '</br>地址： '+CsAllData[i].CSAddr+
                                            '</br>充电桩总数： '+CsAllData[i].CSSum+
                                            '</br>快充个数： '+CsAllData[i].CSFast+
                                            '</br>慢充个数： '+CsAllData[i].CSSlow+
                                            '</br>运营商： '+Operator+
                                            '</br>对外状态： '+CSPub+
                                            '</br>运营状态： '+CSState+
                                            '<p style="margin-top:10px"><a class="btn btn-success btn-sm" onclick="showcsintro('+i+')">详情</a>';
                               
                               }
                               //创建百度样式检索信息窗口对象                       
                                searchInfoWindow[i] = new BMapLib.SearchInfoWindow(map, info[i], {
                                        title  : CsAllData[i].CSName,      //标题
                                        width  : 290,             //宽度
                                        height : 200,              //高度
                                        panel  : "panel",         //检索结果面板
                                        enableAutoPan : true,     //自动平移
                                        searchTypes   :[
                                          //  BMAPLIB_TAB_SEARCH,   //周边检索
                                          //  BMAPLIB_TAB_TO_HERE,  //到这里去
                                           // BMAPLIB_TAB_FROM_HERE //从这里出发
                                        ]
                                    });
                                //添加点击事件
                                marker[i].addEventListener("click", 
                                    (function(k){
                                        // js 闭包
                                        return function(){
                                            //将被点击marker置为中心
                                            map.centerAndZoom(point[k], 13);
                                            //在marker上打开检索信息窗口
                                            searchInfoWindow[k].open(marker[k]);
                                            
                                        }
                                    })(i)                            
                                );
                            }
			});
			
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
			soc.eq(i).val(0.5-Math.random()*0.4); //SOC
			
		}
}
function creatClusterer(e,f){//创建聚合点--在保存车辆信息是产生
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

function initalMap(){
	    map = new BMap.Map("r-map");    // 创建Map实例
		map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_LARGE}); 
		map.addControl(top_right_navigation);  //右上角，仅包含平移和缩放按钮
}



