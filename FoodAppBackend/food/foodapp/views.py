# myapp/views.py
from django.contrib.auth import authenticate, login
from rest_framework import generics
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from .serializers import LoginSerializer  # Import the serializer


class LoginView(generics.GenericAPIView):
    permission_classes = [AllowAny]
    serializer_class = LoginSerializer  # Define the serializer class

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        username = serializer.validated_data.get('username')
        password = serializer.validated_data.get('password')
        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return Response({'message': 'Login Succesfully'})
        else:
            return Response({'error': 'Invalid credentials'}, status=400)
