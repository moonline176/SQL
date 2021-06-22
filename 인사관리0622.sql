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

SELECT last_name"�̸�", hire_date, ADD_MONTHS(hire_date,6),NEXT_DAY(hire_date,'�ݿ���') "�Ի� �� ù �ݿ���",
            TRUNC((sysdate-hire_date)/30) "�ٹ�����" , LAST_DAY(hire_date)+1 "ù �޿���"
FROM employees
ORDER BY hire_date;

SELECT employee_id, last_name, TO_CHAR(commission_pct*salary,'$9,999.99' ) "����"
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY  salary DESC, commission_pct DESC;

SELECT employee_id "���", last_name"�̸�", job_id"����ID", salary"�޿�", department_id"�μ���ȣ"
FROM employees
WHERE department_id IN (50, 60) 
AND salary > 5000;

SELECT employee_id "���", job_id "����ID" , phone_number "��ȭ��ȣ", department_id "�μ���ȣ"
FROM employees
WHERE phone_number LIKE '515%';

SELECT employee_id,last_name, department_id, 
CASE department_id WHEN 20 THEN 'Canada'
                             WHEN 80 THEN 'UK'
                            ELSE 'USA' END �ٹ�����
FROM employees;  

SELECT employee_id, last_name, 
          (NVL(commission_pct,0)+salary)*12 "����",
           TO_CHAR(hire_date,'yyyy') "�Ի�⵵", 
           NVL2(TO_CHAR(commission_pct), 'COMM','NOCOMM') ���翩��
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
-- UNION ALL �� ��� ���� x
--INTERSECT --������
MINUS
SELECT employee_id 
FROM job_history ;
--ORDER BY job_id;
--�� ���� ���� �÷� ����,�÷� ������Ÿ����(��) �����ؾ���
-- �÷��� ������ ù������ ������ ����Ѵ�. 
-- ORDER BY�� �����ʾƵ� ù���� �������� ������ �ȴ�. 
-- ������ �� ���� : UNION�� ������ ���� �ߺ��� �����ϰ� ������ �����ϱ� ����
-- UNION �� �ߺ��� ������� �ʴ´�.
--1. ��ü����� ���Ͽ� �����, ��ձ޿�(����), �ѱ޿��� ���Ͻÿ�.

SELECT TO_NUMBER(null) �μ���ȣ ,TO_CHAR(null) ���� ,COUNT(*) ���ο� ,TRUNC(AVG(salary)) ��ձ޿� , SUM(salary) �հ�
FROM employees
UNION
--2. �μ����� ���Ͽ� �����, ��ձ޿�(����), �ѱ޿��� ���Ͻÿ�.
SELECT department_id,TO_CHAR(null),COUNT(*), TRUNC(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id
UNION
--3. �μ���, ���޺��� ���Ͽ� �����, ��ձ޿�(����), �ѱ޿��� ���Ͻÿ�
SELECT department_id, job_id,  COUNT(*), TRUNC(AVG(salary)), SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;