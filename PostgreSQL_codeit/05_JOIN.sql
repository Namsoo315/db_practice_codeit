---------------------------------  JOIN  ---------------------------------------
SET search_path TO codeit;

-- JOIN문 ★★★★★
-- - 두 테이블 간에 Null이 없는 값만 테이블로 통합하는 방법 (Inner join)
-- - 두 테이블 간에 Null이 있어도 통합이 가능한 방법 (Ouuter join)
-- - 자기 자신과도 Join이 가능하다. (Self join)

-- ANSI식 (American National Standards Institute) 권장(수업) ★★★★★
SELECT
    emp_name, dept_title
FROM employee
    JOIN department ON dept_id = dept_code;

SELECT
    emp_name, dept_title
FROM employee
         JOIN department ON (dept_id = dept_code);
-- 강사 추천 ★★★★★★★★★★★★★★★★
SELECT
    *
FROM employee e
    JOIN department d ON e.dept_code = d.dept_id;

-- USING 문법 : JOIN 되는 키값의 이름이 같을때 사용 가능, !무조건 괄호 필요!
SELECT
    emp_name, job_code, job_name
FROM employee
    JOIN job USING (job_code);

-- 강사 추천
SELECT
    e.emp_name, e.job_code, j.job_code
FROM employee e
    JOIN job j ON e.job_code = j.job_code;

SELECT
    l.local_code, l.local_name, n.national_code
FROM location l
    JOIN national n USING (national_code);

-- Inner JOIN : INNER가 있거나 일반적인 Join문 특별한 키워드가 없는 Join 문장
--              외래키를 사용하는데 null을 허용하지 않고 외래키와 주키가 완벽하게 일치하면 사용하면 된다.
--              -> 반대로 null이 허용되는 경우에 null이 포함된 값을 조회하는 경우는 Outer JOIN을 사용해야한다.
--              ex) 게시글의 글쓴 사람, 결제 시의 물품 번호

-- Outer JOIN : LEFT, RIGHT 키워드가 포함된 JOIN 문으로 키가 서로 일치 않는 경우에도 조회 가능하다.
--              한쪽 테이블 기준으로 결측 값(null)이 있어도 join이 가능함
--                 ex) 주문테이블과 카드결제 테이블을 같이 조회할때, 카드결제가 아니어도 같이 조회할 때
--                     게시글과 댓글을 같이 조회할때 댓글이 없어도 같이 조회할때
--              ※ 주로 잘못된 설계나 결측(null)값을 비정상적으로 조회할때 사용된다.
--              -> Inner join 대비 성능 저하가 크게 발생하나 어쩔수 없이 사용해야한다.

-- left join(ANSI) - 왼쪽 기준으로 오른쪽 null 값이 조회되는 경우
-- 키워드 : left outer join or left join
SELECT
    e.emp_name, e.dept_code, d.dept_title
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id;

-- right join(ANSI) - 오른쪽 기준으로 왼쪽 null 값이 조회되는 경우
-- 키워드 : right outer join or right join
SELECT
    e.emp_name, e.dept_code, d.dept_title
FROM employee e
         RIGHT JOIN department d ON e.dept_code = d.dept_id;

-- JOIN문 WHERE절 조합

-- ORACLE 문법 -> 기본적으로 WHERE절이 있으므로 AND, OR를 결합해서 사용해야 한다. <- 불편!
-- 총무부이거나 기술지원부인 사람을 찾아라
SELECT
    e.emp_id,e.emp_name,d.dept_title
FROM employee e, department d
WHERE e.dept_code = d.dept_id
    AND (d.dept_title = '총무부' OR d.dept_title = '기술지원부');