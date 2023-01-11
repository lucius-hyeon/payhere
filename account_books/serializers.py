from rest_framework import serializers
from .models import AccountBooks

class AccountBooksSerializer(serializers.ModelSerializer):
    class Meta:
        model = AccountBooks
        fields = '__all__'
        read_only_fields = ("author",)