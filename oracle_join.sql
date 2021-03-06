desc employees;
DESC DEPARTMENTS;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_SYNONYMS;
SELECT * FROM user_indexes;
DESC LOCATIONS;
--가장 단순한 join
SELECT EMPLOYEES.FIRST_NAME, DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES, DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

--pk는 이미 인덱스가 만들어져 있다. 
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (D.location_id = l.location_id)
ORDER BY L.city;

--물리적으로 이렇게 붙은것에서 필요한 칼럼을 가져온 형태이다. 
SELECT *
FROM EMPLOYEES, DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

--Alexis 찾기
SELECT EMPLOYEES.first_name, DEPARTMENTS.department_name
FROM EMPLOYEES, DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID 
AND (EMPLOYEES.first_name = 'Alexis');

--non-equijoin : 결합 조건이 완벽히 equal이 아닌 조건들
SELECT E.FIRST_NAME,
       E.LAST_NAME,
       J.JOB_TITLE,
       E.SALARY,
       J.MIN_SALARY,
       J.MAX_SALARY
FROM employees E,
     JOBS J
WHERE e.job_id = j.job_id
AND   e.salary >= j.max_salary;

--outer join : 정상적으로 조인 조건을 만족하지 못하는 행들을 보기위해서 쓴다. (+)을 쓴다. 조인시킬 값이 없는 조인측에 위치
CREATE TABLE TEST_EMP
AS SELECT * FROM EMPLOYEES;

SELECT * FROM TEST_EMP;

CREATE TABLE TEST_DEPT
AS SELECT * FROM departments;

SELECT * FROM test_dept;

DELETE FROM TEST_DEPT WHERE department_id = 10;

SELECT * FROM test_emp WHERE department_id = 10;
SELECT * FROM test_DEPT WHERE department_id = 10; -- 현재 TEST_DEPT에서 ID가 10인 부서는 지워진 상태이다. 

--당연히 결과값이 안나와야 하는 상황 -> 이럴때 OUTER JOIN을 쓰면 둘중 하나라도 있으면 나온다. (+)를 조건이 없는 쪽에 걸어준다!!
SELECT * 
FROM TEST_EMP E,
     test_dept D
WHERE e.department_id = d.department_id(+)
AND e.department_id = 10;

--SELF JOIN --EMPLOYEES 테이블에는 모든 사원 즉, 매니저와 사원들 모두 들어있기 때문에.
SELECT WORKER.LAST_NAME || ' works for ' || MANAGER.LAST_NAME
FROM employees worker, 
     employees manager
WHERE worker.manager_id = manager.employee_id;

DESC EMPLOYEES;
DESC DEPARTMENTS;
SELECT * FROM USER_TABLES;
DESC JOBS;
--실습
SELECT E.first_name, e.last_name, d.department_name, M.first_name AS MANAGER_NAME, J.JOB_TITLE
FROM EMPLOYEES E, 
     EMPLOYEES M,
     DEPARTMENTS D,
     JOBS J
WHERE e.department_id = d.department_id
AND E.job_id = j.job_id
AND e.manager_id = m.employee_id(+) --보여져야할 기준 테이블의 반대편에 붙인다.
ORDER BY e.first_name;

--버젼1 -- 내 버젼
SELECT samples.first_name, samples.hire_date
FROM (SELECT hire_date from employees where first_name = 'Ismael') TARGET,
     EMPLOYEES SAMPLES
WHERE TARGET.hire_date <= SAMPLES.hire_date;

SELECT * 
FROM EMPLOYEES
ORDER BY hire_date;

SELECT E.first_name, E.salary, round(TARGET.AVG_SALARY)
FROM (SELECT AVG(SALARY) AS avg_salary FROM employees) TARGET, 
     EMPLOYEES E
WHERE TARGET.avg_salary < E.salary;

SELECT E.first_name, E.SALARY, (SELECT AVG(SALARY) FROM EMPLOYEES)
FROM EMPLOYEES E
WHERE E.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

     
     
SELECT E.FIRST_NAME, E.HIRE_DATE, I.HIRE_DATE FROM EMPLOYEES I, EMPLOYEES E WHERE I.FIRST_NAME = 'Ismael' AND I.HIRE_DATE < E.HIRE_DATE;

--정답2
SELECT * FROM EMPLOYEES I, EMPLOYEES E WHERE I.FIRST_NAME = 'Ismael'
AND I.hire_date < E.hire_date;




--실습 정답
--축이 되는 테이블을 만들고, 나머지 덧붙이는 얘들을 조인시킨다.
SELECT e.first_name, e.last_name, d.department_name, DECODE(m.first_name, NULL, '사장', m.first_name) as manager_name, j.job_title
FROM employees e,
     departments d,
     employees m,
     jobs j
Where e.department_id = d.department_id
AND e.manager_id = m.employee_id(+)
AND e.job_id = j.job_id
ORDER BY d.department_name;

--2
SELECT * 
FROM EMPLOYEES I, EMPLOYEES E 
WHERE I.FIRST_NAME = 'Ismael'
AND I.hire_date < E.hire_date;

--서브쿼리 버젼 : 이렇게 짜면 옵티마이저가 고려하는 동작방식 후보가 하나로 고정되어 버린다. 위의 경우는 옵티마이저의 실행계획 후보를 여러개 만들 수 있다. 
SELECT samples.first_name, samples.hire_date
FROM (SELECT hire_date from employees where first_name = 'Ismael') TARGET,
     EMPLOYEES SAMPLES
WHERE TARGET.hire_date <= SAMPLES.hire_date;

--3
SELECT AVG(SALARY) FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY FROM employees WHERE SALARY > 10000;

SELECT FIRST_NAME, SALARY, (SELECT AVG(SALARY) FROM EMPLOYEES) AS AVG_SALARY FROM employees WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--쿼리가 반복된다. 줄여주자.
SELECT E.first_name, E.SALARY, (SELECT AVG(SALARY) FROM EMPLOYEES)
FROM EMPLOYEES E
WHERE E.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--스칼라 서브쿼리는 가급적 적게 써야한다. 
--서브쿼리는 3개가 있다. 그냥, 스칼라, 인라인뷰
SELECT E.first_name, E.salary, round(TARGET.AVG_SALARY)
FROM (SELECT AVG(SALARY) AS avg_salary FROM employees) TARGET, 
     EMPLOYEES E
WHERE TARGET.avg_salary < E.salary;
