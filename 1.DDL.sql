-- mariadb 서버에 접속
mariadb -u root -p

-- 스키마(데이터베이스) 목록 조회
show databases;

-- 스키마(데이터베이스) 생성 *중요
CREATE DATABASES board;

--데이터베이스 선택 *중요
use board;

--테이블 목록조회 *중요
show tables;

--문자 인코딩 조회
show varables like 'character_set_server';

--문자 인코딩 변경
ALTER DATABASE board default character set = utf8mb4;

-- 테이블 생성
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), passward VARCHAR(255)); --컴럼명, 타입(문자-길이, 숫자-범위 등), pk(유일한 키)

--테이블 컬럼조회 *중요
describe author;

--테이블 컬럼 상세조회
show full columns from author;

--테이블 삭제

--mysql workbeach 

--테이블 생성명령문 조회
show create table author;

-- post 테이블 신규 생성(id, title, content, author_id) *중요
create table post(id int PRIMARY KEY, title VARCHAR(255), content VARCHAR(255),author_id int, foreign key(author_id) references author(id));
create table post(id int PRIMARY KEY, title VARCHAR(255), content VARCHAR(255),author_id int not null, foreign key(author_id) references author(id));


-- 테이블 index(성능 향상 옵션) 조회
show index from author;

-- alter문 : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table post rename posts;

-- 테이블 컬럼 추가 *중요
alter table author add column age int;

--테이블 컬럼 삭제
alter table author drop column age;

--테이블 컬럼명 변경
alter table post change column content contents varchar(255);

--테이블 컬럼 타입과 제약조건 변경 *중요 => 덮어쓰기 됨에 유의 => 명시해야 할 제약조건은 계속 명시해야 함 
alter table author modify column email varchar(100) not null;

--실습 : author 테이블에 address컬럼 추가. varchar 255
alter table author add address varchar (255);
-- 실습 : post테이블에 title은 not null로 변경, contents 3000자로 변경
alter table post modify title not null, modify contents varchar(3000);

--테이블 삭제
show create table post;
drop table post;






