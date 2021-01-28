from django.db import models
from users.models import *
# Create your models here.
class Appointment(models.Model):
    TIMESLOTS = [
        (0,'9:00AM to 10:00AM'),
        (1,'10:00AM to 11:00AM'),
        (2,'11:00AM to 12:00AM'),
        (3,'12:00AM to 1:00PM'),
        (4,'1:00PM to 2:00PM'),
        (5,'2:00PM to 3:00PM'),
        (6,'3:00PM to 4:00PM'),
        (7,'4:00PM to 5:00PM'),
        (8,'5:00PM to 6:00PM'),
        (9,'6:00PM to 7:00PM'),
        (10,'7:00PM to 8:00PM'), 
    ]
    hospital = models.ForeignKey(VaccinationOrg,on_delete=models.CASCADE)
    patient  = models.ForeignKey(NormalUser,on_delete=models.CASCADE)
    timeslot = models.IntegerField(choices=TIMESLOTS,null=True)

class PatientImage(models.Model):
    user_check = models.ForeignKey(NormalUser,on_delete=models.CASCADE)
    patient_id = models.IntegerField(null=True)
    clicked_photo = models.ImageField(upload_to='uploads/core/clicked_image/')
