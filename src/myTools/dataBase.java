package myTools;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  
 
//import org.apache.log4j.Logger;  
 
public class dataBase {  
   // 使用log4j记录日志  
  // private static Logger logger = Logger.getLogger(BaseDao.class);  
   // 连接驱动  
	   private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";  
	   // 连接路径  
	   private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=充电服务系统5.18";  
	   // 用户名  
	   private static final String USERNAME = "sa";  
	   // 密码  
	   private static final String PASSWORD = "sa12345";  
   //静态代码块  
   static {  
       try {  
           // 加载驱动  
           Class.forName(DRIVER);  
       } catch (ClassNotFoundException e) {  
           e.printStackTrace();  
       }  
   }  
 
   /* 
    * 获取数据库连接 
    */  
   public Connection getConnection() {  
       Connection conn = null;  
     //  logger.debug("开始连接数据库"); 
       System.out.println("开始连接数据库");
       try{  
           conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);  
       }catch(SQLException e){  
           e.printStackTrace();  
         //  logger.error("数据库连接失败！");
           System.out.println("数据库连接失败！");
       }  
      // logger.debug("数据库连接成功"); 
       System.out.println("数据库连接成功！");
       return conn;  
   }  
 
   /* 
    * 关闭数据库连接，注意关闭的顺序 
    */  
   public void close(ResultSet rs, PreparedStatement ps, Connection conn) {  
       if(rs!=null){  
           try{  
               rs.close();  
               rs=null;  
           }catch(SQLException e){  
               e.printStackTrace();  
             //  logger.error("关闭ResultSet失败");  
           }  
       }  
       if(ps!=null){  
           try{  
               ps.close();  
               ps=null;  
           }catch(SQLException e){  
               e.printStackTrace();  
              // logger.error("关闭PreparedStatement失败");  
           }  
       }  
       if(conn!=null){  
           try{  
               conn.close();  
               conn=null;  
           }catch(SQLException e){  
               e.printStackTrace();  
              // logger.error("关闭Connection失败");  
           }  
       }  
   }  
}  