--------------------- UNION ---------------------------
SET search_path TO codeit;

-- 집합 연산자 (UNION, ALL UNION )
-- - 여러개의 select문을 합칠때 사용하는 연산, select절의 table이 달라도 컬럼 갯수만 맞추면 결합이 가능
-- - 서로 다른 테이블간의 결합을 할때 사용된다 ★★★★★
-- - 제약 : table이 달라도 되지만 컬럼 갯수만 일치하면 된다.
-- - 사용처 : 서로 다르게 설계한 table간의 결합이 필요할때 사용된다. (대부분이 설계 미스인 경우다. 권장하진 않지만 빈도는 높은 명령어)
-- - 장점 : 다르게 설계된 테이블도 결합이 가능하다.
-- - 단점 : 연산이 느리다. 다단 UNION은 성능적으로 금기인 명령어!!

-- 직원 테이블과 부서 테이블을 결합 (의미는 없고 훈련용도!)

-- 아래 문장은 갯수가 달라서 UNION이 안된다.
SELECT emp_id, emp_name,dept_code FROM employee
UNION
SELECT dept_id, dept_title FROM department;

SELECT emp_id::CHAR, emp_name FROM employee
UNION
SELECT dept_id, dept_title FROM department;

-- 다른 테이블 연습
SELECT location.local_code, location.local_name FROM location
UNION
SELECT job.job_code, job.job_name FROM job
UNION
SELECT employee.emp_id::CHAR, employee.emp_name FROM employee;

-- Sub Query로 활용하는 방법
SELECT location.local_code, location.local_name FROM location
UNION
SELECT job.job_code, job.job_name FROM job
UNION
SELECT employee.emp_id::CHAR, employee.emp_name FROM employee
ORDER BY local_code; -- 첫번째 결합된 컬럼의 이름 기준
-- ORDER BY 1;

-- WHERE절 붙이기 방법
SELECT location.local_code, location.local_name FROM location
UNION
SELECT job.job_code, job.job_name FROM job
UNION
SELECT employee.emp_id::CHAR, employee.emp_name FROM employee;

-- 같은 테이블 간의 UNION 연산은 비용만 많이 발생하고 효율이 좋지 않다.

-- 2. WHERE절
SELECT T.* FROM
    (SELECT local_code, local_name FROM location
     UNION
     SELECT job_code, job_name FROM job
     UNION
     SELECT emp_id::CHAR, emp_name FROM employee) AS T
WHERE length(local_name) <= 2;
