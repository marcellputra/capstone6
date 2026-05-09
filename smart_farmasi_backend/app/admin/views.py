from flask_admin import Admin, expose, AdminIndexView
from flask_admin.contrib.sqla import ModelView
from flask_admin.theme import Bootstrap4Theme
from app.models import User, UserActivity, db
from .controllers import AdminController
from .components import AdminUIComponents

class MyHomeView(AdminIndexView):
    """
    Overriding the default Admin Index View to provide stats to the dashboard.
    This fixes the 'total_activities is undefined' error on the /admin/ home page.
    """
    @expose('/')
    def index(self):
        stats = AdminController.get_dashboard_stats()
        recent_activities = AdminController.get_recent_activities()
        
        return self.render('admin/index.html', 
                         total_users=stats.get('total_users', 0),
                         active_today=stats.get('active_today', 0),
                         total_scans=stats.get('total_scans', 0),
                         total_symptoms=stats.get('total_symptoms', 0),
                         total_consultations=stats.get('total_consultations', 0),
                         total_activities=stats.get('total_activities', 0),
                         recent_activities=recent_activities)

class UserAdmin(ModelView):
    """View for managing users."""
    column_list = ['id', 'name', 'email', 'is_admin', 'created_at']
    column_searchable_list = ['name', 'email']
    form_columns = ['name', 'email', 'phone', 'is_admin']
    
    column_formatters = {
        'created_at': AdminUIComponents.date_formatter,
        'is_admin': AdminUIComponents.boolean_badge_formatter,
    }

class ActivityAdmin(ModelView):
    """View for monitoring user activities."""
    column_list = ['id', 'user_id', 'activity_type', 'timestamp']
    column_filters = ['activity_type', 'user_id']
    
    column_formatters = {
        'activity_type': AdminUIComponents.status_badge_formatter,
        'timestamp': AdminUIComponents.date_formatter
    }

# Initialize the Admin instance with our custom Home View
admin = Admin(
    name='Smart Pharmacy', 
    index_view=MyHomeView(name='Dashboard', menu_icon_type='fa', menu_icon_value='fa-th-large'),
    theme=Bootstrap4Theme()
)

def init_admin(app):
    """Initializes the admin panel for the Flask app."""
    admin.init_app(app)
    
    # Add other views (Dashboard/Home is already added via index_view)
    admin.add_view(UserAdmin(User, db.session, name='Patients', menu_icon_type='fa', menu_icon_value='fa-users'))
    admin.add_view(ActivityAdmin(UserActivity, db.session, name='Activities', menu_icon_type='fa', menu_icon_value='fa-history'))