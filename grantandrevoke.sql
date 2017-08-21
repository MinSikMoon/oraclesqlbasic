--생성과 실습
--TEST1이라는 유저를 만들거고 비번은 TEST라는 뜻
CREATE USER TEST1 IDENTIFIED BY TEST;

--만들기만 하면 DB에 접속도 못하는 깡통이다.
--최소 접속권한은 줘야함 --사원증 같은 것
--이상태로는 접속밖에 못한다.
GRANT CONNECT, RESOURCE TO TEST1;

--접속이름 : PC의 CLIENT에서 가지고 접속 정보
--사용자 이름 : DBMS에 접속하기 위한 사용자 아이디

--SELECT 권한만 줘보기
GRANT SELECT ON HR.EMPLOYEES TO TEST1;

--SYNONYM을 만들 수 있는 권한주기
GRANT CREATE SYNONYM TO TEST1;

--권한 뺏기
REVOKE SELECT ON HR.EMPLOYEES FROM TEST1;
