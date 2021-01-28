from django.db import models
from users.models import *
# Create your models here.


class KYCInformation(models.Model):
    GENDER_OPTIONS = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'other')
    ]

    user = models.ForeignKey(
        NormalUser, null=True, blank=True, on_delete=models.SET_NULL)
    first_name = models.CharField(max_length=30, null=False, blank=True)
    last_name = models.CharField(max_length=30, null=False, blank=True)
    profile_image = models.ImageField(upload_to='uploads/ekyc/profile_image/')
    dob = models.DateField()
    gender = models.CharField(choices=GENDER_OPTIONS,
                              max_length=1, blank=False, null=False)
    adhaar_image = models.ImageField(upload_to='uploads/ekyc/adhaar_image/')
    updated_at = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)
    