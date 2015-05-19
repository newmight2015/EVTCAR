function checkname(){
                var div = document.getElementById("div1");
                div.innerHTML = "";
                var name1 = document.form1.username.value;
               
                if (name1 == "") {
                    div.innerHTML = "用户名不能为空！";
                    document.form1.username.focus();
                    return false;
                }
                if (name1.length<4||name1.length>16) {
                    div.innerHTML = "请输入长度为4-16个字符！";
                    document.form1.username.select();
                    return false;
                }
                var charname1 = name1.toLowerCase();
                for (var i = 0; i < name1.length; i++) {
                    var charname = charname1.charAt(i);
                    if (!(charname >= 0 && charname <= 9) && (!(charname >= 'a' && charname <= 'z')) && (charname != '_')) {
                        div.innerHTML = "用户名包含非法字母，只能包含字母，数字，和下划线";
                        document.form1.username.select();
                        
                        return false;
                    }
                }
                return true;
                
            }
          
function checkEmail(){
		    var div = document.getElementById("div2");
		    div.innerHTML = "";
		    var email = document.form1.email.value;
		   
		    var sw = email.indexOf("@", 0);
		    var sw1 = email.indexOf(".", 0);
		    var tt = sw1 - sw;
		    if (email.length == 0) {
		        div.innerHTML = "电子邮件不能位空";
		        document.form1.email.focus();
		        return false;
		    }
		    if (email.indexOf("@", 0) == -1) {
		        div.innerHTML = "电子邮件格式不正确，必须包含@符号！";
		        document.form1.email.select();
		        return false;
		    }
		    if (email.indexOf(".", 0) == -1) {
		        div.innerHTML = "电子邮件格式不正确，必须包含.符号！";
		        document.form1.email.select();
		        return false;
		    }
		    if (tt == 1) {
		        div.innerHTML = "邮件格式不对。@和.不可以挨着！";
		        document.form1.email.select();
		        return false;
		    }
		    if (sw > sw1) {
		        div.innerHTML = "电子邮件格式不正确，@符号必须在.之前";
		        document.form1.email.select();
		        return false;
		    }
		    else {
		        return true;
		    }
		    
		    return ture;
}
 function checkPhoneNum(){
                var div = document.getElementById("div3");
                div.innerHTML = "";
                var name1 = document.form1.tel.value;
               
                if (name1 == "") {
                    div.innerHTML = "电话不能为空！";
                    document.form1.tel.focus();
                    return false;
                }
                
                if (name1.length != 11 && name1.length != 7) {
                    div.innerHTML = "1请输入正确的联系方式";
                    document.form1.tel.select();
                    return false;
                }
                for (var i = 0; i < name1.length; i++) {
                    var charname = name1.charAt(i);
                    if (!(charname >= 0 && charname <= 9)) {
                        div.innerHTML = "请输入数字";
                        document.form1.tel.select();
                        return false;
                    }
                }
                return true;
                
            }           
function checkpassword(){
                var div = document.getElementById("div4");
                div.innerHTML = "";
                var password = document.form1.password.value;
                if (password == "") {
                    div.innerHTML = "密码不位空！";
                    document.form1.password.focus();
                    return false;
                }
                if (password.length<4||password.length>12) {
                    div.innerHTML = "密码长度4-12位";
                    document.form1.password.select();
                    return false;
                }
                return true;
            }
            
 function checkrepassword(){
                var div = document.getElementById("div5");
                div.innerHTML = "";
                var password = document.form1.password.value;
                var repass = document.form1.checkpassword.value;
                if (repass == "") {
                    div.innerHTML = "密码不位空！";
                    document.form1.checkpassword.focus();
                    return false;
                }
                if (password != repass) {
                    div.innerHTML = "输入密码和确认密码长度不一致";
                    document.form1.checkpassword.select();
                    return false;
                }
                return true;
            }
            

function check(){
                if (checkname() && checkEmail() && checkPhoneNum() && checkpassword() && checkrepassword() ) {
                    return true;
                }
                else {
                    return false;
                }
            }