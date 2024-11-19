--tinyint는 -128 ~ 127까지 표현(1byte할당)
--author테이블에 age 컬럼 추가
alter table author add column age tinyint
--data insert 테이트
insert into author(id, age) values();
alter table author modify column age tinyint unsigned;
insert into author(id, age) values(6, 200);

--decimal실습
--decimal(정수부, 소수부자릿수)
alter table post add column price decimal(10, 3);

-- decial 소수점 초과 후 값 짤림 현상
insert into post(id, title, price) values(4, 'java programming', 10.33412); 

--문자열 실습
alter table author add column self-introduction text;
insert into author(id, self-introduction) values(7,'안녕하세요. 이재석입니다.')

--프로필 이미지 사진 어떻게 저장 -> 이미지 또는 동영상 -> 바이너리 데이터 변환

--blob(바이너리데이터) 타입 실습
alter table author add column profile_image longblob;
insert into author(id, profile_image) values(8, LOAD_FILE('파일경로'))

-- ENUM : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('user','admin') not null default 'user';
--user값 세팅 후 insert
insert into author(id, role) values(10, 'user');
--users값 세팅 후 insert(잘못된 값)
insert into author(id, role) values(11, 'usesr');
--아무것도 안넣고 insert(default 값)
insert into author(id, name, email) values(11, 'hong', 'hongildong');
-- 남/여와 같이 정해져 있는 것들 or 넣어야 하는 것이 정해져있는 것
--DATE : 날짜, datetime: 날짜 및 시분초(microseconds)
-- datetime은 입력,수정, 조회시에 문자열 형식을 활용
alter table post add column created_time datetime default current_timestamp();

-- 조회시 비교연산자
select * from author where id >= 2 and id <= 4;
select * from author where id between 2 and 4; 2~4
select * from author where id not(id < 2 or id > 4);
select * from author where id in(2,3,4)
-- select * from author where id in(select author_id from post); 로도 활용 가능
select * from author where id not in(1,5) -- 전체 데이터가 1~5까지 있다는 가정

 -- alter table post add column created_time datetime (default current_tiime) : 자바/스프링에서 할 수 있음

 -- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
 select * from post where title like '%h'; -- h로 끝나는 title검색
 select * from post where title like 'h%'; -- h로 시작하는 title검색
 select * from post where title like '%h%'; -- 단어에 이 문자가 있을 경우 검색

-- regexp : 정규표현식을 활용한 조회
select * from author where title regexp '[a-z]'; -- 소문자 알파벳이 하나라도 들어있으면
select * from author where title regexp '[가-힣]'; --하나라도 한글이 포함돼 있으면

-- 날짜변환 : cast, convert :  숫자->날짜, 문자->날짜
select cast(20241119 as date);
select cast('20241119' as date);
select convert(20241119, date);
select convert('20241119', date);

--문자 -> 숫자 변환
select cast('12' as unsigned);
-- cast(date_format(created_time, %H) as unsigned) : created_time에서 시간만 뽑아낸다. 뽑아내면 문자 타입이 됨 / 문자를 cast해서 언사인드 해버림 = int타입

--날짜 조회 방법
--like패턴, 부등호 활용, date_format
select * from post where created_time like '2024-11%'; --문자열처럼 조회
select * from post where created_time >= '2024-01-01' and created_time >= '2025-01-01'

--data_format활용
select date_format(created_time, '%Y-%m-%d') from post; --연,월,일
select date_format(created_time, '%H:%i-%s') from post; --시,분,초
select * from post where date_format(created_time,'%Y') = '2024';
select * from post where cast(data_format(created_time, '%Y')='2024' as unsigned) = 2024;

-- 현재 시간(날짜포함)
select now();
