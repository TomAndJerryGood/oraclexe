/*
���ϸ� : ex09-select-hierarchical.sql

�������� 
	Ʈ�� ������ ������ �����Ϳ��� �θ�-�ڽ� ���踦 ���� �����ϴµ� ���Ǵ� SQL
	�ַ� ������, ������ ������, ������ �ּ� � Ȱ��˴ϴ�.

���� Ű���� 
	START WITH : ���� ������ ���� ������ �����մϴ�. �ֻ��� �θ� ��带 �����մϴ�.
	CONNECT BY : �θ�-�ڽ� ���踦 �����ϴ� Ű�����, PRIOR Ű����� �Բ� ���˴ϴ�.
	PRIOR : �θ�-�ڽ� ���踦 ǥ���ϴ� Ű�����, �ڽ� �ķ��տ� ���˴ϴ�.
	NOCYCLE : ����Ŭ�� ������� �ʵ��� �����ϴ� �ɼ��Դϴ�.
	LEVEL : �� ������ ���̸� ��Ÿ���� �ǻ� �÷����� ���˴ϴ�.
	SYS_CONNECT_BY_PATH : ���� ������ ��θ� ���ڿ��� ǥ�����ִ� �Լ��Դϴ�.
	ORDER SIBLINGS BY : ���� ������ �����ϴµ� ���˴ϴ�.
	
	
*/

--id, name, manager_id, depth

SELECT 
	e.employee_id ,
	e.last_name,
	e.manager_id
	LEVEL AS depth,
	LPAD(' ', LEVEL*2-2) || SYS_CONNECT_BY_PATH(e.last_name, '/') AS hierarcht_path)
FROM
	employees e 
START WITH
	e.manager_id IS NULL 
CONNECT BY --(PRIOR ������ �ڽ�)
	PRIOR e.employee_id = e.manager_id
ORDER SIBLINGS BY e.employee_id;


-- NOCYCLE ����Ŭ�� ������� �ʵ��� ����(���ѷ�������)

SELECT 
	e.employee_id ,
	e.last_name,
	e.manager_id
	LEVEL AS depth,
	LPAD(' ', LEVEL*2-2) || SYS_CONNECT_BY_PATH(e.last_name, '/') AS hierarcht_path)
FROM
	employees e 
START WITH
	e.manager_id = 100 
CONNECT BY --(PRIOR ������ �ڽ�)
	NOCYCLE PRIOR e.employee_id = e.manager_id
ORDER SIBLINGS BY e.employee_id;