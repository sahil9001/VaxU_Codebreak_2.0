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

=

