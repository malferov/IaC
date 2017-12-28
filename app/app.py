from flask import Flask
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)

class Wrapper(Resource):
    def get(self):
        return {'status': 'up'}

api.add_resource(Wrapper, '/')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
