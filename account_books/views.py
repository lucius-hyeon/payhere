from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import get_object_or_404


from .models import AccountBooks
from .serializers import AccountBooksSerializer


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
        serializer = AccountBooksSerializer(account_book)
        return Response(serializer.data)
    
    def put(self, request, author_id, account_book_id):
        account_book = get_object_or_404(AccountBooks, pk=account_book_id, author_id=author_id)
        if request.user == account_book.author:
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