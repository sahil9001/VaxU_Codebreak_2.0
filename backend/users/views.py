from django.shortcuts import render
from rest_framework import status
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from users.serializers import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view, permission_classes
from rest_framework.parsers import MultiPartParser
from users.models import *
from django.utils.crypto import get_random_string
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
import datetime
from django.contrib.auth import get_user_model


def authenticate(email=None, password=None):
    try:
        user = NormalUser.objects.get(email=email, password=password)
    except ObjectDoesNotExist:
        return None
    return user

def authenticate1(email=None, password=None):
    try:
        user = VaccinationOrg.objects.get(email=email, password=password)
    except ObjectDoesNotExist:
        return None
    return user



class ProfileInfoView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_id='profile_view'
    )
    def get(self, request):
        user_obj = {
            "username": request.user.normaluser.username,
            "phone": request.user.normaluser.phone,
            "email": request.user.normaluser.email,
            "blood_group": request.user.normaluser.blood_group,
            "age": request.user.normaluser.age,
            "city": request.user.normaluser.city,
            "country": request.user.normaluser.country,
            "is_kyc": request.user.normaluser.is_kyc,
            "applied_for_vaccination": request.user.normaluser.applied_for_vaccination,
            "is_vaccinated": request.user.normaluser.is_vaccinated
        }
        return Response(user_obj, status.HTTP_200_OK)

class RegistrationVaccView(APIView):
    @swagger_auto_schema(
        operation_id="create_centre",
        request_body=RegistrationVaccinatorSerializer,
        responses={

        }
    )
    def post(self,request):
        print(request.body)
        serializer = RegistrationVaccinatorSerializer(data=request.data)

        if serializer.is_valid():
            user = serializer.save()
            return Response({}, status.HTTP_201_CREATED)
        else:
            data = serializer.errors
            return Response(data, status.HTTP_400_BAD_REQUEST)

class LoginVaccView(APIView):
    @swagger_auto_schema(
        operation_id="login_centre",
        request_body=LoginVaccinatorSerializer,
        responses={

        }
    )
    def post(self,request):
             #   return Response({},status.HTTP_202_ACCEPTED)
        print(request.body)
        serializer = LoginVaccinatorSerializer(data=request.data)

        if serializer.is_valid():
            found_email = serializer.data['email']
            user = authenticate1(
                email=serializer.data['email'],
                password=serializer.data['password']
            )
            print(user)
            request.user = user
            if user:
                token, _ = Token.objects.get_or_create(user=user)
                return Response({'token': f"Token {token.key}"}, status.HTTP_202_ACCEPTED)
            else:
                try:
                    if VaccinationOrg.objects.get(email=found_email):
                        return Response({'detail': 'Credentials did not match'}, status.HTTP_401_UNAUTHORIZED)

                except VaccinationOrg.DoesNotExist:
                    return Response({"detail": "User not found"}, status.HTTP_404_NOT_FOUND)
        else:
            data = serializer.errors
            return Response(data, status.HTTP_400_BAD_REQUEST)


class RegistrationView(APIView):

    @swagger_auto_schema(
        operation_id='create_user',
        request_body=RegistrationSerializer,
        responses={

        },
    )
    def post(self, request):
        print(request.body)
        serializer = RegistrationSerializer(data=request.data)

        if serializer.is_valid():
            user = serializer.save()
            return Response({}, status.HTTP_201_CREATED)
        else:
            data = serializer.errors
            return Response(data, status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):

    @swagger_auto_schema(
        operation_id='login_user',
        request_body=LoginSerializer,
        responses={

        },
    )
    def post(self, request):
     #   return Response({},status.HTTP_202_ACCEPTED)
        print(request.body)
        serializer = LoginSerializer(data=request.data)

        if serializer.is_valid():
            found_email = serializer.data['email']
            user = authenticate(
                email=serializer.data['email'],
                password=serializer.data['password']
            )
            print(user)
            request.user = user
            if user:
                token, _ = Token.objects.get_or_create(user=user)
                return Response({'token': f"Token {token.key}"}, status.HTTP_202_ACCEPTED)
            else:
                try:
                    if NormalUser.objects.get(email=found_email):
                        return Response({'detail': 'Credentials did not match'}, status.HTTP_401_UNAUTHORIZED)

                except NormalUser.DoesNotExist:
                    return Response({"detail": "User not found"}, status.HTTP_404_NOT_FOUND)
        else:
            data = serializer.errors
            return Response(data, status.HTTP_400_BAD_REQUEST)


class ListUserView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        responses={

        }
    )
    def get(self, request):
        return Response({
            "email": request.user.email,
            "password": request.user.password,
            "name": request.user.username,
            "phone": request.user.phone,
            "blood_group": request.user.blood_group,
            "age": request.user.age,
            "applied_for_vaccination": request.user.applied_for_vaccination,
            "is_kyc": request.user.is_kyc
        }, status.HTTP_200_OK)


class ListVacOrg(APIView):
    @swagger_auto_schema(
        responses={

        }
    )
    def get(self, request):
        print(request.data)
        vaccinator_org = []
        vaccination_centers = VaccinationOrg.objects.all()
        for x in vaccination_centers:
            vaccinator_org_body = {
                "center_name": x.centre_name,
                "is_available": x.is_available,
                "org_description": x.org_description,
                "vaccines_available": x.vaccines_available,
                "price": x.price
            }
            vaccinator_org.append(vaccinator_org_body)
        return Response(vaccinator_org,status.HTTP_200_OK)

class AppliedVaccinationView(APIView):
    permission_classes = [IsAuthenticated]
    @swagger_auto_schema(
        responses = {

        }
    )
    def get(self,request):
        print(request.user.normaluser.applied_for_vaccination)
        return Response({"applied_for_vaccination" : request.user.normaluser.applied_for_vaccination},status.HTTP_200_OK)
