package myBean;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
public class ApplicationConstants{
	
	public static Map<String,HttpSession>SESSION_MAP=new HashMap<String,HttpSession>();//索引所有session
	public static int CURRENT_LOGIN_COUNT=0;//当前登录用户数
	public static int TOTAL_HISTORY_COUNT=0;//历史访问总数
	public static Date START_DATE=new Date();//服务器启动时间
	public static Date MAX_ONLINE_COUNT_DATE =new Date();//最高在线时间
	public static int MAX_ONLINE_COUNT=0;//最高在线人数
	
} 