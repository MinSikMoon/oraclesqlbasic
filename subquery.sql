--where 절 서브쿼리 = 서브쿼리
--from절 위치 = inline
--select절 = 스칼라

--실습
--평균급여보다 높은 급여받는 직원 목록
--1. 평균 급여 구하기
SELECT AVG(SALARY) FROM employees;

--2. 셀프조인
SELECT e.first_name, e.salary, V.SALARY
FROM employees E,
     (SELECT AVG(SALARY) AS salary FROM employees) V
WHERE e.salary > V.salary
ORDER BY e.salary DESC;


--2. Ismael와 같은 부서에 있는 모든 직원의 이름과 입사일 출력하시오.
--1. Ismael의 부서구하기
SELECT * FROM employees WHERE first_name = 'Ismael';

--2. join
select * 
from employees e, (SELECT * FROM employees WHERE first_name = 'Ismael') t
where e.department_id = t.department_id
and e.first_name != 'Ismael'; --<> 'Ismael' 도 된다. <>

--3. 평균급여 이상벌고/ 이름에 t, T 포함하는 직원 부서에서 근무하는/ 모든 직원 번호/ 이름/ 급여를 출력하시오.

--평균급여 구하기
SELECT AVG(SALARY) FROM employees;
--이름에 t,T 들어가는 사람이고 평균 급여 이상받는 사람
SELECT employee_id, first_name, salary FROM employees WHERE (first_name LIKE '%T%' OR first_name LIKE '%t%') AND (salary  > (SELECT AVG(SALARY) FROM employees))
ORDER BY salary;



