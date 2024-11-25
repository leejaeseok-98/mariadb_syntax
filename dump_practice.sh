# 덤프파일 생성 : dumpfile.sql이라는 이름의 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql이라는
#한글 깨질때
mysqldump -u root -p board -r dumpfile.sql
# 덤프파일 적용(복원)
# <가 특수문자로 인식되어, window에서는 적용이 안될 경우, git bash 터미널창을 활용
mysql -u root -p board < dumpfile.sql

#dump파일을 github에 업로드

#리눅스에서 마리아db 설치
sudo apt-get install mariadb-server

마이라서버 실행
sudo systemctl start mariadb

#마리아디비 접속 : 1234
mariadb -u root -p
create database board;

git 설치
sudo apt-get install git

#깃dptj repository clone
git clone https://github.com/leejaeseok-98/mariadb_syntax

#덤프파일 복원