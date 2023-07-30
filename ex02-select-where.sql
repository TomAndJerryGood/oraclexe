/*
���ϸ� : ex02-select-where.sql

������ ����Ͽ� �� ����
    WHERE ���� ����Ͽ� ��ȯ�Ǵ� ���� �����մϴ�.

WHERE
    ������ �����ϴ� ������ quere�� �����մϴ�.
    
    ��������� 
    - ���̸�
    - �� ����
    - �� �̸�, ��� �U�� �� ����Ʈ
    
*/

-- WHERE �� ���
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;

/*
���ڿ� �� ��¥
    ���ڿ� �� ��¥ ���� ���� ����ǥ�� �����ϴ�.
    ���� ���� ��ҹ��ڸ� �����ϰ� ��¥ ���� ������ �����մϴ�.
    
    �⺻ ��¥ ǥ�������� DD-MON-RR
*/
SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '03/06/17';

/*
�� ������
    Ư�� ǥ������ �ٸ����̳� ǥ���İ� ���ϴ� ���ǿ��� ���˴ϴ�.
    = ����
    > ���� ŭ
    >= ���� ũ�ų� ����
    < ���� ����
    <= ���� �۰ų� ����
    <> ���� ����
    BETWEEN ... AND ... �� �� ����(��谪 ����)
    IN(set)             �� ����Ʈ �� ��ġ�ϴ� �� �˻�
    LIKE                ��ġ�ϴ� ���� ���� �˻�
    IS NULL             NULL ������ ����

*/
-- �� ������ ���
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;






