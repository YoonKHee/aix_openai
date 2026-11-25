# 검색
# kor_loan_status 테이블에서
# 지역별로 그룹핑 후 주택담보대출을 출력하시오

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



# # 실행문 -- insert
# sql = "insert into stuscore2(no,name) values(:no,:name)"
# cursor.execute(sql,no=4,name='홍긴자')
# conn.commit()               # 저장
# print(cursor.rowcount, '건 입력')



# 실행문 -- insert
# sql = "update stuscore2 set height =:height,specialty =:specialty where no!=:no"
# sql = "delete stuscore2 where no=:no"
# sql = "select region,gubun,sum(loan_jan_amt) from kor_loan_status group by region,gubun having gubun = '주택담보대출'"
sql = '''select round((kor+eng+math)/3,2), case 
    when (kor+eng+math)/3 >= 90 then 'A' 
    when (kor+eng+math)/3 >= 80 then 'B' 
    when (kor+eng+math)/3 >= 70 then 'C' 
    when (kor+eng+math)/3 >= 60 then 'D' 
    else 'F' end ssrank from stuscore'''
cursor.execute(sql)
# conn.commit()               # 저장
# print(cursor.rowcount, '건 입력') 

# 데이터 연결
# rows타입은 [( )]
rows = cursor.fetchall()
print(f'지역\t담보대출')
for row in rows:
    print('{}\t{}\t'.format(*row))
print(len(rows))
cursor.close()

# -----------------------------------------------------
print('프로그램종료')
conn.close()