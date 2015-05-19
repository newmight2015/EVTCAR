package myServlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//import myBean.SessionCounter;
import myBean.usInformation;
/**
 * 用户退出Servlet
 * 
 * @author lixiyu
 */
public class dealExit extends HttpServlet {
	private static final long serialVersionUID = 1599366365079846238L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取session
		HttpSession session = request.getSession();
		// 获取用户对象
		usInformation usInf = (usInformation)session.getAttribute("usInf");
		//String username = (String) session.getAttribute("username");
		// 判断用户是否有效
		if(usInf != null){
			// 将用户对象逐出session
			session.removeAttribute("usInf");
			//session.invalidate();
			//ServletContext application = (ServletContext)session.getServletContext();
			//实现显示在线人数功能
//			List onlineUserList = (List) application.getAttribute("onlineUserList");
//		    onlineUserList.remove(username);
	    	//System.out.println(SessionCounter.getActiveSessions());
			// 设置提示信息
			//request.setAttribute("info", usInf.getUsId() + " 已成功退出！");
		}else{
			System.out.println("usInf不存在");
		}
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}

