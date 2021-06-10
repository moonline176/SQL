package co.board.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO { //db와 연결하기위한 클래스
	public Connection conn;
	
	public DAO(){
		String url = "jdbc:sqlite:C:/sqlite/db/sample.db";
		try {
			conn = DriverManager.getConnection(url); // db와 연결
			System.out.println("연결성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
