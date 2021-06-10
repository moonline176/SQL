package co.board.util;

import java.text.SimpleDateFormat;
import java.util.Scanner;

import co.board.model.Board;

public class ScannerUtil {
	static Scanner scanner = new Scanner(System.in);

	// 입력받은 값들을 리턴 DateUtil참고
	public static int readInt(String prompt) {
		System.out.println(prompt + ">");
		return readInt();
	}

	public static int readInt() { // 숫자
		int result = 0;
		while (true) {
			try {
				String temp = scanner.next();
				result = Integer.parseInt(temp);
				break;
			} catch (Exception e) {
				System.out.println("숫자 형식이 아닙니다.");
			}
		}
		return result;
	}

	public static String readStr() { // 문자
		String result = null;
		try {
			result = scanner.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	public static String readDate() {// 날짜 + 예외처리같이
		String result = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		do { //일단 실행 후 while 적용
			try {
				result = scanner.next();
				df.parse(result.trim()); //trim:공백제거
				break;
			} catch (Exception e) {
				System.out.println("(yyyyMMdd)날짜 형식이 아닙니다.");
			}
		} while(true);
		return result;
	}
		


	public static Board readBoard() {// friend 객체 , split이용
		System.out.println("제목,내용,작성자>");
		String f = scanner.next();
		String[] arr = f.split(",");
		Board boards = new Board(arr[0],arr[1],arr[2]); //set
		return boards; // 배열이 3이 넘으면 catch에서 안내문 작성
		/*
		 * String result = scanner.next();
		 * String[] arr = f.split(" ");
		 * Friend friends = new Friend();
		 * friend.setGubun(arr[0]);
		 * friend.setName(arr[1]);
		 * friend.setGubun(arr[2]);
		 * return friend;
		 */
	}
}

