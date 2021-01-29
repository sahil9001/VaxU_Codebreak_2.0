#utils used for the projects 


def spectrogram_from_wav(to_make='spectrograms', find_files='data', save_to='./img/spectrograms/'):
    
    '''
    DOCSTRING:

    Function which returns a spectrogram given a .wav file. 

    Input x: audio file in wav format 

    output img: spectrogram with no axis

    '''

    results = ['positive', 'negative']
    for res in results: 
        pathlib.Path(f"{to_make}/{res}").mkdir(parents=True, exist_ok=True)
        for files in os.listdir(f"{find_files}/{res}"):
            filename = f"{find_files}/{res}/{files}"
            x, sr = librosa.load(filename, mono=True)
            plt.specgram(x, NFFT=2048, Fs=2, Fc=0, overlap=128, cmap='inferno', sides='default', mode='default', scale='dB')
            plt.axis('off')
            plt.savefig(f"{save_to}/{res}/{files[:-4]}.png")
            plt.clf()


def write_to_csv(filename='covid_dataset.csv', dir_path='data'):
    '''
    DOCSTRING:

    Function which writes data to csv.

    Features it uses: 
    - RMSE 
    - Chroma STFT
    - Spectral Centroid
    - Spectral Bandwidth 
    - Spectral Rolloff 
    - Zero Crossing 

    Input: files in directory, 


    '''

    #Create the header for the CSV File 
    header = 'filename ID chroma_stft rmse spectral_centroid spectral_bandwidth rolloff zero_crossing_rate'
    for x in range(1, 21):
        header += f" mfcc{x}"
    header += ' label'
    header = header.split()
    #create and write to file
    file = open(filename, 'w', newline="")
    with file: 
        writer = csv.writer(file)
        writer.writerow(header)
    results = ['positive', 'negative']
    for res in results: 
        for files in os.listdir(f"{dir_path}/{res}"):
            patient_id = files.split("_")[0]
            filename = f"{dir_path}/{res}/{files}"
            x, sr = librosa.load(filename, mono=True)
            rmse = librosa.feature.rms(y=x)
            chroma_stft = librosa.feature.chroma_stft(y=x, sr=sr)
            spec_cent = librosa.feature.spectral_centroid(y=x, sr=sr)
            spec_bw = librosa.feature.spectral_bandwidth(y=x, sr=sr)
            rolloff = librosa.feature.spectral_rolloff(y=x, sr=sr)
            zcr = librosa.feature.zero_crossing_rate(x)
            mfcc = librosa.feature.mfcc(y=x, sr=sr)
            to_append = f'{filename} {patient_id} {np.mean(chroma_stft)} {np.mean(rmse)} {np.mean(spec_cent)} {np.mean(spec_bw)} {np.mean(rolloff)} {np.mean(zcr)}'    
            for k in mfcc:
                to_append += f' {np.mean(k)}'
            to_append += f' {res}'
            file = open(filename, 'a', newline='')
            with file:
                writer = csv.writer(file)
                writer.writerow(to_append.split())
