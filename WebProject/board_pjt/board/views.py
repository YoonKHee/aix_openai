from django.shortcuts import render
import oracledb
from dotenv import load_dotenv
from pathlib import Path
import os
from .models import Board
from .models import Member
# 전역변수
BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
env_file = BASE_DIR/'.env'
load_dotenv(env_file)
# print('확인',BASE_DIR)
ora_conn = os.getenv('ora_conn')
# print('확인',ora_conn)


# Create your views here.
def blist(request):
    # db 접속
    conn = oracledb.connect(ora_conn)
    cursor = conn.cursor()
    sql = '''select bno,nickname,btitle,bcontent,bgroup,bstep,bindent,bhit,bdate,a.rank
            from board_board a, board_member b
            where a.id = b.id'''
    cursor.execute(sql)
    # 컬럼정보
    columns = [col[0] for col in cursor.description]
    rows = cursor.fetchall()
    print('확인',rows)
    print('확인',columns)
    rows_list = [dict(zip(columns,row)) for row in rows]



    cursor.close()
    conn.close()

    context = {'blist':rows_list}
    return render (request,'blist.html',context)




# sqlite
def blist2(request):
    if request.method == 'GET':
        qs = Board.objects.all().order_by('-bgroup','bstep')
    context = {'list':qs}
    return render (request,'blist2.html',context)