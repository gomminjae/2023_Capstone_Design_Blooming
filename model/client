import json

import numpy as np
import requests
from keras.utils import img_to_array, load_img

# Read the image file and convert it to an array
test_img = img_to_array(load_img('image.jpg', target_size=(224, 224, 3)))

# Reshape the image array to have a 4-dimensional shape
test_img = np.expand_dims(test_img, axis=0)

# JSON data construction
data = json.dumps({"signature_name": "serving_default", "instances": test_img.tolist()})

# Send a POST request
headers = {"content-type": "application/json"}
json_response = requests.post('http://localhost:8501/v1/models/parking:predict', data=data, headers=headers)

predictions = json.loads(json_response.text)
print(predictions)
