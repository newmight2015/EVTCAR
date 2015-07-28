package myListener;

import java.util.Date;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import myBean.ApplicationConstants;

public class MyContextListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO 服务器关闭时调用
		ApplicationConstants.START_DATE=null;
		ApplicationConstants.MAX_ONLINE_COUNT_DATE=null;
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		// TODO 服务器启动时调用
		ApplicationConstants.START_DATE=new Date();//记录服务器启动时间
	}

}
