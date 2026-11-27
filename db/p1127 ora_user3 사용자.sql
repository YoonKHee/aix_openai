--1. ora_user3로 오라클 db연결 o
--2. board모델 오라클에서 board.xlsx 파일을 import o
--3. member모델 오라클에서 member.xlsx 파일을 import
--4. model 게시판페이지 생성 리스트를 출력하시오.
--5. oracledb에 직접 접속후 게시글 생성 리스트를 출력하시오.

alter table board_board set bcontent = varchar2(4000);

create table board(
BNO number(3) primary key,
NICKNAME varchar2(100),
BTITLE varchar2(1000),
BCONTENT varchar2(4000),
BGROUP number(3) default 0,
BSTEP number(3) default 0,
BHIT number(3) default 0,
BDATE date default sysdate,
RANK number(3) default 0,
BINDENT number(3) default 0, 
ID varchar2(50),
BFILE varchar2(100) default '1.jpg'
);

--drop table board;

select table_name from user_tables;

insert into board_board
    (bno, nickname, btitle, bcontent, bgroup, bstep, bhit, bdate, rank, bindent, id, bfile)
select
     bno, nickname, btitle, to_nclob(bcontent), bgroup, bstep, bhit, bdate, rank, bindent, id, bfile
from board;

commit;

select count(*) from board;
select count(*) from board_board;

drop table board;

select bno,nickname,btitle,bcontent,bgroup,bstep,bindent,bhit,bdate,rank
            from board_board a, board_member b
            where a.id = b.id;












11/27 팀 프로젝트

아이관련 웹 서비스 확정.

1. 생체 데이터 사용자가 입력을 하면 데이터로 아이의 생체 시간을 예측.
2. 사진으로 외가 친가 닮은꼴 분석 미래 모습 예측.
3. 커뮤니티 추후 api 상담 
4. ai 생활패턴 예측
5. 이유식 정보 제공
6. 육아일정 체크리스트 관리 - 예방접종 등 개월수마다 필수로 할수있는 체크리스트 형성 알람기능.
7. 조부모 전용보기 화면
8. 산후우울 자가 체크리스트
- 추가로 의사와 상담추천.
9. 공구 알림정도. 
10. 산후조리원 추천.
11. 알레르기 추적
13. 이유식 사진에서 처음 먹은 재료를 자동 기록하고, 3일 안에 반응을 체크하게 알림
14. 선택? 추가입력란? 알러지 체크 회원가입시 알러지입력란
15. 야간·휴일 소아 진료 지도 밤에 아이가 아플 때 가장 먼저 찾는 정보. 상담 답변 끝에 연결
16. ,조부모 따로 관리할수있는 관리자모드?
17. 사진 + 성장 그래프 월간 리포트 그달의 사진과 키·몸무게 백분위를 한 장으로. 쑥쑥찰칵의 성장 영상을 데이터 버전으로 바꾼 것
18. 태교음악 생성하면 좋음, 자장가 - 리스트 추천, 태교음악 랭킹순위
19. 육아 산모 건강체크 같이
20. 엄빠 공동육아 할 체크리스트 공유 디폴트 값으로 할일 5개 정도 정해두기 카테고리 육아,집안일로 나누어 구분.
21. 간단한 산모케어용 응원문구
22. 육아관련 질문 api연결
산모



