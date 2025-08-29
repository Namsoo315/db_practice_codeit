SET search_path TO codeit;

/*
01. GROUP BY 및 HAVING 및 ORDER BY 관련 예제
*/

SELECT *
FROM employee;
/* Q1)
사원들의 급여의 총 합을 조회하시오.
*/
SELECT SUM(e.salary) AS 급여총합
FROM employee e;


/* Q2)
사원들의 급여의 평균을 구하시오.
*/
SELECT AVG(e.salary) AS 급여평균
FROM employee e;


/* Q3)
employee 테이블에서 부서 코드별 그룹을 지정하여
부서코드, 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리), 인원수를 조회하고,
부서코드 순으로 오름차순 정렬하시오.
*/

SELECT e.dept_code,
       SUM(e.salary),
       FLOOR(AVG(e.salary)),
       COUNT(*)
FROM employee e
GROUP BY e.dept_code -- 그룹화
ORDER BY e.dept_code;
-- 정렬

/* Q2)
employee 테이블에서 직급별 직급코드, 보너스를 받는 사원수를 조회하여
직급코드 순으로 오름차순 정렬하시오.
*/
SELECT e.job_code,
       count(*) AS 보너스
FROM employee e
WHERE e.bonus IS NOT NULL
GROUP BY e.job_code
ORDER BY e.job_code;


SELECT *
FROM employee
WHERE salary >= 3_000_000;
/* Q3) HARD!!
employee 테이블에서 주민번호의 8번 째 자리를 조회하여 1이면 남, 2면 여로 결과를 조회하고
성별별 급여 평균(정수처리), 급여 합계, 인원수를 조회한 뒤
인원수로 내림차순 정렬하시오.
*/
SELECT CASE SUBSTRING(e.emp_no, 8, 1)
           WHEN '1' THEN '남'
           WHEN '2' THEN '여'
           ELSE 'NO' END AS 성별,
       FLOOR(AVG(e.salary)),
       SUM(e.salary),
       COUNT(*)          AS 인원수
FROM employee e
GROUP BY 성별
ORDER BY 인원수 DESC;

/* Q4)
300만원 이상을 받는 사원들의 부서별 평균 급여를 조회하시오.
(힌트: 평균 급여는 FLOOR()를 사용해 적절히 잘라내야 할 수도 있다)
*/
SELECT e.dept_code, FLOOR(AVG(e.salary)), count(*)
FROM employee e
WHERE e.salary >= 3_000_000
GROUP BY e.dept_code;

/* Q5)
평균이 300만원 이상인 부서 사원들의 평균 급여를 조회하시오.
(힌트: 평균 급여는 FLOOR()를 사용해 적절히 잘라내야 할 수도 있다)
*/
SELECT e.dept_code, FLOOR(AVG(e.salary)), count(*)
FROM employee e
GROUP BY e.dept_code
HAVING AVG(e.salary) >= 3_000_000;

/* Q6)
급여 합계가 가장 많은 부서의 부서 코드와 급여 합계를 구하시오.
*/

SELECT e.dept_code AS 부서코드,
       sum(e.salary) AS 합계
FROM employee e
GROUP BY e.dept_code
ORDER BY 합계 DESC
LIMIT 1;
