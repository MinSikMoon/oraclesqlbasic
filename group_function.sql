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
SELECT *
FROM employees
WHERE department_id IN
(SELECT DEPARTMENT_ID
FROM employees
GROUP BY DEPARTMENT_ID
HAVING AVG(salary) > (SELECT AVG(SALARY) FROM EMPLOYEES));



--실습
desc departments;
desc employees;
desc jobs;

--1.
SELECT e.job_id
FROM EMPLOYEES E
GROUP BY E.department_id, E.JOB_ID
HAVING E.DEPARTMENT_ID = 30;

SELECT s.JOB_TITLE
FROM JOBS S, (SELECT e.job_id
FROM EMPLOYEES E
GROUP BY E.department_id, E.JOB_ID
HAVING E.DEPARTMENT_ID = 30) G
WHERE S.job_id = G.job_id;

--2. 수수료를 받는 모든 직원의 이름, 부서, 도시명 출력하기
--1. 수수료 받는 직원
SELECT * FROM EMPLOYEES;
SELECT employee_id FROM EMPLOYEES
WHERE COMMISSION_PCT != 0;
DESC DEPARTMENTS
DESC LOCATIONS
--2. JOIN 하기
SELECT E.FIRST_NAME, D.department_name, l.city, C.COMMISSION_PCT
FROM EMPLOYEES E,
     (SELECT employee_id, COMMISSION_PCT FROM EMPLOYEES
      WHERE COMMISSION_PCT != 0) C,
      LOCATIONS L,
      DEPARTMENTS D
WHERE E.employee_id = C.EMPLOYEE_ID
AND E.department_id = D.department_id
AND d.department_id = d.department_id;

--3. SOUTHLAKE에 근무하는 모든 직원 /이름/ 업무/ 부서번호/ 부서명 출력하기
--1. SOUTHLAKE의 로케이션 ID 구하기
SELECT * FROM locations WHERE city = 'Southlake';
--2. location id를 이용하여 south lake에 있는 department id 구하기
SELECT department_id FROM departments WHERE LOCATION_ID = (SELECT LOCATION_ID FROM locations WHERE city = 'Southlake');
--3. DEPARTMENT ID를 이용하여 이름, 업무, 부서번호, 부서명 출력하기
SELECT * 
FROM EMPLOYEES 
WHERE department_id = (SELECT department_id FROM departments WHERE LOCATION_ID = (SELECT LOCATION_ID FROM locations WHERE city = 'Southlake'));

--7. 그들 매니저 보다 먼저 입사한 직원에 대해/ 모든 직원 이름/ 입사일/ 매니저 이름/ 매니저 입사일 구하기
--1. 입사일 구하기
select * from employees;
--2. self join 해보기
select e.employee_id, e.first_name, e.hire_date, e.manager_id, m.hire_date, m.first_name
from employees e, employees m
where e.manager_id = m.employee_id 
and e.hire_date < m.hire_date;


--정답
--4번 : DISTINCT STYLE
SELECT * FROM EMPLOYEES WHERE department_id = 30;
--JOB ID를 가져오자.
SELECT DISTINCT J.job_title FROM EMPLOYEES E, JOBS J WHERE E.department_id = 30 AND J.JOB_ID = e.job_id;
--인라인 스타일 : 서브쿼리가 FROM에 들어가면 인라인이라고 한다.
SELECT J.JOB_TITLE FROM (SELECT DISTINCT JOB_ID FROM EMPLOYEES WHERE department_id = 30) E, JOBS J WHERE E.JOB_ID = J.job_id;

--5번
--1. 수수료를 받는 직원뽑기
SELECT * FROM employees E WHERE commission_pct IS NOT NULL;

SELECT FIRST_NAME, D.department_name, L.city
FROM employees E, DEPARTMENTS D, LOCATIONS L
WHERE E.commission_pct IS NOT NULL
AND E.DEPARTMENT_ID = D.department_id
AND L.LOCATION_ID = d.location_id;


--6번
--1. SOUTHLAKE가 어딘지 먼저 찾는다.
SELECT * FROM LOCATIONS WHERE city = 'Southlake';

SELECT location_id FROM LOCATIONS WHERE city = 'Southlake';

--2. join 하자
SELECT * FROM LOCATIONS L, DEPARTMENTS D WHERE city = 'Southlake' AND L.location_id = d.location_id;

--3. EMPLOYEE랑 조인
SELECT * FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E WHERE city = 'Southlake' AND L.location_id = d.location_id AND e.department_id = d.department_id;

--4. JOB랑 조인
SELECT * FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E, JOBS J
WHERE city = 'Southlake' AND L.location_id = d.location_id AND e.department_id = d.department_id AND E.job_id = J.job_id;

SELECT E.first_name, J.job_title FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E, JOBS J
WHERE city = 'Southlake' AND L.location_id = d.location_id AND e.department_id = d.department_id AND E.job_id = J.job_id;

--7번
--셀프조인
--1. MANAGER 가져오기
SELECT * FROM employees W, employees M WHERE w.manager_id = m.employee_id;
--2. 필터링 조건 걸기
SELECT * FROM employees W, employees M WHERE w.manager_id = m.employee_id
AND w.hire_date < m.hire_date;

--3. 표시 적기
SELECT w.first_name, W.hire_date, w.manager_id, m.first_name, m.hire_date FROM employees W, employees M WHERE w.manager_id = m.employee_id
AND w.hire_date < m.hire_date;