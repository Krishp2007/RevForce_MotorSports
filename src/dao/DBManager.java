package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {
    private static final String URL = "jdbc:mysql://localhost:3306/revForce_motosports";
    private static final String USER = "YOUR_USERNAME";
    private static final String PASS = "YOUR_PASSWORD";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
