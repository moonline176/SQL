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

--SELECT CONCAT (first_name,last_name) --concat�� 2���� �Լ��� ��밡��
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
where substr(last_name, -1,1) = 's'; --sql�Լ��� �̿��� ����ã��, like�� ��

select * 
from employees
where last_name like '%s'; 

select length('oracle'), length('����Ŭ')
from dual; --dual : ���� �׽�Ʈ ���̺�

select lengthb('oracle'), lengthb('����Ŭ') -- b:����Ʈ 
from dual;

select*
from employees
where length(last_name)>5;

SELECT INSTR('Hellow world', 'k') -- l�� ó�� �� ��ġ ����/ �����ƴ�!!!
FROM dual;

SELECT *
FROM employees
WHERE INSTR(last_name,'a') <> 0; -- a �� ��� �ϳ��̻�� ��� 

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

SELECT employee_id, hire_date, TRUNC((sysdate-hire_date)/7) as �ٹ��Ⱓ
FROM employees;

SELECT employee_id, hire_date,
           TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date))
FROM employees;

SELECT employee_id, hire_date,
            ADD_MONTHS(hire_date,3) AS ����������
FROM employees;

SELECT employee_id, hire_date,
            NEXT_DAY(hire_date, '�ݿ���')
FROM employees;

SELECT sysdate, NEXT_DAY(sysdate,6) --'FRIDAY'�� �ȵ� 
FROM dual;

SELECT sysdate, LAST_DAY(sysdate)
FROM dual;

SELECT employee_id, last_name, hire_date,
           LAST_DAY(hire_date)+1 AS ù�޿���
FROM employees;           

SELECT ROUND (sysdate, 'year'),
           ROUND (sysdate, 'month'),
           ROUND (sysdate, 'dd'), 
           ROUND (sysdate, 'd') -- d:�������� ��Ÿ�� (���� �������� �������� �Ͽ��� ��¥�� ��Ÿ��)
FROM dual;           

SELECT TRUNC (sysdate, 'year'),
           TRUNC (sysdate, 'month'),
           TRUNC (sysdate, 'dd'), 
           TRUNC (sysdate, 'd') -- d:�������� ��Ÿ�� (���� �������� �������� �Ͽ��� ��¥�� ��Ÿ��)
FROM dual;           

SELECT TO_CHAR(sysdate, 'year q')
FROM dual;

SELECT employee_id, last_name,
           TO_CHAR(hire_date, 'yyyy/month/dd w hh24:mi:ss') --am�� ����
FROM employees;           

SELECT TO_CHAR (sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

SELECT employee_id, last_name,
           TO_CHAR(salary, 'L999,999.99') -- '9'==> ���� �����ڸ�, �Ҽ� ������ ���� 0���� ǥ�� / '0' 0���� ����/ L : ����(����) ��ȣ
FROM employees;

ALTER SESSION SET NLS_TERRITORY = japan; -- ���� ��ȯ 
SELECT employee_id, last_name,
           TO_CHAR(salary, 'L999,999.99') -- '9'==> ���� �����ڸ�, �Ҽ� ������ ���� 0���� ǥ�� / '0' 0���� ����/ L : ����(����) ��ȣ
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
           salary+salary*NVL(commission_pct,0) as ���ɾ�
FROM employees;           

SELECT employee_id, last_name,
           salary+salary*NVL(commission_pct,0) as���ɾ�,
           NVL2(commission_pct,'yes','no') as ��
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

SELECT last_name, job_id, salary, --���� ������ ���
           DECODE( job_id , 'IT_PROG' , 1.1*salary, --DECODE�� ����Ŭ ����
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

--�޿��� 10000���� ũ�� 'A' / �޿��� 7000< x < 10000 'B' / �޿��� 7000 > �̸� 'C'
SELECT employee_id, last_name,salary,
           CASE WHEN salary > 10000 THEN 'A'
            WHEN salary BETWEEN 7000 and 10000 THEN 'B'
           ELSE 'C' END "SALARY GRADE"
FROM employees;
            
            
SELECT employee_id, last_name,
           salary+salary*NVL(commission_pct,0) as���ɾ�,
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

SELECT COUNT(*), COUNT(department_id), --count(*) : ���̺� ��ü�� Ȯ��
           COUNT(DISTINCT department_id)
FROM employees;

SELECT department_id,job_id, COUNT(*),  -- group by ���� ���� column�� select������ �߰�����
           MIN(salary), SUM(salary)
FROM employees
WHERE commission_pct IS NULL
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1 -- HAVING:GROUP�� where�� ���� ����� �Ұ��� �ϱ� ������ group+having�� set�� WHERE ��� ��� ����
ORDER BY 1,2;

SELECT MAX(SUM(salary)) --�׷��Լ��� ��ø�� �������� �׷����� select���� ������ �� �� ����.
FROM employees
GROUP BY job_id

SELECT department_id, job_id, COUNT(*),  -- group by ���� ���� column�� select������ �߰�����
           MIN(salary), SUM(salary)
FROM employees
GROUP BY ROLLUP (department_id, job_id)
ORDER BY 1,2;
