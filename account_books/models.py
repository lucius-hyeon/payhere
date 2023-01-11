from django.db import models
from users.models import User

# Create your models here.

class AccountBooks(models.Model):
    class Meta:
        db_table = "AccountBooks"
        ordering = ['created_at']
        
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    income = models.IntegerField(default=0)
    expenses = models.IntegerField(default=0)
    balance = models.IntegerField(null=True)
    content = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)