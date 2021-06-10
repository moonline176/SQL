package com.yedam.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Predicate;
import java.util.stream.Stream;

import com.yedam.Person;
import com.yedam.PersonDAO;

public class IteratorExample {

	public static void main(String[] args) {
		List<String> list = Arrays.asList("Hong", "Park", "Choi"); // String타입 배열의 'list' 객체변수 생성
		Iterator<String> iter = list.iterator(); // 반복된 요소를 지정 사용하기 위해서 반복자.
		while (iter.hasNext()) {
			String val = iter.next(); //
			System.out.println(val.toUpperCase().length());
		}

		// stream 사용
		System.out.println("<stream>");
		Stream<String> stream = list.stream();
		stream.forEach(new Consumer<String>() {

			@Override
			public void accept(String t) {
				System.out.println(t);
			}
		}); // consumer 오버라이딩

		// sample 요소를 database에서 갖고 오도록 한다.
		System.out.println("<Person List>");
		PersonDAO dao = new PersonDAO();
		dao.getPersonList();
		ArrayList<Person> persons = dao.getPersonList();
		Stream<Person> pStream = persons.stream();
		long cnt = pStream//
				.filter((t) -> t.getAge() > 20) // return 값이 true인 요소들만 다음 stream으로 넘겨줌
				// filter:요소들을 조건에 따라 걸러내는 작업을 해줍니다.
				.filter((t) -> t.getName().startsWith("김"))
				// .forEach((t) -> System.out.println(t.toString())); //갖고 온 데이터 요소들을 하나하나 설정
				.count(); // long형 타입 반환
		System.out.println("최종처리 건수: " + cnt);
	}

}
