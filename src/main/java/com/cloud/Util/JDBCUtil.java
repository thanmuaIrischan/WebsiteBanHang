package com.cloud.Util;

import java.sql.*;
import java.time.LocalDate;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executor;

public class JDBCUtil {
    public static Connection getConnection()
    {
        Connection conn=null;
        try
        {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    //        String url = System.getenv("DB_URL");
    //        String username =  System.getenv("DB_USERNAME");
    //        String password = System.getenv("DB_PASSWORD");
            String url = "jdbc:mysql://34.122.67.95:3306/ShoeStore";
            String username = "cloud";
            String password = "290103";



            conn=DriverManager.getConnection(url,username,password);
            System.out.println(conn);
        }
        catch (SQLException e)
        {
            //TODO Auto-generated catch block
            System.out.println("Connection error...");
            e.printStackTrace();
        }
        return conn;
    }
    public static void closeConnection(Connection conn)
    {
        try {
            if(conn!=null)
            {
                System.out.println("Close connection!");
                conn.close();
            }
        }
        catch (SQLException e)
        {
            //TODO Auto-generated catch block
            e.printStackTrace();
        }

    }


    public static Date getSQLDate(LocalDate date) {
        return java.sql.Date.valueOf(date);
    }

    public static LocalDate getUtilDate(Date sqlDate) {
        return sqlDate.toLocalDate();
    }
}
