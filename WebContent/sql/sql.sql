create database LectureEvaluation;

CREATE TABLE USER (
	userID VARCHAR(20) PRIMARY KEY,	#작성자 아이디 
	userPassword VARCHAR(64),		#작성자 비밀번호
	userEmail VARCHAR(50),			#작성자 이메일
	userEmailHash VARCHAR(64),		#이메일 확인 해시값
	userEmailChecked boolean		#이메일 확인 여부
);

강의 평가를 무차별하게 남발할 수 없도록 하는 시빌 공격(Sybil Attack)의 기본적인 방어법 
이메일을 인증해야만 강의 평가를 달 수 있도록
해시 데이터가 사용되는 것이 합당할 것입니다.


userEmailHash -> 이메일 인증값

//강의 ㅕ평가글 
CREATE TABLE EVALUATION (
  evaluationID int PRIMARY KEY AUTO_INCREMENT, #평가 번호
  userID varchar(50),		 	#작성자 아이디
  lectureName varchar(50), 		#강의명
  professorName varchar(50),	#교수명
  lectureYear int, 				#수강 연도
  semesterDivide varchar(20), 	#수강 학기
  lectureDivide varchar(10), 	#강의 구분
  evaluationTitle varchar(50),	#평가 제목
  evaluationContent varchar(2048), #평가 내용
  likeCount int #추천갯수
) default char set utf8;

alter table EVALUATION drop semesterDivide;

totalScore varchar(10), 		#종합 점수
  creditScore varchar(10), 		#성적 점수
  comfortableScore varchar(10), #널널 점수
  lectureScore varchar(10), 	#강의 점수


//추천 테이블
CREATE TABLE LIKEY (
  userID varchar(50), 	#작성자 아이디
  evaluationID int, 	#평가 번호
  userIP varchar(50) 	#작성자 아이피
);

한사람이 좋아요를 여러번 누를수 없게 제약 주기위해



================//에러났을때 했던거 
GRANT ALL privileges ON LectureEvaluation.table TO 'root'@'localhost' IDENTIFIED BY '1234';
INSERT INTO mysql.user (host,user,authentication_string,ssl_cipher, x509_issuer, x509_subject) VALUES ('%','root',password('1234'),'','','');


GRANT ALL privileges ON *.* TO 'root'@'%' IDENTIFIED BY '1234';
CREATE USER 'root'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';

update user set authentication_string=authentication_string('1111') where user='root';

UPDATE user SET authentication_string=null WHERE user='root';
FLUSH PRIVILEGES;

ALTER USER 'root'@'%' IDENTIFIED WITH caching_sha2_password BY '1111';



//LIKEY table 수정 
ALTER TABLE LIKEY ADD PRIMARY KEY (userID, evaluationID);
//LIKEY 테이블을 조금 바꿔주도록 하겠습니다. 바로 다음과 같이 ALTER 명령어를 이용해서 
(회원 아이디, 평가 번호)로 PRIMARY KEY를 줍시다. 
왜냐하면 한 명은 특정한 글에 단 한 번만 추천을 누를 수 있어야 하기 때문입니다.

CREATE TABLE community (
  c_num INT AUTO_INCREMENT primary key,
  c_title VARCHAR(50),
  c_userId varchar(20), 	
  c_date DATETIME,
  c_content varchar(2048),
  c_file varchar(50),
  c_avalable int
);

INSERT INTO community VALUES('1', 'ugee719', '무료로 드립니다', '2019.07.19', '관심있으신분은 01076460719 여기로 연락주셔요!', '2.jpg');

CREATE TABLE admin (
  a_id varchar(20) primary key,
  a_password INT(50)
);
INSERT INTO admin VALUES('admin', '1');






