SELECT COUNT(*) FROM employees;

SELECT MAX(SALARY) FROM EMPLOYEES;

SELECT AVG(SALARY), MIN(SALARY), MAX(SALARY), SUM(SALARY) 
FROM employees E,
     departments D
WHERE e.department_id = d.department_id
and d.department_name = 'Sales';

--널값이 아닌 행들의 개수를 돌려준다. 
SELECT COUNT(COMMISSION_PCT) 
FROM EMPLOYEES E, 
     departments D
WHERE e.department_id = D.department_id
AND d.department_name = 'IT';

--GROUP BY, HAVING
--그룹절이 없을때/ 있을 때 차이 느끼기
SELECT DEPARTMENT_ID DEPARTMENT, COUNT(*) NUM
FROM EMPLOYEES
WHERE department_id = 30
GROUP BY department_id;

SELECT DEPARTMENT_NAME DEPARTMENT, COUNT(*) 
FROM EMPLOYEES E,
     departments D
WHERE e.department_id = D.department_id
GROUP BY d.department_name;

SELECT DEPARTMENT_NAME DEPARTMENT, COUNT(*)
FROM EMPLOYEES E,
     departments D
WHERE e.department_id = D.department_id
GROUP BY d.department_name;



SELECT JOB_ID, SUM(SALARY), AVG(SALARY) PAYROLL
FROM employees E
GROUP BY JOB_ID
ORDER BY SUM(SALARY) DESC;

--다중 그룹
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, job_id
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
GROUP BY department_id, job_id;


--잘못된 GROUP BY 쿼리
SELECT COUNT(*) FROM DEPARTMENTS; --전 부서 대상
SELECT LOCATION_ID, COUNT(*) FROM DEPARTMENTS; --에러난다. : 그룹바이가 없다.
SELECT LOCATION_ID, COUNT(*) FROM DEPARTMENTS
GROUP BY location_id;

--그룹을 제한하기 위해 WHERE절을 쓸 수 없다. HAVING 절을 써야한다. 
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(salary) > 2000
GROUP BY department_id; --에러

SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY department_id
HAVING AVG(SALARY) > 2000;


