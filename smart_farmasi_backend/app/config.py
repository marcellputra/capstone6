import os

SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key-change-in-production'
SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root@127.0.0.1/smart_farmasi_db'
SQLALCHEMY_TRACK_MODIFICATIONS = False
JWT_SECRET_KEY = os.environ.get('JWT_SECRET_KEY') or 'jwt-secret-key-change-in-production'