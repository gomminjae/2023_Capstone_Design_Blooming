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
model = torch.hub.load('ultralytics/yolov5', 'custom', path='./best.pt')

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
        return f"<Image Title total Empty{self.filename, self.title ,self.total, self.empty}>"


# 설정값 변경
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 예시: 16MB
app.config['UPLOAD_MAX_FILESIZE'] = 16 * 1024 * 1024
app.config['POST_MAX_SIZE'] = 16 * 1024 * 1024
app.config['UPLOAD_FOLDER'] = './images'


@app.route("/prediction", methods=["POST"])
def predict():
    image_file = request.files['image']
    # request.form을 통해 JSON 데이터를 가져옴
    parkingLotName = request.form['parkingLotName']

    print(parkingLotName)
    filename = secure_filename(image_file.filename)
    image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    image = Image.open(image_file)


    results = model(image)

    # 결과 처리
    predictions = results.pandas().xyxy[0]
    total_predictions = len(predictions.loc[predictions['name'] == 'Car'])
    empty_predictions = len(predictions.loc[predictions['name'] == 'Empty'])

    parkinglot = ParkingLot(filename=filename, title=parkingLotName, total=total_predictions, empty=empty_predictions)
    db.session.add(parkinglot)
    db.session.commit()

    return jsonify({"total": total_predictions, "empty": empty_predictions})

# 이미지만
@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)


# 결과만
@app.route('/parkingLotInfo/<parkingLotName>')
def serve_result(parkingLotName):
    record = db.session.query(ParkingLot).order_by(desc(ParkingLot.timestamp)).filter_by(title=parkingLotName)
    serve_result = []
    if record == None:
        return "wrong Table name"
    for record in record:
        serve_result.append({
            'filename':record.filename,
            'total': record.total,
            'empty': record.empty,
            'timestamp': record.timestamp,
        })

    return jsonify(serve_result)



@app.route('/parkingLotInfo')
def serve_information():
    distinct_records = db.session.query(ParkingLot.title).distinct().all()
    result = {}

    for record in distinct_records:
        queryResult = db.session.query(ParkingLot).order_by(desc(ParkingLot.timestamp)).filter_by(title=record[0]).first()
        result[record[0]] = {
            'filename':queryResult.filename,
            'total': queryResult.total,
            'empty': queryResult.empty,
            'timestamp': queryResult.timestamp,
        }

    return jsonify(result)





if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5001)
