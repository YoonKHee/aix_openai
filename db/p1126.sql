-- 조인
select emp_name,department_id from employees;

select * from departments;

--
select * from board2;

select * from stuscore;
-- 학년,학반,전화번호,주소,보호자,담당교사,학교이름,성명,키,몸무게,특기
-- 학기,국어,영어,수학,합계,평균,등수

-- 조인의 필요성
-- 1. 중복된 데이터를 방지
-- 2. null값을 피하기 위해

-- 107*27
-- cross join : 테이블 연결
select * from employees,departments;

-- equi join : 공통적으로 존재하는 컬럼을 일치시켜서 연결
select department_id from employees;
select department_id from departments;

select * from employees,departments
where employees.department_id = departments.department_id;
-- equi join : 동일한 컬럼
select emp_name,employees.department_id,departments.department_name
, salary
from employees,departments
where employees.department_id = departments.department_id;

select * from departments;
select emp_name,department_id,salary from employees;
select count(*) from employees;
select count(*) from departments;


select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id = b.department_id
;

select job_id from employees;

select * from jobs;

-- equi join / employees, jobs
-- emp_name,salary,job_id,job_title,min_salary,max_salary,department_id
-- hire_date




create table board (
bno number(4) primary key,
id varchar2(100),
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)

);


create table member (
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100),
nickname varchar2(100),
tel char(13),
gender varchar2(10),
hobby varchar2(100),
mdate date default sysdate
);





create table students(
no number(4),
name varchar2(100) primary key,
major varchar2(100),
grade number(2),
age number(3),
gender varchar2(100),
hobby varchar2(200),
sdate date default sysdate
);

select * from students;


create table stuscore(
no number(4),
name varchar2(100),
school varchar2(100),
grade varchar2(2),
height number(4),
kor number(3),
eng number(3),
math number(3),
sw varchar2(100)
);



-- 외래키 등록
-- member primary key, board foreign keyALTER
alter table board add constraint board_member_fk_id foreign key(id)
references member(id) on delete set null;

select * from member;
select * from board;
desc board;


alter table stuscore add constraint stuscore_student_fk_name foreign key(name)
references students(name) on delete cascade;

-- equi join name
select * from students;
select * from stuscore;

-- 성적을 출력할건데, 성별 나이를 같이 출력하고 싶다

select a.no,a.name,gender,age,kor,eng,math 
from stuscore a, students b
where a.name = b.name;


--
select * from board;
select bno,nickname,btitle,bcontent,bdate
from board a, member b
where a.id = b.id;


select * from students;

update students set grade=3 where name= 'Romonda';
commit;

alter table stuscore drop column grade;
select * from stuscore;

select a.name,grade,kor,eng,math
from students a,stuscore b
where a.name = b.name and lower(a.name) like '%a%';


-- employees
-- 사원명, 부서번호, 부서명, 입사일
-- 부서번호 50dltkd
select * from employees;
select * from departments;

select emp_name,a.department_id,department_name,hire_date
from employees a,departments b
where a.department_id = b.department_id and a.department_id >=50
order by a.department_id asc;


select * from employees;
select * from jobs;
-- job_id = man, id,job_title,salary,min,max,hire_date
-- 입사일이 2~3, 5월인 사람
select a.job_id,job_title,salary,min_salary,max_salary,hire_date
from jobs a, employees b
where a.job_id = b.job_id and a.job_id like '%MAN%' and substr(hire_date,4,2) in (02,03,04) ;

select substr(hire_date,4,2) from employees
where substr(hire_date,4,2) in (02,03,05);


-- equi join : 테이블간 같은 컬럼을 가지고 검색
-- non-equi join : 테이블 간, 같은 컬럼이 없이 검색

select * from jobs;
select a.department_id, department_name,a.job_id,job_title
from employees a, departments b, jobs c
where a.department_id = b.department_id and a.job_id = c.job_id;

create table sturank(
srank varchar2(10),
low_score number(3),
high_score number(3)
);

select * from sturank;

-- VVIP,VIP,GOLD,SILVER,BRONZE
insert into sturank values('VVIP',91,100);
insert into sturank values('VIP',81,90);
insert into sturank values('GOLD',71,80);
insert into sturank values('SILVER',61,70);
insert into sturank values('BRONZE',0,60);
commit;

select * from sturank;
select kor from stuscore;


-- non-equi join: 같은컬럼이 없지만 2개의 테이블을 가지고 검색하는것
select name,school,round((kor+eng+math)/3,2),srank
from stuscore a, sturank b
where round((kor+eng+math)/3,2) between low_score and high_score
order by no;

-- 0~3999 E
-- 4000~6999 D
-- 7000~9999 C
-- 10000~11999 B
-- 12000~30000 A
--1.non-equi join
--2.case when then



create table erank(
erank varchar2(10),
low_salary number(10),
high_salary number(10)
);

drop table erank;
insert into erank values('A',12000,30000);
insert into erank values('B',10000,11999);
insert into erank values('C',7000,9999);
insert into erank values('D',4000,6999);
insert into erank values('E',0,3999);
commit;
select * from erank;

select salary,erank
from employees, erank
where salary between low_salary and high_salary
order by salary desc;



select salary,
case
when salary<4000 Then 'E'
when salary<7000 Then 'D'
when salary<10000 Then 'C'
when salary<12000 Then 'B'
when salary<30000 Then 'A'
end rank
from employees
order by salary desc;

select * from stuscore;
select * from students;


select * from stuscore;

alter table stuscore add rank varchar2(20);

-- non-equi join: 같은컬럼이 없지만 2개의 테이블을 가지고 검색하는것
select name,school,round((kor+eng+math)/3,2),srank
from stuscore a, sturank b
where round((kor+eng+math)/3,2) between low_score and high_score
order by no;

update stuscore a set rank = (
select srank
from sturank
where a.avg between low_score and high_score

);
select * from stuscore;

alter table stuscore add avg number(5,2);

update stuscore set avg = round((kor+eng+math)/3,2);

create table filegroup(
bno number(4),
bfile varchar2(100),
constraint board_filegroup_fk_bno foreign key (bno)
references board(bno) on delete cascade

);

select * from filegroup;

select * from board;
-- 컬럼 삭제
alter table board drop column bfile;

insert into filegroup values(1,'1211.jpg');
insert into filegroup values(2,'2222.jpg');
insert into filegroup values(3,'333.jpg');
insert into filegroup values(4,'44.jpg');
insert into filegroup values(7,'112.jpg');
commit;
select * from filegroup;

select a.bno,btitle,bfile from board a,filegroup b
where a.bno=b.bno;

select * from board where bno = 1;

select * from filegroup where bno=1;

create table event(
eno number(4) primary key,
etitle varchar2(1000),
econtent clob,
efile varchar2(100)
);


insert into event values(
event_seq.nextval,'제목','내영','1.jpg'
);
commit;


select * from erank;
select * from employees;

select emp_name,salary,erank,low_salary,high_salary,hire_date 
from employees, erank
where salary between low_salary and high_salary;




-- 파일 여러개 저장

-- equi-join : 같은컬럼을 가지고 2개의 테이블에서 검색
-- non-equi-join : 같은컬럼은 없지만 2개의 테이블에서 검색
-- self-join 자신의 테이블을 2번 호출해서 검색
-- null 값을 출력에서 제외
select a.employee_id,a.emp_name,a.job_id,a.manager_id,b.emp_name 
from employees a,employees b
where a.manager_id = b.employee_id;

-- 그룹함수는 null값이 제외


-- inner join
-- out join

-- null값도 출력하고 싶다면 반대값에 (+)를 한다.
select a.employee_id,a.emp_name,a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id = b.employee_id(+);

select emp_name,manager_id from employees
where manager_id is null;

-- departments, employees 테이블에서
-- employees 테이블에서 없는 부서번호와 부서명 출력
-- equi join을 하고 
-- join 했을때 서로 같이 있는 값만 나오는데 없는값을 보고싶으면 가지고 있는 반대값에 (+)를 한다.
select emp_name,a.department_id,department_name 
from employees a, departments b
where a.department_id(+) = b.department_id;



select emp_name,a.department_id
from employees a, departments b
where a.department_id = b.department_id;

-- ansi join
select emp_name,department_id
from employees inner join departments
using (department_id);

--ansi outer join (left)
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id = b.department_id(+);

select emp_name,a.department_id,department_name
from employees a left outer join departments b
on a.department_id = b.department_id;


-- ansi outer join(right)
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id(+) = b.department_id;

select emp_name,a.department_id,department_name
from employees a right outer join departments b
on a.department_id = b.department_id;


-- ansi outer join(full) 양쪽 값을모두 출력
select emp_name,a.department_id,department_name
from employees a full outer join departments b
on a.department_id = b.department_id;



select * from employees;
create or replace view view_employees
as
select employee_id,emp_name,phone_number from employees;

drop view view_emplyees;
select * from view_employees;

select * from stuscore;
select * from students;

select a.name,school,a.grade,kor,eng,math,avg
from students a, stuscore b
where a.name=b.name;

create or replace view v_stu(
name,school,grade,kor,eng,math,total,avg)
as
select a.name,school,grade,kor,eng,math,kor+eng+math total,avg
from students a, stuscore b
where a.name=b.name;

select * from v_stu;