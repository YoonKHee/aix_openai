import oracledb
import os
from dotenv import load_dotenv


# oracle 접속정보 - sql정보를 더블클릭해서 들어가는것
load_dotenv()
ora_conn = os.getenv('ora_conn')
conn = oracledb.connect(ora_conn)
# print(conn.version)


# 커서연결 - sql명령어 창 연결
cursor = conn.cursor()
# kor+eng+math/3 평균이 80이상인 사람 출력
# 국어,영어,수학 역순정렬로 정렬

# while True:
    # data = input('과목 검색>>(ex:kor)')
    # # data2 = input('점수 검색>>(ex:50k)')
    # if data.strip() == '국어': i = 'kor'
    # elif data.strip() == '영어': i = 'eng'
    # else: i = 'math'
    # if data =='':break
# no = 3
# name = '강감찬'
# school = '신림고'
# rank = ''
# height = 183
# kor =60
# eng =60
# math =60
# total =180
# avg =60
# specialty= 'python'
# srank =''

# 실행문 -- insert
sql = "insert into stuscore2(no,name) values(:no,:name)"
cursor.execute(sql,no=4,name='홍긴자')
conn.commit()               # 저장
print(cursor.rowcount, '건 입력')



# 실행문 -- insert
# sql = "update stuscore2 set height =:height,specialty =:specialty where no!=:no"
sql = "delete stuscore2 where no=:no"
cursor.execute(sql,no=4)
conn.commit()               # 저장
print(cursor.rowcount, '건 입력') 

# 데이터 연결
# rows타입은 [( )]
# rows = cursor.fetchall()
# print(rows)
# print(len(rows))
# cursor.close()

# -----------------------------------------------------
print('프로그램종료')
conn.close()