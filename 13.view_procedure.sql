-- view : 실제데이터를 참조함ㄴ 하는 가상의 테이블
-- 사용목적 1) 복잡한 쿼리 대신 2) 테이블의 컬럼까지 권한 분리
-- 복잡한 쿼리를 한번짜면 뷰이름만 써서 조회할 수 있음

--view 생성
create view author_for_marketing as select name, email from author;
-- view 조회
select * from author_for_marketing;

--view권한부여
grant select on board.author_for_marketing to '계정명'@'localhost'

--view삭제
drop view author_for_marketing;

--프로시저 생성 //프로시저는 복잡한 쿼리를 한번에 실행하도록 함 -view와 비슷함..프로그래밍이 가능
DELIMITER //
create procedure hello_procedure()
begin
    select 'hello world';
end
// DELIMITER ;

--프로시저 호출
call hello_procedure();

--프로시저 삭제
drop procedure hello_procedure();

--게시글목록조회 프로시저 생성
DELIMITER //
create procedure 게시글목록조회()
begin
    select 'hello world';
end
// DELIMITER ;

call  게시글목록조회();

--게시글 단건 조회
DELIMITER //
create procedure 게시글id단건조회(in postid bigint)
begin
    select * from post where id = postid;
end
// DELIMITER ;

call  게시글id단건조회(1);

--게시글목록조회byemail
DELIMITER //
create procedure 게시글목록조회byemail(in inputEmail varchar(255))
begin
    select p.id, p.title, p.contents from post inner join author_post ap on a.id = ap.author_post  where email = inputEmail;
end
// DELIMITER ;

--글쓰기
DELIMITER //
create procedure 글쓰기(in inputTitle varchar(255),in inputContents varchar(255),in inputEmail varchar(255))
begin
    declare authorId bigint;
    declare postId bigint;
    --post테이블에 insert
    insert into post(title, contents) values (inputTitle, inputContents)
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;
    --author_post테이블 insert
    insert into author_post(author_id, post_id) VALUES(authorId,postId);
end
// DELIMITER ;

-- 글삭제 : 입력값으로 글id, 본인email
DELIMITER //
create procedure 글삭제(in inputPostId bigint,in inputEmail varchar(255))
begin
    declare authorPostCount bigint;
    declare authorId bigint;
    select count(*) into authorPostCount from author_post where post_id = inputPostId;
    select id into authorId from author where email = inputEmail;
    if authorPostCount >= 2 then
    --elseif까지 사용 가능
        delete from author_post where post_id = inputPostId and author_id=authorId;
    else
        delete from author_post where post_id = inputPostId and author_id=authorId;
        delete from post where id = inputPostId;
        +
    end if;

end
// DELIMITER ;

--반복문을 통해 post대량 생성 : title, 글쓴이 email

create procedure 글도배(in count int,in inputEmail varchar(255))
begin
    declare countValue int default 0;
    declare authorId bigint;
    declare postId bigint;
    while countValue < count Do
    insert into post(title, contents) values ("안녕하세요");
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;
    insert into author_post(author_id, post_id) VALUES(authorId,postId);
        set countValue = countValue+1;
    end while;

end
// DELIMITER ;













