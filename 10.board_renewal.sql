 -- 여러 사용자가 1개의 글을 수정할 수 있다 가정 후 DB 리뉴얼
 -- author와 post가 n:m관계가 되어 관계테이블을 별도로 생성
 create table author(id bigint autho_increment,
 email VARCHAR(255) not null unique, name VARCHAR(255),
 create_time datetime DEFAULT current_timestamp());

 creat table post(id bigint autho_increment primary key,
 title VARCHAR(255) not null, contents VARCHAR(3000), create_time datetime DEFAULT create_time());

 --1:1관계인 author_address
 -- 1:1관계의 보장은 author_id unique 설정
 create table author_address(id bigint autho_increment primary key,
 country VARCHAR(255), city VARCHAR(255), street VARCHAR(255),j author_id bigint not null unique,
 foreign key(author_id) references author(id));

 -- author_post는 연결테이블로 생성
create table author_post(id bigint autho_increment primary key, 
author_id bigint not null, post_id bigint not null, 
foreign key(author_id) references author(id),
foreign key(post_id) references post(id))

--복합키로 author_post 생성
create table author_post2(
    author_id bigint not null,
    post_id bigint not null,
    primary key(author_id,post_id),
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id));

-- 내 id로 내가 쓴 글 조회
select from post p inner join author_post ap on p.id = ap.post_id where ap.author_id = 1;

-- 내 id로 내가 쓴 글 조회
select p.* from post p inner join author_post ap on p.id=ap.post_id 
where ap.author_id = 1;

-- 글 2번 이상 쓴 사람에 대한 정보 조회
select a.* from author a inner join author_post ap on a.id = ap.author_id 
group by a.id having count(a.id)>=2 order by author_id;










