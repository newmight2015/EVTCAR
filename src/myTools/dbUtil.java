package myTools;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  

import org.apache.log4j.Logger;
 
//import org.apache.log4j.Logger;  
/**
 * SQL���ݿ����ӹ��߰�
 * @author stando
 *
 */
public class dbUtil {
       private static Logger logger = Logger.getLogger(dbUtil.class);  
      // 
	   private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";  
	   // 
	   private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=充电服务系统6.5";  
	   //
	   private static final String USERNAME = "sa";  
	   //
	   private static final String PASSWORD = "sa12345";  

	   private Connection con = null;
	   
	   private PreparedStatement ps = null ;
	   
	   private ResultSet rs = null;
	   
	   private int resu = 0;
	   static {  
	       try {  
	           Class.forName(DRIVER);  
	       } catch (ClassNotFoundException e) {  
	           e.printStackTrace();  
	       }  
	   }  
	   public dbUtil(){
		   con = this.getConnection();
	   }
	   public Connection getConnection() {  
	       Connection conn = null;  
	       logger.info("****开始连接数据库!****");
	       //System.out.println("****开始连接数据库dbUtil****");
	       try{  
	           conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);  
	       }catch(SQLException e){  
	           e.printStackTrace();
	           logger.error("****数据库连接失败！***");
	           //System.out.println("****数据库连接失败！***");
	       }  
	       //System.out.println("****数据库连接成功！****");
	       return conn;  
	   }  
	 /**
	  * 关闭数据库
	  */
	   public void closeAll() {  
	       if(rs!=null){  
	           try{  
	               rs.close();  
	               rs=null;  
	           }catch(SQLException e){  
	               e.printStackTrace();  
	           }  
	       }  
	       if(ps!=null){  
	           try{  
	               ps.close();  
	               ps=null;  
	           }catch(SQLException e){  
	               e.printStackTrace();   
	           }  
	       }  
	       if(con!=null){  
	           try{  
	               con.close();  
	               con=null;  
	           }catch(SQLException e){  
	               e.printStackTrace();  
	           }  
	       }  
	       logger.info("****数据库关闭成功!****");
	   }
	   
	   
	   /**  
	    * @param sql 更新语句     
	    * @param pras  语句中要输入的变量，用字符数组存放
	    * @return  调用 db.getResu()获取返回的影响条数，初始为0；
	    */  
	   public void update(String sql,String... pras){   
	       try {  
	           ps=con.prepareStatement(sql);  
	           for(int i=0;i<pras.length;i++){  
	               ps.setString(i+1,pras[i]);  
	           }  
	           resu=ps.executeUpdate();  
	       } catch (SQLException e) {  
	           // TODO Auto-generated catch block  
	           e.printStackTrace();  
	       }
	   }  
	 
	   /**  
	    * @param sql 查询语句
	    * @param pras 语句中要输入的变量，用字符数组存放
	    * @return  返回查询结果集
	    */  
	   public ResultSet query(String sql,String... pras){  
	       try {  
	           ps=con.prepareStatement(sql);  
	 
	           if(pras!=null)  
	               for(int i=0;i<pras.length;i++){  
	                   ps.setString(i+1, pras[i]);  
	               }  
	           rs=ps.executeQuery();  
	       } catch (SQLException e) {  
	           // TODO Auto-generated catch block  
	           e.printStackTrace();  
	       }  
	       return rs;  
	       
	   }  
	   /**
	    * 返回更新的影响条数
	    * @return
	    */
	   public int getResu(){
		   return resu;
	   }
	   /**
	    * 返回结果集
	    * @return
	    */
	   public ResultSet getRS(){
		   return rs;
	   }

}
  