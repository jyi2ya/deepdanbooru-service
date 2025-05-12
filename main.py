import os
from flask import Flask, request, jsonify
import base64
from io import BytesIO
from PIL import Image
from deepdanbooru_onnx import DeepDanbooru

app = Flask(__name__)

MODEL_PATH = os.getenv('DANBOORU_MODEL_PATH', './deepdanbooru/deepdanbooru.onnx')
TAGS_PATH = os.getenv('DANBOORU_TAGS_PATH', './deepdanbooru/tags.txt')
HOST = os.getenv('DANBOORU_HOST', '0.0.0.0')
PORT = int(os.getenv('DANBOORU_PORT', '5000'))
LOG_LEVEL = os.getenv('DANBOORU_LOG_LEVEL', 'info')

danbooru = DeepDanbooru(
    model_path=MODEL_PATH,
    tags_path=TAGS_PATH,
)

@app.route('/tag', methods=['POST'])
def tag_image():
    try:
        data = request.get_json()
        if not data or 'image' not in data:
            return jsonify({'error': 'No image data provided'}), 400

        image_data = base64.b64decode(data['image'])
        img = Image.open(BytesIO(image_data))
        result = danbooru(img)

        processed_result = {
            tag: float(confidence)
            for tag, confidence in result.items()
        }

        return jsonify(processed_result)

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host=HOST, port=PORT)
