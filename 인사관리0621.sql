SELECT last_name as Employee, salary "Monthly Salary" 
from employees
where department_id in(20,50) and salary BETWEEN 3000 and 12000 and last_name like '%a%'
order by 2;

select UPPER('oracle database'), LOWER( 'ORACLE DATABASE'), INITCAP('oracle database')
from dual;

select * 
from employees
--where LOWER (last_name) = 'king';
--where last_name = INITCAP('king');
where last_name = INITCAP('&employee_name');

select first_name || last_name
from employees;

--SELECT CONCAT (first_name,last_name) --concat는 2가지 함수만 사용가능
SELECT CONCAT(CONCAT (first_name,' '), last_name)
from employees;

SELECT last_name, substr(last_name,1,3)
from employees;
SELECT CONCAT(CONCAT (first_name,' '), last_name),
            substr(concat(concat(first_name,' '),last_name),2,5) as result
from employees;

select last_name, substr(last_name,-3,3)
from employees;

select * 
from employees
where substr(last_name, -1,1) = 's'; --sql함수를 이용한 조건찾기, like와 비교

select * 
from employees
where last_name like '%s'; 

select length('oracle'), length('오라클')
from dual; --dual : 임의 테스트 테이블

select lengthb('oracle'), lengthb('오라클') -- b:바이트 
from dual;

select*
from employees
where length(last_name)>5;

SELECT INSTR('Hellow world', 'k') -- l이 처음 들어간 위치 설명/ 갯수아님!!!
FROM dual;

SELECT *
FROM employees
WHERE INSTR(last_name,'a') <> 0; -- a 가 적어도 하나이상들어간 목록 

SELECT *
FROM employees
WHERE last_name LIKE '%a%';

SELECT RPAD(last_name, 15, '*') AS last_name,
           LPAD(salary, 10, '*') AS salary
FROM employees;

SELECT REPLACE('jack and jue','j','bl')
FROM dual;

SELECT employee_id,
           REPLACE(last_name, SUBSTR(last_name,2,2),'**') AS last_name
FROM employees;           

SELECT TRIM('w' FROM 'window'),
           TRIM(LEADING 'w' FROM 'window'),
           TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT employee_id, last_name, 
            CONCAT('+82',TRIM(LEADING '0' FROM phone_number)) AS phone
FROM employees;            

SELECT employee_id, CONCAT (first_name, last_name) NAME,
            job_id, LENGTH (last_name),
            INSTR (last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(job_id, 4) = 'REP';

SELECT ROUND (45.926, 2) , ROUND (45.926,1),
           ROUND (45.926), ROUND (45.926, -1)
FROM dual;

SELECT TRUNC (45.926,2) , TRUNC (45.926,1),
           TRUNC (45.926), TRUNC (45.926,-1)
FROM dual;          

SELECT employee_id, last_name, salary,
           ROUND (salary*0.967,0)
FROM employees;           

SELECT employee_id, last_name, salary,
           MOD (salary, 600)
FROM employees;           

DESC employees;

SELECT user
FROM dual;

SELECT sysdate, sysdate+10,sysdate-10
FROM dual;

SELECT employee_id, hire_date, hire_date+14
FROM employees;

SELECT employee_id, hire_date, TRUNC((sysdate-hire_date)/7) as 근무기간
FROM employees;

SELECT employee_id, hire_date,
           TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date))
FROM employees;

SELECT employee_id, hire_date,
            ADD_MONTHS(hire_date,3) AS 수습종료일
FROM employees;

SELECT employee_id, hire_date,
            NEXT_DAY(hire_date, '금요일')
FROM employees;

SELECT sysdate, NEXT_DAY(sysdate,6) --'FRIDAY'는 안됨 
FROM dual;

SELECT sysdate, LAST_DAY(sysdate)
FROM dual;

SELECT employee_id, last_name, hire_date,
           LAST_DAY(hire_date)+1 AS 첫급여일
FROM employees;           

SELECT ROUND (sysdate, 'year'),
           ROUND (sysdate, 'month'),
           ROUND (sysdate, 'dd'), 
           ROUND (sysdate, 'd') -- d:일주일을 나타냄 (매주 수요일이 기준으로 일요일 날짜를 나타냄)
FROM dual;           

SELECT TRUNC (sysdate, 'year'),
           TRUNC (sysdate, 'month'),
           TRUNC (sysdate, 'dd'), 
           TRUNC (sysdate, 'd') -- d:일주일을 나타냄 (매주 수요일이 기준으로 일요일 날짜를 나타냄)
FROM dual;           

SELECT TO_CHAR(sysdate, 'year q')
FROM dual;

SELECT employee_id, last_name,
           TO_CHAR(hire_date, 'yyyy/month/dd w hh24:mi:ss') --am은 형식
FROM employees;           

SELECT TO_CHAR (sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

SELECT employee_id, last_name,
           TO_CHAR(salary, 'L999,999.99') -- '9'==> 정수 실제자리, 소수 나머지 전부 0으로 표현 / '0' 0으로 고정/ L : 로컬(국가) 기호
FROM employees;

ALTER SESSION SET NLS_TERRITORY = japan; -- 로컬 변환 
SELECT employee_id, last_name,
           TO_CHAR(salary, 'L999,999.99') -- '9'==> 정수 실제자리, 소수 나머지 전부 0으로 표현 / '0' 0으로 고정/ L : 로컬(국가) 기호
FROM employees;

ALTER SESSION SET NLS_TERRITORY = korea;

SELECT employee_id, last_name, 
           TO_CHAR(hire_date,'yyyy'), salary
FROM employees
WHERE hire_date > TO_DATE('01.01.99','dd.mm.rr');

SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE salary > TO_NUMBER('8,000','9,999');

SELECT employee_id, last_name, salary, commission_pct
FROM employees;

SELECT employee_id, last_name, salary, commission_pct,
           salary+salary*NVL(commission_pct,0) as 수령액
FROM employees;           

SELECT employee_id, last_name,
           salary+salary*NVL(commission_pct,0) as수령액,
           NVL2(commission_pct,'yes','no') as 비교
FROM employees;

SELECT NULLIF(1,1), NULLIF(1,2)
FROM dual

SELECT employess_id, commission_pct, manager_id,
COALESCE(commission_pct,manager_id,1111)
FROM employees;           
 
SELECT last_name, job_id, salary,
           CASE job_id WHEN 'IT_PROG' THEN 1.1*salary
                            WHEN 'ST_CLERK' THEN 1.15*salary
                            WHEN 'SA_REP' THEN 1.2*salary
           ELSE salary END revised_salary
FROM employees;           

SELECT last_name, job_id, salary, --위와 동일한 결과
           DECODE( job_id , 'IT_PROG' , 1.1*salary, --DECODE는 오라클 전용
                             'ST_CLERK' , 1.15*salary,
                             'SA_REP' , 1.2*salary,
            salary) revised_salary
FROM employees;           

SELECT last_name, job_id, salary,
           CASE WHEN job_id =  'IT_PROG' THEN 1.1*salary
                   WHEN job_id = 'ST_CLERK' THEN 1.15*salary
                   WHEN job_id = 'SA_REP' THEN 1.2*salary
           ELSE salary END revised_salary
FROM employees;           

--급여가 10000보다 크면 'A' / 급여가 7000< x < 10000 'B' / 급여가 7000 > 이면 'C'
SELECT employee_id, last_name,salary,
           CASE WHEN salary > 10000 THEN 'A'
            WHEN salary BETWEEN 7000 and 10000 THEN 'B'
           ELSE 'C' END "SALARY GRADE"
FROM employees;
            
            
SELECT employee_id, last_name,
           salary+salary*NVL(commission_pct,0) as수령액,
           CASE WHEN commission_pct is not null THEN 'yes'
           ELSE 'no' END "commision"
FROM employees;

SELECT MIN (salary) , MAX(salary),
           AVG (salary) , SUM(salary)
FROM employees;           

SELECT MIN (salary) , MAX(salary),
           AVG (salary) , SUM(salary)
FROM employees
WHERE department_id IN (50,60);

SELECT MIN (last_name) , MAX(last_name)
           FROM employees;

SELECT MIN (hire_date) , MAX(hire_date)
FROM employees;

SELECT AVG(commission_pct), AVG (NVL(commission_pct,0))
FROM employees;

SELECT COUNT(*), COUNT(department_id), --count(*) : 테이블 전체값 확인
           COUNT(DISTINCT department_id)
FROM employees;

SELECT department_id,job_id, COUNT(*),  -- group by 절에 적은 column은 select절에도 추가가능
           MIN(salary), SUM(salary)
FROM employees
WHERE commission_pct IS NULL
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1 -- HAVING:GROUP와 where은 동시 사용이 불가능 하기 때문에 group+having이 set로 WHERE 대신 사용 가능
ORDER BY 1,2;

SELECT MAX(SUM(salary)) --그룹함수를 중첩한 절에서는 그룹절을 select절에 가지고 올 수 없다.
FROM employees
GROUP BY job_id

SELECT department_id, job_id, COUNT(*),  -- group by 절에 적은 column은 select절에도 추가가능
           MIN(salary), SUM(salary)
FROM employees
GROUP BY ROLLUP (department_id, job_id)
ORDER BY 1,2;
