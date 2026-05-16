from flask_restful import Resource
from flask import request
from flask_jwt_extended import jwt_required, get_jwt_identity
import requests
import os
from app.models import UserActivity, db

class ChatbotAPI(Resource):
    @jwt_required()
    def post(self):
        try:
            user_id = get_jwt_identity()
            data = request.get_json()
            
            if not data or 'message' not in data:
                return {'message': 'Missing message'}, 400
                
            user_message = data['message']
            
            # Simple AI Logic (Replace with Gemini/OpenAI API call)
            # Example using Gemini API:
            # api_key = os.getenv('GEMINI_API_KEY')
            # response = call_gemini(user_message, api_key)
            
            ai_response = self._get_ai_response(user_message)
            
            # Save activity
            activity = UserActivity(
                user_id=int(user_id),
                activity_type='chatbot',
                description=f"User asked: {user_message[:50]}..."
            )
            db.session.add(activity)
            db.session.commit()
            
            return {
                'reply': ai_response,
                'status': 'success'
            }, 200
        except Exception as e:
            return {'message': f'Internal Server Error: {str(e)}'}, 500

    def _get_ai_response(self, message):
        """
        Placeholder for real AI integration.
        For now, provides more sophisticated responses than the frontend hardcode.
        """
        msg = message.lower()
        if 'halo' in msg or 'hi' in msg:
            return "Halo! Saya asisten SEHATI. Ada yang bisa saya bantu terkait kesehatan atau penggunaan aplikasi ini?"
        
        if 'obat' in msg:
            return "Penting untuk selalu membaca dosis pada kemasan. Jika Anda ragu, saya sarankan konsultasi dengan apoteker kami. Apakah ada obat spesifik yang Anda tanyakan?"
            
        if 'gejala' in msg or 'sakit' in msg:
            return "Saya mengerti Anda merasa kurang sehat. SEHATI memiliki fitur 'Cek Gejala' yang bisa memberikan rekomendasi awal. Namun, ingat bahwa saya bukan pengganti dokter."
            
        return "Terima kasih atas pertanyaannya. Saya sedang mempelajari lebih lanjut tentang hal itu. Untuk saat ini, pastikan Anda beristirahat cukup dan minum air putih yang banyak."
