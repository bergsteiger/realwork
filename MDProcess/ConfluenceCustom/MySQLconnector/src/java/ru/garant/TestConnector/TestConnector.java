package ru.garant.TestConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import com.mysql.jdbc.MysqlErrorNumbers;

public class TestConnector{
	private Connection conn = null;

	//static private TestConnector iam = null;

	public TestConnector (Connection conn) {
		this.conn = conn;
	}

	public static void main (String [] args) {
		try {
            // The newInstance() call is a work around for some
            // broken Java implementations

            Class.forName ("com.mysql.jdbc.Driver").newInstance ();
			//Class theDriver = com.mysql.jdbc.Driver.class;
			//Class theDriver = com.mysql.jdbc.Driver.class;

            Connection conn = DriverManager.getConnection (
            		"jdbc:mysql://localhost:3306/mytestdb?autoReconnect=true&useUnicode=true&"
            		//"jdbc:mysql://localhost/test?" +
            		+ "user=root&password=q"
            );
            //junit.textui.TestRunner.run(TestConnector.class);
            TestConnector o = new TestConnector (conn);
            //o.printTable("label", "*", null);
            o.executeUpdate("INSERT INTO test (doc_id, check_sum) VALUE (2111, 'qweqeeqweqweq')");
		} catch (SQLException e) {
			printErr (e, "main");
		} catch (Exception e) {
            // handle the error
			System.err.println ("main Exception: " + e.getMessage ());
        }
	}

	public void executeUpdate (String query) throws Exception {
		Statement stmt = null;
		try {
			stmt = this.conn.createStatement ();

			//query = "SHOW TABLES";
		    //rs = stmt.executeQuery (query);
		    // or alternatively, if you don't know ahead of time that
		    // the query will be a SELECT...
		    int res = stmt.executeUpdate (query);
		    System.out.println ("executeUpdate: res=" + res);
		} catch (SQLException e) {
			if (e.getErrorCode() == MysqlErrorNumbers.ER_NO_SUCH_TABLE) {
				//stmt.executeUpdate ("CREATE TABLE testtbl ()");
			}
			throw (e);
		} finally {
		    // it is a good idea to release
		    // resources in a finally{} block
		    // in reverse-order of their creation
		    // if they are no-longer needed
		    if (stmt != null) {
		        try {
		            stmt.close ();
		        } catch (SQLException e) {
		        	printErr (e, "executeUpdate:stmt.close");
		        }
		        stmt = null;
		    }
		}
	}

	public void printTable (String tblName, String colName, String cond) throws Exception {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = this.conn.createStatement ();

			String query = new String ("SELECT " + colName + " FROM " + tblName);
			if (cond != null) {
				query += "WHERE " + cond;
			}
			//query = "SHOW TABLES";
		    //rs = stmt.executeQuery (query);
		    // or alternatively, if you don't know ahead of time that
		    // the query will be a SELECT...
		    if (stmt.execute (query)) {
		        rs = stmt.getResultSet ();
		    }
		    int i = 0;
			while (rs.next ()) {
				rawOut (i++, rs);
			}
		} finally {
		    // it is a good idea to release
		    // resources in a finally{} block
		    // in reverse-order of their creation
		    // if they are no-longer needed
		    if (rs != null) {
		        try {
		            rs.close ();
		        } catch (SQLException e) {
		        	printErr (e, "printTable:rs.close");
		        }
		        rs = null;
		    }
		    if (stmt != null) {
		        try {
		            stmt.close ();
		        } catch (SQLException e) {
		        	printErr (e, "printTable:stmt.close");
		        }
		        stmt = null;
		    }
		}
	}
	private void rawOut (int iRow, ResultSet rs) throws Exception {
		ResultSetMetaData md = rs.getMetaData ();
		String sRow = new String ();
		int len = md.getColumnCount ();
		for (int i = 1; i <= len; ++i) {
			int step = 0;
			try {
				sRow += md.getColumnName (i);
				sRow += "(" + md.getColumnLabel (i) + ") = ";
				sRow += "'" + rs.getString (i) + "'";
				sRow += " of " + md.getColumnTypeName (i) + "; ";
			} catch (Exception e) {
				System.err.println ("rawOut Exception: row=" + iRow + ",col=" + i + ": " + e.getMessage () + " on step " + step);
			}
		}
		System.out.println (iRow + ": " + sRow);
	}

	static private void printErr (SQLException e, String funcName) {
		// handle any errors
	    System.err.println (funcName + " SQLException: " + e.getMessage ());
	    System.err.println (funcName + " SQLState: " + e.getSQLState ());
	    System.err.println (funcName + " VendorError: " + e.getErrorCode ());
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
