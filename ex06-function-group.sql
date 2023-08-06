/*
파일명 : ex06-function-group.sql
*/

-- 여러행(그룹) 함수

-- AVG() - 평균
-- MAX() - 최대값
-- MIN() - 최소값
-- SUM() - 합계

SELECT AVG(salary) AS avg_salary,
        MAX(salary) AS max_salary,
        MIN(salary) AS min_salary,
        SUM(salary) AS SUM_salary
FROM employees
WHERE job_id LIKE '%REP%';

--COUNT() 함수 - null 값이 아닌 모든 행의 개수를 반환합니다. 
SELECT *
FROM employees
WHERE department_id = 50;


SELECT COUNT(*) AS total_employees
FROM employees
WHERE department_id = 50;

SELECT COUNT(commission_pct) AS non_null_commission_count
FROM employees
WHERE department_id = 50;