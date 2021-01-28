from django.contrib import admin
from django.urls import path, include
from users.views import *

urlpatterns = [
    path('register/', RegistrationView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('list/',ListUserView.as_view(),name='list_user'),
    path('vaccinators/', ListVacOrg.as_view(),name='list_org'),
    path('apply/check/',AppliedVaccinationView.as_view()),
    path('info/',ProfileInfoView.as_view(),name='profile_info'),
    path('vacc/register/',RegistrationVaccView.as_view(),name='create_centre'),
    path('vacc/login/',LoginVaccView.as_view(),name='login_centre')
]
