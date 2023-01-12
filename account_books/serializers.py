from rest_framework import serializers
from .models import AccountBooks, Url

class AccountBooksSerializer(serializers.ModelSerializer):
    account_books = AccountBooks
    balance = serializers.SerializerMethodField()
    """
    get_balance() 시간이 너무 오래 걸린다 -> 최적화 방법 찾아보기
    """
    def get_balance(self, obj):
        account_books = AccountBooks.objects.filter(author_id=obj.author.id)
        balance = 0
        update_balance =[]
        for account_book in account_books:
            if obj.date >= account_book.date and obj.created_at>= account_book.created_at:
                balance += account_book.income - account_book.expenses
                if account_book.balance != balance:
                    account_book.balance = balance
                    update_balance.append(account_book)
            else:
                break
        AccountBooks.objects.bulk_update(update_balance,["balance"])
        return balance

    class Meta:
        model = AccountBooks
        fields = '__all__'
        read_only_fields = ("author",)
        
        
class UrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = Url
        fields = '__all__'