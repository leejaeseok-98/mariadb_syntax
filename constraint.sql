-- not null 제약조건추가
alter table author modify column email varchar(255) not null;

--unique 제약조건 추가
alter table author modify column email varchar(255) unique;
alter table author modify column email varchar(255) not null unique;

--foreign key 제약조건 삭제 및 추가
--제약조건의 이름 확인 후 삭제 및 추가 기능
--제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';
--제약조건 삭제
alter table post drop foreign key post_ibfk_1;
--제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

--delete , update 관련 제약조건 테스트
--on delete cascade 테스트
--제약조건 삭제
--제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;
--제약조건 삭제
--제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update set null;

-- degault옵션
alter table author modify column name varchar(255) default 'anonymous';
-- 입력하면 입력한 값 기본값 익명

-- auto_increment / id같은 것(고객이 입력하지 않고 자동으로 입력되는 것)
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

alter table post modify column author_id bigint; --위에 했을때 에러 
--제약조건 드랍하고 다시 추가해야함


--db한대에 스프링서버가 있다. 사용자가 저장해서 스프링에 주고 스프링이 db에 줌
-- 저장을 못함 : 해결책 - 스페어 서버에 저장 
--문제점 : 잠깐의 서버가 작동 중단됨
--부하분산기 (로드밸런서) : 로드밸런서에서 나눠서 서버에 보내줌 /
-- 나중에 서버를 합치면 문제점이 생김 : pk값의 중복으로 에러남
-- 해결책 중 하나 : 난수값
--

-- uuid
alter table post add column user_id  char(36) default (UUID());






















