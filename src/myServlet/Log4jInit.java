package myServlet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
/**
 * log4j控制台文件输出，初始化配置文件
 * @author Administrator
 *
 */
public class Log4jInit extends HttpServlet {

	public void destroy() {
	super.destroy(); 
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {}
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {}
	
	public void init() throws ServletException {
		String prefix = getServletContext().getRealPath("/");
		String file = getServletConfig().getInitParameter("log4j"); //是web.xml中的参数
		if (file != null) {
			PropertyConfigurator.configure(prefix + file);
		}
		Logger log = Logger.getLogger(Log4jInit.class);
		log.info("Logg4j日志已经初始化。");
	}
}