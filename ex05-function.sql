/*
파일명 ex05-function.sql

함수(function)
    매개변수를 받아 특성 계산(작업)을 수행하고 결과를 반환하는 구조로 되어있다.

함수 유형
    단일행 함수  - 단일형 매개변수를 받아 결과 값 반환
    여러행(그룹) 함수 - 여러행 매개변수를 받아 결과 값 반환
    
*/

-- 단일행 함수

-- 1.대소문자 변환 함수
    -- LOWER() 함수 - 문자열을 소문자로 변환
SELECT employee_id, last_name, department_id
FROM employees
WHERE LOWER(last_name) = 'higgins';

-- UPPER() 함수 - 문자열을 대문자로 변환
SELECT UPPER('higgins') FROM dual;
-- 단순 출력을 하고 싶을 떈 FROM dual 사용
/* SELECT 12*3 FROM dual; */

-- INITCAP(함수) - 문자열의 첫 글자를 대문자로 변환
SELECT employee_id, last_name, department_id
FROM employees
WHERE last_name = INITCAP('higgins');

-- 문자 조작 함수 
  -- CONCAT() 함수 - 두 개의 파라미터 값을 연결합니다.
SELECT 'Hello' || 'World' FROM dual;
SELECT CONCAT('Hello', 'World') FROM dual;

-- SUBSTR() - 지정된 길이의 문자열 추출합니다.
SELECT SUBSTR('HelloWorld', 1, 7) FROM dual; -- HelloWo

-- LENGTH() - 문자열의 길이를 숫자 값으로 표시합니다
SELECT LENGTH ('HelloWorld') From dual; --10

-- INSTR() - 문자열에서 지정된 문자의 위치를 찾습니다.
SELECT INSTR('HelloWorld', 'W') FROM dual; --6 6번째 글자 

--LPAD() - 왼쪽부터 문자식으로 채운 표현식을 반환합니다.
SELECT LPAD('salary', 10, '*') FROM dual; -- ****salary

--RPAD() - 오른쪽부터 문자식으로 채운 표현식을 반환합니다.
SELECT RPAD('salary', 10, '*') FROM dual; -- salary****

-- REPLACE() -문자열에서 지정된 문자를 치환합니다.
SELECT REPLACE('JACK and JUE', 'J', 'BL') FROM dual; --BLACK AND BLUE

-- TRIM() - 문자열에서 선행 또는 후행 문자를 자릅니다.
SELECT TRIM('H' FROM 'HelloWorld') FROM dual; -- elloWorld

-- 숫자 함수 
-- ROUND() - 지정된 소수점 자릿수로 값을 반올림합니다.
SELECT ROUND(45.926, 2) FROM dual;

-- TRUNC() - 지정된 소수점 자릿수로 값을 전달합니다.
SELECT TRUNC(45.926, 2) FROM dual;

-- MOD() - 나눈 나머지를 반환합니다.
SELECT MOD(1600, 300) FROM dual;

-- CEIL() - 주어진 소수점을 올림하여 정수로 반환
SELECT CEIL(45.2) FROM dual; -- 46



-- 날짜 함수 

-- SYSDATE - 현재 날짜와 시간을 얻을수 있는 pseudo-column
SELECT SYSDATE FROM dual;

/*
날짜 연산
    날짜에 숫자를 더하거나 빼서 결과 날짜 값을 구합니다.
    두 날짜 사이의 일수를 알아내기 위해 빼기연산을 합니다.
*/

SELECT last_name, (sysdate - hire_date) / 7 AS WEEKS 
FROM employees
WHERE department_id = 90;

/*
날짜 조작 함수
    MONTHS_BETWEEN(date1, date2) : 두 날짜 간의 월 수를 계산합니다.
    ADD_MONTHS(date, n) : 날짜에 n개월을 추가합니다.
    NEXT_DAY(date, day_of_week) : 지정된 날짜의 다음으로 주어진 요일이 나오는 날짜를 계산합니다.
                                    (1: 일요일 ~ 7:토요일)
    LAST_DAY(date) : 주어진 월의 마지막 날짜를 반환합니다.
    ROUND(date, format) : 날짜를 지정된 형식으로 반올림합니다.
    TRUNC(date, format) : 날짜를 지정된 형식으로 절삭합니다.
    
*/
SELECT MONTHS_BETWEEN(TO_DATE('2017-12-22', 'YYYY-MM-DD'), TO_DATE('2017-05-22', 'YYYY-MM-DD')) FROM dual;

SELECT ADD_MONTHS(TO_DATE('2022-12-16', 'YYYY-MM-DD'), 1) FROM dual;

SELECT NEXT_DAY(TO_DATE('2023-08-05', 'YYYY-MM-DD'), 7) FROM dual;

SELECT LAST_DAY(TO_DATE('2023-08-05', 'YYYY-MM-DD')) FROM dual;

SELECT ROUND(SYSDATE, 'MONTH') FROM dual;
SELECT TRUNC(SYSDATE, 'MONTH') FROM dual;

-- 변환 함수
/*
-  TO_CHAR() 함수 - 날짜 또는 숫자를 문자열로 변환
 
    yyyy - 전체 연도를숫자로 나타냅니다.
    YEAR - 영어 철자로 표기된 연도를 반환합니다.
    MM - 월의 2자리 숫자 값을 반환합니다.
    MONTH - 전체 월 이름을 반환합니다.
    MON - 월의 3자리 약어를 반환합니다.
    DY - 3자리 요일 약어를 반환합니다.
    DAY - 요일의 전체 이름을 반환합니다. 
    DD - 월간 일(1-31)을 숫자 형식응로 반환합니다.
    HH, HH12, HH24 -1일 동안 시간 똔든 반일 시간(1-12) 또는 전일 시간(0-23)을 반환합니다.
    MI - 분(0-59)을 반환합니다.
    SS - 초(0-59)를 반환합니다.
    FF - 밀리세컨드(0-999)를 반환합니다.
    AM 또는 PM - 오전/오후를 나타내는 자오선 표시 반환합니다.
    A.M. 또는 P.M. - 오전/오후를 나타내는 마침표가 있는 자오선 표시를 반환합니다.
    
*/

SELECT last_name, TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') AS HIREDATE
FROM employees;

--TIMESTAMP - 날짜 정보 + 밀리세컨드 

SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF2') FROM dual;

/*
-- TO_CHAR() 함수를 숫자에 사용 할 때
        9 - 숫자로 나타냅니다.
        0 - 0이 표시되도록 강제로 적용합니다.
        $ - 부동 달러 기호를 배치합니다. 
        L - 부동 로컬 통화 기호를 사용합니다.
        . - 소수점을 출력합니다.
        , - 천단위 표시자로 쉼표를 출력합니다.
*/

SELECT TO_CHAR(salary, 'L99,999.99') SALARY
FROM employees
WHERE last_name = 'Ernst';

-- TO_DATE() 함수 - 문자열 DATE 타입으로 변환

SELECT last_name, TO_CHAR(hire_date, 'YYYY-MM-DD')
FROM employees
WHERE hire_date < TO_DATE('2005-01-01', 'YYYY-MM-DD');



/*
함수 중첩
    단일 행 함수는 어떠한 레벨로도 중첩 될 수 있습니다.
    중첩된 함수는 가장 깊은 레벨에서 가장 낮은 레벨로 평가됩니다. 
*/

SELECT last_name, UPPER(CONCAT(SUBSTR(last_name, 1, 8), '_US'))
FROM employees
WHERE department_id = 60;

-- NVL() 함수 - null 값을 실제 지정한 값으로 반환합니다. (null이 연산이 안될때 사용)
SELECT last_name, salary, NVL(commission_pct, 0), (salary * 12) AS Y_SAL,
        (salary * 12) + (salary * 12 * NVL(commission_pct, 0)) AS AN_SAL
FROM employees;

-- NVL2() 함수
-- 첫 번째 표현식을 검사합니다. 펏번째 표현식이 null이 아니면 두번 째 표현식을 반환합니다.
-- 첫 번째 표현식이 null  이면 세 번째 표현식이 반환됩니다.

SELECT last_name, salary, commission_pct,
        NVL2(commission_pct, 'SAL+COMM', 'SAL') AS income
FROM employees
WHERE department_id IN(50, 80);

-- NULLIF() 함수
-- 두 표현식을 비교하고 같은면 null을 반환하고 다르면 expr1을 반환합니다.
-- 그러나 expr1에 대해 리터럴 NULL을 지정할 수 없습니다.
SELECT first_name, LENGTH(first_name) AS expr1,
        last_name, LENGTH(last_name) AS expr2,
        NULLIF(LENGTH(first_name), LENGTH(last_name)) AS result
FROM employees;

-- COALESCE() 함수
-- 리스트에서 null이 아닌 첫 번째 표현식을 반환합니다. 
SELECT last_name, employee_id,
        COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id), 'No commission and no manager')
FROM employees;

-- 조건부 표현식 
/*
 CASE 식
        IF-THEW-ELSE 문 작업을 수행하여 조건부 조회를 편리하게 수행하도록 합니다.
*/
SELECT last_name, job_id, salary,
        CASE job_id
            WHEN 'IT_PROG' THEN 1.10 * salary
            WHEN 'ST_CLERK' THEN 1.15 * salary
            WHEN 'SA_REP' THEN 1.20 * salary
            ELSE salary
        END AS REVISED_SALARY
FROM employees;

-- DECODE() 함수
-- CASE 식과 유사한 작업을 수행합니다.
SELECT last_name, job_id, salary,
        DECODE(job_id, 'IT_PROG', 1.10 * salary,
                        'ST_CLERK', 1.15 * salary,
                        'ST_REP', 1.20 * salary,
                        salary) AS REVISED_SALARY
FROM employees;
            



