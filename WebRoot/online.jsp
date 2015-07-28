<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Date" import="java.text.DateFormat" 
		 import="myBean.usInformation" import="myBean.ApplicationConstants"%>
		 <script type="text/javascript" src="js/jquery.js"></script>
  <body>
  服务器启动时间：<%=DateFormat.getDateTimeInstance().format(ApplicationConstants.START_DATE) %>,
 累计共接待过<%=ApplicationConstants.TOTAL_HISTORY_COUNT %>访客。</br>
 目前在线总人数：<%=ApplicationConstants.SESSION_MAP.size() %>，登录用户：<%=ApplicationConstants.CURRENT_LOGIN_COUNT %>。
APP下载总数：<%=ApplicationConstants.TOTAL_APPDOWNLOAD_COUNT %>。</br>
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
</body>