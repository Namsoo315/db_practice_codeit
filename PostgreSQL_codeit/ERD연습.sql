CREATE TABLE `사원` (
	`사번`	LONG	NOT NULL,
	`이름`	VARCHAR(20)	NULL,
	`성별`	CHAR(1)	NULL,
	`주소`	VARCHAR(100)	NULL,
	`전화번호`	VARCHAR(20)	NULL,
	`주민등록번호`	VARCHAR(20)	NULL
);

CREATE TABLE `출결상태` (
	`날짜`	DATE	NOT NULL,
	`사번`	LONG	NOT NULL,
	`출결사항`	TEXT	NULL
);

CREATE TABLE `고객` (
	`고객번호`	LONG	NULL,
	`이름`	VARCHAR(20)	NOT NULL,
	`전화번호`	VARCHAR(20)	NOT NULL,
	`성별`	CHAR(1)	NULL
);

CREATE TABLE `상담일지` (
	`일련번호`	LONG	NULL,
	`타입`	VARCHAR(20)	NULL,
	`상담내용`	TEXT	NULL,
	`고객번호`	LONG	NULL
);

CREATE TABLE `반품목록` (
	`일련번호`	LONG	NULL,
	`반품내용`	TEXT	NULL
);

CREATE TABLE `과정` (
	`과정코드`	LONG	NULL,
	`학생코드`	LONG	NULL,
	`과정명`	VARCHAR(100)	NOT NULL,
	`수강료`	INT	NULL,
	`기간`	VARCHAR(20)	NULL,
	`강사코드`	LONG	NULL
);

CREATE TABLE `강사` (
	`강사코드`	LONG	NULL,
	`이름`	VARCHAR(20)	NOT NULL,
	`전화번호`	VARCHAR(20)	NOT NULL
);

CREATE TABLE `학생` (
	`학생코드`	LONG	NULL,
	`이름`	VARCHAR(20)	NOT NULL,
	`전화번호`	VARCHAR(20)	NOT NULL
);

ALTER TABLE `사원` ADD CONSTRAINT `PK_사원` PRIMARY KEY (
	`사번`
);

ALTER TABLE `출결상태` ADD CONSTRAINT `PK_출결상태` PRIMARY KEY (
	`날짜`,
	`사번`
);

ALTER TABLE `고객` ADD CONSTRAINT `PK_고객` PRIMARY KEY (
	`고객번호`
);

ALTER TABLE `상담일지` ADD CONSTRAINT `PK_상담일지` PRIMARY KEY (
	`일련번호`
);

ALTER TABLE `반품목록` ADD CONSTRAINT `PK_반품목록` PRIMARY KEY (
	`일련번호`
);

ALTER TABLE `과정` ADD CONSTRAINT `PK_과정` PRIMARY KEY (
	`과정코드`,
	`학생코드`
);

ALTER TABLE `강사` ADD CONSTRAINT `PK_강사` PRIMARY KEY (
	`강사코드`
);

ALTER TABLE `학생` ADD CONSTRAINT `PK_학생` PRIMARY KEY (
	`학생코드`
);

ALTER TABLE `출결상태` ADD CONSTRAINT `FK_사원_TO_출결상태_1` FOREIGN KEY (
	`사번`
)
REFERENCES `사원` (
	`사번`
);

ALTER TABLE `반품목록` ADD CONSTRAINT `FK_상담일지_TO_반품목록_1` FOREIGN KEY (
	`일련번호`
)
REFERENCES `상담일지` (
	`일련번호`
);

ALTER TABLE `과정` ADD CONSTRAINT `FK_학생_TO_과정_1` FOREIGN KEY (
	`학생코드`
)
REFERENCES `학생` (
	`학생코드`
);

