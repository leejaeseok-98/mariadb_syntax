 -- read uncommited에서 발생할 수 있는 dirty read실습
 -- 실습절차 
 -- 1) work벤치에서 auto_commit해제 후 update, commit하지 않음(트랜잭션1) / 문제점 : rollback할 수 있음 -> 정합성이 깨짐
 -- 2) 터미널을 열러 select했을 때 위 변경사항이 읽히는지 확인 (트랜잭션2)
 -- 2) 터미널을 열러 select했을 때 위 변경사항이 읽히는지 확인 (트랜잭션2)
 -- 결론 : mariadb는 기본이 repeatable read이므로 commit되기전에 조회되는 dirty read 발생하지 않음


--read commited에서 발생할 수 있는 phantom read, non-reapeatablee-read 실습
-- 아래코드는 워크벤치에서 실행
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
--아래 코드는 터미널에서 실행한다.
insert into author(email) values('ffffff');
-- 결론 : mariadb는기본이 repeatable read이므로 phantom read 발생하지 않음.

--repeatable read에서 발생할 수 있는 lost update 실습

--lost update 해결을 위한 배타적 lock
-- 아래 코드는 워크벤치에서 실행
start transaction;
select post_count from author where id = 1 for update;
do sleep(10);
update author set post_count = (select post_count from author where id = 1)-1 where id = 1;
commit

-- 아래 코드는 터미널에서 실행
update author set post_count = (select post_count from author where id = 1)-1 where id = 1;

--lost update 해결을 위한 공유 lock
--아래코드는 워크벤치에서 실행
start transaction;
select post_count from author where id = 1 lock in share mode;
do sleep(10);
commit;

--아래코드는 터미널에서 실행
select post_count from author where id = 1 lock in share mode;

















































