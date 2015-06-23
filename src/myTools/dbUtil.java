package myTools;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  
 
//import org.apache.log4j.Logger;  
/**
 * SQL���ݿ����ӹ��߰�
 * @author stando
 *
 */
public class dbUtil {
	   // ʹ��log4j��¼��־  
	  // private static Logger logger = Logger.getLogger(BaseDao.class);  
	   // ��������  
		   private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";  
		   // ����·��  
		   private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=充电服务系统6.5";  
		   // �û���  
		   private static final String USERNAME = "sa";  
		   // ����  
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
       System.out.println("****开始连接数据库dbUtil****");
       try{  
           conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);  
       }catch(SQLException e){  
           e.printStackTrace();  
           System.out.println("****数据库连接失败！***");
       }  
       System.out.println("****数据库连接成功！****");
       return conn;  
   }  
 /**
  * �ر�����
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
   }
   
   public void ExcuteQuery(String condition){ //ִ�в�ѯ����
	   try {
			 ps = con.prepareStatement(condition);
			 rs = ps.executeQuery();
			while (rs.next()) {
				rs.getFloat(3);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.closeAll();
		}
   }
   
   /**  
    * @param sql���ݿ����(����ɾ����) ���      
    * @param pras�����б��ɴ����ɲ���������ΪNULL����������ʽ���ڣ�  
    * @return ������Ӱ�춼����  
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
    * @param sql���ݿ��ѯ���  
    * @param pras�����б��ɴ����ɲ���������ΪNULL����������ʽ���ڣ�  
    * @return ���ؽ����  
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
    * ��ȡ���²�����Ӱ������
    * @return
    */
   public int getResu(){
	   return resu;
   }
   public ResultSet getResultSet(){
	   return rs;
   }

}
  