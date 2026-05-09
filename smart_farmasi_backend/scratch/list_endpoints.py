from app import create_app

app = create_app()
with app.app_context():
    print("Listing all endpoints:")
    for rule in app.url_map.iter_rules():
        print(f"Endpoint: {rule.endpoint}, Methods: {rule.methods}, Path: {rule.rule}")
