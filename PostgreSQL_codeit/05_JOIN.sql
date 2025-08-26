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

-- ANSI 문법
SELECT
    e.emp_id,e.emp_name,d.dept_title
FROM employee e
JOIN department d ON e.dept_code = d.dept_id
  WHERE d.dept_title = '총무부' OR d.dept_title = '기술지원부';

-- ANSI 금기 문법
-- ON이 사실상 WHERE절이기 때문에 ON에서 사용해도 된다.
SELECT
    e.emp_id,e.emp_name,d.dept_title
FROM employee e
    JOIN department d ON e.dept_code = d.dept_id
    AND (d.dept_title = '총무부' OR d.dept_title = '기술지원부');

-- CROSS JOIN : Cartesian(카테시안) 곱, ROW간 결합될 수 있는 전체 경우 수를 출력
SELECT
    e.emp_name, d.dept_title
FROM employee e
    CROSS JOIN department d;

-- self join : 테이블 하나로 join을 활용하는 경우, 자기 자신을 참조할 일이 생긴다.(자신이 트리구조로 구성 될 때)
-- 사례 : 대댓글, Q&A글처럼 한 테이블 안에 자식-부모 관계가 성립되는 트리 구조
-- 직원의 관리자를 출력해라!
SELECT
    e.emp_id, e.emp_name, e.manager_id, m.emp_name AS 관리자
FROM employee e
    JOIN employee m ON e.manager_id::INT = m.emp_id;

-- 관리자가 없어도 출력이 빌표할땐 LEFT 조인 활용해야 한다.
SELECT
    e.emp_id, e.emp_name, e.manager_id, m.emp_name AS 관리자
FROM employee e
         LEFT JOIN employee m ON e.manager_id::INT = m.emp_id;

-- 다중 join : 3개 이상의 테이블을 결합할때 사용 ★★★★★
-- employee, job, department, location
-- 직원 id, 이름, 직위이름, 부서이름, 부서의 국가 위치, 국가 이름, Local 이름
-- 주의점 : join 순서가 존재한다!
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;
SELECT * FROM location;
SELECT
    e.emp_id, e.emp_name, j.job_name, d.dept_title,d.location_id, l.local_name
FROM employee e
    JOIN job j ON e.job_code = j.job_code
    JOIN department d ON e.dept_code = d.dept_id
    JOIN location l ON d.location_id = l.local_code;

-- oracle문법 다중 조인
SELECT e.emp_id,
       e.emp_name,
       j.job_code,
       d.dept_title,
       l.local_name,
       l.national_code
FROM employee e,
     job j,
     department d,
     location l
WHERE e.job_code = j.job_code
  AND e.dept_code = d.dept_id
  AND d.location_id = l.local_code;

-- NON_EQUI JOIN : 비등가조인 일치하는 범위에 값을 가져오는 기능
SELECT
    e.emp_name, e.salary, s.sal_level
FROM employee e
         JOIN sal_grade s ON (e.salary BETWEEN  3000000 AND 3500000);

SELECT
    e.emp_name, e.salary, s.sal_level
FROM employee e
         JOIN sal_grade s ON (e.salary BETWEEN  min_sal AND max_sal);

SELECT  * FROM sal_grade;
SELECT * FROM  employee;

-- DB에서 성능적으로 고려 할 순서 (연산이 오래 걸리는 시간)
-- 1. 네트워크 전송시간 -> 여러 네트워크를 통해 DB 사용함으로써 전송시간에 딜레이 생긴다.
-- 2. HDD(하드디스크, SSD)에서 읽어오는 시간 -> 캐시를 통해 빠르게 접근하기는 하지만 느리다!
-- 3. 쿼리 처리 시간 (복잡한 함수나 로직으로 인해 처리가 지연되는 시간)

-- JOIN문을 사용할때 주의 해야할 점 = 이유? 잘못 사용하면 과도한 JOIN으로 인해 성능저하 발생!
-- 1. index 생성된 값을 키값으로 사용 할 것 (PK는 index를 자동 생성함으로 PK로 join 권장)
-- 2. 결합하는 값은 주로 외래키 = 주키로 사용할 것 ★★★★★
--    -> DB 설계할때 sequence number 통해 주키를 할당하고 해당 키로 Join을 하면 속도 측면에서 문제가 거의 없다.
-- 3. Outer Join은 Inner Join 성능저하 유발한다. 다중으로 중복해서 사용하지 말길 권장, 6개 정도가 권장
-- ※ Join을 통해 성능 저하가 발생하는 경우 꼬인 코드를 풀어 성능 개선을 하거나 적절한 반정규화를 실행해야한다.
---------------------------------- JOIN 끝 ------------------------------------

