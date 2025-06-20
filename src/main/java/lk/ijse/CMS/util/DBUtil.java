package lk.ijse.CMS.util;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static BasicDataSource dataSource;

    static {
        dataSource = new BasicDataSource();
        dataSource.setUrl("jdbc:mysql://localhost:3306/cms_db");
        dataSource.setUsername("root");
        dataSource.setPassword("Cb@IJSE#JDBC");
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setInitialSize(5);
        dataSource.setMaxTotal(10);
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
