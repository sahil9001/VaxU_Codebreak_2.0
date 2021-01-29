**COVID-Cough Analysis**

Using data from crowd-sources as well as open source projects I want to use two different models ANN and CNN in order to pass the audio-features and spectrogram through them to see if it can diagnose the disease.

 The dataset is imbalanced since there are only 37 negative samples. That is why I will look into the data augmentation with audio files as well as using the spectrogram. 

**Dataset:** 

Coswara-Data: 

- multiple audio files with different features 
- includes different types of coughs, vocalizations, and other features 

link: https://github.com/iiscleap/Coswara-Data


The data was sourced as well as using online datasets on audio files from different sources. 
- The data needs to be merged and untared for each single folder. 
- Using the audio for deep_cough and from there create the csv file with the features and spectrogram of each. 
- Pass it through the previously created ANN and CNN. 

What is being done?

- Using the above mentioned audio files I want to be able to predict based on the cough whether an individual has COVID-19 or not. 
- Also want to play around with audio data augmentation, to see if it doesn't distort the result of the actual audio. 
- Try out, if possible, whether a conversion of audio->image (a spectrogram) and then using random jitter on the spectrogram or other data augmentation techniques to increase the dataset available.  

**Process:** 
1. Download and separate the data
2. Create a DataFrame from the filenames to have an overview of the stats 
3. Create Spectrograms from the audio files 
4. Extract features from the audio files
5. Pass the features through an ANN 
6. Pass Spectrogram images through a CNN
7. Evaluate both models 
8. Optimization: Can we improve any of the models without additional data?
9. Use additional data from the Coswara-Dataset (India) to train the nets
10. Once the models work ok, use data augmentation (audio + images)
11. Front-End?? To upload own audio and come back with a result??

Currently at Number 9

Resources to read:

**Papers**

-Hasegawa-Johnson, Mark, Alan Black, Lucas Ondel, Odette Scharenborg, and Francesco Ciannella. “Image2speech: Automatically Generating Audio Descriptions of Images,” n.d., 5.

-Ko, Tom, Vijayaditya Peddinti, Daniel Povey, and Sanjeev Khudanpur. “Audio Augmentation for Speech Recognition,” n.d., 4.

-Park, Daniel S., William Chan, Yu Zhang, Chung-Cheng Chiu, Barret Zoph, Ekin D. Cubuk, and Quoc V. Le. “SpecAugment: A Simple Data Augmentation Method for Automatic Speech Recognition.” Interspeech 2019, September 15, 2019, 2613–17. https://doi.org/10.21437/Interspeech.2019-2680.

-Shuvaev, Sergey, Hamza Giaffar, and Alexei A Koulakov. “Representations of Sound in Deep Learning of Audio Features from Music,” n.d., 5.

-Zhang, Hongyi, Moustapha Cisse, Yann N. Dauphin, and David Lopez-Paz. “Mixup: Beyond Empirical Risk Minimization.” ArXiv:1710.09412 [Cs, Stat], April 27, 2018. http://arxiv.org/abs/1710.09412.
