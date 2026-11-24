# 경제전문가입니다.
# 2027년 주식시세가 어떻게 될지 알려주는 프로그램을 구현하시오.
# 반도체주, 전력시설주, 우주항공주
# 500자 이내로 짧게 알려줘

import os
from dotenv import load_dotenv
from pathlib import Path
import anthropic
from anthropic import Anthropic

#---------------------------------------------------------------
# 1. key불러오기
BASE_DIR = Path(__file__).resolve().parent.parent
envFile = BASE_DIR / '.env'
load_dotenv(envFile)
api_key = os.getenv('api_key')
print(api_key)

if not api_key:
    raise RuntimeError(f'{envFile}에서 api_key를 찾을 수 없습니다.')

#---------------------------------------------------------------
# 2. 검색어 입력
while True:
    txt_input = input('알고싶은 주식을 입력하세요.>>')
    if txt_input:break
    print('주식 입력')
    print()

#---------------------------------------------------------------
# 3. 클라이언트 연결 api연결
client = Anthropic(api_key=api_key)

try:
    messages = client.messages.create(
        model = 'claude-haiku-5-5',
        system= ('실시간 주가는 알 수 없으니 구체적인 현재가와 예상가 숫자는 말하지 마세요.\n'
                '대신 업종 전망과 오르거나 내릴 수 있는 이유를 쉽게 설명하세요.\n'
                '마지막에 "투자 조언이 아닙니다"라고 덧붙이세요.'),
        messages = [{'role': 'user', 'content': f'{txt_input}을 가지고 예측 주식가를 알려주세요'}],
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