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




