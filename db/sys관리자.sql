--user 등록
-- c## 붙이지 않아도 되게 설정
alter session set "_ORACLE_SCRIPT"=true;

-- user 생성 : 아이디 ora_user3, 비밀번호 1111
create user ora_user3 identified by 1111;

-- 권한 부여 : 접속 + 테이블 만들기 + 관리자 권한
grant connect, resource, dba to ora_user3;


-- 사용자 삭제
alter session set "_ORACLE_SCRIPT" = true;

drop user ora_user3 cascade;