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
 * �û��˳�Servlet
 * 
 * @author lixiyu
 */
public class dealExit extends HttpServlet {
	private static final long serialVersionUID = 1599366365079846238L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ��ȡsession
		HttpSession session = request.getSession();
		// ��ȡ�û�����
		usInformation usInf = (usInformation)session.getAttribute("usInf");
		//String username = (String) session.getAttribute("username");
		// �ж��û��Ƿ���Ч
		if(usInf != null){
			session.removeAttribute("usInf");
		}else{
			System.out.println(usInf+"退出登录失败");
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	this.doGet(request, response);
}

}

