//用户信息验证
//

var USERCheck = { 
    MAINURL: "localhost:8080/EVTcar2",
    _trim:function(str){ 
        return $.trim(str);
    },
    _callback:function(callback,isok,error,data){ 
        if(callback!==null){
            callback(isok,error,data)
        }
        return error;
    },
    showErr:function(msg){ 
    	 $(".map-messagebox .message").html(msg);
         $(".map-messagebox").show(1000,function(){setTimeout(function(){$(".map-messagebox").hide(1000)},2000) });
    },
    //功能：验证是否登录
    //参数：验证成功后的回调函数（callback)、向服务器发送的地址（url)
    //返回：验证是否成功的信息，成功：已经登录，失败：请先登录
    isLogin:function(callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"/dealMessage",
            type:"GET",
            dataType:"json",
            data:{act:'checkLogin'},
            success:function(data){
                return _this._callback(callback,data.isSuccess,data.message,data)
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
    //功能：校验验证码
    //参数：验证成功后的回调函数（callback)、向服务器发送的地址（url)
    //返回：验证是否成功的信息，成功：已经登录，失败：请先登录
    checkCode:function(code,callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"/dealMessage",
            type:"GET",
            dataType:"json",
            data:{act:'checkCode',code:code},
            success:function(data){
                return _this._callback(callback,data.isSuccess,data.message,data)
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
    //功能：用户注册
    //参数：注册成功后的回调函数（callback)、向服务器发送的地址（url)
    //返回：注册是否成功的信息，成功：注册成功，失败：注册失败
    userRegister:function(callback,url){ 
        var _this = this;
        var username = $.trim($(":input[name='username']").val());
        var email = $.trim($(":input[name='email']").val());
        var tel = $.trim($(":input[name='tel']").val());
        var password = $.trim($(":input[name='password']").val());
        $.ajax({ 
            url:url+"/dealPhoneRegister.do",
            type:"POST",
            dataType:"json",
            data:{
            	username:username,
            	email:email,
            	tel:tel,
            	password:password
            },
            success:function(data){
                return _this._callback(callback,data.isSuccess,data.message,data)
            },
            error:function(data){ 
                return _this._callback(callback,false,data.message,data);
            }
        })
    },
    //功能：发送纠错信息----张伟增加15/7/6
    //参数：12项充电桩信息
    //返回：无返回值null
    correctCsInf:function(CSId,CSName,CSAddr,CSDate,CSMode,CSFast,CSlow,Operator,ParkFee,CSPub,CSState,CSPhone,CSNotes,callback,url){
    	var _this = this;
        $.ajax({ 
            url:url+"/dealMessage",
            type:"POST",
            dataType:"json",
            data:{
            	act:'correctCsInf',
            	CSId:CSId,
            	CSName:CSName,
            	CSAddr:CSAddr,
            	CSDate:CSDate,
            	CSMode:CSMode,
            	CSFast:CSFast,
            	CSlow:CSlow,
            	Operator:Operator,
            	ParkFee:ParkFee,
            	CSPub:CSPub,
            	CSState:CSState,
            	CSPhone:CSPhone,
            	CSNotes:CSNotes,
            },
            success:function(data){
                return _this._callback(callback,data.isSuccess,data.message,data)
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
    //功能：发送预约订单信息
    //参数：预约起始时间、电桩id、验证成功后的回调函数（callback)、
    //返回：无返回值 null，跳转至预约订单页
    produceOrder:function(csId,dateBegin,timeBegin,dateStop,timeStop,csType,csName,csAddr,callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"/dealMessage",
            type:"POST",
            dataType:"json",
            data:{
            	act:'produceOrder',
            	dateBegin:dateBegin,
            	timeBegin:timeBegin,
            	dateStop:dateStop,
            	timeStop:timeStop,
            	csId:csId,
            	csType:csType,
            	csName:csName,
            	csAddr:csAddr,
            },
            success:function(data){
                return _this._callback(callback,data.isSuccess,data.message,data)
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
     //功能：查询消息提醒
    //参数：预约起始时间、电桩id、验证成功后的回调函数（callback)、
    //返回：无返回值 null，跳转至预约订单页
    checkMsg:function(callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"dealMessage",
            type:"GET",
            dataType:"html",
            data:{
            	act:'checkMsg',
            },
            success:function(data){
                return _this._callback(callback,true,data,data)
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
    /*
     * 功能：查询历史消息提醒----张伟
     */
    checkOldMsg:function(callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"dealMessage",
            type:"GET",
            dataType:"html",
            data:{
            	act:'checkOldMsg',
            },
            success:function(data){
                return _this._callback(callback,true,data,data)
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
     //功能：查询最新订单
    //参数：预约起始时间、电桩id、验证成功后的回调函数（callback)、
    //返回：无返回值 null，跳转至预约订单页
    checkNewOrder:function(callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"dealMessage",
            type:"GET",
            dataType:"html",
            data:{
            	act:'checkNewOrder',
            },
            success:function(data){
                return _this._callback(callback,true,data,data);
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },
    //功能：查询历史订单
    //参数：预约起始时间、电桩id、验证成功后的回调函数（callback)、
    //返回：无返回值 null，跳转至预约订单页
    checkOldOrder:function(callback,url){ 
        var _this = this;
        $.ajax({ 
            url:url+"dealMessage",
            type:"GET",
            dataType:"html",
            data:{
            	act:'checkOldOrder',
            },
            success:function(data){
                return _this._callback(callback,true,data,data);
            },
            error:function(data){ 
                console.log(data);
                return _this._callback(callback,false,"连接服务器失败，请稍后再试",data);
            }
        })
    },




}

