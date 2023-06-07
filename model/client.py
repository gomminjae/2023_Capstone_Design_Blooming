

import requests

# 서버 URL 설정
url = 'http://15.164.140.81:8080/prediction'

# 이미지 파일 경로 설정
image_path = "image.jpeg"

# 파일을 담을 딕셔너리 생성
files = {'image': open(image_path, 'rb')}

# JSON 데이터 생성
data = {'parkingLotName': 'IT융합대학'}

# Send the POST request to the server with proper Content-Type header
response = requests.post(url, files=files, data=data)

# 응답 출력
print(response.text)
