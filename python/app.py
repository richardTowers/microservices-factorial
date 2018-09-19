import requests
from flask import Flask

app = Flask(__name__)

@app.route('/<inp>')
def index(inp):
    try:
        inp = int(inp)
    except ValueError:
        inp = 0

    if inp <= 1:
        return requests.get('http://base-factorial.apps.internal:8080').text
    else:
        prec = int(requests.get('http://factorial.apps.internal:8080/{}'.format(inp-1)).text)
        return str(inp * prec)

app.run(host='0.0.0.0', port=8080)
