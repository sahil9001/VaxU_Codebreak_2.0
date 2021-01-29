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
from .serializers import *
from .models import *
from ekyc.face_match import *
# Create your views here.
class VaccinatorInfoView(APIView):
    permission_classes = [IsAuthenticated]
    @swagger_auto_schema(
        responses={

        }
    )
    def get(self,request):
        user = VaccinationOrg.objects.get(username = request.user.username)
        return Response({
            "phone" : user.phone,
            "centre_name" : user.centre_name,
            "is_available" : user.is_available,
            "org_description" : user.org_description,
            "vaccines_available" : user.vaccines_available,
            "price" : user.price,
            "city" : user.city,
            "country" : user.country
        },status.HTTP_200_OK)


class PatientImageCheckView(APIView):
    parser_classes = [MultiPartParser]
    permission_classes = [IsAuthenticated]
    @swagger_auto_schema(
        request_body=ImageCheckSerializer,
        operation_id='check',
        responses={
            
        }
    )
    def post(self,request):
        serializer = ImageCheckSerializer(data=request.data)
        if serializer.is_valid():
            print(serializer.validated_data['patient_id'])
            try:
                patient_obj = NormalUser.objects.get(pk=serializer.validated_data['patient_id'])
            except ObjectDoesNotExist:
                return Response({"Patient not found"},status.HTTP_404_NOT_FOUND)
            
            try: 
                kyc_info = KYCInformation.objects.get(user=patient_obj)
            except ObjectDoesNotExist:
                return Response({"KYC Patient not found"},status.HTTP_404_NOT_FOUND)
            
            patient_image = serializer.save(patient = patient_obj)
            #match function
            verified_image = patient_image.clicked_photo.url
            unverified_image = kyc_info.profile_image.url
            print(verified_image)
            print(face_match(verified_image,unverified_image))
            response = True
            return Response({
                "message" : response
            },status.HTTP_200_OK)
        else:
            data = serializer.errors
            return Response({
                "message" : "Bad request",
                "errors" : data
            },status.HTTP_400_BAD_REQUEST)

class PatientAllotedList(APIView):
    permission_classes = [IsAuthenticated]
    @swagger_auto_schema(

    )
    def get(self,request):
        patients = Appointment.objects.filter(hospital = request.user)
        response_body = []
        for x in patients:
            response_obj = {
                "patient" : x.patient.username,
                "patient_id" : x.patient.id,
                "timeslot" : x.timeslot
            }
            response_body.append(response_obj)
        
        return Response(response_body,status.HTTP_200_OK)

class PatientMarkVaccinatedView(APIView):
    permission_classes = [IsAuthenticated]
    @swagger_auto_schema(
        responses={

        }
    )
    def get(self,request,id):
        try:
            appointment = Appointment.objects.get(patient=NormalUser.objects.get(pk=id),hospital=request.user)
        except Appointment.ObjectDoesNotExist:
            return Response({"message": "Appointment not found"},status.HTTP_404_NOT_FOUND)

        user = NormalUser.objects.get(pk=id)
        user.is_vaccinated = True
        user.applied_for_vaccination = False
        user.save()
        appointment.delete()
        return Response({"message" : "User vaccinated successfully"},status.HTTP_200_OK)