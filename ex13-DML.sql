/*
파일명 : ex13-DML.sql

DML(Data Manipulation Language)
	DB에서 데이터를 조작하고 처리하는 SQL
	
	INSERT문 : 테이블에 새로운 레코드 삽입
	UPDATE문 : 테이블에 기존 레코드를 갱신(업데이트) 하는데 사용
	DELETE문 : 테이블에 특정 레코드를 삭제
	
	SELECT는 DML 포할될 수 있지만, 보통 DQL(Data Quary Language) 분류한다 
*/


/*
INSERT 문
[기본형식]
	INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
	VALUES(값1, 값2, ...);

	또는

	INSERT INTO 테이블명 ( 컬럼명1, 컬럼명2, ...) subquary; 
*/

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Public Relations', 100, 1700); --데이터베이스에 반영이 된게 아님 

commit; -- 커밋을 해야 데이터베이스에 반영이됨 (DML 결과를 영구적으로 DB에 반영)

--null 값을 가진 행 삽입
-- 열 생략
INSERT INTO department (department_id, department_name)
VALUES(290, 'Purchasing');

ROLLBACK; -- DML문의 실행결과를 취소할 때 

-- null 키워드 지정
INSERT INTO departments
VALUES (300, 'Finance', NULL, NULL);

/* INSERT subquery

*/

CREATE TABLE sales_reps
AS (
	SELECTE employee_id id, last_name name, salary, commission_pct
	FROM employees 
	WHERE 1 = 2
	);

SELECT * FROM sales_reps; --빈껍데기에 스키마의 테이블이 생김

--rep가 포함 된 사원들을 넣고 싶음
-- job_id REP 포함된 사원

SELECT employee_id, last_name, salary, commission_pct
FROM employees 
WHERE job_id LIKE '%REP%'
;
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees 
WHERE job_id LIKE '%REP%'
;

commit; 영구반영

SELETE * FROM sales_reps;      

/*
UPDATE 문
    테이블의 기존 값을 수정합니다.
    
[기본형식]
    UPDATE 테이블명
    SET 컬럼명1 = 수정값, 컬럼명2 = 수정값
    WHERE 조건절
*/

CREATE TABLE copy_emp
AS SELECT * FROM employees WHERE 1 = 2;

INSERT INTO copy_emp 
SELECT * FROM employees;

commit;

SELECT * FROM copy_emp;

-- 113번회원 부서번호 50번으로 변경 
UPDATE copy_emp
SET department_id = 50
WHERE employee_id = 113;

rollback;

--모든회원의 부서 번호가 110번으로 변경 
UPDATE copy_emp
SET department_id = 110;


UPDATE copy_emp
SET department_id = 80
WHERE employee_id = 113
;



UPDATE copy_emp
SET department_id = (SELECT department_id
                        FROM employees
                        WHERE employee_id = 100)
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 200);
                
SELECT * FROM copy_emp 
WHERE job_id = 'AD_ASST';
                        
/*
DELETE 문
    DELETE 문을 사용하여 테이블에서 기존 행을 제거할 수 있습니다.

*/

-- 사원번호 200번인 사원 삭제 
DELETE FROM copy_emp 
WHERE employee_id = 200;

SELECT * FROM copy_emp
WHERE employee_id = 200;

ROLLBACK;

-- 테이블 전체 데이터 삭제
DELETE FROM copy_emp;

SELECT * FROM copy_emp;

/*
TRUNCATE 문
    테이블을 빈 상태로, 테이블 구조 그대로 남겨둔채 테이블에서 모든 행을 제거합니다.
    DML 문이 아니라 DDL(데이터 정의어) 문이므로쉽게 언두할 수 없습니다.
*/

--쉽게 복구 할 수 없으니 조심해라.
TRUNCATE TABLE copy_emp;

/*
트랜잭션(Transaction)
    데이터 처리를 한 단위입니다.
    오라클에서 발생하는 여러 개의 SQL 명령문을 
    하나의 논리적인 작업 단위로 처리하는데 이를 트랜젝션 이라고 합니다.
    
    COMMIT : SQL 문의 결과를 영구적으로 DB에 반영
    ROLLBACK : SQL 문의 실행결과를 취소 할 떄 
    SAVEPOINT : 트랜잭션의 한 지점에 표시하는 임시 저장점
    

*/

CREATE TABLE member(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30), -- 최대 저장할 수 있는 수가 30이상
    addr VARCHAR2(50) -- 최대 저장할 수 있는 수가 50이상
    );
    
INSERT INTO member VALUES(1, '피카츄', '태초마을'); -- 모든 수가 들어가면 생략가능 
COMMIT;
INSERT INTO member VALUES(2, '라이츄', '태초마을'); -- 모든 수가 들어가면 생략가능 
INSERT INTO member VALUES(3, '파이리', '태초마을'); -- 모든 수가 들어가면 생략가능 
INSERT INTO member VALUES(4, '꼬부기', '태초마을'); -- 모든 수가 들어가면 생략가능 
INSERT INTO member VALUES(5, '버터풀', '태초마을'); -- 모든 수가 들어가면 생략가능 

ROLLBACK;

SELECT * FROM member;


--SAVEPOINT
INSERT INTO member VALUES(6, '야도란', '태초마을');
SAVEPOINT mypoint;
INSERT INTO member VALUES(7, '피죤투', '태초마을');
INSERT INTO member VALUES(8, '도가스', '태초마을');
INSERT INTO member VALUES(9, '지우', '태초마을');
ROLLBACK TO mypoint;
COMMIT;
    
    
/*
SELECT 문의 FOR UPDATE 절 
    FOR UPDATE는 특정 레코드를 잠금(LOCK) 처리하는 SQL구문입니다.
    COMMIT  또는 ROLLBACK으로 잠금해제 합니다.
*/

SELECT employee_id, salary, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE; -- 다른 사원들이 해당 정보를 수정할 수 없음 

commit;

















