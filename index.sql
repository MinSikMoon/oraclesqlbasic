SELECT * FROM employees WHERE first_name = 'Alexis';

--풀스캔을 탄다.
SELECT * FROM departments WHERE department_name = 'Shipping';

SELECT * FROM employees WHERE hire_date = '2007-06-21';

--인덱스 달기
CREATE INDEX ix_emp_01 on employees(HIRE_DATE);

--인덱스 리빌드 = 밸런스가 무너지 트리구조를 높이 맞게 맞추는것

--인덱스 실습
CREATE TABLE TEST_JOB
AS SELECT * FROM JOBS;

SELECT * FROM test_job;

SELECT * FROM test_emp E, test_job J
WHERE e.job_id = j.job_id AND FIRST_NAME = 'Daniel';

-- e.first_name은 다니엘이라는 1건이라는 걸 추출하기 위한 칼럼이다. 따라서 인덱스 필요, 검색횟수 제한
-- jobs의 job id는 19건 중에서 1건으로 건수를 줄여주는 역할칼럼 하지만 employees의 job id는 결과 건수에 영향을 미치는 것이 아니다. 
CREATE INDEX TEST_JOB_01 ON TEST_JOB(JOB_ID);
CREATE INDEX TEST_EMP_01 ON TEST_EMP(FIRST_NAME);

--인덱스 삭제
DROP INDEX TEST_JOB_O1;
DROP INDEX TEST_EMP_01;

