from app import create_app
from app.models import User, UserActivity

app = create_app()
with app.app_context():
    users = User.query.all()
    print(f"Total Users: {len(users)}")
    for u in users:
        print(f"ID: {u.id}, Name: {u.name}, Email: {u.email}")
    
    activities = UserActivity.query.all()
    print(f"Total Activities: {len(activities)}")
