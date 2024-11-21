-- inner join
-- 두테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합찾기
select * from author inner join post on author.id = post,author_id;
select * from author a inner join post p on author.id = post,author_id;
select * from post p inner join author a on author.id = post,author_id; -- 출력순서만 달라질뿐 조회결과는 같음
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일만을 출력하시오.
select p.*, a.email from post p inner join author a on a.id = p.author_id;

-- 글쓴이가 있는 글 제목, 내용, 그리고 글쓴이의 이메일만을 출력하시오.
-- post의 글쓴이가 없는 데이터는 포함 안되고 글쓴이 중에 글을 한번도 안쓴사람
select p.title, p.contents, a.email from post p inner join author a on a.id = p.author_id;

--모든 글목록을 출력하고 만약에 글쓴이가 있아면 이메일 정보 출력
--글을 한번도 안쓴 글쓴이 정보는 포함 x
select p.*, a.email from post p left join author a where a.id = p.author_id;

--글쓴이를 기준으로 left join할 경우, 글쓴이가 n개의 글을 쓸 수 있으므로 같은 글쓴이가 여러번 출력될 수 있음
--author와 post가 1:n관계이다.
-- 글쓴이가 없는 글은 포함 안됌
select * from author a left join post p on a.id=p.author_id;

--실습 : 글쓴이가 있는 글 중에서 글에 title과 저자의 email만 출력하되, 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email from author a inner join post p on a.id = p.author_id where a.age >=30;

--글의 내용과 글의 저자의 이름이 있는, 글 목록을 출력하되 2024-06 이후에 만들어진 글만 출력
select p.title, a.name from post p inner join author a on a.id = p.author_id where created_time >= 2024-06;

select p.title, a.name from post p left join author a on a.id = p.author

--union : 두테이블의 select 결과를 횡으로 결합(기본적으로 distinct 적용)
--컴럼의 개수와 컬럼의 타입이 같아야함에 유의
-- union all : 중복까지 모두 포함
select name, email from author union select title, contents from post;

--서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
--where절 안에 서브쿼리
-- 한번이라도 글을 쓴 author목록 조회
select distinct a.* from author a inner join post p on a.id = p.author_id;
select * from author  where id in (select author_id from post);
--select절 안에 서브쿼리
--author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) from post where author_id = a.id)from author a;

--from절 안에 서브쿼리
select a.name from (select * from author) as a;

--없어진 기록 찾기
select * from ANIMAL_OUTS

--집계함수
select COUNT(id) from author; == select COUNT(*) from author;
--null은 카운트가 제외된다.
select sum(price) from post;
select avg(price) from post;
--소수점 첫번째자리에서 반올림해서 소수점을 없앱
select round(avg(price), 0) as '평균' from post;

--group by : 그룹화 데이터를 하나의 행(row)처럼 취급.
-- author_id로 그룹핑 하였으면, 그외의 컬럼을 조회하는 것은 적절치 않다.
select author_id from post group by author_id;
--group by와 집계함수는 같이 활용됨
--아래 쿼리에서 *은 그룹화된 데이터내에서의 개수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price) from post group by author_id;

--author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) from post where author_id = a.id)from author a;
-- 위에 문제 join과 group by 집계함수를 사용한 글의 개수 출력 -- join해서 author_id 그룹화하고 개수 씀
select a.email, count(author_id) from author a inner join post p on a.id = p.author_id group by author_id where ifnull(author_id,0);


--where와 group by -- select from join on where group by having order by
--연도별 post 글의 개수 출력, 연도가 null인 값은 제외
select date_format(created_time,'%Y') as year, count(*) as count from post where created_time is not null group by year 
having year = 2024;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기

-- 입양 시각 구하기(1)

-- having : group by를 통해 나온 집계값에 대한 조건
-- 글을 2개 이상 쓴사람에 대한 정보조회
select author_id from post group by author_id having count(*) >=2;
select author_id, count(*) as count from post group by author_id having count>=2;

--다중열 group by
--post에서 작성자별로 만든 제목의 개수를 출력하시오.
select author_id, title, count(*) from post group by author_id, title;




