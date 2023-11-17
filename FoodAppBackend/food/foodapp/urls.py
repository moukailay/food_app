# myapp/urls.py
from django.urls import path
from .views import *

urlpatterns = [
    path('login/', LoginView.as_view(), name='login'), # Ce code permet de créer une url pour l'api login
]
