package co.board.access;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.board.model.Board;
import co.board.util.DAO;

public class BoardDAO extends DAO implements BoardAccess  {
	PreparedStatement psmt;
	ResultSet rs;
	String sql;
	
	@Override
	public ArrayList<Board> selectAll() {
		ArrayList<Board> bList = new ArrayList<>();
		try {
			psmt = conn.prepareStatement("select * from board");
			rs = psmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setB_id(rs.getInt("b_id"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_writer(rs.getString("b_writer"));
				bList.add(board); // 데이터건수만큼 ArrayList담아서 반환.
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bList;
	}

	@Override
	public void insert(Board board) {
		String sql = "insert into board (b_title, b_content, b_writer) values (?,?,?)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, board.getB_title());
			psmt.setString(2, board.getB_content());
			psmt.setString(3, board.getB_writer());
			int r = psmt.executeUpdate(); // insert, update, delete 할 때 execute사용
			System.out.println(r + "건 입력.");
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}

	@Override
	public void update(Board board) {
		String sql = "update board set b_content=? where b_id=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, board.getB_content());
			psmt.setInt(2, board.getB_id());
			int r = psmt.executeUpdate();
			System.out.println(r + "건 변경되었습니다.");
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}

	@Override
	public void delete(int b_id) {
		String sql = "delete from board where b_id = ?";

		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, b_id);
			int r = psmt.executeUpdate();
			if (r == 0) {
				System.out.println("글 삭제 실패");
			} else {
				System.out.println("글 삭제 성공");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}

	@Override
	public Board selectOne(int b_id) {
		String sql = "select * from board where b_id = ?";
		Board b = null;
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, b_id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				b = new Board();
				b.setB_title(rs.getString("b_title"));
				b.setB_content(rs.getString("b_content"));
				b.setB_writer(rs.getString("b_writer"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
// PreparedStatement 객체생성.
		
	}
		return b;

	}
}