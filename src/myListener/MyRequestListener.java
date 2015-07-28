package myListener;

import java.io.IOException;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import myBean.ApplicationConstants;
import myTools.fileUtil;
import myTools.myTime;

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
		session.setAttribute("ip", request.getRemoteAddr());
		String uri = request.getRequestURI();
		String[] suffix={".html",".jsp",".do",".apk"};
		//ָ����׺
		for(int i=0;i<suffix.length;i++){
			if(uri.endsWith(suffix[i])){
				if(i==3){
					ApplicationConstants.TOTAL_APPDOWNLOAD_COUNT++;
					String path="c:/downLog/"+myTime.getTime("yyyyMM")+".txt";
					fileUtil.NewFile(path);
					StringBuffer temp = new StringBuffer();
					temp.append("\r\n");
					temp.append(myTime.getTime("yyyy-MM-dd HH:mm:ss"));
					temp.append("	总计：");
					temp.append(ApplicationConstants.TOTAL_APPDOWNLOAD_COUNT);
					temp.append("	ip：");
					temp.append(request.getRemoteAddr());
					try {
						fileUtil.ForOPSWriter(temp.toString(), path);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
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
		session.setAttribute("activeTimes", activeTimes+1);
	}

}
