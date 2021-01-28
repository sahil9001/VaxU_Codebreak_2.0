from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class User(AbstractUser):
    class Types(models.IntegerChoices):
        PATIENT = 0
        VACCINATOR = 1

    user_type = models.IntegerField(choices=Types.choices,null=True)


class VaccinationOrg(User):
    phone = models.CharField(max_length=10,null=True)
    centre_name = models.CharField(max_length=100)
    is_available = models.BooleanField(default=True)
    org_description = models.CharField(max_length=100)
    vaccines_available = models.IntegerField()
    price = models.CharField(max_length=100)
    city = models.CharField(max_length=40,null=True)
    country = models.CharField(max_length=100,null=True)


    def __str__(self):
        return self.centre_name + " " + self.city

class NormalUser(User):    
    is_vaccinated = models.BooleanField(default=False)
    phone = models.CharField(max_length=100,null=True)
    blood_group = models.CharField(max_length=3)
    age = models.IntegerField(default=0)
    is_kyc = models.BooleanField(default=False)
    applied_for_vaccination = models.BooleanField(default=False)
    symptoms = models.CharField(max_length=4000)
    city = models.CharField(max_length=40,null=True)
    country = models.CharField(max_length=100,null=True)
    vaccinationcenter = models.ForeignKey(VaccinationOrg,on_delete=models.CASCADE,null=True)
