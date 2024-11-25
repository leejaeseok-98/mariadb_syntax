--  사용자 관리
-- 사용자 목록 조회
select * from mysql.users;

--사용자 생성
create user '계정명'@'localhost (or) %' identified by '4321';--(비밀번호)

--사용자에게 select 권한 부여
grant select on board.author to 'kimseonguk'@'localhost';

--사용자 권한 회수
revoke select on board.author from 'kimseonguk'@'localhost';

--사용자 계정 삭제
drop user 'kimseonguk'@'localhost';





























