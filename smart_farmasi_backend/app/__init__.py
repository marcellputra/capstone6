from flask import Flask
from app.models import db, bcrypt
from app.admin.views import init_admin
from flask_jwt_extended import JWTManager
from flask_cors import CORS
from flask_migrate import Migrate

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config')
    
    db.init_app(app)
    bcrypt.init_app(app)
    JWTManager(app)
    CORS(app)
    Migrate(app, db)
    init_admin(app)
    
    from app.api.auth import RegisterAPI, LoginAPI, ProfileAPI
    from app.api.users import SaveActivityAPI
    
    from flask_restful import Api
    api = Api(app)
    api.add_resource(RegisterAPI, '/api/register')
    api.add_resource(LoginAPI, '/api/login')
    api.add_resource(ProfileAPI, '/api/profile')
    api.add_resource(SaveActivityAPI, '/api/activity')
    
    @app.route('/')
    def index():
        return """
        <html>
            <head>
                <title>Smart Farmasi API</title>
                <style>
                    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #f0f2f5; }
                    .container { text-align: center; padding: 2rem; background: white; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
                    h1 { color: #2c3e50; }
                    p { color: #7f8c8d; }
                    a { color: #3498db; text-decoration: none; font-weight: bold; }
                    a:hover { text-decoration: underline; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>💊 Smart Farmasi Backend</h1>
                    <p>API is running successfully.</p>
                    <p>Go to <a href="/admin">Admin Panel</a></p>
                </div>
            </body>
        </html>
        """
    
    return app