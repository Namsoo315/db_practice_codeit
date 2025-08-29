SET search_path TO codeit;

/*
01. JOIN 관련 예제
*/

SELECT *
FROM employee;
SELECT *
FROM job;
SELECT *
FROM department;
SELECT *
FROM location;
SELECT *
FROM national;
SELECT *
FROM sal_grade;
/* Q1)
직급이 대리이면서, 아시아 지역에 근무하는 직원의 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하시오.
(힌트: INNER JOIN, JOIN 조건)
*/
SELECT e.emp_id,
       e.emp_name,
       j.job_name,
       d.dept_title,
       l.local_name,
       e.salary
FROM employee e
         JOIN job j ON e.job_code = j.job_code
         JOIN department d ON e.dept_code = d.dept_id
         JOIN location l ON l.local_code = d.location_id
WHERE j.job_name = '대리' AND
      l.local_name LIKE 'ASIA%';

/* Q2)
주민번호가 70년대 생이면서 성별이 여자이고, 성이 '전'씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
(힌트: SUBSTRING, LIKE, JOIN)
*/
SELECT e.emp_name,
       e.emp_no,
       d.dept_title,
       j.job_name
FROM employee e
         JOIN job j ON e.job_code = j.job_code
         JOIN department d ON e.dept_code = d.dept_id
WHERE SUBSTRING(e.emp_no, 1, 1) = '7' AND
       SUBSTRING(e.emp_no, 8, 1) IN ('2', '4')
  AND emp_name LIKE '전%';


/* Q3)
이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
(힌트: LIKE, JOIN)
*/
SELECT e.emp_id,
       e.emp_name,
       d.dept_title
FROM employee e
         JOIN department d ON e.dept_code = d.dept_id
WHERE e.emp_name LIKE '%형%';


/* Q4)
해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
(힌트: JOIN, WHERE)
*/
SELECT e.emp_name,
       j.job_name,
       e.dept_code,
       d.dept_title
FROM employee e
         JOIN job j ON e.job_code = j.job_code
         JOIN department d ON e.dept_code = d.dept_id
WHERE d.dept_title LIKE '해외영업%';

/* Q5)
보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
(힌트: IS NOT NULL, JOIN)
*/

SELECT e.emp_name,
       e.bonus,
       d.dept_title,
       l.local_name
FROM employee e
         JOIN department d ON e.dept_code = d.dept_id
         JOIN location l ON d.location_id = l.local_code
WHERE e.bonus IS NOT NULL;

/* Q6)
부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
(힌트: JOIN, WHERE)
*/
SELECT e.emp_name,
       j.job_name,
       d.dept_title,
       l.local_name
FROM employee e
         JOIN department d ON e.dept_code = d.dept_id
         JOIN job j ON e.job_code = j.job_code
         JOIN location l ON d.location_id = l.local_code
WHERE d.dept_id = 'D2';

/* Q7)
본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의 사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
단, 연봉에 보너스포인트를 적용할 것.
(힌트: JOIN, COALESCE)
*/
SELECT e.emp_name,
       j.job_name,
       e.salary,
       (e.salary + COALESCE(e.salary * e.bonus, 0)) * 12 AS 보너스포함연봉
FROM employee e
         JOIN job j ON e.job_code = j.job_code
JOIN sal_grade s ON e.sal_level = s.sal_level
WHERE e.salary > s.min_sal;


/* Q8)
한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
(힌트: JOIN, IN)
*/
SELECT e.emp_name,
       d.dept_title,
       l.local_name,
       n.national_name
FROM employee e
         JOIN department d ON e.dept_code = d.dept_id
         JOIN location l ON d.location_id = l.local_code
         JOIN national n ON l.national_code = n.national_code
WHERE n.national_code IN ('KO', 'JP');

/* Q9)
같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
단, SELF JOIN을 사용해 작성할 것.
(힌트: SELF JOIN)
*/
SELECT e1.emp_name,
       e1.dept_code,
       e2.emp_name
FROM employee e1
JOIN employee e2 ON e1.dept_code = e2.dept_code
WHERE NOT e1.emp_name = e2.emp_name;

/* Q10)
보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
(힌트: IS NULL, JOIN, IN)
*/
SELECT e.emp_name,
       j.job_name,
       e.salary
FROM employee e
JOIN job j ON e.job_code = j.job_code
WHERE e.bonus IS NULL AND
    e.job_code IN ('J4', 'J7')
