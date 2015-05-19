
function checkname(){
                var div = document.getElementById("div1");
                div.innerHTML = "";
                var name1 = document.form.username.value;
               
                if (name1 == "") {
                    div.innerHTML = "用户名不能为空！";
                    document.form.username.focus();
                    return false;
                }
                if (name1.length<4||name1.length>16) {
                    div.innerHTML = "请输入长度为4-16个字符！";
                    document.form.username.select();
                    return false;
                }
                var charname1 = name1.toLowerCase();
                for (var i = 0; i < name1.length; i++) {
                    var charname = charname1.charAt(i);
                    if (!(charname >= 0 && charname <= 9) && (!(charname >= 'a' && charname <= 'z')) && (charname != '_')) {
                        div.innerHTML = "用户名包含非法字母，只能包含字母，数字，和下划线";
                        document.form.username.select();
                        
                        return false;
                    }
                }
                return true;
                
            }
     
function checkpassword(){
                var div = document.getElementById("div2");
                div.innerHTML = "";
                var password = document.form.password.value;
                if (password == "") {
                    div.innerHTML = "密码不位空！";
                    document.form.password.focus();
                    return false;
                }
                if (password.length<4||password.length>12) {
                    div.innerHTML = "密码长度4-12位";
                    document.form.password.select();
                    return false;
                }
                return true;
            }
 
function checklogin(){
                if (checkname() && checkpassword()) {
                    return true;
                }
                else {
                    return false;
                }
            }