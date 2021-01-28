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
from ekyc.adhaar import *

# Create your views here.


class KYCFormView(APIView):
    permission_classes = [IsAuthenticated]
    parser_classes = [MultiPartParser]
    @swagger_auto_schema(
        operation_id='kyc',
        request_body=KYCFormSerializer,
        responses={

        },
    )
    def post(self, request):
        serializer = KYCFormSerializer(data=request.data)
        if serializer.is_valid():
            # Run function 
            ekyc = serializer.save(request=request)
            path = ekyc.adhaar_image.url
            adhaarnumber = extracting_uid(path)     
            #if valid then save else refill
            if adhaarnumber == ekyc.adhaar_number:
                print("here")
                user = NormalUser.objects.get(email = request.user.normaluser.email)
                user.applied_for_vaccination = True
                user.save()
                return Response({
                    "message" : "KYC Application saved",
                }, status.HTTP_201_CREATED)
            else:
                ekyc.delete()
                return Response({
                    "message" : "Adhaar number not matched"
                },status.HTTP_400_BAD_REQUEST)
        else:
            data = serializer.errors
            print(data)
            return Response(data, status.HTTP_406_NOT_ACCEPTABLE)
