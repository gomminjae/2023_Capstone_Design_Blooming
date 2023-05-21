import tensorflow as tf 
import coremltools 

model = tf.keras.models.load_model('model.h5')
tf.saved_model.save(model,"models")

coreml_model = coremltools.convert(model)

coreml_model.save("Blooming.mlmodel")