import torch
from flask import Flask, jsonify, request
from PIL import Image

app = Flask(__name__)

model = torch.hub.load('ultralytics/yolov5', 'custom', path='./best.pt')


# 설정값 변경 (413 에러 해결)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 예시: 16MB
app.config['UPLOAD_MAX_FILESIZE'] = 16 * 1024 * 1024
app.config['POST_MAX_SIZE'] = 16 * 1024 * 1024

@app.route("/", methods=["GET"])
def hello():
    return "hello"


@app.route("/prediction", methods=["POST"])
def predict():
    # request.environ['CONTENT_TYPE'] = 'multipart/form-data'
    print(request)
    image_file = request.files['image']
    image = Image.open(image_file)
    results = model(image)
    # Results
    predictions = results.pandas().xyxy[0]

    car_predictions = len(predictions.loc[predictions['name'] == 'Car'])
    empty_predictions = len(predictions.loc[predictions['name'] == 'Empty'])
    print([car_predictions, empty_predictions])
    return jsonify({"predictions": [car_predictions, empty_predictions]})


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
