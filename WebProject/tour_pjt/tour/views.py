from django.shortcuts import render
from pathlib import Path
from django.http import JsonResponse
import os
from dotenv import load_dotenv
import anthropic
from anthropic import Anthropic

# 1. 키 불러오기
BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
envFile = BASE_DIR/ '.env'
load_dotenv(envFile)
api_key = os.getenv('api_key')
# Create your views here.
def ajax_data(request):
    data = request.POST.get('data')
    txt_input = data
    if not txt_input:
        return JsonResponse({'result':'여행지를 입력해주세요.'})

    # 3. 클라이언트 연결
    client = Anthropic(api_key=api_key)

    try:
        messages = client.messages.create(
            model = 'claude-haiku-5-5',
            system = ('당신은 여행설계 전문가입니다.\n'
                    f'{txt_input}여행 1박2일로 코스로 짜주세요.\n'
                    '여행일정,여행지,숙소,식사추천을 해주세요.\n'
                    '이해하기 쉽고 간략하게 답합니다.\n'
                    '가독성 있게 띄어쓰기 줄바꿈 마크다운을 적절히 활용하여 작성합니다.'),
            messages = [{'role':'user','content':f'{txt_input}을 가지고 1박2일코스 1.여행일정,2.여행지,3.숙소,4.식사추천을 가독성있게 제안해주세요'}],
            max_tokens=1000,
        )
    except anthropic.APIConnectionError as error:
        print(f'인터넷연결,방화벽문제등 확인:{error}')
        return JsonResponse({'result':'인터넷 연결을 확인해주세요.'})
    except anthropic.RateLimitError as error:
        print(f'요청량 또는 프로젝은 사용한도 확인:{error}')
        return JsonResponse({'result':'요청이 많습니다. 잠시 후 다시 시도해주세요.'})
    except anthropic.APIError as error:
        print(f'인증,권한 등 api 오류 확인:{error}')
        return JsonResponse({'result':'API 오류가 발생했습니다.'})

    # 4.결과확인
    result = messages.content[0].text.strip()
    if not result:
        return JsonResponse({'result':'응답결과 내용이 없습니다.'})

    context = {'result':result}
    return JsonResponse(context)




def tour(request):
    return render(request,'tour.html')