import pytesseract
from PIL import Image
import datetime
import cv2
import sys
import os
import os.path
import re
import numpy as np
# Function to extract the text from image as string


def extracting_uid(path):
    adhaar_number = ""
    print("Here")
    # img=Image.open(self.image_file)
    img = cv2.imread(path)
    # convert the image to gray
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    img = cv2.medianBlur(img, 3)

    # the following command uses the tesseract directory path to get the trained data in the config option
    text = pytesseract.image_to_string(img)
    adhaar_number = re.findall(r'\d+', text)
    print(adhaar_number)    
    if len(adhaar_number) >= 3:
        adhaar_number = adhaar_number[-3] + adhaar_number[-2]+adhaar_number[-1]
        print(adhaar_number)
        if len(adhaar_number) == 12:
            return adhaar_number
    else:
        return "not proper image"