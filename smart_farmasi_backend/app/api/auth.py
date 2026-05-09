from flask_restful import Resource
from flask import request
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from app.models import db, User, bcrypt
from sqlalchemy.exc import IntegrityError

class RegisterAPI(Resource):
    def post(self):
        try:
            data = request.get_json()
            if not data:
                return {'message': 'No input data provided'}, 400
            
            # Basic validation
            name = data.get('name')
            email = data.get('email')
            password = data.get('password')
            
            if not name or not email or not password:
                return {'message': 'Missing required fields (name, email, password)'}, 400

            # Check if user already exists
            if User.query.filter_by(email=email).first():
                return {'message': 'Email already registered'}, 409

            hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
            user = User(
                name=name,
                email=email,
                password_hash=hashed_password
            )
            db.session.add(user)
            db.session.commit()
            return {'message': 'User created successfully'}, 201
            
        except IntegrityError:
            db.session.rollback()
            return {'message': 'User already exists or database error'}, 409
        except Exception as e:
            db.session.rollback()
            return {'message': f'Internal Server Error: {str(e)}'}, 500

class LoginAPI(Resource):
    def post(self):
        try:
            data = request.get_json()
            if not data:
                return {'message': 'No input data provided'}, 400
                
            email = data.get('email')
            password = data.get('password')
            
            if not email or not password:
                return {'message': 'Missing email or password'}, 400

            user = User.query.filter_by(email=email).first()
            if user and bcrypt.check_password_hash(user.password_hash, password):
                access_token = create_access_token(identity=str(user.id))
                return {
                    'token': access_token, 
                    'user': {
                        'id': user.id, 
                        'name': user.name, 
                        'email': user.email
                    }
                }, 200
            
            return {'message': 'Invalid email or password'}, 401
        except Exception as e:
            return {'message': f'Internal Server Error: {str(e)}'}, 500

class ProfileAPI(Resource):
    @jwt_required()
    def get(self):
        try:
            user_id = get_jwt_identity()
            user = User.query.get(int(user_id))
            if not user:
                return {'message': 'User not found'}, 404
            return {'id': user.id, 'name': user.name, 'email': user.email}, 200
        except Exception as e:
            return {'message': f'Internal Server Error: {str(e)}'}, 500