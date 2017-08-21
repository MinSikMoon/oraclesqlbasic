DESCRIBE DEPARTMENTS; 

SELECT * FROM USER_TABLES;

DESCRIBE EMP_10
CREATE TABLE EMP_10(C1 NUMBER(10), C2 VARCHAR(10));
CREATE TABLE 100-EMP(C1 NUMBER(10), C2 VARCHAR(10));
CREATE TABLE EMP-100(C1 NUMBER(10), C2 VARCHAR(10));
CREATE TABLE 100_EMP(C1 NUMBER(10), C2 VARCHAR(10));

SELECT * FROM EMP_10; 

INSERT INTO EMP_10(C1,C2) VALUES (1,'A');
INSERT INTO EMP_10(C1,C2) VALUES (1,'A');
SELECT * FROM EMP_10;
UPDATE EMP_10 SET C2='B' WHERE C1 = 1;
DELETE FROM EMP_10;

SELECT * FROM DEPARTMENTS;

INSERT INTO DEPARTMENTS
(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) 
VALUES(999, 'IT', NULL, 1700);

COMMIT;

SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = '50'
GROUP BY JOB_ID
ORDER BY AVG(SALARY) DESC;

SELECT * FROM employees;

SELECT FIRST_NAME||' '||LAST_NAME AS NAME, SALARY * 12 AS ANNUAL_INCOME
FROM EMPLOYEES
ORDER BY SALARY DESC;

SELECT FIRST_NAME || 
       LAST_NAME || 
       JOB_ID
FROM EMPLOYEES;

SELECT FIRST_NAME || ''||
      LAST_NAME||
      '('||JOB_ID||')'
FROM EMPLOYEES;

SELECT FIRST_NAME||LAST_NAME || '의 연봉은 ' || SALARY*12 || '입니다' AS TEXT
FROM EMPLOYEES;

SELECT FIRST_NAME, LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE LAST_NAME = 'King';

SELECT FIRST_NAME||' '||LAST_NAME AS NAME ,
       SALARY,
       COMMISSION_PCT,
       (COMMISSION_PCT * SALARY) 
FROM EMPLOYEES
ORDER BY SALARY DESC;

/*null값 배우는 중*/
/*오라클은 기본적으로 중복된 행을 모두 display*/
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
ORDER BY DEPARTMENT_NAME;

/*DISTINCT로 중복제거*/
SELECT DISTINCT DEPARTMENT_NAME
FROM DEPARTMENTS
ORDER BY DEPARTMENT_NAME;

SELECT DEPARTMENT_NAME, JOB_ID
FROM EMPLOYEES;

--실습
SELECT * FROM EMPLOYEES;

SELECT EMPLOYEE_ID, 
       FIRST_NAME||' '||LAST_NAME AS NAME ,
       EMAIL
FROM EMPLOYEES;

DESCRIBE DEPARTMENTS;

SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

DESCRIBE EMPLOYEES;

SELECT EMPLOYEE_ID || ', ' || 
       FIRST_NAME || ', ' ||
       LAST_NAME || ', ' ||
       EMAIL || ', ' ||
       PHONE_NUMBER || ', ' ||
       HIRE_DATE || ', ' ||
       JOB_ID || ', ' ||
       SALARY || ', ' ||
       COMMISSION_PCT || ', ' ||
       MANAGER_ID || ', ' ||
       DEPARTMENT_ID AS "THE OUTPUT"
FROM EMPLOYEES;





