package ar.org.centro8.curso.java.connectors;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Connector {
    
    /*
    ///////////// DRIVER BD ///////////////
    
    // MYSQL: 
    private static String driver="com.mysql.cj.jdbc.Driver";    // driver mysql 6 o superior
    private static String driver="com.mysql.jdbc.Driver";       //driver mysql 5
    private static String vendor="mysql";
    
    // POSTGRESQL:
    private static String driver="org.postgresql.Driver";
    private static String vendor="postgresql";
    */
    
    // MARIADB:
    private static String driver="org.mariadb.jdbc.Driver";
    private static String vendor="mariadb";
  
    ///////////// REMOTA FREEDB BD NEGOCIOROPAWEB:////////////
    private static String server="freedb.tech";
    private static String port="3306";
    private static String db="freedbtech_negocioRopaWeb";
    private static String user="freedbtech_negocioRopaWeb";
    private static String pass="centro8";
    private static String params="";  
    /*
    ///////////// REMOTA POSTGRE BD NEGOCIOROPAWEB:////////////
    private static String server="motty.db.elephantsql.com";
    private static String port="5432";
    private static String db="ebqvseru";
    private static String user="ebqvseru";
    private static String pass="O1d_3PdcBcQI5QcTkGW9ePfJOTR9dNvy";
    private static String params="";  
    
 /* 
    ///////////// BD LOCAL ///////////////
    
    private static String server="localhost";
    private static String port="3306";
    private static String db="negocioWebRopa";
    private static String params="?serverTimezone=UTC";
    private static String user="root";
    private static String pass="";
   
   */     
  
    
    private static String url="jdbc:"+vendor+"://"+server+":"+port+"/"+db+params;
    
    private static Connection conn=null;
    
    private Connector(){ }
    
    public synchronized static Connection getConnection(){
        try{
            if(conn==null || conn.isClosed()){
                Class.forName(driver);
                conn=DriverManager.getConnection(url, user, pass);
            }
        }catch(SQLException e) { System.out.println("Problema de conexión");
        }catch(ClassNotFoundException e) { System.out.println("No se encontro el driver");
        }catch(Exception e){ System.out.println(e); }
        return conn;
    }
}