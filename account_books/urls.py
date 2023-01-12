from django.urls import path
from .views import AccountBooksView, AccountBooksDetailView, AccountBooksDetailShortURL

urlpatterns = [
    path('<int:author_id>/', AccountBooksView.as_view(), name="account_books_view"),
    path('<int:author_id>/<int:account_book_id>/', AccountBooksDetailView.as_view(), name="account_book_detail_view"),
    path('create_url/',AccountBooksDetailShortURL.as_view(), name="create_url"),
]
