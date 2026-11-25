import os
from pathlib import Path
from dotenv import load_dotenv
import anthropic 
from anthropic import Anthropic

#1. openai 키 불러오기
load_dotenv()
# print(os.getenv('open_ai_key'))
# 위치 찾기
# BASE_DIR = Path(__file__).resolve().parent.parent
# print(BASE_DIR)

# ENV_FILE = 'BASE_DIR/.env'
# load_dotenv(ENV_FILE)
# 2. open ai 클라이언트 생성 클로드(anthropic)
api_key = os.getenv('anthropic_api_key')
client = Anthropic(api_key=api_key)

# 3. 검색어 입력
message1 = input('초등학교 수업자료 설명.>>')

# 4. openai 모델에 요청
try:
    messages = client.messages.create(
        model = 'claude-haiku-5-5',
        system = '당신은 초등학생 교사입니다.\
                [학습목표],[학습내용],[학습정리],[퀴즈] 순서로 간단하게 알려주세요.',
        messages = [{'role': 'user', 'content': message1}],
        max_tokens= 1000


)
except anthropic.APIConnectionError as error:
    print(error) # 인터넷연결,프록시,방화벽 문제 등 확인
except anthropic.RampLimitExceededError as error:
    print(error) # 짧은 시간의 요청량 또는 프로젝트 사용한도 확인
except anthropic.APIError as error:
    print(error) # 인증,권한,잘못된 요청 등 그 밖의 api 오류 확인



# 5. 출력
result = ''.join(
    block.text for block in messages.content if block.type == 'text'
).strip()
if not result:
    raise RuntimeError('응답결과 내용이 없습니다.')
if not result:
    raise RuntimeError('응답결과 내용이 없습니다.')
print('[응답]')
print(result)