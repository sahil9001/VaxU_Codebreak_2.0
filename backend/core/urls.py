from django.contrib import admin
from django.urls import path, include
from .views import *

urlpatterns = [
    path('check/',PatientImageCheckView.as_view(),name='check'),
    path('list/', PatientAllotedList.as_view(), name='patient_list'),
    path('vaccinated/<int:id>/',PatientMarkVaccinatedView.as_view(),name='patient_vaccinated')
]
