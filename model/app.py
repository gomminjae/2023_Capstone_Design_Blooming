import torch
from flask import Flask, jsonify, request, send_from_directory
from PIL import Image
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
model = torch.hub.load('ultralytics/yolov5', 'custom', path='./best.pt')

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///images.db'
db = SQLAlchemy(app)
migrate = Migrate(app, db)


class Images(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255))
    car = db.Column(db.Integer)
    empty = db.Column(db.Integer)

    def __repr__(self):
        return f"<Image Car Empty{self.filename, self.car, self.empty}>"


# 설정값 변경
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 예시: 16MB
app.config['UPLOAD_MAX_FILESIZE'] = 16 * 1024 * 1024
app.config['POST_MAX_SIZE'] = 16 * 1024 * 1024
app.config['UPLOAD_FOLDER'] = './images'


@app.route("/prediction", methods=["POST"])
def predict():
    # request.environ['CONTENT_TYPE'] = 'multipart/form-data'
    image_file = request.files['image']
    filename = secure_filename(image_file.filename)
    image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    image = Image.open(image_file)

    results = model(image)
    # Results
    predictions = results.pandas().xyxy[0]

    car_predictions = len(predictions.loc[predictions['name'] == 'Car'])
    empty_predictions = len(predictions.loc[predictions['name'] == 'Empty'])
    images = Images(filename=filename, car=car_predictions, empty=empty_predictions)
    print(images)
    db.session.add(images)
    db.session.commit()

    return jsonify({"car": car_predictions,"empty": empty_predictions})


# 이미지만
@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)


# 결과만
@app.route('/results/<filename>')
def serve_result(filename):
    result = db.session.query(Images).filter_by(filename=filename).first()
    if result is not None:
        return jsonify({"car": result.car,"empty": result.empty})
    else:
        return "No tuple found with filename '{filename}'"


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
