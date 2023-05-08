from flask import Flask
import subprocess

app = Flask(__name__)

@app.route('/')
def build_storage():
    subprocess.call(["../deploy_file_storage.sh"])
    subprocess.call(["../deploy_blob_storage.azcli"])