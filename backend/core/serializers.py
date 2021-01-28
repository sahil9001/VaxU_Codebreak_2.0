from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from ekyc.models import *
from slugify import slugify
from .models import *

class ImageCheckSerializer(serializers.ModelSerializer):
    clicked_photo = serializers.ImageField()
    patient_id = serializers.IntegerField()
    class Meta:
        model = PatientImage
        fields = ['clicked_photo','patient_id']

    def save(self,patient):
        patientimage = PatientImage.objects.create(
            user_check = patient,
            patient_id = self.validated_data['patient_id'],
            clicked_photo = self.validated_data.get('clicked_photo',None)
        )
        return patientimage
 