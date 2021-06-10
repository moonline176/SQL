package com.yedam;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

public class PersonDAO {
	static PreparedStatement psmt;
	static ResultSet rs;
	static Connection conn;

	// 1.조회 2.입력 3.수정 4.삭제 5.전체리스트(각각 기능을 분리) => 메소드로 기능분리.

	// 전체리스트
	public ArrayList<Person> getPersonList() {
		ArrayList<Person> personList = new ArrayList<Person>(); // <>내부에 Person을 생략할 수 있지만 구분 하기 편하게하기 위해 사용
		connect(); // Connection객체 연결
		String sql = "select * from person";
		try {
			psmt = conn.prepareStatement(sql); // PreparedStatement 쿼리를 실행, 결과를 받는 역할 / 공식처럼 쓰임
			rs = psmt.executeQuery(); // 쿼리실행결과를 가져오는 부분.
			while (rs.next()) {
				// System.out.println(rs.getInt("id"));
				Person person = new Person();
				person.setId(rs.getInt("id"));
				person.setName(rs.getString("name"));
				person.setAge(rs.getInt("age"));
				person.setPhone(rs.getString("phone"));
				personList.add(person);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(); // try.catch부문에 finally 사용할 것
		}
		return personList;
	}

	// 단건조회
	public static Person getPerson(int id) {
		connect();
		String sql = "select * from person where id = ?";
		Person p = null;
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				p = new Person();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setAge(rs.getInt("age"));
				p.setPhone(rs.getString("phone"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(); // try.catch부문에 finally 사용할 것
		}

// PreparedStatement 객체생성.
		return p;
	}

	// 입력기능
	public static void insertPerson(int id, String name, int age, String phone) {
		connect();
		String sql = "insert into person values (?,?,?,?)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, id);
			psmt.setString(2, name);
			psmt.setInt(3, age);
			psmt.setString(4, phone);
			int r = psmt.executeUpdate(); // insert, update, delete 할 때 execute사용
			System.out.println(r + "건 입력.");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(); // try.catch부문에 finally 사용할 것
		}

	}

	// 수정기능
	public static void updatePerson(Person p) {
		connect();
		String sql = "update person set name=?,age=?,phone=? where id=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, p.getName());
			psmt.setInt(2, p.getAge());
			psmt.setString(3, p.getPhone());
			psmt.setInt(4, p.getId());
			int r = psmt.executeUpdate();
			System.out.println(r + "건 변경되었습니다.");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

	}

	// 삭제기능
	public static void deletePerson(int id) {

		connect();
		String sql = "delete from person where id = ?";

		try {
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, id);
			int r = psmt.executeUpdate();
			if (r == 0) {
				System.out.println("회원정보를 실패");
			} else {
				System.out.println("회원정보 삭제");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(); // try.catch부문에 finally 사용할 것
		}
	}

	// Connection 객체 얻어오는 부분.
	public static void connect() {

		String url = "jdbc:sqlite:C:/sqlite/db/sample.db";
		try {
			conn = DriverManager.getConnection(url); // db와 연결
			System.out.println("연결성공");

			// sqlite 실행결과를 가져옴

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public static void close() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (psmt != null) {
			try {
				psmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
