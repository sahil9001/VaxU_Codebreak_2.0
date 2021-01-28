from django.contrib import admin
from django.urls import path, include
from .views import KYCFormView

urlpatterns = [
    path('register/', KYCFormView.as_view(), name='kyc'),
]
