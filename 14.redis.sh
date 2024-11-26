#redis설치
sudo apt-get install redis-server

#redis접속
redis-cli

#redis는 0~15번까지의 데이터베이스로 구성(default는 0번 구성)
#데이터베이스 선택
select db번호

#데이터베이스내 모든 키 조회
keys *

#일반적인 String 자료구조
set key명 value값
#set을 통해 key:value 세팅. 맵에서 set은 이미 존재할 때 덮어쓰기.
set email_1 hong1@naver.com
# nx :이미존재하면 pass, 없으면 set
set user:email:1 hong1@naver.com nx
#ex : 만료시간(초단위) - ttl(time to live)
set user:email:1 hong1@naver.com ex 10
#get을 통해 value값 얻기
get user:email_1:1

#특정 key삭제
del user:email_1:1
#현재 DB내 모든 key삭제
flushdb

#redis활용 예시 : 동시성 이슈
#1.좋아요 기능 구현
set posting:1 0
#좋아요 눌렀을 경우
incr likes:posting:1 #특정 key값의 value를 1만큼 중가
decr likes:posting:1 #특정 key값의 value를 1만큼 감소
get likes:posting:1 
#2.재고관리
set stocks:product:1 100
decr stocks:product:1
get stocks:product:1

#bash쉘을 활용하여 재고감소 프로그램 작성











