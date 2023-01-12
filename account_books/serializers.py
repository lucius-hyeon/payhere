from rest_framework import serializers
from .models import AccountBooks, Url

class AccountBooksSerializer(serializers.ModelSerializer):
    class Meta:
        model = AccountBooks
        fields = '__all__'
        read_only_fields = ("author",)
        
        
class UrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = Url
        fields = '__all__'