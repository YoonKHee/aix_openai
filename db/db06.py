import os
import oracledb
from dotenv import load_dotenv

# 1. 불러오기--------------------------------------------------------------
load_dotenv()
ora_conn = os.getenv('ora_conn')
# print(ora_conn)

# 2. db연결-------------------------------------------------------------
conn = oracledb.connect(ora_conn)
cursor = conn.cursor()
# print(conn)
# print(cursor)

# 3. 쿼리작성실행------------------------------------------------------------
# Q. employees, erank, non-equi join를 사용해서 월급의 등급을 출력하시오 emp_name,salary,erank,low_salary,hihg_salary,hire_date
# -- 0-3999     E등급
# -- 4000-6999  D
# -- 7000-9999  C
# -- 10000-11999   B
# -- 12000 - 30000 A등급
# Q2 employees,departments - emp_name,department_id,department_name
# sql = '''select emp_name,salary,erank,low_salary,high_salary,hire_date
#         from employees, erank
#         where salary between low_salary and high_salary'''
# sql = '''select emp_name,a.department_id,department_name
#         from employees a,departments b
#         where a.department_id = b.department_id'''
sql ='''select name,kor+eng+math total from stuscore'''
cursor.execute(sql)

# sql = 'select * from stuscore'
# cursor.execute(sql)

# 컬럼명 추출
columns = [col[0] for col in cursor.description]
print(columns)
# print(cursor.description)
# rows = cursor.fetchall()
# print(rows)

# 4. 데이터 정보 전달 --------------------------------------------------
rows=cursor.fetchall()

# 4-2 딕셔너리 형태로 변환-----------------------------------------------
rows = [dict(zip(columns,row))for row in rows]
# context=('stulist':rows)
# return render('index.html',context=('sulist':rows))

# 5 데이터 출력
for row in rows:
    print(row)
    # print(row[0],row[1],row[2],row[3])


# 5-2. insert,update,delete 할 경우
# conn.commit()
# cursor.rollback()


# 6. db정보 닫기
cursor.close()
conn.close()



# 기획서만 보면 전체 내용을 다 알수 있도록 
# 기획서가 나와야 방향성이 나옴
# 꼼꼼하게 작성 무엇을 보여주려고 하는지 상대방을 이해시키기 위한 도구 제안하는 내용
