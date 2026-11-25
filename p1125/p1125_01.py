import oracledb
import os
from dotenv import load_dotenv

ora_conn = os.getenv('ora_conn')
load_dotenv()
print(os.getenv('ora_id'))
# env 접속1
conn = oracledb.connect(ora_conn)
# env 접속2
conn = oracledb.connect('ora_user/1111@localhost:1521/XE')
# 오라클 db접속
# localhost : ip주소
# 접속3
# conn = oracledb.connect(user='ora_user',password = '1111',dsn='localhost:1521/XE')
# 접속4
# conn = oracledb.connect('ora_user/1111@localhost:1521/XE')

cursor = conn.cursor()
sql = 'select * from stuscore'
cursor.execute(sql)

rows = cursor.fetchall()

rows
# print(rows)

for row in rows:
    print('{},{},{},{},{},{},{},{},{},{},{}'.format(*row))
