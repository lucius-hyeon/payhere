from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import get_object_or_404
from django.http import HttpResponseRedirect

from .models import AccountBooks, Url
from .serializers import AccountBooksSerializer, UrlSerializer
import random
from datetime import datetime,timedelta

class AccountBooksView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, author_id):
        account_books = AccountBooks.objects.filter(author_id = author_id)
        serializer = AccountBooksSerializer(account_books, many=True)
        return Response(serializer.data)
    
    def post(self, request, author_id):
        serializer = AccountBooksSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(author=request.user)
            return Response(serializer.data)
        else:
            return Response(serializer.errors)
    
class AccountBooksDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    
    def get(self, request, author_id, account_book_id):
        account_book = get_object_or_404(AccountBooks, pk=account_book_id, author_id=author_id)
        if request.user == account_book.author:
            serializer = AccountBooksSerializer(account_book)
            return Response(serializer.data)
        return Response("접근 권한이 없습니다.")
    
    def put(self, request, author_id, account_book_id):
        """
        가계부의 세부 정보를 수정할 수 있다.
        단 put 요청 시 is_copy 값이 들어오게 되면 copy 매소드 역할을 해준다
        """
        account_book = get_object_or_404(AccountBooks, pk=account_book_id, author_id=author_id)
        if request.user == account_book.author:
            is_copy = request.data.get("is_copy",False)
            if is_copy:
                account_book.pk = None
                account_book.save()
                return Response("복제 성공")
            else:
                serializer = AccountBooksSerializer(account_book, data=request.data, partial=True)
                if serializer.is_valid():
                    serializer.save(author=request.user)
                    return Response(serializer.data)
        return Response({"message: 접근 권한이 없습니다."})
    
    def delete(self, request, author_id, account_book_id):
        account_book = get_object_or_404(AccountBooks, pk=account_book_id, author_id=author_id)
        if request.user == account_book.author:
            account_book.delete()
            return Response({"message: 삭제 완료."})
        else:
            return Response({"message: 삭제 권한이 없습니다."})
        

class AccountBooksDetailShortURL(APIView):
    HOST_DOMAIN = "http://127.0.0.1:8000"
    
    def get(self, request, new_url):
        new_url = self.HOST_DOMAIN + "/" + new_url
        url = get_object_or_404(Url, new_url=new_url)
        if self.url_expire_time(url):
            return Response("해당 URL은 만료되었습니다.")
        return HttpResponseRedirect(url.origin_url)
    
    def post(self, request):
        """
        url 주소가 넘어오지 않거나, 만료된 url 정보를 담고 있다면
        새로운 단축 url을 만들어주고 반환한다
        """
        try:
            url = get_object_or_404(Url, origin_url=request.data["origin_url"])
            if self.url_expire_time(url):
                raise
            serializer = UrlSerializer(url)
            return Response(serializer.data)
        except:
            serializer = UrlSerializer(data=request.data)
            if serializer.is_valid():
                new_url = self.HOST_DOMAIN + "/" + self.base62()
                # new_url = self.base62()
                serializer.save(new_url=new_url)
                return Response(serializer.data)
            return Response(serializer.errors)            
    
    def base62(self):
        result = ""
        words = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 
                'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 
                'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        
        while True:
            result = ''.join(random.sample(words,8))
            try:
                url = url.objects.get(new_link=result)
            except:
                return result
    
    def url_expire_time(self, url):
        expire_time = datetime.now() - url.created_at
        if expire_time > timedelta(minutes=10):
            url.delete()
            return True
        return False