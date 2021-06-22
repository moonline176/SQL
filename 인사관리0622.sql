--1.
SELECT DISTINCT job_id
FROM employees;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary BETWEEN 7000 AND 12000
            AND last_name LIKE 'H%';
            
SELECT TO_CHAR(sysdate,'yyyy/mm/dd hh24:mi:ss day')
FROM dual;

SELECT employee_id, last_name,hire_date, SUBSTR(email,0,3) "email" ,LENGTH(email)
FROM employees
WHERE hire_date > TO_DATE('1999-01-01','yyyy-mm-dd');

SELECT last_name"이름", hire_date, ADD_MONTHS(hire_date,6),NEXT_DAY(hire_date,'금요일') "입사 후 첫 금요일",
            TRUNC((sysdate-hire_date)/30) "근무개월" , LAST_DAY(hire_date)+1 "첫 급여일"
FROM employees
ORDER BY hire_date;

SELECT employee_id, last_name, TO_CHAR(commission_pct*salary,'$9,999.99' ) "수당"
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY  salary DESC, commission_pct DESC;

SELECT employee_id "사번", last_name"이름", job_id"업무ID", salary"급여", department_id"부서번호"
FROM employees
WHERE department_id IN (50, 60) 
AND salary > 5000;

SELECT employee_id "사번", job_id "업무ID" , phone_number "전화번호", department_id "부서번호"
FROM employees
WHERE phone_number LIKE '515%';

SELECT employee_id,last_name, department_id, 
CASE department_id WHEN 20 THEN 'Canada'
                             WHEN 80 THEN 'UK'
                            ELSE 'USA' END 근무지역
FROM employees;  

SELECT employee_id, last_name, 
          (NVL(commission_pct,0)+salary)*12 "연봉",
           TO_CHAR(hire_date,'yyyy') "입사년도", 
           NVL2(TO_CHAR(commission_pct), 'COMM','NOCOMM') 수당여부
FROM employees
ORDER BY department_id, (salary*12)+commission_pct*salary;

SELECT e.last_name "Employee", e.employee_id "#Emp", m.last_name "Manager", m.employee_id "#Mgr"
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id)
ORDER BY 2;              

SELECT p.last_name, p.department_id, c.last_name, c.department_id
FROM employees p JOIN employees c
ON (p.department_id = c.department_id)
WHERE p.employee_id <> c.employee_id
ORDER BY p.department_id, p.last_name, c.last_name;

SELECT employee_id  FROM employees
--UNION
--UNION ALL
-- UNION ALL 의 경우 정렬 x
--INTERSECT --교집합
MINUS
SELECT employee_id 
FROM job_history ;
--ORDER BY job_id;
--두 문장 간의 컬럼 갯수,컬럼 데이터타입이(가) 동일해야함
-- 컬럼의 제목은 첫문장의 제목을 사용한다. 
-- ORDER BY를 하지않아도 첫문장 기준으로 정렬이 된다. 
-- 정렬이 된 이유 : UNION이 정렬을 통해 중복을 제거하고 빠르게 실행하기 위함
-- UNION 은 중복을 허용하지 않는다.
--1. 전체사원에 대하여 사원수, 평균급여(정수), 총급여를 구하시오.

SELECT TO_NUMBER(null) 부서번호 ,TO_CHAR(null) 업무 ,COUNT(*) 총인원 ,TRUNC(AVG(salary)) 평균급여 , SUM(salary) 합계
FROM employees
UNION
--2. 부서별에 대하여 사원수, 평균급여(정수), 총급여를 구하시오.
SELECT department_id,TO_CHAR(null),COUNT(*), TRUNC(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id
UNION
--3. 부서별, 직급별에 대하여 사원수, 평균급여(정수), 총급여를 구하시오
SELECT department_id, job_id,  COUNT(*), TRUNC(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;