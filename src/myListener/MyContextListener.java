package myListener;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import myBean.ApplicationConstants;
import myTools.fileUtil;
import myTools.myTime;

public class MyContextListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		String path="c:/webdata/"+myTime.getTime("yyyyMMdd")+".txt";
		fileUtil.NewFile(path);
		StringBuffer temp = new StringBuffer();
		temp.append("\r\n");
		temp.append("\r\n");
		temp.append("\r\n");
		temp.append("//**************************分割线开始**********************************//");
		temp.append("\r\n");
		temp.append(myTime.getTime("yyyy-MM-dd HH:mm:ss"));
		temp.append("\r\n");
		temp.append(" 	服务器启动时间：");temp.append(DateFormat.getDateTimeInstance().format(ApplicationConstants.START_DATE));
		temp.append("\r\n");
		temp.append("	累计共接待过:");temp.append(ApplicationConstants.TOTAL_HISTORY_COUNT);temp.append("位访客");
		temp.append("\r\n");
		temp.append("	APP下载总数:");temp.append(ApplicationConstants.TOTAL_APPDOWNLOAD_COUNT);
		temp.append("\r\n");
		temp.append("	最高在线人数:");temp.append(ApplicationConstants.MAX_ONLINE_COUNT);temp.append("。发生在:");temp.append(ApplicationConstants.MAX_ONLINE_COUNT_DATE);
		temp.append("\r\n");
		temp.append("//**************************分割线结束**********************************//");
		temp.append("\r\n");
		try {
			fileUtil.ForOPSWriter(temp.toString(), path);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ApplicationConstants.START_DATE=null;
		ApplicationConstants.MAX_ONLINE_COUNT_DATE=null;
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		// TODO ����������ʱ����
		ApplicationConstants.START_DATE=new Date();//��¼����������ʱ��
	}

}
