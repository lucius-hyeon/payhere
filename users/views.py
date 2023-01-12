from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import User
from .serializers import UserSerializer
from .serializers import CustomTokenObtainPairSerializer


# Create your views here.
class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer
    
    
class UserView(APIView):
        
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response("회원가입 완료")
        else:
            return Response(serializer.errors)