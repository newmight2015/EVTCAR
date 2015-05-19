
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

    function eachAllCs(point,marker,info,searchInfoWindow){//输出地图覆盖物
            $.each(CsAllData, function(i, content){
                                point[i] = new window.BMap.Point(CsAllData[i].lng,CsAllData[i].lat); //循环生成新的地图点
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
                                            '</br>地址：'+CsAllData[i].csAddr+'</br>充电桩总数：'+CsAllData[i].csAllNum+
                                            '</br>快充个数:'+CsAllData[i].csFastNum+'</br>慢充个数:'+CsAllData[i].csSlowNum+'</br>空闲充电桩数：0';
                               //创建百度样式检索信息窗口对象                       
                                searchInfoWindow[i] = new BMapLib.SearchInfoWindow(map, info[i], {
                                        title  : CsAllData[i].csName,      //标题
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
                            });
        }

    $("#search").on("click",function(){
    	$(".select-section").hide(300);
        if(sendPos.lat==""){
            $(".map-messagebox .message").html("请输入您的位置");
            $(".map-messagebox").show(1000,function(){setTimeout(function(){$(".map-messagebox").hide(1000)},2000) });
        }else {
            var AjaxURL="dealPhoneQuery.do?lng="+sendPos.lng+"&lat="+sendPos.lat;
            var opoint = new BMap.Point(sendPos.lng,sendPos.lat);
            map.centerAndZoom(opoint, 13);
            $.ajax({
                        type: "GET",
                        dataType: "html",
                        url: AjaxURL,
                       // data: {VehData:JSON.stringify(VehData)},
                        success: function (data) {
                                CsAllData = JSON.parse(data);
                                var point = new Array(); //存放标注点经纬信息的数组
                                var marker = new Array(); //存放标注点对象的数组
                                var info = new Array(); //存放提示信息窗口对象的数组
                                var searchInfoWindow =new Array();//存放检索信息窗口对象的数组
                                eachAllCs(point,marker,info,searchInfoWindow);
                        },
                        error: function(data) {
                            alert("error:"+data.responseText);
                         }
                    });  
        }
    })
