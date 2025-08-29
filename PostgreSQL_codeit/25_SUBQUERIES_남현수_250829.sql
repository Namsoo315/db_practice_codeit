SET search_path TO codeit;

/*
01. SUBQUERY 관련 예제
*/

/* Q1)
사원명이 '노홍철'인 사원의 부서코드와 같은 부서에 속한 직원의 이름과 부서코드를 조회하시오.
(힌트: 서브쿼리, WHERE 절)
*/
SELECT e.emp_name,
       e.dept_code
FROM employee e
WHERE e.dept_code = (SELECT dept_code FROM employee WHERE emp_name = '노홍철')
  AND NOT e.emp_name = '노홍철';


/* Q2)
전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하시오.
(힌트: 서브쿼리, AVG, WHERE 절)
*/
SELECT e.emp_id,
       e.emp_name,
       e.dept_code,
       e.salary
FROM employee e
WHERE e.salary > (SELECT AVG(salary) FROM employee);

/* Q3)
노홍철 사원의 급여보다 많은 급여를 받고 있는 사원의 사번, 이름, 부서코드, 직급코드, 급여를 조회하시오.
(힌트: 서브쿼리, WHERE 절)
*/
SELECT e.emp_id,
       e.emp_name,
       e.dept_code,
       e.job_code,
       e.salary
FROM employee e
WHERE e.salary > (SELECT salary FROM employee WHERE emp_name = '노홍철');


/* Q4)
가장 적은 급여를 받는 직원의 사번, 이름, 직급코드, 부서코드, 급여, 입사일을 조회하시오.
(힌트: 서브쿼리, MIN, WHERE 절)
*/
SELECT e.emp_id,
       e.emp_name,
       e.job_code,
       e.dept_code,
       e.salary,
       e.hire_date
FROM employee e
WHERE e.salary = (SELECT MIN(salary) FROM employee);

/* Q5)
부서별 급여 합계 중 가장 큰 부서의 부서명, 급여 합계를 조회하시오.
(힌트: 서브쿼리, GROUP BY, HAVING 절)
*/
SELECT d.dept_title, SUM(e.salary) AS 급여합계
FROM employee e
         JOIN department d ON e.dept_code = d.dept_id
GROUP BY d.dept_title
HAVING SUM(e.salary) =
       (SELECT SUM(salary) FROM employee GROUP BY dept_code ORDER BY SUM(salary) DESC LIMIT 1);

/* Q6)
부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여를 조회하시오.
(힌트: 서브쿼리, IN 연산자)
*/
SELECT e.emp_name, e.job_code, e.dept_code, e.salary
FROM employee e
WHERE (e.dept_code, e.salary) IN (SELECT dept_code, MAX(salary) FROM employee GROUP BY dept_code)
ORDER BY e.dept_code;

SELECT *
FROM job;
SELECT * FROM employee
WHERE job_code = 'J6';
SELECT * FROM employee
WHERE job_code = 'J5';

/* Q7)
과장 직급의 최소 급여보다 많이 받는 대리 직급의 사번, 이름, 직급명, 급여를 조회하시오.
*/
SELECT e.emp_id, e.emp_name, j.job_name, e.salary
FROM employee e
         JOIN job j ON e.job_code = j.job_code
WHERE j.job_name = '대리'
  AND e.salary > (SELECT MIN(e2.salary)
                  FROM employee e2
                           JOIN job j2 ON e2.job_code = j2.job_code
                  WHERE j2.job_name = '과장');

/* Q8)
직급별 급여 평균을 조회하시오.
(힌트: 서브쿼리, GROUP BY)
*/
SELECT j.job_code,
       floor(sub.급여평균)
FROM (
        SELECT job_code, AVG(salary) AS 급여평균
        FROM employee
        GROUP BY job_code
     )sub
JOIN job j ON sub.job_code = j.job_code


