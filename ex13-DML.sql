/*
���ϸ� : ex13-DML.sql

DML(Data Manipulation Language)
	DB���� �����͸� �����ϰ� ó���ϴ� SQL
	
	INSERT�� : ���̺� ���ο� ���ڵ� ����
	UPDATE�� : ���̺� ���� ���ڵ带 ����(������Ʈ) �ϴµ� ���
	DELETE�� : ���̺� Ư�� ���ڵ带 ����
	
	SELECT�� DML ���ҵ� �� ������, ���� DQL(Data Quary Language) �з��Ѵ� 
*/


/*
INSERT ��
[�⺻����]
	INSERT INTO ���̺�� (�÷���1, �÷���2, ...)
	VALUES(��1, ��2, ...);

	�Ǵ�

	INSERT INTO ���̺�� ( �÷���1, �÷���2, ...) subquary; 
*/

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Public Relations', 100, 1700); --�����ͺ��̽��� �ݿ��� �Ȱ� �ƴ� 

commit; -- Ŀ���� �ؾ� �����ͺ��̽��� �ݿ��̵� (DML ����� ���������� DB�� �ݿ�)

--null ���� ���� �� ����
-- �� ����
INSERT INTO department (department_id, department_name)
VALUES(290, 'Purchasing');

ROLLBACK; -- DML���� �������� ����� �� 

-- null Ű���� ����
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

SELECT * FROM sales_reps; --�󲮵��⿡ ��Ű���� ���̺��� ����

--rep�� ���� �� ������� �ְ� ����
-- job_id REP ���Ե� ���

SELECT employee_id, last_name, salary, commission_pct
FROM employees 
WHERE job_id LIKE '%REP%'
;
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees 
WHERE job_id LIKE '%REP%'
;

commit; �����ݿ�

SELETE * FROM sales_reps;      

/*
UPDATE ��
    ���̺��� ���� ���� �����մϴ�.
    
[�⺻����]
    UPDATE ���̺��
    SET �÷���1 = ������, �÷���2 = ������
    WHERE ������
*/

CREATE TABLE copy_emp
AS SELECT * FROM employees WHERE 1 = 2;

INSERT INTO copy_emp 
SELECT * FROM employees;

commit;

SELECT * FROM copy_emp;

-- 113��ȸ�� �μ���ȣ 50������ ���� 
UPDATE copy_emp
SET department_id = 50
WHERE employee_id = 113;

rollback;

--���ȸ���� �μ� ��ȣ�� 110������ ���� 
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
DELETE ��
    DELETE ���� ����Ͽ� ���̺��� ���� ���� ������ �� �ֽ��ϴ�.

*/

-- �����ȣ 200���� ��� ���� 
DELETE FROM copy_emp 
WHERE employee_id = 200;

SELECT * FROM copy_emp
WHERE employee_id = 200;

ROLLBACK;

-- ���̺� ��ü ������ ����
DELETE FROM copy_emp;

SELECT * FROM copy_emp;

/*
TRUNCATE ��
    ���̺��� �� ���·�, ���̺� ���� �״�� ���ܵ�ä ���̺��� ��� ���� �����մϴ�.
    DML ���� �ƴ϶� DDL(������ ���Ǿ�) ���̹Ƿν��� ����� �� �����ϴ�.
*/

--���� ���� �� �� ������ �����ض�.
TRUNCATE TABLE copy_emp;

/*
Ʈ�����(Transaction)
    ������ ó���� �� �����Դϴ�.
    ����Ŭ���� �߻��ϴ� ���� ���� SQL ��ɹ��� 
    �ϳ��� ������ �۾� ������ ó���ϴµ� �̸� Ʈ������ �̶�� �մϴ�.
    
    COMMIT : SQL ���� ����� ���������� DB�� �ݿ�
    ROLLBACK : SQL ���� �������� ��� �� �� 
    SAVEPOINT : Ʈ������� �� ������ ǥ���ϴ� �ӽ� ������
    

*/

CREATE TABLE member(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30), -- �ִ� ������ �� �ִ� ���� 30�̻�
    addr VARCHAR2(50) -- �ִ� ������ �� �ִ� ���� 50�̻�
    );
    
INSERT INTO member VALUES(1, '��ī��', '���ʸ���'); -- ��� ���� ���� �������� 
COMMIT;
INSERT INTO member VALUES(2, '������', '���ʸ���'); -- ��� ���� ���� �������� 
INSERT INTO member VALUES(3, '���̸�', '���ʸ���'); -- ��� ���� ���� �������� 
INSERT INTO member VALUES(4, '���α�', '���ʸ���'); -- ��� ���� ���� �������� 
INSERT INTO member VALUES(5, '����Ǯ', '���ʸ���'); -- ��� ���� ���� �������� 

ROLLBACK;

SELECT * FROM member;


--SAVEPOINT
INSERT INTO member VALUES(6, '�ߵ���', '���ʸ���');
SAVEPOINT mypoint;
INSERT INTO member VALUES(7, '������', '���ʸ���');
INSERT INTO member VALUES(8, '������', '���ʸ���');
INSERT INTO member VALUES(9, '����', '���ʸ���');
ROLLBACK TO mypoint;
COMMIT;
    
    
/*
SELECT ���� FOR UPDATE �� 
    FOR UPDATE�� Ư�� ���ڵ带 ���(LOCK) ó���ϴ� SQL�����Դϴ�.
    COMMIT  �Ǵ� ROLLBACK���� ������� �մϴ�.
*/

SELECT employee_id, salary, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE; -- �ٸ� ������� �ش� ������ ������ �� ���� 

commit;

















