import torch
from flask import Flask, jsonify, request, send_from_directory
from PIL import Image
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os

from sqlalchemy import desc
from werkzeug.utils import secure_filename
from datetime import datetime
from collections import namedtuple

app = Flask(__name__)
model = torch.hub.load('ultralytics/yolov5', 'custom', force_reload=True, path='./best1.pt')

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///parkingLot.db'
db = SQLAlchemy(app)
migrate = Migrate(app, db)


class ParkingLot(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255))
    title = db.Column(db.String(255))
    total = db.Column(db.Integer)
    empty = db.Column(db.Integer)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return f"<Image Title total Empty{self.filename, self.title, self.total, self.empty}>"


# 설정값 변경
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 예시: 16MB
app.config['UPLOAD_MAX_FILESIZE'] = 16 * 1024 * 1024
app.config['POST_MAX_SIZE'] = 16 * 1024 * 1024
app.config['UPLOAD_FOLDER'] = './images'


@app.route("/prediction", methods=["POST"])
def predict():
    # request.environ['CONTENT_TYPE'] = 'multipart/form-data'
    image_file = request.files['image']
    parkingLotName = request.form['parkingLotName']

    filename = secure_filename(image_file.filename)
    image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    image = Image.open(image_file)

    results = model(image)
    # Results
    predictions = results.pandas().xyxy[0]

    total_predictions = len(predictions.loc[predictions['name'] == 'Car'])
    empty_predictions = len(predictions.loc[predictions['name'] == 'Empty'])
    parkinglot = ParkingLot(filename=filename, title=parkingLotName, total=(total_predictions+empty_predictions), empty=empty_predictions)

    db.session.add(parkinglot)
    db.session.commit()

    parkingLot = ParkingLot.query.all()
    print(parkingLot)

    return str(total_predictions + empty_predictions) + "개의 주차 자리 중 " + str(empty_predictions) + "개 자리가 비어있습니다"


# 이미지만
@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)


# 결과만
@app.route('/results/<filename>')
def serve_result(filename):
    result = db.session.query(ParkingLot).filter_by(filename=filename).last()
    if result is not None:
        return jsonify(
            {"title": result.title, "total": result.total, "empty": result.empty, "timestamp": result.timestamp})
    else:
        return "No tuple found with filename '{filename}'"


@app.route('/parkingLotInfo')
def serve_information():
    distinct_records = db.session.query(ParkingLot.title).distinct().all()
    print(distinct_records)
    serve_result = {}
    for record in distinct_records:
        queryResult = db.session.query(ParkingLot).order_by(desc(ParkingLot.timestamp)).filter_by(
            title=record[0]).first()
        serve_result[record[0]] = {
            'total': queryResult.total,
            'empty': queryResult.empty,
            'timestamp': queryResult.timestamp,
        }

    return serve_result


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
