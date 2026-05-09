from app.models import User, UserActivity, db
from datetime import datetime

class AdminController:
    """
    Controller handling the business logic for the Admin Dashboard.
    Provides stats specifically for Smart Pharmacy features.
    """
    
    @staticmethod
    def get_dashboard_stats():
        """Fetches aggregated data for Smart Pharmacy features."""
        total_users = User.query.count()
        today = datetime.now().date()
        new_users_today = User.query.filter(db.func.date(User.created_at) == today).count()
        
        # Feature-specific stats from Activity Logs
        total_scans = UserActivity.query.filter_by(activity_type='scan').count()
        total_symptoms = UserActivity.query.filter_by(activity_type='symptom_check').count()
        total_consultations = UserActivity.query.filter_by(activity_type='chatbot').count()
        
        return {
            'total_users': total_users,
            'active_today': new_users_today,
            'total_scans': total_scans,
            'total_symptoms': total_symptoms,
            'total_consultations': total_consultations,
            'total_activities': UserActivity.query.count()
        }

    @staticmethod
    def get_recent_activities(limit=10):
        """Fetches the most recent user activities."""
        return UserActivity.query.order_by(UserActivity.timestamp.desc()).limit(limit).all()
