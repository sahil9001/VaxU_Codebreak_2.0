from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from users.models import *
from slugify import slugify


class RegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        write_only=True,
        min_length=8,
        error_messages={
            "blank": "Password cannot be empty.",
            "min_length": "Password must be atleast 8 characters.",
        },
        allow_blank=True,
        required=False
    )
    username = serializers.CharField(
        allow_blank=True,
        required=False,
        error_messages={
            "required": "Name field is required.",
        },)
    phone = serializers.CharField(allow_blank=True, required=False, error_messages={
        "required": "Name field is required.",
    },)
    email = serializers.EmailField()
    blood_group = serializers.CharField()
    age = serializers.IntegerField()
    city = serializers.CharField()
    country = serializers.CharField()
    class Meta:
        model = NormalUser
        fields = ['username','email', 'phone', 'password','blood_group','age','city','country']

    def save(self):
        last_user_id = 0
        if NormalUser.objects.count() > 0:
            last_user_id = NormalUser.objects.last().id + 1

        normaluser = NormalUser.objects.create(
            user_type = 0,
            username=self.validated_data['username'],
            password=self.validated_data['password'],
            phone=self.validated_data['phone'],
            email = self.validated_data['email'],
            blood_group = self.validated_data['blood_group'],
            age=self.validated_data['age'],
            city=self.validated_data['city'],
            country=self.validated_data['country'],
            is_kyc=False,
            applied_for_vaccination=False,
            is_vaccinated=False
        )

        normaluser.save()
        return normaluser


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField(allow_blank=False)
    password = serializers.CharField(allow_blank=False)
    class Meta:
        model = NormalUser
        fields = ['email','password']

class LoginVaccinatorSerializer(serializers.Serializer):
    email = serializers.EmailField(allow_blank=False)
    password = serializers.CharField(allow_blank=False)
    class Meta:
        model = VaccinationOrg
        fields = ['email','password']

class RegistrationVaccinatorSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        write_only=True,
        min_length=8,
        error_messages={
            "blank": "Password cannot be empty.",
            "min_length": "Password must be atleast 8 characters.",
        },
        allow_blank=True,
        required=False
    )
    username = serializers.CharField(
        allow_blank=True,
        required=False,
        error_messages={
            "required": "Name field is required.",
        },)
    phone = serializers.CharField(allow_blank=True, required=False, error_messages={
        "required": "Name field is required.",
    },)
    email = serializers.EmailField()
    centre_name = serializers.CharField()
    is_available = serializers.BooleanField()
    org_description = serializers.CharField()
    vaccines_available = models.IntegerField()
    price = models.CharField()
    city = serializers.CharField()
    country = serializers.CharField()
    class Meta:
        model = VaccinationOrg
        fields = ['username','email', 'phone', 'password','centre_name','is_available','vaccines_available','price','org_description', 'city','country']

    def save(self):
        last_user_id = 0
        if VaccinationOrg.objects.count() > 0:
            last_user_id = VaccinationOrg.objects.last().id + 1

        vaccuser = VaccinationOrg.objects.create(
            user_type = 1,
            username=self.validated_data['username'],
            password=self.validated_data['password'],
            phone=self.validated_data['phone'],
            email = self.validated_data['email'],
            centre_name = self.validated_data['centre_name'],
            is_available=self.validated_data['is_available'],
            vaccines_available=self.validated_data['vaccines_available'],
            price=self.validated_data['price'],
            city=self.validated_data['city'],
            country=self.validated_data['country'],
        )

        vaccuser.save()
        return vaccuser
