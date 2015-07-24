package myTools;

import java.text.SimpleDateFormat;
import java.util.Date;

public class myTime {
	public static String getTime(String way){
		SimpleDateFormat df = new SimpleDateFormat(way);//way:"yyyy-MM-dd HH:mm:ss"
		String time = df.format(new Date());// new Date()
		return time;
	}
}
