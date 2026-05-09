from flask_restful import Resource
from flask import request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models import User, UserActivity, db

class SaveActivityAPI(Resource):
    @jwt_required()
    def post(self):
        try:
            user_id = get_jwt_identity()
            data = request.get_json()
            
            if not data or 'activity_type' not in data:
                return {'message': 'Missing activity_type'}, 400
                
            activity = UserActivity(
                user_id=int(user_id),
                activity_type=data['activity_type'],
                description=data.get('description', '')
            )
            db.session.add(activity)
            db.session.commit()
            return {'message': 'Activity saved successfully'}, 201
        except Exception as e:
            db.session.rollback()
            return {'message': f'Internal Server Error: {str(e)}'}, 500