import os
from dotenv import load_dotenv
from pathlib import Path 
# import openai
import anthropic 
from anthropic import Anthropic


# ------------------------------------------------------------
# 1. key 불러오기
BASE_DIR = Path(__file__).resolve().parent.parent
envFile =BASE_DIR/ '.env'
load_dotenv(envFile)
api_key = os.getenv('api_key')
# print(api_key)

# ------------------------------------------------------------
# 2. 검색어 입력하기
# 클로드 연결해서 진행
while True:
    txt_input = input('가고싶은 여행지를 입력하세요.>>')
    if txt_input:break
    print('여행지를 입력해야합니다.')
    print()

# ------------------------------------------------------------    
# 3. 클라이언트 연결
#client
client = Anthropic(api_key=api_key)

try:
    messages = client.messages.create(
        model =  "claude-haiku-5-5",
        system = (
            '당신은 여행설계 전문가입니다.\n'
            '여행 일정을 1박2일 코스를 설계해주세요\n'
            '[버스여행]으로 알려주세요.\n'
            '여행자가 이해하기 쉽게 간략하게 답합니다\n'
        ),
        messages = [{'role': 'user', 'content': f'{txt_input}을 가지고 [1박2일코스]-버스여행, 여행지, 숙소, 식사 등을 제안해주세요'}],
        max_tokens = 1000,
    )
except anthropic.APIConnectionError as error:
    print(f'인터넷연결,방화벽문제등 확인:{error}')
    exit()
except anthropic.RateLimitError as error:
    print(f'요청량 또는 프로젝은 사용한도 확인:{error}')
    exit()
except anthropic.APIError as error:
    print(f'인증,권한 등 api 오류 확인:{error}')
    exit()


# ------------------------------------------------------------
# 4. 결과확인
result = messages.content[0].text.strip()
if not result:
    raise RuntimeError('응답결과 내용이 없습니다.')

print()
print(result)
print('완료')






[ 디장고 tour_pjt ]
< 프로젝트 생성>o
<앱생성>o


homeo
tour<파일생성>o



index.html - 링크:tour.html
tour.html


<html구성>
tour.html


입력창
검색버튼


<출력부분>
경주 소개 - 직접전달내용
경주 여행 1박2일 코스 - gpt 검색내용전달[오후 12:19][ 디장고 tour_pjt ]
< 프로젝트 생성>
<앱생성>


home
tour<파일생성>



index.html - 링크:tour.html
tour.html


<html구성>
tour.html


입력창
검색버튼


<출력부분>
경주, 내장산,설악산

경주 소개 - 직접전달내용
경주 여행 1박2일 코스 - gpt 검색내용전달

[여행일정]
[여행지]
[숙소]
[식사추천] 이 챗지피티에서 가져와져야함