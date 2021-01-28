#!/usr/bin/env python
import os
import json
import sys
import pytesseract
import re
import csv
import dateutil.parser as dparser
from PIL import Image


def extracting_uid(path):

    adhaar_number = "not a proper image"
    img = Image.open(path)
    img = img.convert('RGBA')
    pix = img.load()

    for y in range(img.size[1]):
        for x in range(img.size[0]):
            if pix[x, y][0] < 102 or pix[x, y][1] < 102 or pix[x, y][2] < 102:
                pix[x, y] = (0, 0, 0, 255)
            else:
                pix[x, y] = (255, 255, 255, 255)

    img.save('temp.png')

    text = pytesseract.image_to_string(Image.open('temp.png'))

    # Initializing data variable
    name = None
    gender = None
    ayear = None
    uid = None
    yearline = []
    genline = []
    nameline = []
    text1 = []
    text2 = []
    genderStr = '(Female|Male|emale|male|ale|FEMALE|MALE|EMALE)$'

    # Searching for Year of Birth
    lines = text
    # print (lines)
    for wordlist in lines.split('\n'):
        xx = wordlist.split()
        if [w for w in xx if re.search('(Year|Birth|irth|YoB|YOB:|DOB:|DOB)$', w)]:
            yearline = wordlist
            break
        else:
            text1.append(wordlist)
    try:
        text2 = text.split(yearline, 1)[1]
    except Exception:
        pass

    try:
        yearline = re.split('Year|Birth|irth|YoB|YOB:|DOB:|DOB', yearline)[1:]
        yearline = ''.join(str(e) for e in yearline)
        if yearline:
            ayear = dparser.parse(yearline, fuzzy=True).year
    except Exception:
        pass

    # Searching for Gender
    try:
        for wordlist in lines.split('\n'):
            xx = wordlist.split()
            if [w for w in xx if re.search(genderStr, w)]:
                genline = wordlist
                break

        if 'Female' in genline or 'FEMALE' in genline:
            gender = "Female"
        if 'Male' in genline or 'MALE' in genline:
            gender = "Male"

        text2 = text.split(genline, 1)[1]
    except Exception:
        pass

    # Read Database
    with open('namedb1.csv', 'r') as f:
        reader = csv.reader(f)
        newlist = list(reader)
    newlist = sum(newlist, [])

    # Searching for Name and finding exact name in database
    try:
        text1 = filter(None, text1)
        for x in text1:
            for y in x.split():
                if y.upper() in newlist:
                    nameline.append(x)
                    break
        name = ' '.join(str(e) for e in nameline)
    except Exception:
        pass

    # Searching for UID
    try:
        newlist = []
        for xx in text2.split('\n'):
            newlist.append(xx)
        newlist = list(filter(lambda x: len(x) > 12, newlist))
        for no in newlist:
            if re.match("^[0-9 ]+$", no):
                adhaar_number = str(no)

    except Exception:
        pass

    return(adhaar_number)
