package visitorBook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class VisitorBookDAO {
	
	//Write visitorBook
	public int write (VisitorBookDTO visitorBookDTO) {
		String SQL = "INSERT INTO VISITORBOOK VALUES (0, ?, ?, ?, NOW(), 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, visitorBookDTO.getUserID().replace("<", "&lt;").replaceAll(">","&gt;").replaceAll("/r/n", "<br>;"));
			pstmt.setString(2, visitorBookDTO.getVisitorBookTitle().replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("/r/n", "<br>;"));
			pstmt.setString(3, visitorBookDTO.getVisitorBookContent().replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("/r/n", "<br>;"));
			return pstmt.executeUpdate(); //Success write
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; //Fail write
	}
	
	public ArrayList<VisitorBookDTO> getList (String orderType, String searchType, String search, int pageNumber) {
		ArrayList<VisitorBookDTO> visitorBookList = null;
		String SQL = "SELECT * FROM VISITORBOOK WHERE 1=1 ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(!search.equals("")) {
				if (searchType.equals("제목")) {
					SQL += "AND visitorBookTitle LIKE ? ";
				} else if (searchType.equals("내용")) {
					SQL += "AND visitorBookContent LIKE ? ";
				} else if (searchType.equals("제목+내용")) {
					SQL += "AND CONCAT(visitorBookTitle, visitorBookContent) LIKE ? ";
				}
			}
			if (orderType.equals("최신순")) {
				SQL += "ORDER BY visitorBookID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if (orderType.equals("추천순")) {
				SQL += "ORDER BY likeCount DESC, visitorBookID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			if(!search.equals("")) {
				pstmt.setString(1, "%" + search + "%");
			}
			rs = pstmt.executeQuery();
			visitorBookList = new ArrayList<VisitorBookDTO>();
			while (rs.next()) {
				VisitorBookDTO visitorBook = new VisitorBookDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getInt(6)
				);
				visitorBookList.add(visitorBook);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return visitorBookList;
	}
	
	//Like
	public int like (String visitorBookID) {
		String SQL = "UPDATE VISITORBOOK SET likeCount = likeCount + 1 WHERE visitorBookID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(visitorBookID));
			return pstmt.executeUpdate(); // 1 , success like
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // fail like
	}
	
	//GetUserID
	public String getUserID (String visitorBookID) {
		String SQL = "SELECT userID FROM VISITORBOOK WHERE visitorBookID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(visitorBookID));
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				return rs.getString(1); //Success getUserID
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null; //Fail getUserID
	}
	
	//Delete visitorBook
	public int delete (String visitorBookID) {
		String SQL = "DELETE FROM VISITORBOOK WHERE visitorBookID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(visitorBookID));
			return pstmt.executeUpdate(); //1, Success delete
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; //Fail delete
	}
	public int deleteLikey (String visitorBookID) {
		String SQL = "DELETE FROM LIKEY WHERE visitorBookID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(visitorBookID));
			return pstmt.executeUpdate(); //1, Success likey
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; //fail likey
	}
}
