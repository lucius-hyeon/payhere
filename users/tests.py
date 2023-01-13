from django.urls import reverse
from rest_framework.test import APITestCase
from rest_framework import status
from users.models import User

class UserSignupTest(APITestCase):
    def setUp(self):
        self.data = {"email": "admin@naver.com", "password": "password",}
        self.user = User.objects.create_user(self.data["email"], self.data["password"])
    
    def test_signup(self):
        url = reverse("signup")
        user_data = {
            "email": "test@naver.com",
            "password": "password",
        }
        response = self.client.post(url,user_data)
        self.assertEqual(response.status_code, 200)
    
    def test_signup_error(self):
        url = reverse("signup")
        user_data = {
            "email": "admin@naver.com",
            "password": "password",
        }
        response = self.client.post(url,user_data)
        self.assertEqual(response.status_code, 400)
        
        
        
class UserSigninTest(APITestCase):
    def setUp(self):
        self.data = {"email": "test@naver.com", "password": "password",}
        self.user = User.objects.create_user("test@naver.com", "password")
        
    def test_signin(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, self.data)
        self.assertEqual(response.status_code, 200)
        
    def test_refresh(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, self.data)
        
        url = reverse("token_refresh")
        refresh_token = response.data["refresh"]
        response = self.client.post(url, {"refresh":refresh_token})
        self.assertEqual(response.status_code, 200)
        
    def test_blacklist(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, self.data)
        
        url = reverse("token_blacklist")
        refresh_token = response.data["refresh"]
        response = self.client.post(url, {"refresh":refresh_token})
        self.assertEqual(response.status_code, 200)