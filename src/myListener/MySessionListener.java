package myListener;

import java.util.Date;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import myBean.ApplicationConstants;

public class MySessionListener implements HttpSessionListener,HttpSessionAttributeListener {

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		HttpSession session = se.getSession();
		ApplicationConstants.SESSION_MAP.put(session.getId(), session);
		ApplicationConstants.TOTAL_HISTORY_COUNT++;//更新总人数
		if(ApplicationConstants.SESSION_MAP.size()>ApplicationConstants.MAX_ONLINE_COUNT){
			ApplicationConstants.MAX_ONLINE_COUNT=ApplicationConstants.SESSION_MAP.size();//更新最大在线人数
			ApplicationConstants.MAX_ONLINE_COUNT_DATE=new Date();//更新时间
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		HttpSession session = se.getSession();
		ApplicationConstants.SESSION_MAP.remove(session.getId());
	}

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		if(event.getName().equals("usInf")){
			ApplicationConstants.CURRENT_LOGIN_COUNT++;
			HttpSession session=event.getSession();
			for(HttpSession sess : ApplicationConstants.SESSION_MAP.values()){
				if(event.getValue().equals(sess.getAttribute("usInf"))
						&&session.getId() != sess.getId()){
					System.out.println("@__________event sessionAdd 失效---->"+sess.getId());
					sess.invalidate();//使session失效
				}
			}
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		if(event.getName().equals("usInf")){
			ApplicationConstants.CURRENT_LOGIN_COUNT--;
		}
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		if(event.getClass().equals("usInf")){
			HttpSession session=event.getSession();
			//重新登录session
			for(HttpSession sess : ApplicationConstants.SESSION_MAP.values()){
				//如果账号在其他机器上登录过，则以前的使登录失效
				if(event.getValue().equals(sess.getAttribute("usInf"))
						&&session.getId() != sess.getId()){
					System.out.println("@__________event sessionReplaced 失效---->"+sess.getId());
					sess.invalidate();//使session失效
				}
			}
		}
	}

}
