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