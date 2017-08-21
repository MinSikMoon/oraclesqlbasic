SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME = 'alexis'; --no results

SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('alexis'); --칼럼을 가공하지 않고 값자체를 바꾸는 것이 권장된다. 

SELECT * 
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = 'alexis'; --칼럼자체를 조작함. 성능관점에서는 이렇게 하면 좋지 않다. 인덱스를 활용하지 못하게 된다. full scan이 일어나게 된다.

select CONCAT('Good', 'String') FROM dual;

SELECT SYSDATE FROM DUAL;

--날짜 포맷
SELECT TO_CHAR(TO_DATE('15-3-2016', 'DD-MM-YYYY'),' DD "OF" MONTH') FROM dual;

--SYSDATE를 원하는 문자열로 바꾸려면 TO_CHAR로 바꾼다.
SELECT TO_CHAR(SYSDATE, 'YYYY MM HH dy HH12:MI:SS') FROM dual;

SELECT 12345678, TO_CHAR(12345678, '$099,999,999') FROM dual;

SELECT FIRST_NAME, TO_CHAR(SALARY, '$9,999') AS SALARY
FROM EMPLOYEES
WHERE department_id = 10;

--NVL --첫 파라미터랑 두번째 파라미터가 동일하게 맞춰주기 위해서 TO_CHAR 쓴다.
SELECT LAST_NAME, JOB_ID, SALARY, NVL(TO_CHAR(MANAGER_ID), '사장'),NVL(COMMISSION_PCT, 0) AS COMM_PCT, (NVL(COMMISSION_PCT,0)*SALARY) AS COMMISSION
FROM EMPLOYEES
ORDER BY COMM_PCT DESC;

--DECODE 버젼
SELECT LAST_NAME, 
       JOB_ID, 
       SALARY, 
       DECODE(MANAGER_ID,NULL, '사장', 0), 
       DECODE(COMMISSION_PCT, NULL, 0, COMMISSION_PCT) AS COMM_PCT, 
       DECODE(COMMISSION_PCT, NULL,0, commission_pct)*SALARY AS COMMISSION
FROM EMPLOYEES
ORDER BY COMM_PCT DESC;

--DECODE --조건절
SELECT last_name, salary, job_id, decode(job_id, 'IT_PROG', salary * 1.2, 'ST_MAN', salary * 1.1, salary) revised_salary 
FROM EMPLOYEES;

--실습3
SELECT FIRST_NAME || ', ' ||
       LAST_NAME || '(' ||
       EMAIL || '@hyundai.com) :' ||
       TO_CHAR(SALARY, '$999,999') AS OUTPUT
FROM EMPLOYEES;
DESCRIBE EMPLOYEES;

SELECT FIRST_NAME || ' ' || LAST_NAME,
       TO_CHAR(HIRE_DATE, 'dy') as hire_day
FROM EMPLOYEES
ORDER BY hire_day desc;

--정답
SELECT FIRST_NAME || ' ' || LAST_NAME,
       TO_CHAR(HIRE_DATE, 'dy') as hire_day
FROM EMPLOYEES
ORDER BY  TO_CHAR(HIRE_DATE, 'D');

select TO_NUMBER(TO_CHAR(HIRE_DATE, 'DD'))  FROM EMPLOYEES;

SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       DECODE(COMMISSION_PCT, NULL, 'No Commission', COMMISSION_PCT*SALARY) AS BONUS
FROM EMPLOYEES
ORDER BY BONUS ASC;
       