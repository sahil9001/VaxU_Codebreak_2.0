from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from ekyc.models import *
from users.serializers import *
from slugify import slugify
from users.models import *

class KYCFormSerializer(serializers.ModelSerializer):
    first_name = serializers.CharField()
    last_name = serializers.CharField()
    profile_image = serializers.ImageField()
    dob = serializers.DateField()
    gender = serializers.CharField()
    adhaar_image = serializers.ImageField()
    hospital_id = serializers.CharField()
    class Meta:
        model = KYCInformation
        fields = ['first_name','last_name','hospital_id','profile_image','dob','gender','adhaar_image']

    def save(self,request):
        ekyc = KYCInformation.objects.create(
            user = request.user.normaluser,
            age = request.user.normaluser.age,
            first_name = self.validated_data['first_name'],
            last_name = self.validated_data['last_name'],
            profile_image = self.validated_data.get('profile_image',None),
            dob = self.validated_data['dob'],
            gender = self.validated_data['gender'],
            hospital_vacc = VaccinationOrg.objects.get(pk=int(self.validated_data['hospital_id'])),
            adhaar_image = self.validated_data.get('adhaar_image',None)   
        )
        return ekyc
