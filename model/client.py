import json
import numpy as np
import requests

from PIL import Image

# Read the image file and convert it to an array
image = Image.open('image.jpg')
image = image.resize((224, 224))
test_img = np.array(image)

# Reshape the image array to have a 4-dimensional shape
test_img = np.expand_dims(test_img, axis=0)

# JSON data construction
data = json.dumps({"signature_name": "serving_default", "instances": test_img.tolist()})

# Send a POST request
headers = {"content-type": "application/json"}
json_response = requests.post('http://blooming-parking-lot.ap-northeast-2.elasticbeanstalk.com/v1/models/parking:predict', data=data, headers=headers)

predictions = json.loads(json_response.text)
print(predictions)
