from django.urls import path

from .views import *

urlpatterns = [
    path('', Hello, name='hello'),
]