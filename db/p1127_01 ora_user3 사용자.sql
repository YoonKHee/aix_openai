select * from board;

-- 1번부터 10번까지 가져오기
select * from board 
where bno <=10;

select * from board
where bno between 1 and 10;
-- 3,3,5,6,7,11,20,22,23,25,26,35,36,38,49,52
delete board where bno=6;
commit;
-- 10개
--1~10개
select * from board;



-- rownum
select rownum,a.* from board a;

select * from board
where rownum<=10;

select * from departments;

select rownum rnum,b.* from (select rownum,a.* from board a order by id desc)b;

select rownum,a.* from board a
order by id desc;
-- 테이블로 넣어서 수정이 되게함
select * from (select rownum rnum,a.* from departments a)
where rnum >=10 and rnum <=20;

-- 11~20 까지 출력
select rownum rnum,a.* from board a;

select * from (select rownum rnum,a.* from board a)
where rnum > 10 and rnum <= 20;

select * from (select rownum rnum,b.* from(select * from board a order by id desc) b)
where rnum>=11 and rnum<=20;

-- 합계점수가 가장 높은 학생 11-20위를 앞에 번호를 부여해서 출력하시오
select * from stuscore;
select rownum rnum,a.* from stuscore a;

select * from (select rownum rnum,b.* from(select * from stuscore a order by id desc) b)
where rnum >=11 and rnum <=20;

select kor+eng+math total from(select rownum rnum,a.* from stuscore a)
where rnum >=11 and rnum <= 20;


select kor+eng+math total from stuscore a
order by total desc;

select * from (select rownum rnum, b.* from (select kor+eng+math total from stuscore a
order by total desc) b)
where rnum >=11 and rnum <= 20;

--row_number() over() : 정렬을 먼저 부여한 후 번호부여
-- rownum,a.* : 번호를 먼저 부여한 후 정렬
select * from(select row_number() over(order by (kor+eng+math) desc) rnum,a.* from stuscore a)
where rnum>=11 and rnum<=20;


-- rank 순위
-- rank() 동일점수가 있을때 중복 순위 갯수만큼 다음 순위가 밀림 ex) 31,31, 33
-- densc_rank()동일 점수가 있을때 중복순위 상관없이 진행됨 ex) 31,31, 32
select dense_rank() over(order by (kor+eng+math) desc),kor+eng+math from stuscore ; 

select * from stuscore;
alter table stuscore add total number(3);

update stuscore set total = kor+eng+math;
commit;

update stuscore set rank = null;


alter table stuscore modify rank number(3);
desc stuscore;

select * from stuscore;

-- rank over() 을 사용해서 rank 컬럼에 등수 입력
-- 합계점수를 update를 사용해서 입력
select name,total,avg,rank() over(order by total desc) from stuscore;

select rank() over(order by total desc)ranks from stuscore; 

update stuscore set rank = (select rank() over(order by total desc)ranks from stuscore);

select name,total,rank() over(order by total desc) rank, rank from stuscore;

update stuscore a set rank = (select ranks from(
select name,rank() over(order by total desc) ranks from stuscore)b
where a.name = b.name);


select ranks from(
select name,rank() over(order by total desc) ranks from stuscore)b;

select name,rank from stuscore a;
select name,rank() over(order by total desc) from stuscore b;

update stuscore a set rank=1;
update stuscore a set rank = 
(select ranks from 
(select name,rank() over(order by total desc) ranks from stuscore) b 
where a.name = b.name);



select * from stuscore order by rank;


create table employees2 as select * from employees;

select * from employees2;

-- rank컬럼 생성후
-- 월급이 높은 순으로 rank를 입력
alter table employees2 add rank number(3);
update employees2 a set rank = 
(select ranks from 
(select employee_id,rank() over(order by salary desc)ranks from employees2) b
where a.employee_id = b.employee_id);
commit;

desc employees2;
select salary,rank from employees2 order by rank asc ;

select emp_name,salary,rank() over(order by salary desc) from employees2 b;


select * from students;
select * from stuscore;


-- member table rank 생성하고
-- board에 bhit가 높은 순으로 순위를 부여해서 member table rank에 입력하시오

alter table member add rank number(3);

update member a set rank = (select ranks from (select c.id,bhit,rank() over(order by bhit desc) ranks
from member c, board d 
where c.id = d.id)b
where a.id = b.id);

select a.id,bhit,rank() over(order by bhit desc)rank 
from member a, board b
where a.id = b.id;


select * from board;
select * from member order by rank asc;

alter table board add rank number(3) default 0;

select * from board order by rank;

update board a set rank = (select ranks from (
select bhit,id, rank() over(order by bhit desc)ranks from board) b
where a.id=b.id);


select bhit, rank() over(order by bhit desc)ranks from board;



select id,count(bhit) from board
group by id;



select school,count(school) sc from stuscore
group by school
order by sc desc;

-- kor 50이상 출력
select * from stuscore
where kor >= 50;

--eng 80점 이상 출력
select * from stuscore
where eng >= 80;
--kor 50이상이면서 eng가 80점 이상인 사람 출력
select * from (
select * from stuscore where kor>=50
) where eng>=80;


select rownum,a.* from ( select school,count(school) sc from stuscore
group by school
order by sc desc) a;
-- 그룹별 등수
select * from stuscore;
select school,total,rank() over(partition by school order by total desc) ranks from stuscore;



select * from member;
select * from board;

select bno,nickname,btitle,bcontent,bgroup,bstep,bindent,bhit,bdate,a.rank
from board a, member b
where a.id = b.id;

desc board;
desc member;


-- 사원명 월급 부서번호 부서 이름을 출력하시오
select * from employees;
select * from departments;

select emp_name,salary,a.department_id, department_name
from employees a, departments b
where a.department_id = b.department_id;

select * from board;


