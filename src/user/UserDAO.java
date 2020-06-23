package user;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DatabaseUtil;


public class UserDAO {

	

	public int login(String userID, String userPassword) {

		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
	
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			if(rs.next()) {
    
				if(rs.getString(1).equals(userPassword))

					return 1; // login successfully

				else

					return 0; // Invalid password

			}

			return -1; // No username in DB

		} catch (SQLException e) {

			e.printStackTrace();

		

		}finally {
			
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}

		return -2; 

	}

	 

	public int join(UserDTO user) {

		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, false)";
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
	
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		

		}finally {
			
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}

		return -1; 
	}

	

	public boolean getUserEmailChecked(String userID) {

		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
	
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getBoolean(1);

		} catch (SQLException e) {

			e.printStackTrace();

		

		}finally {
			
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}

		return false;
	}
	
	public boolean setUserEmailChecked(String userID) {

		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
	
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			pstmt.executeUpdate();
			return true;

		} catch (SQLException e) {

			e.printStackTrace();

		

		}finally {
			
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}

		return false; 
	}
	
	public String getUserEmail(String userID) {

		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
	
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);

		} catch (SQLException e) {

			e.printStackTrace();

		

		}finally {
			
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}

		return null;
	}
	
	public String getUserPassword(String userID) {

		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
	
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);

		} catch (SQLException e) {

			e.printStackTrace();

		

		}finally {
			
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}

		return null; //  db¿À·ù
	}

}

