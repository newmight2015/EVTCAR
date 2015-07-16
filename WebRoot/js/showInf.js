
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
    var map = new BMap.Map("r-map");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
    map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    //定义经纬度变量；
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
            	varCSMode=$("#changedata [name='changedata4']").val();
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
                		alert(""+error+"");
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
        	opoint = new BMap.Point(sendPos.lng, sendPos.lat);
            var csOperator = $("#select1").data("csoperator");
            var csRange = $("#select2").data("csrange");
            var csParkFee = $("#select3").data("csparkfee");
            var cityName=$("#cityname").val();
            var AjaxURL="dealCsQuery.do?lng="+sendPos.lng+"&lat="+sendPos.lat+"&csOperator="+csOperator
            +"&csRange="+csRange+"&csParkFee="+csParkFee+"&cityName="+cityName;
            alert(AjaxURL);
            $.ajax({
                        type: "GET",
                        dataType: "html",
                        url: AjaxURL,
                       // data: {VehData:JSON.stringify(VehData)},
                        success: function (data) {
                                CsAllData = JSON.parse(data);//存放推荐充电站的数组
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
        }
    })
    
	$("#csorder .cptype :input").on("click",function(){ 
		$("#csorder .cptype :checked").siblings("[name='cp']").removeAttr("checked");
		$(this).prop("checked",true);
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
        USERCheck.isLogin(function(isok,error){
            if(isok != 'false'){
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
                	if(isok=="false"){ 
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

	
    
