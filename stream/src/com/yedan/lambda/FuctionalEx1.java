package com.yedan.lambda;
interface Run {
	void run(); //Run이라는 이름만 정의
}
class RunCls implements Run{ // 여기서 run클래스를 구현함

	@Override
	public void run() {
		System.out.println("달립니다.");
	}
	
}
public class FuctionalEx1 {
	public static void main(String[] args) {
		RunCls cls = new RunCls();
		cls.run(); 
		
		Run r = () -> System.out.println("빨리 달립니다"); //람다 표현식
		/*람다의 표현식
		1. 람다는 매개변수 화살표(->) 함수몸체로 이용하여 사용 할 수 있습니다.
		2. 함수몸체가 단일 실행문이면 괄호{}를 생략 할 수 있습니다. 
		3. 함수몸체가 return문으로만 구성되어 있는 경우 괄호{}를 생략 할 수 없습니다
		*/
		r.run(); 
	}

}
