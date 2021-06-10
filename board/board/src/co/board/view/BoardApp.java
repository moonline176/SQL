package co.board.view;

import java.util.List;

import co.board.access.BoardAccess;
import co.board.access.BoardDAO;
import co.board.model.Board;
import co.board.util.ScannerUtil;


public class BoardApp {
	BoardAccess BoardList = new BoardDAO();
	
	public void start() {
		int menunum;
		do {
			menuTitle(); //메뉴 출력
			menunum = ScannerUtil.readInt("입력");//메뉴 선택
			switch(menunum) { // 실행
			case 1:  selectAll();	break;
			case 2:  insert();	break;
			case 3:  update();	break;
			case 4:  delete();	break;
			case 5:  selectOne(); break;
			}
		} while(menunum != 0);
	}
	
	private void selectOne() {
		int b_id = ScannerUtil.readInt();
		Board board = BoardList.selectOne(b_id);
		System.out.println(board);
	}

	//등록
	private void insert() {
		Board Board = ScannerUtil.readBoard();
		BoardList.insert(Board);
	}
	//이름으로 검색해서 전화번호 수정
	public void update() {
		Board Board = new Board();
		System.out.println("id입력");
		Board.setB_id(ScannerUtil.readInt());
		System.out.println("수정할 내용 입력");
		Board.setB_content(ScannerUtil.readStr());
		BoardList.update(Board);
	}
	//이름으로 검색해서 삭제
	private void delete() {
		int a = ScannerUtil.readInt();
		BoardList.delete(a);
	}
	
	//전체조회
	public void selectAll() {
		List<Board> list = BoardList.selectAll();
		for(Board Board : list) {
			System.out.println(Board);
		}
	}
	

	//메뉴출력
	public void menuTitle() {
		System.out.println("==게시판 관리==");
		System.out.println("=1. 전체조회 ==");
		System.out.println("=2. 글등록   ==");
		System.out.println("=3. 글수정   ==");
		System.out.println("=4. 글삭제   ==");
		System.out.println("=5.	한건조회 ==");
		System.out.println("=0. 종료    ==");
	}
}
