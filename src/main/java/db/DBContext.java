package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Le Phong Vinh - CE181130
 */
/**
 * DBContext provides basic JDBC database connection and utility methods for
 * executing queries. Designed as a base class for DAOs in the project.
 */
public class DBContext {

    // Holds the database connection (not reused in this pattern)
    private Connection conn;

    // Database connection string (change according to your DB config)
    private final String DB_URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=HospitalDB3;encrypt=false";
    private final String DB_USER = "sa";         // DB username
    private final String DB_PWD = "123456";      // DB password

    /**
     * Constructor loads the SQL Server JDBC driver. Required once for all
     * DBContext instances.
     */
    public DBContext() {
        try {
            // Dynamically load the JDBC driver class (required for some environments)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ex) {
            // Log severe error if the driver is missing
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Opens and returns a new Connection to the database. Each call returns a
     * new connection.
     *
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
    }

    /**
     * Executes a SELECT SQL query with optional parameters. Returns a ResultSet
     * with the result (the caller must close it!).
     *
     * @param query SQL query (may contain ? placeholders for parameters)
     * @param params Array of parameters to substitute (or null)
     * @return ResultSet of query results (caller must close)
     * @throws SQLException on error
     */
    public ResultSet executeSelectQuery(String query, Object[] params) throws SQLException {
        // Prepare statement with parameterized SQL to prevent SQL injection
        PreparedStatement statement = this.getConnection().prepareStatement(query);
        if (params != null) {
            // Set all provided parameters in order (1-based index for JDBC)
            for (int i = 0; i < params.length; i++) {
                statement.setObject(i + 1, params[i]);
            }
        }
        // Execute and return the result set
        return statement.executeQuery();
    }

    /**
     * Executes an UPDATE/INSERT/DELETE SQL query with optional parameters.
     * Returns the number of rows affected.
     *
     * @param query SQL query (may contain ? placeholders)
     * @param params Array of parameters to substitute (or null)
     * @return Number of rows affected
     * @throws SQLException on error
     */
    public int executeQuery(String query, Object[] params) throws SQLException {
        // Prepare statement with parameterized SQL
        PreparedStatement statement = this.getConnection().prepareStatement(query);
        if (params != null) {
            // Set all provided parameters
            for (int i = 0; i < params.length; i++) {
                statement.setObject(i + 1, params[i]);
            }
        }
        // Execute and return row count
        return statement.executeUpdate();
    }
}
