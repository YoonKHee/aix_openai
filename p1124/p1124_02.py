import os
from dotenv import load_dotenv
# import openai
import anthropic 
from anthropic import Anthropic
# 파일 불러오기
load_dotenv()
api_key = os.getenv('api_key')
# print('확인:',os.getenv('open_ai_key'))


# 외부연결이기에 try-except
client = anthropic.Anthropic(api_key=api_key)    # OpenAI(api_key=api_key) 대신
messagel = input('챗gpt 검색을 시작합니다. 검색할 내용을 입력하세요.>>')
model="claude-haiku-5-5" # 사용할 모델
INPUT_LIMIT = 100000   # 이 값을 넘으면 단가가 5배
MAX_OUTPUT = 500   # 출력 상한
try:
    # 클로드 연결
    response = client.messages.create(
        model=model, # 사용할 모델
        system='한국어로 친절하고 간결하게 답해줘요', # 지시사항 규칙
        max_tokens=MAX_OUTPUT,
        # input = massage1
        messages = [{'role': 'user', 'content': 'api 연결확인 환영문자를 짧게 작성해주세요'}]
    )

except anthropic.APIConnectionError as error:
    print(f'연결에러: {error}')
except anthropic.RateLimitError as error:
    print(f'요청한도에러: {error}')
except anthropic.APIError as error:
    print(f'요청실패 {error}')

# 응답 결과 메세지
result = response.content[0].text.strip()
if not result:
    raise RuntimeError('api 응답에 표시할 텍스트가 없습니다.')
print('-'*40)
print(response)
print('-'*40)
print('[ 응답 ] ',result)