import torch
from flask import Flask, jsonify, request
from PIL import Image


app = Flask(__name__)

model = torch.hub.load('ultralytics/yolov5', 'custom', path='./best.pt')


@app.route("/prediction", methods=["POST"])
def predict():
    image_file = request.files['image']
    image = Image.open(image_file)
    results = model(image)
    results.show()
    # Results
    predictions = results.pandas().xyxy[0]

    car_predictions = len(predictions.loc[predictions['name'] == 'Car'])
    empty_predictions = len(predictions.loc[predictions['name'] == 'Empty'])
    print([car_predictions, empty_predictions])
    return jsonify({"predictions": [car_predictions, empty_predictions]})


if __name__ == '__main__':
    app.run()
