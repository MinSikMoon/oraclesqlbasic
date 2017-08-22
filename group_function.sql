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
GROUP BY department_id; --에러
WHERE AVG(salary) > 2000--where 절이 제한하는 것은 from절에서 가져오는것, where이 그룹 전에 실행되었으므로 

SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY department_id
HAVING AVG(SALARY) > 2000;

-실습
SELECT COUNT(*)
FROM employees 
GROUP BY department_id;



SELECT DEPARTMENT_ID, AVG(SALARY), COUNT(*) 
FROM EMPLOYEES
GROUP BY department_id
HAVING AVG(SALARY) >= 10000 AND COUNT(*) >= 2;

--1. 전체 평균
SELECT AVG(SALARY) 
FROM employees;

--부서별 평균 급여
SELECT AVG(SALARY) 
FROM EMPLOYEES
GROUP BY department_id;




--2. 평균 급여보다 많이 받는 부서별
SELECT DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM employees);

--3. 완성
SELECT E.DEPARTMENT_ID, E.FIRST_NAME
FROM EMPLOYEES E,
     (SELECT DEPARTMENT_ID
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM employees)) SUB
WHERE E.department_id IN SUB.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID;

--정답
--1.
SELECT AVG(SALARY), COUNT(*) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000 
AND COUNT(1) >= 2;

SELECT D.DEPARTMENT_NAME, AVG(E.SALARY), COUNT(1) 
FROM EMPLOYEES E,
     DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.department_name
HAVING AVG(SALARY) >= 10000 AND COUNT(1) >= 2;

SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SAL, COUNT(1) CNT 
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000
AND COUNT(1) >= 2;

--인라인 스타일로 : JOIN이 부하가 가장 큰데, 이렇게 인라인으로 함으로써 성능차이가 발생
SELECT D.DEPARTMENT_NAME, E.AVG_SAL, E.CNT
FROM DEPARTMENTS D,
      (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SAL, COUNT(1) CNT 
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000
AND COUNT(1) >= 2) E
WHERE E.DEPARTMENT_ID = d.department_id;

--정답2
--1. 전체 평균 급여 구한다.
--2. 평균보다 높은 부서 구한다.
--3. 해당 부서 직원 구한다.
--1.
SELECT AVG(SALARY) FROM EMPLOYEES;
--2.
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID
HAVING AVG(salary) > (SELECT AVG(SALARY) FROM EMPLOYEES);

--3.
SELECT * FROM EMPLOYEES WHERE department_id IN (100, 20, 70 ...);

--3이랑 2랑 결합
SELECT FIRST_NAME
FROM employees
WHERE department_id IN
(SELECT DEPARTMENT_ID, AVG(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID
HAVING AVG(salary) > (SELECT AVG(SALARY) FROM EMPLOYEES));
