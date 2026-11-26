select * from employees;;

-- oracle if 절 조건에 따라 실행할수있는 형태
-- decode : 정확히 일치할때 실행
-- case : 크거나 작거나 정확히 일치할때 실행

select emp_name,department_id,
decode(department_id,10,'10번',
20,'20번', 30,'30번') as did from employees;


select * from stuscore;


-- 10번대 월급 1.2배
-- 20번대 유지 1배
-- 30번대 월급 2배
-- 40번대 월급 2.5배
-- 50번대 월급 1.8배
select department_id,salary, 
decode(department_id,10,salary*1.2,
20,salary*1,
30,salary*2,
40,salary*2.5,
50,salary*1.8) as new_salary
from employees
where department_id <= 50;

-- case
select department_id,salary, 
case 
when department_id <=50 then '근무장소이동:A동'
when department_id >=50 then '근무장소이동:B동'
end as move_department
from employees;


select department_id,salary, 
case 
when department_id <=50 then salary*1.5
when department_id >=50 then salary*1.9
end as move_department
from employees;


select * from stuscore;
-- case를 사용해서 평균이 (kor+eng+math)/3 = 90이상a,80점이상b 70점이상c 60점이상d 나머지f
--score_rank

select round((kor+eng+math)/3,2),rank,
case
when (kor+eng+math)/3 >= 90 then 'A'
when (kor+eng+math)/3 >= 80 then 'B'
when (kor+eng+math)/3 >= 70 then 'C'
when (kor+eng+math)/3 >= 60 then 'D'
when (kor+eng+math)/3 < 60 then 'F'
end as score_rank
from stuscore;


alter table stuscore modify total number(5);
alter table stuscore add rank varchar(2);
update stuscore set total = kor+eng+math
update stuscore set avg = total/3;
commit;
desc stuscore2;
update stuscore set rank = (
case
when (kor+eng+math)/3>=90 then 'A'
when (kor+eng+math)/3 >= 80 then 'B'
when (kor+eng+math)/3 >= 70 then 'C'
when (kor+eng+math)/3 >= 60 then 'D'
else 'F'
end
);

select * from stuscore2;
drop table stuscore2;
create table stuscore2 as select * from stuscore where 1=2;
insert into stuscore2 values(
1,'홍길동','신림고','',178,100,100,99,100++100+99,(100+100+99)/3,'C',''
);

-- employees 연봉 5000이하는 20% 인상 1.2배, 8000이하 10% 인상, 그외 8000초과 5% 인상
select salary*12*1412 as 연봉,
case
when salary*12*1412 <=50000000 then to_char(salary*12*4*1412, '999,999,999')||'원'
when salary*12*1412 <=80000000 then to_char(salary*12*2*1412, '999,999,999')||'원'
when salary*12*1412 >80000000 then to_char(salary*12*1*1412, '999,999,999')||'원'
end 인상연봉
from employees;

desc employees;



select * from stuscore;

-- no 1-17 : 1반
-- 18~50 : 2반
-- 51~77 : 3반
-- 나머지 : 4반
-- grade
case when no>=1 and no<=17

select no,
case
when no>=1 and no<=17 then '1반'
when no>=18 and no<=50 then '2반'
when no>=51 and no<=77 then '3반'
else '4반'
end grade
from stuscore;

-- count, sum, avg,min,max,studev:표준편차,variance:분산
select count(*) from employees;

-- employees 월급의 총합과 평균
-- 평균보다 낮은 사월 출력

-- commission_pct를 수수료 받는 사원수를 출력

select salary from employees 
where salary <= (select avg(salary) from employees);


select count(*),count(commission_pct) from employees;
select count(*),count(manager_id) from employees;

select count(*) from employees
where commission_pct is not null;

-- department_id 가 없는 커미션 받는 사원수
select count(commission_pct) from employees
where department_id is null;

--그룹함수
--부서별 월급합계를 출력하시오
select department_id,sum(salary) from employees
group by department_id
order by department_id;


select emp_name,sum(salary) from employees
group by emp_name;

-- 그룹함수컬럼과 일반컬럼은 동시에 사용이 안됨.
-- 근데 group by 에 일반 컬럼을 넣으면 일반컬럼도 출력 가능
-- 그룹을 나누어도 그룹이 인당 한개면 원본과 다를게 없다.
select emp_name,job_id,count(commission_pct) from employees
where department_id is null
group by emp_name,job_id;

-- 지역별 region 금액 합계를 출력하시오.
select region,sum(loan_jan_amt) from kor_loan_status
group by region;

-- 연도별 금액합계 출력
select substr(period,1,4) year,sum(loan_jan_amt) from kor_loan_status
group by substr(period,1,4);

-- 월별금액합계
select period,sum(loan_jan_amt) month from kor_loan_status
group by period
order by period;


-- 그룹함수컬럼의 제약조건은 having
-- 일반 컬럼의 제약조건은 where
select department_id,sum(salary) from employees
where department_id >=50
group by department_id
having sum(salary)>=50000;

-- 부서별 평균 급여를 출력하시오
-- 부서별 평균이 5000이하 출력
select department_id,round(avg(salary),1) from employees
group by department_id
having avg(salary) <= 5000;


-- kor_loan_status 테이블에서
-- 2012년 이상의 년도별 총합 금액을 출력
-- 총합 현재 단위가 십만원, 원단위 출력하고 천단위 표시하시오
select substr(period,1,4),
to_char(sum(loan_jan_amt)*100000,'L999,999,999,999') 
from kor_loan_status
group by substr(period,1,4)
having substr(period,1,4)>=2012;

select substr(period,1,4),sum(loan_jan_amt) from kor_loan_status
group by substr(period,1,4);


select * from kor_loan_status;

-- 지역별 그룹핑을 한 후 주택담보대출이 최대인 지역을 출력하시오
-- 검색된 것들중 첫번째꺼 출력
select region,gubun,sum(loan_jan_amt) as  from kor_loan_status
where gubun = '주택담보대출'
group by region,gubun 
order by sum(loan_jan_amt) desc fetch first 1 rows only;

-- 이중쿼리
select region,sum(loan_jan_amt) as amt from kor_loan_status
where gubun='주택담보대출'
group by region
having sum(loan_jan_amt) = (
select max(sum(loan_jan_amt)) as amt from kor_loan_status
where gubun='주택담보대출'
group by region
);


-- 이중쿼리 평균이 50이상이면서 학교가 신림고인 학생 출력
select * from(
select * from stuscore
where avg>50)
where school = '신림고'
order by total desc;

select * from stuscore
where total>50 and school = '신림고';


select * from stuscore;

create table student(
no number(4) primary key,
name varchar2(50),
school varchar2(20),
grade number(2),
height number(5,2),
kor number(3),
eng number(3),
math number(3),
sw varchar(20)
);


select * from students;

-- 학년별 합계 최고 성적을 출력하시오.
select 학교,학년,max(국어+영어+수학) from students
group by 학교,학년;

-- 학교별 반결 최고성적 출력
--stuscore
--a 가 들어가 있는 학생 모두 출력
--국어,영어,수학 역순정렬로 정렬
select kor,eng,math from stuscore
order by kor desc; and eng desc and math desc;

select * from stuscore2;
insert into stuscore2 values(
2,'홍길자','신림고','',162,50,50,50,50,50,'C','');
commit;


desc stuscore;

select * from stuscore2;

update stuscore2 set height =180,specialty ='C'
where no!=1;

select * from kor_loan_status;
select region,gubun,sum(loan_jan_amt) from kor_loan_status
group by region,gubun
having gubun = '주택담보대출';


SELECT * FROM stuscore;

select round((kor+eng+math)/3,2),
case
when (kor+eng+math)/3 >= 90 then 'A'
when (kor+eng+math)/3 >= 80 then 'B'
when (kor+eng+math)/3 >= 70 then 'C'
when (kor+eng+math)/3 >= 60 then 'D'
else 'F'
end ssrank
from stuscore;