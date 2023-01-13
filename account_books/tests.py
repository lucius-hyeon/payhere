from django.urls import reverse
from rest_framework.test import APITestCase
from rest_framework import status
from users.models import User
from account_books.models import AccountBooks, Url

class AccountBooksTest(APITestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user_data = {"email": "test@naver.com", "password": "password",}
        cls.account_book_data = {
            "date": "2023-01-01",
            "income": "10000",
            "content":"test_code"
            }
        cls.user = User.objects.create_user(cls.user_data["email"],cls.user_data["password"])
        cls.account_books=[]
        for i in range(10):
            cls.account_books.append(AccountBooks.objects.create(author=cls.user, date="2023-01-01",income="10000",content="test_code"))
        
        
        
    def setUp(self):
        self.access_token = self.client.post(reverse("token_obtain_pair"),self.user_data).data['access']
        
    def test_create_account_book(self):
        """
        가계부 내역 생성 기능 테스트
        """
        response = self.client.post(
            path=f"/account_books/{self.user.pk}/",
            data=self.account_book_data,
            HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
        )
        self.assertEqual(response.status_code, 200)
        
    def test_fail_is_not_login_account_books_list(self):
        """
        비로그인 사용자가 가계부에 접근 할 경우 테스트
        """
        response = self.client.post(
            path=f"/account_books/{self.user.pk}/"
        )
        self.assertEqual(response.status_code, 401)
        
    def test_view_account_books_list(self):
        response = self.client.get(
            path=f"/account_books/{self.user.pk}/",
            HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
        )
        self.assertEqual(response.status_code, 200)
        
    def test_view_account_book_detail(self):
        """
        가계부 상세 정보 열람 기능 테스트
        """
        for account_book in self.account_books:
            response = self.client.get(
                path=f"/account_books/{self.user.pk}/{account_book.pk}/",
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            self.assertEqual(response.status_code,200)
        
        
    def test_put_account_book_detail(self):
        """
        가계부 상세 정보 수정 기능 테스트
        """
        for account_book in self.account_books:
            response = self.client.put(
                path=f"/account_books/{self.user.pk}/{account_book.pk}/",
                data=self.account_book_data,
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            content = (account_book.content)
            self.assertEqual(response.data["content"],content)
            self.assertEqual(response.status_code,200)
            
    def test_delete_account_book_detail(self):
        """
        가계부 상세 정보 삭제 기능 테스트
        """
        for account_book in self.account_books:
            response = self.client.delete(
                path=f"/account_books/{self.user.pk}/{account_book.pk}/",
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            self.assertEqual(response.status_code,200)
            
    def test_copy_account_book_detail(self):
        """
        가계부 상세 정보 복제 기능 테스트
        """
        for account_book in self.account_books:
            response = self.client.put(
                path=f"/account_books/{self.user.pk}/{account_book.pk}/",
                data={"is_copy":"true"},
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            self.assertEqual(response.status_code,200)
            self.assertEqual(response.data, {"message":"복제 성공"})
            
            
    def test_create_short_url_account_book_detail(self):
        """
        단축 Url 생성 테스트
        """
        for account_book in self.account_books:
            origin_url = f"http://127.0.0.1:8000/account_books/{self.user.pk}/{account_book.pk}/"
            response = self.client.post(
                path=f"/account_books/create_url/",
                data={"origin_url":origin_url},
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            self.assertEqual(response.status_code,200)
            
    def test_short_url_account_book_detail(self):
        """
        생성된 단축 Url get 요청 테스트
        """
        for account_book in self.account_books:
            origin_url = f"http://127.0.0.1:8000/account_books/{self.user.pk}/{account_book.pk}/"
            response = self.client.post(
                path=f"/account_books/create_url/",
                data={"origin_url":origin_url},
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            new_url = response.data["new_url"]
            origin_url = response.data["origin_url"]
            response = self.client.get(
                path=new_url,
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            # 301 리다이렉트 성공시
            self.assertEqual(response.status_code,301)
            
    def test_is_not_short_url_account_book_detail(self):
        """
        존재하지 않는 단축 Url 입력 테스트
        """
        for account_book in self.account_books:
            new_url = f"http://127.0.0.1:8000/AGqIezFT/"
            response = self.client.get(
                path=new_url,
                HTTP_AUTHORIZATION=f"Bearer {self.access_token}"
            )
            
            self.assertEqual(response.status_code,404)