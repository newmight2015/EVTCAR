<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Date" import="java.text.DateFormat" 
		 import="myBean.usInformation" import="myBean.ApplicationConstants"%>
		 <script type="text/javascript" src="js/jquery.js"></script>
  <body>
  服务器启动时间：<%=DateFormat.getDateTimeInstance().format(ApplicationConstants.START_DATE) %>,
 累计共接待过<%=ApplicationConstants.TOTAL_HISTORY_COUNT %>访客。</br>
 目前在线总人数：<%=ApplicationConstants.SESSION_MAP.size() %>，登录用户：<%=ApplicationConstants.CURRENT_LOGIN_COUNT %>。</br>
 <table border=1>
 	<tr>
 		<th>jsessionid</th>
 		<th>account</th>
 		<th>creationTime</th>
 		<th>lastAccessedTime</th>
 		<th>new</th>
 		<th>activeTimes</th>
 		<th>ip</th>
 	</tr>
 	<%
 		for(String id : ApplicationConstants.SESSION_MAP.keySet()){
 			HttpSession sess = ApplicationConstants.SESSION_MAP.get(id);
 			usInformation usInf = (usInformation)sess.getAttribute("usInf");
 	 %>
 	<tr <%=session == sess ? "bgcolor=#DDDDDD":"" %>>
 		<td><%=id %></td>
 		<td><%= usInf==null ? "&nbsp;" : usInf.getUsId() %></td>
 		<td><%=DateFormat.getDateTimeInstance().format(sess.getCreationTime()) %></td>
 		<td><%=DateFormat.getDateTimeInstance().format(sess.getLastAccessedTime()) %></td>
 		<td><%=sess.isNew() %></td>
 		<td><%=sess.getAttribute("activeTimes") %></td>
 		<td><%=sess.getAttribute("ip") %></td>
 		<%} %>
 	</tr>
 </table>

<!--层遮罩部分-->
<div style="position:absolute;display:none; left:0px; top:0px;" id="tranDiv">
<div style="position:absolute;left:0px; top:0px; width:100%; height:100%;background-color:#000000;filter:alpha(Opacity=30)" id="tranDivBack"> </div> 
<div align='center'style='position:absolute;left:0px; top:0px; width:100%; height:100%; background-color:#e5edf5;background-image:url(images/bestnetqywimg/tccbg.gif);'  id='infoDiv'></div> 
</div> 
<!--层遮罩部分结束-->
<!--弹出层登录-->
<div id="popLayer" style="display:none"><form id="formdl" name="formdl" method="post" action=""><br /><font align="center" color="#0000ff" size="3"><b>---手机号码先登录---</b></font><br /><br />

  <br/>
  <input type="submit" name="Submit" class="bntccanniu" value="登录" /> <input type="button" name="Submit1" class="bntccanniu" value="取消" onclick="closeWindow();"/>
  
</form>
</div> 
<a href="javascript:showWindow();">点击此处看看</a>
</body>
<script language="javascript"> 
//登陆弹出对话框，并使背景元素不可用
var div_width = 300;
var div_height = 200;
function showWindow(width,height){ 
location.href="#";
width = div_width;
height = div_height
var windowstr= document.getElementById("popLayer").innerHTML;
document.getElementById("infoDiv").innerHTML=windowstr; 
document.getElementById("infoDiv").style.left=((document.body.clientWidth-width)>0?(document.body.clientWidth-width):0)/2+"px"; 
document.getElementById("infoDiv").style.top=200+"px"; 
document.getElementById("infoDiv").style.zIndex=10001;
document.getElementById("infoDiv").style.width=width; 
document.getElementById("infoDiv").style.height=height; 
document.getElementById("infoDiv").style.border="3px solid #0099ff";
document.getElementById("tranDiv").style.height=document.body.clientHeight+ "px"; 
document.getElementById("tranDiv").style.width=document.body.clientWidth+ "px"; 
document.getElementById("tranDiv").style.display=""; 
document.getElementById("tranDivBack").style.display=""; 
document.getElementById("tranDivBack").style.zIndex=10000;
document.getElementById("infoDiv").style.display=""; 
} 
function closeWindow(){ 
document.getElementById("tranDiv").style.display="none"; 
} 

</script> 