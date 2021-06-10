package co.board.access;

import java.util.ArrayList;

import co.board.model.Board;



public interface BoardAccess {
		//1.전체조회
		public ArrayList<Board> selectAll();
		
		//2.글등록
		public void insert(Board board);
		
		//3.글수정
		public void update(Board board);
		
		//4.글삭제
		public void delete(int b_id);
		
		//5.단건조회
		public Board selectOne(int b_id);
		
		

}
