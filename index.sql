SELECT * FROM employees WHERE first_name = 'Alexis';

--풀스캔을 탄다.
SELECT * FROM departments WHERE department_name = 'Shipping';

SELECT * FROM employees WHERE hire_date = '2007-06-21';

--인덱스 달기
CREATE INDEX ix_emp_01 on employees(HIRE_DATE);

