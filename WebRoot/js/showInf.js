
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
    
    initalMap();
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
    //点击“提交纠错”，提交纠错信息。
    $("#correctCsInf1111").on("click",function(){
    	alert("correctCsInf");
    	USERCheck.isLogin(function(isok,error){
            if(isok != 'false'){
            	//var id = $("#csorder table").data("id");
            	var CSId=$("#changedata [name='changedata0']").val();
            	var CSName=$("#changedata [name='changedata1']").val();
            	var CSAddr=$("#changedata [name='changedata2']").val();
            	var CSDate=$("#changedata [name='changedata3']").val();
            	var varCSMode=$("#changedata [name='changedata4']").val();
            	var CSFast=$("#changedata [name='changedata5']").val();
            	var CSlow=$("#changedata [name='changedata6']").val();
            	var Operator=$("#changedata [name='changedata7']").val();
            	var ParkFee=$("#changedata [name='changedata8']").val();
            	var CSPub=$("#changedata [name='changedata9']").val();
            	var CSState=$("#changedata [name='changedata10']").val();
            	var CSPhone=$("#changedata [name='changedata11']").val();
            	var CSNotes=$("#changedata [name='changedata12']").val();
//                if(dateBegin==""||timeBegin==""||dateStop==""||timeStop==""){ 
//                	$("#csorder .errormsg").html("请输入准确的预约时间");
//                	return null;
//                }

                USERCheck.correctCsInf(CSId,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes,function(isok,error){ 
                	if(isok=="false"){ 
                		alert(error);
                		//$("#csorder .errormsg").html(error);
                	}else { 
                		alert("提交纠错信息成功!");
                		//$("#csorder .errormsg").html("您的预约请求已提交，请到用户管理中查看订单详情。");
                		//window.location.href = 'userInf.html';
                	}
                },window.MAINURL);
                
                
            }else { 
            	alert("您好，请先登录！登录后才能预约");
                window.location.href = "login.jsp";
            }
        },window.MAINURL);
    })

    //点击“搜索”，搜索周围充电站
    $("#search").on("click",function(){
    	
    	$(".select-section").slideUp();
    	$(".search-toggle a").html("展开");
    	STATICINFO.USERPOSITION.name = $("#suggestId").val();
        if(sendPos.lat==""){
            $(".map-messagebox .message").html("请输入您的位置");
            $(".map-messagebox").show(1000,function(){setTimeout(function(){$(".map-messagebox").hide(1000)},2000) });
        }else {
        	map.clearOverlays();
        	$(".search-head span").html($("#suggestId").val());
        	opoint = new BMap.Point(sendPos.lng, sendPos.lat);
        	var geoc = new BMap.Geocoder();
        	var getCity = geoc.getLocation(opoint, function(rs){
    			var addComp = rs.addressComponents;
    			var cityName = addComp.province;
    			var csOperator = $("#select1").data("csoperator");
                var csRange = $("#select2").data("csrange");
                var csParkFee = $("#select3").data("csparkfee");
                //alert(AjaxURL);
                $.ajax({
                            type: "POST",
                            dataType: "json",
                            url: "dealPcCsQuery.do?cityName="+cityName,
                            data: {
                            	"lng":sendPos.lng,
                            	"lat":sendPos.lat,
                            	"csOperator":csOperator,
                            	"csRange":csRange,
                            	"csParkFee":csParkFee,
                            	},
                            success: function (data) {
                                    CsAllData = data;//存放推荐充电站的数组
                                    //alert(CsAllData);
                                    var point = new Array(); //存放标注点经纬信息的数组
                                    marker = new Array(); //存放标注点对象的数组
                                    var info = new Array(); //存放提示信息窗口对象的数组
                                    searchInfoWindow =new Array();//存放检索信息窗口对象的数组
                                    var srcpic = "pic/icon_charger.png";
                                    eachAllCs(srcpic,point,marker,info,searchInfoWindow,true);
                                    //eachAllCs(point,marker,info,searchInfoWindow,true);
                                    map.centerAndZoom(opoint, 11);
                                    new showRecommend();
                                  //  new enableOrderButton();
                                    //alert(CsAllData);
                            },
                            error: function(data) {
                                alert("error:"+data.responseText);
                             }
                        });
    			//$("#cityname").val(addComp.province);
    			//alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
    		});        
              
        }
    })
    
	$("#csorder .cptype :input").on("click",function(){ 
		$("#csorder .cptype :checked").siblings("[name='cp']").removeAttr("checked");
		$(this).prop("checked",true);
	});
  //点击提交评价信息----张伟增加
    $("#makeComment").click(function(){
    	var r=confirm("是否确认提交评价！");
    	if(r==true){
    	USERCheck.isLogin(function(isok,error){
            if(isok != 'false'){
            	var act=$("#act").val();
            	var starsum=$("#starsum").val();
            	var comment=$("#comment").val();
            	var csid=$("#csidv").val();
            	var usordid="1";
            	var AjaxURL="dealMessage?act="+act+"&starsum="+starsum+"&comment="+comment+"&csid="+csid+"&usordid="+usordid;
            	$.ajax({
                    type: "POST",
                    dataType: "html",
                    url: AjaxURL,
                    success: function (data) {
                    	
                    	if(data.isSuccess=="false"){
    	            		alert("提交评价失败，请重新提交!");
    	            		//$("#csorder .errormsg").html(error);
    	            			          
                    	}else { 
    	            		alert("提交评价成功!");
    	            		$("#comment").val("");
    			            var AjaxURL="dealMessage?CSId="+csid;
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
    				                                   $("#csidv").attr("value",csid);
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
    });
    //点击提交评价信息----张伟增加
//    $("#makeComment").click(function(){
//    	USERCheck.isLogin(function(isok,error){
//            if(isok != 'false'){
//            	var act=$("#act").val();
//            	var starsum=$("starsum").val();
//            	var comment=$("#comment").val();
//            	var csid=$("#csidv").val();
//            	var AjaxURL="dealMessage?act="+act+"&starsum="+starsum+"&comment="+comment+"&csid="+csid;
//            	$.ajax({
//                    type: "POST",
//                    dataType: "html",
//                    url: AjaxURL,
//                    success: function (data) {
//                    	if(data.isSuccess=="false"){
//    	            		alert("提交评价失败，请重新提交!");
//    	            		//$("#csorder .errormsg").html(error);
//                    	}else { 
//    	            		alert("提交评价成功!");
//    	            		//$("#csorder .errormsg").html("您的预约请求已提交，请到用户管理中查看订单详情。");
//    	            		//window.location.href = 'userInf.html';
//                    	}
//                    },
//                    error: function(data) {
//                        alert("error:"+data.message);
//                     }
//                });
//            }else { 
//            	alert("您好，请先登录！登录后才能预约");
//                window.location.href = "login.jsp";
//            }
//        },window.MAINURL);
//    });

    $("#makeOrder").on("click",function(){
    	//alert("此功能正在开发中，敬请期待！")
       
    	USERCheck.isLogin(function(isok,error){
            if(isok != false){
            	var id = $("#csorder table").data("id");
                var dateBegin =	 $("#csorder [name='start-date']").val();
                var timeBegin = $("#csorder [name='start-time']").val();
                var dateStop = $("#csorder [name='stop-date']").val();
                var timeStop = $("#csorder [name='stop-time']").val();
                var csId = CsAllData[id].CSId;
                var csName = CsAllData[id].CSName;
                var csAddr = CsAllData[id].CSAddr;
                var csType = $("input[name='cp']:checked").val();
                if(dateBegin==""||timeBegin==""||dateStop==""||timeStop==""){ 
                	$("#csorder .errormsg").html("请输入准确的预约时间");
                	return null;
                }

                USERCheck.produceOrder(csId,dateBegin,timeBegin,dateStop,timeStop,csType,csName,csAddr,function(isok,error){ 
                	if(isok==false){
                		$("#csorder .errormsg").html(error);
                	}else { 
                		$("#csorder .errormsg").html("您的预约请求已提交，请到用户管理中查看订单详情。");
                		//window.location.href = 'userInf.html';
                	}
                },window.MAINURL)
            }else { 
            	alert("您好，请先登录！登录后才能预约");
                window.location.href = "login.jsp";
            }
        },window.MAINURL)
        
    })

	
    
