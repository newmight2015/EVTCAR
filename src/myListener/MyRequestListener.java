package myListener;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class MyRequestListener implements ServletRequestListener {

	@Override
	public void requestDestroyed(ServletRequestEvent event) {
		// TODO Auto-generated method stub

	}

	@Override
	public void requestInitialized(ServletRequestEvent event) {
		// TODO Auto-generated method stub
		HttpServletRequest request = (HttpServletRequest)event.getServletRequest();
		HttpSession session = request.getSession(true);
		session.setAttribute("ip", request.getRemoteAddr());//记录IP地址
		String uri = request.getRequestURI();
		String[] suffix={".html",".jsp",".do"};
		//指定后缀
		for(int i=0;i<suffix.length;i++){
			if(uri.endsWith(suffix[i])){
				break;
			}
			if(i==suffix.length-1){
				return;
			}
		}
		Integer activeTimes=(Integer)session.getAttribute("activeTimes");
		if(activeTimes==null){
			activeTimes = 0;
		}
		session.setAttribute("activeTimes", activeTimes+1);//更新访问次数
	}

}
