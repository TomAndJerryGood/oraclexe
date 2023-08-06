/*
파일명 : ex08-select-subquery.sql

Subquery 구문
    다른 SELECT 문의 포함되는 SELECT 문 입니다.
*/

-- 단일 행 SubQuery 실행
SELECT last_name, salary 
FROM employees
WHERE salary > ( SELECT salary FROM employees WHERE last_name = 'Abel'); -- 아벨급여 : $11,000
-- 아벨이라는 사원보다 급여가 높은 사람을 조회해주세요

-- Subquery에서 그룹 함수 사용
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

/*
여러 행 SubQuery 
    IN 
        리스트의 임의 멤버와 같음
        
    ANY
        =, <>, >, < , <=, >= 연산자가 앞에 있어야 합니다.
        < ANY는 최대값보다 작음을 의미합니다.
        > ANY는 최소값보다 큼을 의미합니다.
        = ANY는 IN과 같습니다.
    ALL 
        > ALL은 최대값보다 큼을 의미합니다.
        < ALL은 최소값보다 작음을 의미합니다.
        
*/

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
--$9000보다 작은 사원들
AND job_id <> 'IT_PROG';



SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
--최대값 9000보다 큰 사원들
AND job_id <> 'IT_PROG';


SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary IN(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
-- 9000 6000 4800 4200 에 해당하는 사원들
AND job_id <> 'IT_PROG';

/*
EXISTS 연산자
    Subquery에서 최소한 한 개의 행을 반환하면 TRUE로 평가됩니다.
*/

SELECT * FROM departments
WHERE NOT EXISTS -- 한 개의 행이라도 조회가 되지 않는값을 조회한다(사원이 없는 부서)
        (SELECT * FROM employees
        WHERE employees.department_id = departments.department_id);
-- 위에 연산자와 같은 값 
SELECT * FROM departments
WHERE department_id NOT IN -- 한 개의 행이라도 조회가 되지 않는값을 조회한다(사원이 없는 부서)
        (SELECT department_id FROM employees
        WHERE employees.department_id = departments.department_id);

SELECT * FROM departments
WHERE EXISTS -- 한 개의 행이라도 조회되는 값을 조회한다 (사원이 있는 부서)
        (SELECT * FROM employees
        WHERE employees.department_id = departments.department_id);
        
/*
Subquery의 null 값
    반환된 값 중 하나가 null 값이면 전체  query가 행을 반환하지 않습니다.
    null 값을 비교하는 모든 조건은 결과가 null이기 때문입니다.
*/
--
SELECT emp.last_name
FROM employees emp 
WHERE emp.employee_id NOT IN 
                        (SELECT mgr.manager_id
                        FROM employees mgr);
        
SELECT emp.last_name
FROM employees emp 
WHERE emp.employee_id IN(100, 102, 103);

SELECT emp.last_name
FROM employees emp
WHERE 
 emp.employee_id <> null
OR emp.employee_id <> 100
OR emp.employee_id <> 101
OR emp.employee_id <> 103;

SELECT emp.last_name
FROM employees emp
WHERE 1=1
AND emp.employee_id <> null
AND emp.employee_id <> 100
AND emp.employee_id <> 101
AND emp.employee_id <> 103;